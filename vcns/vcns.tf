
#------------------------------------------- VCNs

resource "oci_core_vcn" "VCN_PRD"{ 
    cidr_block = "10.0.0.0/22" 
    dns_label = "VCNPRD1" 
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    display_name = "VCN_PRD"
} 

resource "oci_core_vcn" "VCN_NONPRD"{ 
    cidr_block = "10.0.4.0/22" 
    dns_label = "VCNNONPRD1" 
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    display_name = "VCN_NONPRD"
} 

#------------------------------------------- Subnets

resource "oci_core_subnet" "S_APP-PRD" {
    cidr_block = "10.0.0.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "S_APP-PRD"
    dns_label = "APPPRD1"
}

resource "oci_core_subnet" "S_BD-PRD" {
    cidr_block = "10.0.1.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "S_BD-PRD"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "BDPRD1"
}

resource "oci_core_subnet" "S_APP-FQA" {
    cidr_block = "10.0.4.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "S_APP-FQA"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "APPFQA1"
}

resource "oci_core_subnet" "S_BD-FQA" {
    cidr_block = "10.0.5.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "S_BD-FQA"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "BDFQA1"
}

resource "oci_core_subnet" "S_CUSTOMAPP-FQA" {
    cidr_block = "10.0.6.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "S_CUSTOMAPP-FQA"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "CUSTOMAPPFQA1"
}

resource "oci_core_subnet" "BD-DEV" {
    cidr_block = "10.0.7.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "BD-DEV"
    prohibit_public_ip_on_vnic = "true" 
    dns_label = "BDDEV1"
}

#------------------------------------------- SLs

resource "oci_core_security_list" "SL_APP-PRD" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_APP-PRD"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

resource "oci_core_security_list" "SL_BD-PRD" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_BD-PRD"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

resource "oci_core_security_list" "SL_APP-FQA" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_APP-FQA"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

resource "oci_core_security_list" "SL_BD-FQA" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_BD-FQA"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

resource "oci_core_security_list" "SL_CUSTOMAPP-FQA" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_CUSTOMAPP-FQA"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

resource "oci_core_security_list" "SL_BD-DEV" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "SL_BD-DEV"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        description = "Egress to any ip"
        stateless = "false"
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"
    
        description = "TCP Ingress for ssh"
    
        stateless = "false"
        tcp_options {
    
            #Optional
            max = 22
            min = 22
        }
    }

    ingress_security_rules {
        protocol = 1
        source = "0.0.0.0/0"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = 1
        source = "10.0.0.0/22"
        stateless = "false"
    }
}

#------------------------------------------- NSGs

resource "oci_core_network_security_group" "NSG_NONPROD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "NSG_NONPROD"
}

#------------------------------------------- RTs

resource "oci_core_route_table" "RT_APP-PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "RT_APP-PRD"
}

resource "oci_core_route_table" "RT_BD-PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "RT_BD-PRD"
}

resource "oci_core_route_table" "RT_APP-FQA" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "RT_APP-FQA"
}

resource "oci_core_route_table" "RT_BD-FQA" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "RT_BD-FQA"
}

resource "oci_core_route_table" "RT_CUSTOMAPP-FQA" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "RT_CUSTOMAPP-FQA"
}

resource "oci_core_route_table" "RT_BD-DEV" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "RT_BD-DEV"

    route_rules {
        #Required
        network_entity_id = "${oci_core_service_gateway.SGW_VCN-NONPRD.id}"

        #Optional
        #cidr_block = var.route_table_route_rules_cidr_block
        description = "Intento"
        destination = "all-iad-services-in-oracle-services-network"
        destination_type = "SERVICE_CIDR_BLOCK"
    }
}

#------------------------------------------- IGWs

resource "oci_core_internet_gateway" "IGW_VCN_PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "IGW_VCN_PRD"
    enabled = "true"
}

resource "oci_core_internet_gateway" "IGW_VCN-NONPRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "IGW_VCN-NONPRD"
    enabled = "true"
}

#------------------------------------------- SGWs

resource "oci_core_service_gateway" "SGW_VCN-PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    display_name = "SGW_VCN-PRD"
    services {
        #Required
        service_id = "${data.oci_core_services.test_services.services.0.id}"
    }
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"

    #Optional
    route_table_id = "${oci_core_route_table.RT_APP-PRD.id}"
}

resource "oci_core_service_gateway" "SGW_VCN-NONPRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    display_name = "SGW_VCN-NONPRD"
    services {
        #Required
        service_id = "${data.oci_core_services.test_services.services.1.id}"
    }
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"

    #Optional
    route_table_id = "${oci_core_route_table.RT_BD-FQA.id}"
}

#------------------------------------------- Services

data "oci_core_services" "test_services" {
}
output "services" { 
    value = "${data.oci_core_services.test_services.services}"
}

#------------------------------------------- RT attachment to subnet

resource "oci_core_route_table_attachment" "RT_APP-PRD_S_APP-PRD" {
  subnet_id = "${oci_core_subnet.S_APP-PRD.id}"
  route_table_id = "${oci_core_route_table.RT_APP-PRD.id}"
}

resource "oci_core_route_table_attachment" "RT_BD-PRD_S_BD-PRD" {
  subnet_id = "${oci_core_subnet.S_BD-PRD.id}"
  route_table_id = "${oci_core_route_table.RT_BD-PRD.id}"
}

resource "oci_core_route_table_attachment" "RT_APP-FQA_S_APP-FQA" {
  subnet_id = "${oci_core_subnet.S_APP-FQA.id}"
  route_table_id = "${oci_core_route_table.RT_APP-FQA.id}"
}

resource "oci_core_route_table_attachment" "RT_BD-FQA_S_BD-FQA" {
  subnet_id = "${oci_core_subnet.S_BD-FQA.id}"
  route_table_id = "${oci_core_route_table.RT_BD-FQA.id}"
}

resource "oci_core_route_table_attachment" "RT_CUSTOMAPP-FQA_S_CUSTOMAPP-FQA" {
  subnet_id = "${oci_core_subnet.S_CUSTOMAPP-FQA.id}"
  route_table_id = "${oci_core_route_table.RT_CUSTOMAPP-FQA.id}"
}

resource "oci_core_route_table_attachment" "RT_BD-DEV_BD-DEV" {
  subnet_id = "${oci_core_subnet.BD-DEV.id}"
  route_table_id = "${oci_core_route_table.RT_BD-DEV.id}"
}

#------------------------------------------- Instance

resource "oci_core_instance" "BASTION" {
    availability_domain = "us-ashburn-1"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaal3ixa5anu2k63av2hjpm2y7tm6isuso5y6gjte22njgtkqbxdk6q"
    shape = "VM.Standard.E2.1.Micro"
    display_name = "BASTION"
    extended_metadata = {
        some_string = "stringA"
        nested_object = "{\"some_string\": \"stringB\", \"object\": {\"some_string\": \"stringC\"}}"
    }
    fault_domain = "FAULT-DOMAIN-1"
    hostname_label = "BASTION"
    source_details {
        source_id = "ocid1.image.oc1.iad.aaaaaaaaqdc7jslbtue7abhwvxaq3ihvazfvihhs2rwk2mvciv36v7ux5sda"
        source_type = "image"
    }
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "${oci_core_subnet.S_APP-PRD.id}"
    }
    metadata = {

    }
    preserve_boot_volume = false
}

#------------------------------------------- PRUEBA Sgw

data "oci_core_service_gateways" "test_service_gateways" {
    #Required
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa7th5ozo2pr5dr3xbwcepdlehlmbn6nehzskfl35ahw66szyc2j7a"
}
output "sgw" {
    value = "${data.oci_core_service_gateways.test_service_gateways.service_gateways}"
}
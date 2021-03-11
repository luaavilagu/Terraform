
resource "oci_core_vcn" "VCN_PRD"{ 
cidr_block = "10.0.0.0/22" 
dns_label = "VCNPRD1" 
compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
display_name = "VCN_PRD"
} 

resource "oci_core_internet_gateway" "IGW_VCN_PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "IGW_VCN_PRD"
    enabled = "true"
}

data "oci_core_services" "test_services" {
}
output "test_services" { 
    value = "${data.oci_core_services.test_services.services}"
}

resource "oci_core_route_table" "RT_VCN_PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "RT_VCN_PRD"
}

resource "oci_core_service_gateway" "SGW_VCN_PRD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    services {
        #Required
        service_id = "${data.oci_core_services.test_services.services.0.id}"
    }
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"

    #Optional
    #display_name = "SGW_VCN_PRD"
    #route_table_id = "${oci_core_route_table.RT_VCN_PRD.id}"
}

resource "oci_core_subnet" "APP-PRD" {
    cidr_block = "10.0.0.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "APP-PRD"
    dns_label = "APPPRD1"
}

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

resource "oci_core_subnet" "BD-PRD" {
    cidr_block = "10.0.1.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "BD-PRD"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "BDPRD1"
}

resource "oci_core_security_list" "BD-PRD" {
    
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_PRD.id}"
    display_name = "BD-PRD"

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

resource "oci_core_vcn" "VCN_NONPRD"{ 
    cidr_block = "10.0.4.0/22" 
    dns_label = "VCNNONPRD1" 
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq" 
    display_name = "VCN_NONPRD"
} 

resource "oci_core_subnet" "APP-FQA" {
    cidr_block = "10.0.4.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "APP-FQA"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "APPFQA1"
}

resource "oci_core_subnet" "BD-FQA" {
    cidr_block = "10.0.5.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "BD-FQA"
    prohibit_public_ip_on_vnic = "true"
    dns_label = "BDFQA1"
}

resource "oci_core_subnet" "CUSTOMAPP-FQA" {
    cidr_block = "10.0.6.0/24"
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "CUSTOMAPP-FQA"
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

resource "oci_core_network_security_group" "NSG_NONPROD" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaan3mcv6dzha2vestcsfjn6prwet6ws3zi3lxpalbvewey6n6rehdq"
    vcn_id = "${oci_core_vcn.VCN_NONPRD.id}"
    display_name = "NSG_NONPROD"
}

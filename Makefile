
include constants

list:
	openstack stack list

boot_uplaybox:
	heat stack-create -P name="playbox" -P image=${U1404} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/playbox.yaml" playbox

boot_cplaybox:
	heat stack-create -P name="playbox" -P image=${CENTOS7} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/playbox.yaml" playbox

boot_ukeystone:
	heat stack-create -P name="keystone" -P image=${U1404} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/keystone.yaml" keystone

boot_ckeystone:
	heat stack-create -P name="keystone" -P image=${CENTOS7} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/keystone.yaml" keystone

boot_uguts:
	heat stack-create -P name="guts" -P image=${U1404} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/guts.yaml" guts

boot_cguts:
	# openstack stack create --parameter image=${CENTOS7} --parameter network=${NETWORK_ALOK} \
	# --parameter subnet=${SUBNET_ALOK} --parameter security_group=${SEC_GRP_ALOK} -t "heat-templates/guts.yaml" guts
	heat stack-create -P image=${CENTOS7} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -f "heat-templates/guts.yaml" guts

boot_guts_dashboard:
	heat stack-create -P name="gdashboard" -P image=${IMAGE} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -P floating_ip=${FLOATING_IP_181} -f "heat-templates/guts_dashboard.yaml" \
	guts_dashboard

boot_guts_source:
	heat stack-create -P name="gsource" -P image=${IMAGE} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -P keypair='cloud' -f "heat-templates/guts_source.yaml" guts_source

boot_okanbox:
	heat stack-create -P name="okanbox" -P image=${IMAGE} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -P floating_ip=${FLOATING_IP_204} -f "heat-templates/okanbox.yaml" okanbox


boot_aio:
	heat stack-create -P name="aio" -P image=${IMAGE} -P network=${NETWORK_ALOK} -P subnet=${SUBNET_ALOK} \
	-P security_group=${SEC_GRP_ALOK} -P floating_ip=${FLOATING_IP_181} -f "heat-templates/aio.yaml" aio

boot_devstack:
	heat stack-create -P name="devstack" -P image=${U1404} -P network=${NETWORK_OKANSTACK} \
	-P subnet=${SUBNET_OKANSTACK} -P security_group=${SEC_GRP_ALOK} -P floating_ip=${FLOATING_IP_181} \
	-f "heat-templates/devstack.yaml" devstack

build_u1404:
	cd packer && ./packer build -var-file u1404_variables.json u1404.json

build_centos7:
	cd packer && ./packer build -var-file centos7_variables.json centos7.json

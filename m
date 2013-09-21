Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 7/8] sdptool: Remove support for adding and removing service records
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379599248-7923-8-git-send-email-szymon.janc@tieto.com>
Date: Sat, 21 Sep 2013 12:27:02 -0500
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <F3FF0CE0-2D7E-4853-9FE9-E7577C52A732@holtmann.org>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com> <1379599248-7923-8-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> SDP database should now be controlled only by adapters. SDP code
> is no longer able to notify controllers about external changes to
> database. This results in services added/removed by sdptool being
> not updated properly in adapter structure.
> ---
> tools/sdptool.1 |   16 -
> tools/sdptool.c | 2595 ++-----------------------------------------------------
> 2 files changed, 54 insertions(+), 2557 deletions(-)

this is a bit dangerous. We still need sdptool for qualification purposes. So I rather keep it around.

Regards

Marcel

> 
> diff --git a/tools/sdptool.1 b/tools/sdptool.1
> index 88ad818..ee95e67 100644
> --- a/tools/sdptool.1
> +++ b/tools/sdptool.1
> @@ -82,18 +82,6 @@ Browse all available services on the device
> specified by a Bluetooth address as a parameter.
> .IP "\fBrecords [--tree] [--raw] [--xml] bdaddr\fP" 10
> Retrieve all possible service records.
> -.IP "\fBadd [ --handle=N --channel=N ]\fP" 10
> -Add a service to the local
> -SDP database.
> -.IP "" 10
> -You can specify a handle for this record using
> -the \fB--handle\fP option.
> -.IP "" 10
> -You can specify a channel to add the service on
> -using the \fB--channel\fP option.
> -.IP "\fBdel record_handle\fP" 10
> -Remove a service from the local
> -SDP database.
> .IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10
> Retrieve a service from the local
> SDP database.
> @@ -112,10 +100,6 @@ Displays help on using sdptool.
> sdptool browse 00:80:98:24:15:6D
> .PP
> sdptool browse local
> -.PP
> -sdptool add DUN
> -.PP
> -sdptool del 0x10000
> .SH "BUGS"
> .PP
> Documentation needs improving.
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index c241655..7d1121d 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -1145,2148 +1145,30 @@ static void print_service_attr(sdp_record_t *rec)
> 	}
> }
> 
> -/*
> - * Support for Service (de)registration
> - */
> -typedef struct {
> -	uint32_t handle;
> -	char *name;
> -	char *provider;
> -	char *desc;
> -	unsigned int class;
> -	unsigned int profile;
> -	uint16_t psm;
> -	uint8_t channel;
> -	uint8_t network;
> -} svc_info_t;
> -
> -static int add_sp(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
> -	uuid_t root_uuid, sp_uuid, l2cap, rfcomm;
> -	sdp_profile_desc_t profile;
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 1;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -	sdp_list_free(root, 0);
> -
> -	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &sp_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -	sdp_list_free(svclass_id, 0);
> -
> -	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
> -	profile.version = 0x0100;
> -	profiles = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, profiles);
> -	sdp_list_free(profiles, 0);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_add_lang_attr(&record);
> -
> -	sdp_set_info_attr(&record, "Serial Port", "BlueZ", "COM Port");
> -
> -	sdp_set_url_attr(&record, "http://www.bluez.org/",
> -			"http://www.bluez.org/", "http://www.bluez.org/");
> -
> -	sdp_set_service_id(&record, sp_uuid);
> -	sdp_set_service_ttl(&record, 0xffff);
> -	sdp_set_service_avail(&record, 0xff);
> -	sdp_set_record_state(&record, 0x00001234);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Serial Port service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_dun(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root, *aproto;
> -	uuid_t rootu, dun, gn, l2cap, rfcomm;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 2;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&rootu, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &rootu);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&dun, DIALUP_NET_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &dun);
> -	sdp_uuid16_create(&gn,  GENERIC_NETWORKING_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &gn);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, DIALUP_NET_PROFILE_ID);
> -	profile.version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Dial-Up Networking", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Dial-Up Networking service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_fax(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, fax_uuid, tel_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel? si->channel : 3;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&fax_uuid, FAX_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &fax_uuid);
> -	sdp_uuid16_create(&tel_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &tel_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, FAX_PROFILE_ID);
> -	profile.version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq  = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Fax", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -	printf("Fax service registered\n");
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -	return ret;
> -}
> -
> -static int add_lan(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 4;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, LAN_ACCESS_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, LAN_ACCESS_PROFILE_ID);
> -	profile.version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "LAN Access over PPP", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("LAN Access service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_headset(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 5;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, HEADSET_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
> -	profile.version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Headset", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Headset service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_headset_ag(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 7;
> -	sdp_data_t *channel;
> -	uint8_t netid = si->network ? si->network : 0x01; // ???? profile document
> -	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
> -	profile.version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Voice Gateway", 0, 0);
> -
> -	sdp_attr_add(&record, SDP_ATTR_EXTERNAL_NETWORK, network);
> -
> -	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Headset AG service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_handsfree(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 6;
> -	uint16_t u16 = 0x31;
> -	sdp_data_t *channel, *features;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, HANDSFREE_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
> -	profile.version = 0x0101;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	features = sdp_data_alloc(SDP_UINT16, &u16);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Handsfree", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Handsfree service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_handsfree_ag(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel : 7;
> -	uint16_t u16 = 0x17;
> -	sdp_data_t *channel, *features;
> -	uint8_t netid = si->network ? si->network : 0x01; // ???? profile document
> -	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
> -	profile.version = 0x0105;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	features = sdp_data_alloc(SDP_UINT16, &u16);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Voice Gateway", 0, 0);
> -
> -	sdp_attr_add(&record, SDP_ATTR_EXTERNAL_NETWORK, network);
> -
> -	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Handsfree AG service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_simaccess(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel? si->channel : 8;
> -	uint16_t u16 = 0x31;
> -	sdp_data_t *channel, *features;
> -	int ret = 0;
> -
> -	memset((void *)&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&svclass_uuid, SAP_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &svclass_uuid);
> -	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
> -	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile.uuid, SAP_PROFILE_ID);
> -	profile.version = 0x0101;
> -	pfseq = sdp_list_append(0, &profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	features = sdp_data_alloc(SDP_UINT16, &u16);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "SIM Access", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("SIM Access service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_opush(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, opush_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_record_t record;
> -	uint8_t chan = si->channel ? si->channel : 9;
> -	sdp_data_t *channel;
> -	uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xff };
> -	void *dtds[sizeof(formats)], *values[sizeof(formats)];
> -	unsigned int i;
> -	uint8_t dtd = SDP_UINT8;
> -	sdp_data_t *sflist;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&opush_uuid, OBEX_OBJPUSH_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &opush_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &chan);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
> -	proto[2] = sdp_list_append(0, &obex_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	for (i = 0; i < sizeof(formats); i++) {
> -		dtds[i] = &dtd;
> -		values[i] = &formats[i];
> -	}
> -	sflist = sdp_seq_alloc(dtds, values, sizeof(formats));
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FORMATS_LIST, sflist);
> -
> -	sdp_set_info_attr(&record, "OBEX Object Push", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("OBEX Object Push service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(proto[2], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_pbap(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, pbap_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_record_t record;
> -	uint8_t chan = si->channel ? si->channel : 19;
> -	sdp_data_t *channel;
> -	uint8_t formats[] = {0x01};
> -	uint8_t dtd = SDP_UINT8;
> -	sdp_data_t *sflist;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&pbap_uuid, PBAP_PSE_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &pbap_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, PBAP_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &chan);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
> -	proto[2] = sdp_list_append(0, &obex_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sflist = sdp_data_alloc(dtd,formats);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_REPOSITORIES, sflist);
> -
> -	sdp_set_info_attr(&record, "OBEX Phonebook Access Server", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record,
> -			SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("PBAP service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(proto[2], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_ftp(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, ftrn_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_record_t record;
> -	uint8_t u8 = si->channel ? si->channel: 10;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&ftrn_uuid, OBEX_FILETRANS_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &ftrn_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, OBEX_FILETRANS_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &u8);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
> -	proto[2] = sdp_list_append(0, &obex_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "OBEX File Transfer", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("OBEX File Transfer service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(proto[2], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_directprint(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, opush_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_record_t record;
> -	uint8_t chan = si->channel ? si->channel : 12;
> -	sdp_data_t *channel;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&opush_uuid, DIRECT_PRINTING_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &opush_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, BASIC_PRINTING_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> -	channel = sdp_data_alloc(SDP_UINT8, &chan);
> -	proto[1] = sdp_list_append(proto[1], channel);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
> -	proto[2] = sdp_list_append(0, &obex_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Direct Printing", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("Direct Printing service registered\n");
> -
> -end:
> -	sdp_data_free(channel);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(proto[2], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_nap(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, ftrn_uuid, l2cap_uuid, bnep_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint16_t lp = 0x000f, ver = 0x0100;
> -	sdp_data_t *psm, *version;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&ftrn_uuid, NAP_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &ftrn_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, NAP_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&bnep_uuid, BNEP_UUID);
> -	proto[1] = sdp_list_append(0, &bnep_uuid);
> -	version  = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -
> -	{
> -		uint16_t ptype[4] = { 0x0010, 0x0020, 0x0030, 0x0040 };
> -		sdp_data_t *head, *pseq;
> -		int p;
> -
> -		for (p = 0, head = NULL; p < 4; p++) {
> -			sdp_data_t *data = sdp_data_alloc(SDP_UINT16, &ptype[p]);
> -			head = sdp_seq_append(head, data);
> -		}
> -		pseq = sdp_data_alloc(SDP_SEQ16, head);
> -		proto[1] = sdp_list_append(proto[1], pseq);
> -	}
> -
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Network Access Point Service", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("NAP service registered\n");
> -
> -end:
> -	sdp_data_free(version);
> -	sdp_data_free(psm);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_gn(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, ftrn_uuid, l2cap_uuid, bnep_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint16_t lp = 0x000f, ver = 0x0100;
> -	sdp_data_t *psm, *version;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&ftrn_uuid, GN_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &ftrn_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, GN_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&bnep_uuid, BNEP_UUID);
> -	proto[1] = sdp_list_append(0, &bnep_uuid);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Group Network Service", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("GN service registered\n");
> -
> -end:
> -	sdp_data_free(version);
> -	sdp_data_free(psm);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_panu(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, ftrn_uuid, l2cap_uuid, bnep_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint16_t lp = 0x000f, ver = 0x0100;
> -	sdp_data_t *psm, *version;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -	sdp_list_free(root, NULL);
> -
> -	sdp_uuid16_create(&ftrn_uuid, PANU_SVCLASS_ID);
> -	svclass_id = sdp_list_append(NULL, &ftrn_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -	sdp_list_free(svclass_id, NULL);
> -
> -	sdp_uuid16_create(&profile[0].uuid, PANU_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(NULL, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -	sdp_list_free(pfseq, NULL);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(NULL, proto[0]);
> -
> -	sdp_uuid16_create(&bnep_uuid, BNEP_UUID);
> -	proto[1] = sdp_list_append(NULL, &bnep_uuid);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(NULL, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "PAN User", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("PANU service registered\n");
> -
> -end:
> -	sdp_data_free(version);
> -	sdp_data_free(psm);
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_hid_keyb(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, hidkb_uuid, l2cap_uuid, hidp_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_data_t *psm, *lang_lst, *lang_lst2, *hid_spec_lst, *hid_spec_lst2;
> -	unsigned int i;
> -	uint8_t dtd = SDP_UINT16;
> -	uint8_t dtd2 = SDP_UINT8;
> -	uint8_t dtd_data = SDP_TEXT_STR8;
> -	void *dtds[2];
> -	void *values[2];
> -	void *dtds2[2];
> -	void *values2[2];
> -	int leng[2];
> -	uint8_t hid_spec_type = 0x22;
> -	uint16_t hid_attr_lang[] = { 0x409, 0x100 };
> -	static const uint16_t ctrl = 0x11;
> -	static const uint16_t intr = 0x13;
> -	static const uint16_t hid_attr[] = { 0x100, 0x111, 0x40, 0x0d, 0x01, 0x01 };
> -	static const uint16_t hid_attr2[] = { 0x0, 0x01, 0x100, 0x1f40, 0x01, 0x01 };
> -	const uint8_t hid_spec[] = {
> -		0x05, 0x01, // usage page
> -		0x09, 0x06, // keyboard
> -		0xa1, 0x01, // key codes
> -		0x85, 0x01, // minimum
> -		0x05, 0x07, // max
> -		0x19, 0xe0, // logical min
> -		0x29, 0xe7, // logical max
> -		0x15, 0x00, // report size
> -		0x25, 0x01, // report count
> -		0x75, 0x01, // input data variable absolute
> -		0x95, 0x08, // report count
> -		0x81, 0x02, // report size
> -		0x75, 0x08,
> -		0x95, 0x01,
> -		0x81, 0x01,
> -		0x75, 0x01,
> -		0x95, 0x05,
> -		0x05, 0x08,
> -		0x19, 0x01,
> -		0x29, 0x05,
> -		0x91, 0x02,
> -		0x75, 0x03,
> -		0x95, 0x01,
> -		0x91, 0x01,
> -		0x75, 0x08,
> -		0x95, 0x06,
> -		0x15, 0x00,
> -		0x26, 0xff,
> -		0x00, 0x05,
> -		0x07, 0x19,
> -		0x00, 0x2a,
> -		0xff, 0x00,
> -		0x81, 0x00,
> -		0x75, 0x01,
> -		0x95, 0x01,
> -		0x15, 0x00,
> -		0x25, 0x01,
> -		0x05, 0x0c,
> -		0x09, 0xb8,
> -		0x81, 0x06,
> -		0x09, 0xe2,
> -		0x81, 0x06,
> -		0x09, 0xe9,
> -		0x81, 0x02,
> -		0x09, 0xea,
> -		0x81, 0x02,
> -		0x75, 0x01,
> -		0x95, 0x04,
> -		0x81, 0x01,
> -		0xc0         // end tag
> -	};
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_add_lang_attr(&record);
> -
> -	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &hidkb_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, HID_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	/* protocols */
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[1] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &ctrl);
> -	proto[1] = sdp_list_append(proto[1], psm);
> -	apseq = sdp_list_append(0, proto[1]);
> -
> -	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> -	proto[2] = sdp_list_append(0, &hidp_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	/* additional protocols */
> -	proto[1] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &intr);
> -	proto[1] = sdp_list_append(proto[1], psm);
> -	apseq = sdp_list_append(0, proto[1]);
> -
> -	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> -	proto[2] = sdp_list_append(0, &hidp_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_add_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "HID Keyboard", NULL, NULL);
> -
> -	for (i = 0; i < sizeof(hid_attr) / 2; i++)
> -		sdp_attr_add_new(&record,
> -					SDP_ATTR_HID_DEVICE_RELEASE_NUMBER + i,
> -					SDP_UINT16, &hid_attr[i]);
> -
> -	dtds[0] = &dtd2;
> -	values[0] = &hid_spec_type;
> -	dtds[1] = &dtd_data;
> -	values[1] = (uint8_t *) hid_spec;
> -	leng[0] = 0;
> -	leng[1] = sizeof(hid_spec);
> -	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng, 2);
> -	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
> -	sdp_attr_add(&record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
> -
> -	for (i = 0; i < sizeof(hid_attr_lang) / 2; i++) {
> -		dtds2[i] = &dtd;
> -		values2[i] = &hid_attr_lang[i];
> -	}
> -
> -	lang_lst = sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang) / 2);
> -	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);
> -	sdp_attr_add(&record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_SDP_DISABLE, SDP_UINT16, &hid_attr2[0]);
> -
> -	for (i = 0; i < sizeof(hid_attr2) / 2 - 1; i++)
> -		sdp_attr_add_new(&record, SDP_ATTR_HID_REMOTE_WAKEUP + i,
> -						SDP_UINT16, &hid_attr2[i + 1]);
> -
> -	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("HID keyboard service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_hid_wiimote(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, hid_uuid, l2cap_uuid, hidp_uuid;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[3];
> -	sdp_data_t *psm, *lang_lst, *lang_lst2, *hid_spec_lst, *hid_spec_lst2;
> -	unsigned int i;
> -	uint8_t dtd = SDP_UINT16;
> -	uint8_t dtd2 = SDP_UINT8;
> -	uint8_t dtd_data = SDP_TEXT_STR8;
> -	void *dtds[2];
> -	void *values[2];
> -	void *dtds2[2];
> -	void *values2[2];
> -	int leng[2];
> -	uint8_t hid_spec_type = 0x22;
> -	uint16_t hid_attr_lang[] = { 0x409, 0x100 };
> -	uint16_t ctrl = 0x11, intr = 0x13;
> -	uint16_t hid_release = 0x0100, parser_version = 0x0111;
> -	uint8_t subclass = 0x04, country = 0x33;
> -	uint8_t virtual_cable = 0, reconnect = 1, sdp_disable = 0;
> -	uint8_t battery = 1, remote_wakeup = 1;
> -	uint16_t profile_version = 0x0100, superv_timeout = 0x0c80;
> -	uint8_t norm_connect = 0, boot_device = 0;
> -	const uint8_t hid_spec[] = {
> -		0x05, 0x01, 0x09, 0x05, 0xa1, 0x01, 0x85, 0x10,
> -		0x15, 0x00, 0x26, 0xff, 0x00, 0x75, 0x08, 0x95,
> -		0x01, 0x06, 0x00, 0xff, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x11, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x12, 0x95, 0x02, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x13, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x14, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x15, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x16, 0x95, 0x15, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x17, 0x95, 0x06, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x18, 0x95, 0x15, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x19, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x1a, 0x95, 0x01, 0x09, 0x01, 0x91, 0x00,
> -		0x85, 0x20, 0x95, 0x06, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x21, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x22, 0x95, 0x04, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x30, 0x95, 0x02, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x31, 0x95, 0x05, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x32, 0x95, 0x0a, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x33, 0x95, 0x11, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x34, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x35, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x36, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x37, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x3d, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x3e, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0x85, 0x3f, 0x95, 0x15, 0x09, 0x01, 0x81, 0x00,
> -		0xc0, 0x00
> -	};
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&hid_uuid, HID_SVCLASS_ID);
> -	svclass_id = sdp_list_append(NULL, &hid_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, HID_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(NULL, profile);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto[1] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &ctrl);
> -	proto[1] = sdp_list_append(proto[1], psm);
> -	apseq = sdp_list_append(0, proto[1]);
> -
> -	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> -	proto[2] = sdp_list_append(0, &hidp_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	proto[1] = sdp_list_append(0, &l2cap_uuid);
> -	psm = sdp_data_alloc(SDP_UINT16, &intr);
> -	proto[1] = sdp_list_append(proto[1], psm);
> -	apseq = sdp_list_append(0, proto[1]);
> -
> -	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
> -	proto[2] = sdp_list_append(0, &hidp_uuid);
> -	apseq = sdp_list_append(apseq, proto[2]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_add_access_protos(&record, aproto);
> -
> -	sdp_add_lang_attr(&record);
> -
> -	sdp_set_info_attr(&record, "Nintendo RVL-CNT-01",
> -					"Nintendo", "Nintendo RVL-CNT-01");
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_DEVICE_RELEASE_NUMBER,
> -						SDP_UINT16, &hid_release);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_PARSER_VERSION,
> -						SDP_UINT16, &parser_version);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_DEVICE_SUBCLASS,
> -						SDP_UINT8, &subclass);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_COUNTRY_CODE,
> -						SDP_UINT8, &country);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_VIRTUAL_CABLE,
> -						SDP_BOOL, &virtual_cable);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_RECONNECT_INITIATE,
> -						SDP_BOOL, &reconnect);
> -
> -	dtds[0] = &dtd2;
> -	values[0] = &hid_spec_type;
> -	dtds[1] = &dtd_data;
> -	values[1] = (uint8_t *) hid_spec;
> -	leng[0] = 0;
> -	leng[1] = sizeof(hid_spec);
> -	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng, 2);
> -	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
> -	sdp_attr_add(&record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
> -
> -	for (i = 0; i < sizeof(hid_attr_lang) / 2; i++) {
> -		dtds2[i] = &dtd;
> -		values2[i] = &hid_attr_lang[i];
> -	}
> -
> -	lang_lst = sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang) / 2);
> -	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);
> -	sdp_attr_add(&record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_SDP_DISABLE,
> -						SDP_BOOL, &sdp_disable);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_BATTERY_POWER,
> -						SDP_BOOL, &battery);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_REMOTE_WAKEUP,
> -						SDP_BOOL, &remote_wakeup);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_PROFILE_VERSION,
> -						SDP_UINT16, &profile_version);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_SUPERVISION_TIMEOUT,
> -						SDP_UINT16, &superv_timeout);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_NORMALLY_CONNECTABLE,
> -						SDP_BOOL, &norm_connect);
> -
> -	sdp_attr_add_new(&record, SDP_ATTR_HID_BOOT_DEVICE,
> -						SDP_BOOL, &boot_device);
> -
> -	if (sdp_record_register(session, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("Wii-Mote service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_cip(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, cmtp, cip;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint16_t psm = si->psm ? si->psm : 0x1001;
> -	uint8_t netid = si->network ? si->network : 0x02; // 0x02 = ISDN, 0x03 = GSM
> -	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&cip, CIP_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &cip);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, CIP_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	apseq = sdp_list_append(0, proto[0]);
> -	proto[0] = sdp_list_append(proto[0], sdp_data_alloc(SDP_UINT16, &psm));
> -	apseq = sdp_list_append(apseq, proto[0]);
> -
> -	sdp_uuid16_create(&cmtp, CMTP_UUID);
> -	proto[1] = sdp_list_append(0, &cmtp);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_attr_add(&record, SDP_ATTR_EXTERNAL_NETWORK, network);
> -
> -	sdp_set_info_attr(&record, "Common ISDN Access", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("CIP service registered\n");
> -
> -end:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -	sdp_data_free(network);
> -
> -	return ret;
> -}
> -
> -static int add_ctp(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, tcsbin, ctp;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	uint8_t netid = si->network ? si->network : 0x02; // 0x01-0x07 cf. p120 profile document
> -	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&ctp, CORDLESS_TELEPHONY_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &ctp);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, CORDLESS_TELEPHONY_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&tcsbin, TCS_BIN_UUID);
> -	proto[1] = sdp_list_append(0, &tcsbin);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_attr_add(&record, SDP_ATTR_EXTERNAL_NETWORK, network);
> -
> -	sdp_set_info_attr(&record, "Cordless Telephony", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto end;
> -	}
> -
> -	printf("CTP service registered\n");
> -
> -end:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -	sdp_data_free(network);
> -
> -	return ret;
> -}
> -
> -static int add_a2source(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, avdtp, a2src;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	sdp_data_t *psm, *version;
> -	uint16_t lp = 0x0019, ver = 0x0100;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&a2src, AUDIO_SOURCE_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &a2src);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&avdtp, AVDTP_UUID);
> -	proto[1] = sdp_list_append(0, &avdtp);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Audio Source", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto done;
> -	}
> -
> -	printf("Audio source service registered\n");
> -
> -done:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_a2sink(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, avdtp, a2snk;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	sdp_data_t *psm, *version;
> -	uint16_t lp = 0x0019, ver = 0x0100;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&a2snk, AUDIO_SINK_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &a2snk);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&avdtp, AVDTP_UUID);
> -	proto[1] = sdp_list_append(0, &avdtp);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Audio Sink", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto done;
> -	}
> -
> -	printf("Audio sink service registered\n");
> -
> -done:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_avrct(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, avctp, avrct;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	sdp_data_t *psm, *version, *features;
> -	uint16_t lp = 0x0017, ver = 0x0100, feat = 0x000f;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &avrct);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&avctp, AVCTP_UUID);
> -	proto[1] = sdp_list_append(0, &avctp);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	features = sdp_data_alloc(SDP_UINT16, &feat);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
> -
> -	sdp_set_info_attr(&record, "AVRCP CT", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto done;
> -	}
> -
> -	printf("Remote control service registered\n");
> -
> -done:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_avrtg(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> -	uuid_t root_uuid, l2cap, avctp, avrtg;
> -	sdp_profile_desc_t profile[1];
> -	sdp_list_t *aproto, *proto[2];
> -	sdp_record_t record;
> -	sdp_data_t *psm, *version, *features;
> -	uint16_t lp = 0x0017, ver = 0x0100, feat = 0x000f;
> -	int ret = 0;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(0, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&avrtg, AV_REMOTE_TARGET_SVCLASS_ID);
> -	svclass_id = sdp_list_append(0, &avrtg);
> -	sdp_set_service_classes(&record, svclass_id);
> -
> -	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
> -	profile[0].version = 0x0100;
> -	pfseq = sdp_list_append(0, &profile[0]);
> -	sdp_set_profile_descs(&record, pfseq);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(0, &l2cap);
> -	psm = sdp_data_alloc(SDP_UINT16, &lp);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(0, proto[0]);
> -
> -	sdp_uuid16_create(&avctp, AVCTP_UUID);
> -	proto[1] = sdp_list_append(0, &avctp);
> -	version = sdp_data_alloc(SDP_UINT16, &ver);
> -	proto[1] = sdp_list_append(proto[1], version);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(0, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	features = sdp_data_alloc(SDP_UINT16, &feat);
> -	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
> -
> -	sdp_set_info_attr(&record, "AVRCP TG", 0, 0);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		ret = -1;
> -		goto done;
> -	}
> -
> -	printf("Remote target service registered\n");
> -
> -done:
> -	sdp_list_free(proto[0], 0);
> -	sdp_list_free(proto[1], 0);
> -	sdp_list_free(apseq, 0);
> -	sdp_list_free(aproto, 0);
> -
> -	return ret;
> -}
> -
> -static int add_udi_ue(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel: 18;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -	sdp_list_free(root, NULL);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -		sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid16_create(&svclass_uuid, UDI_MT_SVCLASS_ID);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -	sdp_list_free(svclass, NULL);
> -
> -	sdp_set_info_attr(&record, "UDI UE", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("UDI UE service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_udi_te(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel: 19;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -	sdp_list_free(root, NULL);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -		sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid16_create(&svclass_uuid, UDI_TA_SVCLASS_ID);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -	sdp_list_free(svclass, NULL);
> -
> -	sdp_set_info_attr(&record, "UDI TE", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("UDI TE service registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char sr1_uuid[] = {	0xbc, 0x19, 0x9c, 0x24, 0x95, 0x8b, 0x4c, 0xc0,
> 					0xa2, 0xcb, 0xfd, 0x8a, 0x30, 0xbf, 0x32, 0x06 };
> 
> -static int add_sr1(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass;
> -	uuid_t root_uuid, svclass_uuid;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) sr1_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_set_info_attr(&record, "TOSHIBA SR-1", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("Toshiba Speech Recognition SR-1 service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char syncmls_uuid[] = {	0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x10, 0x00,
> 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 };
> 
> static unsigned char syncmlc_uuid[] = {	0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x10, 0x00,
> 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 };
> 
> -static int add_syncml(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
> -	uint8_t channel = si->channel ? si->channel: 15;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) syncmlc_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -		sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(NULL, &obex_uuid));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_set_info_attr(&record, "SyncML Client", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("SyncML Client service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char async_uuid[] = {	0x03, 0x50, 0x27, 0x8F, 0x3D, 0xCA, 0x4E, 0x62,
> 					0x83, 0x1D, 0xA4, 0x11, 0x65, 0xFF, 0x90, 0x6C };
> 
> -static int add_activesync(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel: 21;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -	sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) async_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_set_info_attr(&record, "Microsoft ActiveSync", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("ActiveSync service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char hotsync_uuid[] = {	0xD8, 0x0C, 0xF9, 0xEA, 0x13, 0x4C, 0x11, 0xD5,
> 					0x83, 0xCE, 0x00, 0x30, 0x65, 0x7C, 0x54, 0x3C };
> 
> -static int add_hotsync(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel: 22;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -	sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) hotsync_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_set_info_attr(&record, "PalmOS HotSync", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("HotSync service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char palmos_uuid[] = {	0xF5, 0xBE, 0xB6, 0x51, 0x41, 0x71, 0x40, 0x51,
> 					0xAC, 0xF5, 0x6C, 0xA7, 0x20, 0x22, 0x42, 0xF0 };
> 
> -static int add_palmos(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass;
> -	uuid_t root_uuid, svclass_uuid;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) palmos_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("PalmOS service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char nokid_uuid[] = {	0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0x10, 0x00,
> 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
> 
> -static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass;
> -	uuid_t root_uuid, svclass_uuid;
> -	uint16_t verid = 0x005f;
> -	sdp_data_t *version = sdp_data_alloc(SDP_UINT16, &verid);
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) nokid_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_attr_add(&record, SDP_ATTR_SERVICE_VERSION, version);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		sdp_data_free(version);
> -		return -1;
> -	}
> -
> -	printf("Nokia ID service record registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char pcsuite_uuid[] = {	0x00, 0x00, 0x50, 0x02, 0x00, 0x00, 0x10, 0x00,
> 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
> 
> -static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel: 14;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -		sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid128_create(&svclass_uuid, (void *) pcsuite_uuid);
> -	svclass = sdp_list_append(NULL, &svclass_uuid);
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_set_info_attr(&record, "Nokia PC Suite", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("Nokia PC Suite service registered\n");
> -
> -	return 0;
> -}
> -
> static unsigned char nftp_uuid[] = {	0x00, 0x00, 0x50, 0x05, 0x00, 0x00, 0x10, 0x00,
> 					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
> 
> @@ -3302,436 +1184,69 @@ static unsigned char apple_uuid[] = {	0xf0, 0x72, 0x2e, 0x20, 0x0f, 0x8b, 0x4e,
> static unsigned char iap_uuid[] = {	0x00, 0x00, 0x00, 0x00, 0xde, 0xca, 0xfa, 0xde,
> 					0xde, 0xca, 0xde, 0xaf, 0xde, 0xca, 0xca, 0xfe };
> 
> -static int add_apple(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root;
> -	uuid_t root_uuid;
> -	uint32_t attr783 = 0x00000000;
> -	uint32_t attr785 = 0x00000002;
> -	uint16_t attr786 = 0x1234;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_attr_add_new(&record, 0x0780, SDP_UUID128, (void *) apple_uuid);
> -	sdp_attr_add_new(&record, 0x0781, SDP_TEXT_STR8, (void *) "Macmini");
> -	sdp_attr_add_new(&record, 0x0782, SDP_TEXT_STR8, (void *) "PowerMac10,1");
> -	sdp_attr_add_new(&record, 0x0783, SDP_UINT32, (void *) &attr783);
> -	sdp_attr_add_new(&record, 0x0784, SDP_TEXT_STR8, (void *) "1.6.6f22");
> -	sdp_attr_add_new(&record, 0x0785, SDP_UINT32, (void *) &attr785);
> -	sdp_attr_add_new(&record, 0x0786, SDP_UUID16, (void *) &attr786);
> -
> -	sdp_set_info_attr(&record, "Apple Macintosh Attributes", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("Apple attribute service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_isync(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_list_t *root, *svclass, *proto;
> -	uuid_t root_uuid, svclass_uuid, serial_uuid, l2cap_uuid, rfcomm_uuid;
> -	uint8_t channel = si->channel ? si->channel : 16;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(NULL, &l2cap_uuid));
> -
> -	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> -	proto = sdp_list_append(proto, sdp_list_append(
> -		sdp_list_append(NULL, &rfcomm_uuid), sdp_data_alloc(SDP_UINT8, &channel)));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid16_create(&serial_uuid, SERIAL_PORT_SVCLASS_ID);
> -	svclass = sdp_list_append(NULL, &serial_uuid);
> -
> -	sdp_uuid16_create(&svclass_uuid, APPLE_AGENT_SVCLASS_ID);
> -	svclass = sdp_list_append(svclass, &svclass_uuid);
> -
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_set_info_attr(&record, "AppleAgent", "Bluetooth acceptor", "Apple Computer Ltd.");
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	printf("Apple iSync service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_semchla(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_record_t record;
> -	sdp_profile_desc_t profile;
> -	sdp_list_t *root, *svclass, *proto, *profiles;
> -	uuid_t root_uuid, service_uuid, l2cap_uuid, semchla_uuid;
> -	uint16_t psm = 0xf0f9;
> -
> -	memset(&record, 0, sizeof(record));
> -	record.handle = si->handle;
> -
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -
> -	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> -	proto = sdp_list_append(NULL, sdp_list_append(
> -		sdp_list_append(NULL, &l2cap_uuid), sdp_data_alloc(SDP_UINT16, &psm)));
> -
> -	sdp_uuid32_create(&semchla_uuid, 0x8e770300);
> -	proto = sdp_list_append(proto, sdp_list_append(NULL, &semchla_uuid));
> -
> -	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
> -
> -	sdp_uuid32_create(&service_uuid, 0x8e771301);
> -	svclass = sdp_list_append(NULL, &service_uuid);
> -
> -	sdp_set_service_classes(&record, svclass);
> -
> -	sdp_uuid32_create(&profile.uuid, 0x8e771302);	// Headset
> -	//sdp_uuid32_create(&profile.uuid, 0x8e771303);	// Phone
> -	profile.version = 0x0100;
> -	profiles = sdp_list_append(NULL, &profile);
> -	sdp_set_profile_descs(&record, profiles);
> -
> -	sdp_set_info_attr(&record, "SEMC HLA", NULL, NULL);
> -
> -	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
> -		printf("Service Record registration failed\n");
> -		return -1;
> -	}
> -
> -	/* SEMC High Level Authentication */
> -	printf("SEMC HLA service registered\n");
> -
> -	return 0;
> -}
> -
> -static int add_gatt(sdp_session_t *session, svc_info_t *si)
> -{
> -	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
> -	uuid_t root_uuid, proto_uuid, gatt_uuid, l2cap;
> -	sdp_profile_desc_t profile;
> -	sdp_record_t record;
> -	sdp_data_t *psm, *sh, *eh;
> -	uint16_t att_psm = 27, start = 0x0001, end = 0x000f;
> -	int ret;
> -
> -	memset(&record, 0, sizeof(sdp_record_t));
> -	record.handle = si->handle;
> -	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> -	root = sdp_list_append(NULL, &root_uuid);
> -	sdp_set_browse_groups(&record, root);
> -	sdp_list_free(root, NULL);
> -
> -	sdp_uuid16_create(&gatt_uuid, GENERIC_ATTRIB_SVCLASS_ID);
> -	svclass_id = sdp_list_append(NULL, &gatt_uuid);
> -	sdp_set_service_classes(&record, svclass_id);
> -	sdp_list_free(svclass_id, NULL);
> -
> -	sdp_uuid16_create(&profile.uuid, GENERIC_ATTRIB_PROFILE_ID);
> -	profile.version = 0x0100;
> -	profiles = sdp_list_append(NULL, &profile);
> -	sdp_set_profile_descs(&record, profiles);
> -	sdp_list_free(profiles, NULL);
> -
> -	sdp_uuid16_create(&l2cap, L2CAP_UUID);
> -	proto[0] = sdp_list_append(NULL, &l2cap);
> -	psm = sdp_data_alloc(SDP_UINT16, &att_psm);
> -	proto[0] = sdp_list_append(proto[0], psm);
> -	apseq = sdp_list_append(NULL, proto[0]);
> -
> -	sdp_uuid16_create(&proto_uuid, ATT_UUID);
> -	proto[1] = sdp_list_append(NULL, &proto_uuid);
> -	sh = sdp_data_alloc(SDP_UINT16, &start);
> -	proto[1] = sdp_list_append(proto[1], sh);
> -	eh = sdp_data_alloc(SDP_UINT16, &end);
> -	proto[1] = sdp_list_append(proto[1], eh);
> -	apseq = sdp_list_append(apseq, proto[1]);
> -
> -	aproto = sdp_list_append(NULL, apseq);
> -	sdp_set_access_protos(&record, aproto);
> -
> -	sdp_set_info_attr(&record, "Generic Attribute Profile", "BlueZ", NULL);
> -
> -	sdp_set_url_attr(&record, "http://www.bluez.org/",
> -			"http://www.bluez.org/", "http://www.bluez.org/");
> -
> -	sdp_set_service_id(&record, gatt_uuid);
> -
> -	ret = sdp_device_record_register(session, &interface, &record,
> -							SDP_RECORD_PERSIST);
> -	if (ret < 0)
> -		printf("Service Record registration failed\n");
> -	else
> -		printf("Generic Attribute Profile Service registered\n");
> -
> -	sdp_data_free(psm);
> -	sdp_data_free(sh);
> -	sdp_data_free(eh);
> -	sdp_list_free(proto[0], NULL);
> -	sdp_list_free(proto[1], NULL);
> -	sdp_list_free(apseq, NULL);
> -	sdp_list_free(aproto, NULL);
> -
> -	return ret;
> -}
> -
> struct {
> 	char		*name;
> 	uint32_t	class;
> -	int		(*add)(sdp_session_t *sess, svc_info_t *si);
> 	unsigned char *uuid;
> } service[] = {
> -	{ "DID",	PNP_INFO_SVCLASS_ID,		NULL,		},
> -
> -	{ "SP",		SERIAL_PORT_SVCLASS_ID,		add_sp		},
> -	{ "DUN",	DIALUP_NET_SVCLASS_ID,		add_dun		},
> -	{ "LAN",	LAN_ACCESS_SVCLASS_ID,		add_lan		},
> -	{ "FAX",	FAX_SVCLASS_ID,			add_fax		},
> -	{ "OPUSH",	OBEX_OBJPUSH_SVCLASS_ID,	add_opush	},
> -	{ "FTP",	OBEX_FILETRANS_SVCLASS_ID,	add_ftp		},
> -	{ "PRINT",	DIRECT_PRINTING_SVCLASS_ID,	add_directprint	},
> -
> -	{ "HS",		HEADSET_SVCLASS_ID,		add_headset	},
> -	{ "HSAG",	HEADSET_AGW_SVCLASS_ID,		add_headset_ag	},
> -	{ "HF",		HANDSFREE_SVCLASS_ID,		add_handsfree	},
> -	{ "HFAG",	HANDSFREE_AGW_SVCLASS_ID,	add_handsfree_ag},
> -	{ "SAP",	SAP_SVCLASS_ID,			add_simaccess	},
> -	{ "PBAP",	PBAP_SVCLASS_ID,		add_pbap,	},
> -
> -	{ "NAP",	NAP_SVCLASS_ID,			add_nap		},
> -	{ "GN",		GN_SVCLASS_ID,			add_gn		},
> -	{ "PANU",	PANU_SVCLASS_ID,		add_panu	},
> -
> -	{ "HCRP",	HCR_SVCLASS_ID,			NULL		},
> -	{ "HID",	HID_SVCLASS_ID,			NULL		},
> -	{ "KEYB",	HID_SVCLASS_ID,			add_hid_keyb	},
> -	{ "WIIMOTE",	HID_SVCLASS_ID,			add_hid_wiimote	},
> -	{ "CIP",	CIP_SVCLASS_ID,			add_cip		},
> -	{ "CTP",	CORDLESS_TELEPHONY_SVCLASS_ID,	add_ctp		},
> -
> -	{ "A2SRC",	AUDIO_SOURCE_SVCLASS_ID,	add_a2source	},
> -	{ "A2SNK",	AUDIO_SINK_SVCLASS_ID,		add_a2sink	},
> -	{ "AVRCT",	AV_REMOTE_SVCLASS_ID,		add_avrct	},
> -	{ "AVRTG",	AV_REMOTE_TARGET_SVCLASS_ID,	add_avrtg	},
> -
> -	{ "UDIUE",	UDI_MT_SVCLASS_ID,		add_udi_ue	},
> -	{ "UDITE",	UDI_TA_SVCLASS_ID,		add_udi_te	},
> -
> -	{ "SEMCHLA",	0x8e771301,			add_semchla	},
> -
> -	{ "SR1",	0,				add_sr1,	sr1_uuid	},
> -	{ "SYNCML",	0,				add_syncml,	syncmlc_uuid	},
> -	{ "SYNCMLSERV",	0,				NULL,		syncmls_uuid	},
> -	{ "ACTIVESYNC",	0,				add_activesync,	async_uuid	},
> -	{ "HOTSYNC",	0,				add_hotsync,	hotsync_uuid	},
> -	{ "PALMOS",	0,				add_palmos,	palmos_uuid	},
> -	{ "NOKID",	0,				add_nokiaid,	nokid_uuid	},
> -	{ "PCSUITE",	0,				add_pcsuite,	pcsuite_uuid	},
> -	{ "NFTP",	0,				NULL,		nftp_uuid	},
> -	{ "NSYNCML",	0,				NULL,		nsyncml_uuid	},
> -	{ "NGAGE",	0,				NULL,		ngage_uuid	},
> -	{ "APPLE",	0,				add_apple,	apple_uuid	},
> -	{ "IAP",	0,				NULL,		iap_uuid	},
> -
> -	{ "ISYNC",	APPLE_AGENT_SVCLASS_ID,		add_isync,	},
> -	{ "GATT",	GENERIC_ATTRIB_SVCLASS_ID,	add_gatt,	},
> +	{ "DID",	PNP_INFO_SVCLASS_ID		},
> +
> +	{ "SP",		SERIAL_PORT_SVCLASS_ID		},
> +	{ "DUN",	DIALUP_NET_SVCLASS_ID		},
> +	{ "LAN",	LAN_ACCESS_SVCLASS_ID		},
> +	{ "FAX",	FAX_SVCLASS_ID			},
> +	{ "OPUSH",	OBEX_OBJPUSH_SVCLASS_ID		},
> +	{ "FTP",	OBEX_FILETRANS_SVCLASS_ID	},
> +	{ "PRINT",	DIRECT_PRINTING_SVCLASS_ID	},
> +
> +	{ "HS",		HEADSET_SVCLASS_ID		},
> +	{ "HSAG",	HEADSET_AGW_SVCLASS_ID		},
> +	{ "HF",		HANDSFREE_SVCLASS_ID		},
> +	{ "HFAG",	HANDSFREE_AGW_SVCLASS_ID	},
> +	{ "SAP",	SAP_SVCLASS_ID			},
> +	{ "PBAP",	PBAP_SVCLASS_ID			},
> +
> +	{ "NAP",	NAP_SVCLASS_ID			},
> +	{ "GN",		GN_SVCLASS_ID			},
> +	{ "PANU",	PANU_SVCLASS_ID			},
> +
> +	{ "HCRP",	HCR_SVCLASS_ID			},
> +	{ "HID",	HID_SVCLASS_ID			},
> +	{ "KEYB",	HID_SVCLASS_ID			},
> +	{ "WIIMOTE",	HID_SVCLASS_ID			},
> +	{ "CIP",	CIP_SVCLASS_ID			},
> +	{ "CTP",	CORDLESS_TELEPHONY_SVCLASS_ID	},
> +
> +	{ "A2SRC",	AUDIO_SOURCE_SVCLASS_ID		},
> +	{ "A2SNK",	AUDIO_SINK_SVCLASS_ID		},
> +	{ "AVRCT",	AV_REMOTE_SVCLASS_ID		},
> +	{ "AVRTG",	AV_REMOTE_TARGET_SVCLASS_ID	},
> +
> +	{ "UDIUE",	UDI_MT_SVCLASS_ID		},
> +	{ "UDITE",	UDI_TA_SVCLASS_ID		},
> +
> +	{ "SEMCHLA",	0x8e771301			},
> +
> +	{ "SR1",	0,				sr1_uuid	},
> +	{ "SYNCML",	0,				syncmlc_uuid	},
> +	{ "SYNCMLSERV",	0,				syncmls_uuid	},
> +	{ "ACTIVESYNC",	0,				async_uuid	},
> +	{ "HOTSYNC",	0,				hotsync_uuid	},
> +	{ "PALMOS",	0,				palmos_uuid	},
> +	{ "NOKID",	0,				nokid_uuid	},
> +	{ "PCSUITE",	0,				pcsuite_uuid	},
> +	{ "NFTP",	0,				nftp_uuid	},
> +	{ "NSYNCML",	0,				nsyncml_uuid	},
> +	{ "NGAGE",	0,				ngage_uuid	},
> +	{ "APPLE",	0,				apple_uuid	},
> +	{ "IAP",	0,				iap_uuid	},
> +
> +	{ "ISYNC",	APPLE_AGENT_SVCLASS_ID		},
> +	{ "GATT",	GENERIC_ATTRIB_SVCLASS_ID	},
> 
> 	{ 0 }
> };
> 
> -/* Add local service */
> -static int add_service(bdaddr_t *bdaddr, svc_info_t *si)
> -{
> -	sdp_session_t *sess;
> -	int i, ret = -1;
> -
> -	if (!si->name)
> -		return -1;
> -
> -	sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
> -	if (!sess)
> -		return -1;
> -
> -	for (i = 0; service[i].name; i++)
> -		if (!strcasecmp(service[i].name, si->name)) {
> -			if (service[i].add)
> -				ret = service[i].add(sess, si);
> -			goto done;
> -		}
> -
> -	printf("Unknown service name: %s\n", si->name);
> -
> -done:
> -	free(si->name);
> -	sdp_close(sess);
> -
> -	return ret;
> -}
> -
> -static struct option add_options[] = {
> -	{ "help",	0, 0, 'h' },
> -	{ "handle",	1, 0, 'r' },
> -	{ "psm",	1, 0, 'p' },
> -	{ "channel",	1, 0, 'c' },
> -	{ "network",	1, 0, 'n' },
> -	{ 0, 0, 0, 0 }
> -};
> -
> -static const char *add_help =
> -	"Usage:\n"
> -	"\tadd [--handle=RECORD_HANDLE --channel=CHANNEL] service\n";
> -
> -static int cmd_add(int argc, char **argv)
> -{
> -	svc_info_t si;
> -	int opt;
> -
> -	memset(&si, 0, sizeof(si));
> -	si.handle = 0xffffffff;
> -
> -	for_each_opt(opt, add_options, 0) {
> -		switch (opt) {
> -		case 'r':
> -			if (strncasecmp(optarg, "0x", 2))
> -				si.handle = atoi(optarg);
> -			else
> -				si.handle = strtol(optarg + 2, NULL, 16);
> -			break;
> -		case 'p':
> -			if (strncasecmp(optarg, "0x", 2))
> -				si.psm = atoi(optarg);
> -			else
> -				si.psm = strtol(optarg + 2, NULL, 16);
> -			break;
> -		case 'c':
> -			if (strncasecmp(optarg, "0x", 2))
> -				si.channel = atoi(optarg);
> -			else
> -				si.channel = strtol(optarg + 2, NULL, 16);
> -			break;
> -		case 'n':
> -			if (strncasecmp(optarg, "0x", 2))
> -				si.network = atoi(optarg);
> -			else
> -				si.network = strtol(optarg + 2, NULL, 16);
> -			break;
> -		default:
> -			printf("%s", add_help);
> -			return -1;
> -		}
> -	}
> -
> -	argc -= optind;
> -	argv += optind;
> -
> -	if (argc < 1) {
> -		printf("%s", add_help);
> -		return -1;
> -	}
> -
> -	si.name = strdup(argv[0]);
> -
> -	return add_service(0, &si);
> -}
> -
> -/* Delete local service */
> -static int del_service(bdaddr_t *bdaddr, void *arg)
> -{
> -	uint32_t handle, range = 0x0000ffff;
> -	sdp_list_t *attr;
> -	sdp_session_t *sess;
> -	sdp_record_t *rec;
> -
> -	if (!arg) {
> -		printf("Record handle was not specified.\n");
> -		return -1;
> -	}
> -
> -	sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
> -	if (!sess) {
> -		printf("No local SDP server!\n");
> -		return -1;
> -	}
> -
> -	handle = strtoul((char *)arg, 0, 16);
> -	attr = sdp_list_append(0, &range);
> -	rec = sdp_service_attr_req(sess, handle, SDP_ATTR_REQ_RANGE, attr);
> -	sdp_list_free(attr, 0);
> -
> -	if (!rec) {
> -		printf("Service Record not found.\n");
> -		sdp_close(sess);
> -		return -1;
> -	}
> -
> -	if (sdp_device_record_unregister(sess, &interface, rec)) {
> -		printf("Failed to unregister service record: %s\n", strerror(errno));
> -		sdp_close(sess);
> -		return -1;
> -	}
> -
> -	printf("Service Record deleted.\n");
> -	sdp_close(sess);
> -
> -	return 0;
> -}
> -
> -static struct option del_options[] = {
> -	{ "help",	0, 0, 'h' },
> -	{ 0, 0, 0, 0 }
> -};
> -
> -static const char *del_help =
> -	"Usage:\n"
> -	"\tdel record_handle\n";
> -
> -static int cmd_del(int argc, char **argv)
> -{
> -	int opt;
> -
> -	for_each_opt(opt, del_options, 0) {
> -		switch (opt) {
> -		default:
> -			printf("%s", del_help);
> -			return -1;
> -		}
> -	}
> -
> -	argc -= optind;
> -	argv += optind;
> -
> -	if (argc < 1) {
> -		printf("%s", del_help);
> -		return -1;
> -	}
> -
> -	return del_service(NULL, argv[0]);
> -}
> -
> /*
>  * Perform an inquiry and search/browse all peer found.
>  */
> @@ -4203,8 +1718,6 @@ static struct {
> 	{ "search",  cmd_search,      "Search for a service"          },
> 	{ "browse",  cmd_browse,      "Browse all available services" },
> 	{ "records", cmd_records,     "Request all records"           },
> -	{ "add",     cmd_add,         "Add local service"             },
> -	{ "del",     cmd_del,         "Delete local service"          },
> 	{ "get",     cmd_get,         "Get local service"             },
> 	{ "setattr", cmd_setattr,     "Set/Add attribute to a SDP record"          },
> 	{ "setseq",  cmd_setseq,      "Set/Add attribute sequence to a SDP record" },
> -- 
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


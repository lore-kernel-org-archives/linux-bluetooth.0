Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP records for HID and HCRP services
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1134931482.6881.22.camel@localhost>
References: <1134931482.6881.22.camel@localhost>
Content-Type: multipart/mixed; boundary="=-1qrbkDYmIB4XLEIkNBgS"
Message-Id: <1138247615.12526.22.camel@panic>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 25 Jan 2006 19:53:35 -0800


--=-1qrbkDYmIB4XLEIkNBgS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

On Sun, 2005-12-18 at 19:44 +0100, Marcel Holtmann wrote:
> Hi guys,
> 
> some of you played with SDP records for HID and HCRP services lately and
> I like to add support for them to sdptool. Anyone who wants to submit a
> patch for them?

here is the HID patch, also it only adds a keyboard record.

better late then never ... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
USS Enterprise Bumperstricker: We break for cubes!

--=-1qrbkDYmIB4XLEIkNBgS
Content-Disposition: attachment; filename=sdptool_hid.patch
Content-Type: text/x-patch; name=sdptool_hid.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-utils-2.25/tools/sdptool.c	2006-01-17 16:15:00.000000000 -0800
+++ bluez-utils-2.25_new/tools/sdptool.c	2006-01-25 19:49:12.000000000 -0800
@@ -1135,6 +1135,178 @@
 	sdp_list_free(langs, 0);
 }
 
+/*
+ *  add hid keyboard descriptor
+ */
+static int add_hid_keyboard(sdp_session_t *session, svc_info_t *si)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, hidkb_uuid, l2cap_uuid, hidp_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[3];
+	sdp_data_t *channel, *lang_lst, *lang_lst2, *hid_spec_lst, *hid_spec_lst2;
+	int i;
+	uint8_t dtd = SDP_UINT16;
+	uint8_t dtd2 = SDP_UINT8;
+	uint8_t dtd_data = SDP_TEXT_STR8;
+	void *dtds[2];
+	void *values[2];
+	void *dtds2[2];
+	void *values2[2];
+	int leng[2];
+	sdp_record_t *sdp_record;
+	uint8_t hid_spec_type = 0x22;
+	uint16_t hid_attr_lang[] = {0x409,0x100};
+	static const uint8_t ctrl = 0x11;
+	static const uint8_t intr = 0x13;
+	static const uint16_t hid_attr[] = {0x100,0x111,0x40,0x0d,0x01,0x01};
+	static const uint16_t hid_attr2[] = {0x0,0x01,0x100,0x1f40,0x01,0x01};
+	const uint8_t hid_spec[] = { 
+		0x05, 0x01, // usage page
+		0x09, 0x06, // keyboard
+		0xa1, 0x01, // key codes
+		0x85, 0x01, // minimum
+		0x05, 0x07, // max
+		0x19, 0xe0, // logical min
+		0x29, 0xe7, // logical max
+		0x15, 0x00, // report size
+		0x25, 0x01, // report count
+		0x75, 0x01, // input data variable absolute
+		0x95, 0x08, // report count
+		0x81, 0x02, // report size
+		0x75, 0x08, 
+		0x95, 0x01, 
+		0x81, 0x01, 
+		0x75, 0x01, 
+		0x95, 0x05,
+		0x05, 0x08,
+		0x19, 0x01,
+		0x29, 0x05, 
+		0x91, 0x02,
+		0x75, 0x03,
+		0x95, 0x01,
+		0x91, 0x01,
+		0x75, 0x08,
+		0x95, 0x06,
+		0x15, 0x00,
+		0x26, 0xff,
+		0x00, 0x05,
+		0x07, 0x19,
+		0x00, 0x2a,
+		0xff, 0x00,
+		0x81, 0x00,
+		0x75, 0x01,
+		0x95, 0x01,
+		0x15, 0x00,
+		0x25, 0x01,
+		0x05, 0x0c,
+		0x09, 0xb8,
+		0x81, 0x06,
+		0x09, 0xe2,
+		0x81, 0x06,
+		0x09, 0xe9,
+		0x81, 0x02,
+		0x09, 0xea,
+		0x81, 0x02,
+		0x75, 0x01,
+		0x95, 0x04,
+		0x81, 0x01,
+		0xc0         // end tag
+	};
+
+
+	if (!session) {
+		printf("%s: sdp_session invalid\n", (char*)__func__);
+		exit(-1);
+	}
+
+	sdp_record = sdp_record_alloc();
+	if (!sdp_record) {
+		perror("add_keyboard sdp_record_alloc: ");
+		exit(-1);
+	}
+
+	memset((void*)sdp_record, 0, sizeof(sdp_record_t));
+	sdp_record->handle = 0xffffffff;
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(sdp_record, root);
+
+	add_lang_attr(sdp_record);
+	
+	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &hidkb_uuid);
+	sdp_set_service_classes(sdp_record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, HID_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(0, profile);
+	sdp_set_profile_descs(sdp_record, pfseq);
+
+	// PROTO
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[1] = sdp_list_append(0, &l2cap_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ctrl);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(0, proto[1]);
+
+	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
+	proto[2] = sdp_list_append(0, &hidp_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(sdp_record, aproto);
+
+	// ATTR_ADD_PROTO
+	proto[1] = sdp_list_append(0, &l2cap_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &intr);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(0, proto[1]);
+
+	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
+	proto[2] = sdp_list_append(0, &hidp_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_add_access_protos(sdp_record, aproto);
+	
+	sdp_set_info_attr(sdp_record, "BlueZ HID Bluetooth Keyboard", "BlueZ", "http://www.bluez.org");
+
+	for (i = 0; i < sizeof(hid_attr)/2; i++) {
+		sdp_attr_add_new(sdp_record, SDP_ATTR_HID_DEVICE_RELEASE_NUMBER+i, SDP_UINT16, &hid_attr[i]);
+	}
+
+	dtds[0] = &dtd2;
+	values[0] = &hid_spec_type;
+	dtds[1] = &dtd_data;
+	values[1] = (uint8_t*)hid_spec;
+	leng[0] = 0;
+	leng[1] = sizeof(hid_spec);
+	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng, 2);
+	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);	
+	sdp_attr_add(sdp_record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
+	
+	for (i = 0; i < sizeof(hid_attr_lang)/2; i++) {
+		dtds2[i] = &dtd;
+		values2[i] = &hid_attr_lang[i];
+	}
+	lang_lst = sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang)/2);
+	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);	
+	sdp_attr_add(sdp_record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
+
+	sdp_attr_add_new(sdp_record, SDP_ATTR_HID_SDP_DISABLE, SDP_UINT16, &hid_attr2[0]);
+	for (i = 0; i < sizeof(hid_attr2)/2-1; i++) {
+		sdp_attr_add_new(sdp_record, SDP_ATTR_HID_REMOTE_WAKEUP+i, SDP_UINT16, &hid_attr2[i+1]);
+	}
+	
+	if (sdp_record_register(session, sdp_record, SDP_RECORD_PERSIST) < 0) {
+		printf("%s: HID Device (Keyboard) Service Record registration failed\n", (char*)__func__);
+		exit(-1);
+	}
+
+	return(1);
+}
+
 static int add_sp(sdp_session_t *session, svc_info_t *si)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
@@ -2659,7 +2831,7 @@
 	{ "GN",		GN_SVCLASS_ID,			add_gn		},
 	{ "PANU",	PANU_SVCLASS_ID,		add_panu	},
 
-	{ "HID",	HID_SVCLASS_ID,			NULL		},
+	{ "HID",	HID_SVCLASS_ID,			add_hid_keyboard		},
 	{ "CIP",	CIP_SVCLASS_ID,			NULL		},
 	{ "CTP",	CORDLESS_TELEPHONY_SVCLASS_ID,	add_ctp		},
 

--=-1qrbkDYmIB4XLEIkNBgS--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

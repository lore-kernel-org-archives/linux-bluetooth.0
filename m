Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 10:30:15 -0600
Message-ID: <CAAbnaHZVo-zW=QCvjEjd98rvN7RBwL8+ZS1Fi6E=LBmtKhCr9Q@mail.gmail.com>
Subject: [RFC generichid 2/5]
From: Nathaniel Haggard <natester@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the sdp record.

 input/generichid.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/input/generichid.c b/input/generichid.c
index 926d8ec..ec8283d 100644
--- a/input/generichid.c
+++ b/input/generichid.c
@@ -148,9 +148,204 @@ static void add_lang_attr(sdp_record_t *r)

 static int sdp_keyboard_service(struct adapter_data *adapt)
 {
-    return -1;
-}
+	bdaddr_t src;
+	sdp_record_t *record;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, hidkb_uuid, l2cap_uuid, hidp_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[3];
+	sdp_data_t *psm, *lang_lst, *lang_lst2, *hid_spec_lst, *hid_spec_lst2;
+	unsigned int i;
+	uint8_t dtd = SDP_UINT16;
+	uint8_t dtd2 = SDP_UINT8;
+	uint8_t dtd_data = SDP_TEXT_STR8;
+	void *dtds[2];
+	void *values[2];
+	void *dtds2[2];
+	void *values2[2];
+	int leng[2];
+	uint8_t hid_spec_type = 0x22;
+	uint16_t hid_attr_lang[] = { 0x409, 0x100 };
+	static const uint16_t ctrl = 0x11;
+	static const uint16_t intr = 0x13;
+	static const uint16_t hid_attr[] = { 0x100, 0x111, 0x40,
+						0x0d, 0x01, 0x01 };
+	static const uint16_t hid_attr2[] = { 0x0, 0x01, 0x100,
+						0x1f40, 0x01, 0x01 };
+	const uint8_t hid_spec[] = {
+		0x05, 0x01, /*	Usage Page (Generic Desktop)		*/
+		0x09, 0x06, /*	Usage (Keyboard)			*/
+		0xA1, 0x01, /*	Collection (Application)		*/
+		0x85, 0x01, /*	Report ID				*/
+		0x05, 0x07, /*	Usage (Key codes)			*/
+		0x19, 0xE0, /*	Usage Minimum (224)			*/
+		0x29, 0xE7, /*	Usage Maximum (231)			*/
+		0x15, 0x00, /*	Logical Minimum (0)			*/
+		0x25, 0x01, /*	Logical Maximum (1)			*/
+		0x75, 0x01, /*	Report Size (1)				*/
+		0x95, 0x08, /*	Report Count (8)			*/
+		0x81, 0x02, /*	Input (Data, Variable, Absolute)	*/
+		0x95, 0x01, /*	Report Count (1)			*/
+		0x75, 0x08, /*	Report Size (8)				*/
+		0x81, 0x01, /*	Input (Constant)    ;5 bit padding	*/
+		0x95, 0x05, /*	Report Count (5)			*/
+		0x75, 0x01, /*	Report Size (1)				*/
+		0x05, 0x08, /*	Usage Page (Page# for LEDs)		*/
+		0x19, 0x01, /*	Usage Minimum (01)			*/
+		0x29, 0x05, /*	Usage Maximum (05)			*/
+		0x91, 0x02, /*	Output (Data, Variable, Absolute)	*/
+		0x95, 0x01, /*	Report Count (1)			*/
+		0x75, 0x03, /*	Report Size (3)				*/
+		0x91, 0x01, /*	Output (Constant)			*/
+		0x95, 0x06, /*	Report Count (1)			*/
+		0x75, 0x08, /*	Report Size (3)				*/
+		0x15, 0x00, /*	Logical Minimum (0)			*/
+		0x25, 0x65, /*	Logical Maximum (101)			*/
+		0x05, 0x07, /*	Usage (Key codes)			*/
+		0x19, 0x00, /*	Usage Minimum (00)			*/
+		0x29, 0x65, /*	Usage Maximum (101)			*/
+		0x81, 0x00, /*	Input (Data, Array)			*/
+		0xC0,
+		0x09, 0x02, /* mouse part starts here */
+		0xa1, 0x01,
+		0x09, 0x01,
+		0xa1, 0x00,
+		0x85, 0x02,
+		0x05, 0x09,
+		0x19, 0x01,
+		0x29, 0x05,
+		0x15, 0x00,
+		0x25, 0x01,
+		0x95, 0x05,
+		0x75, 0x01,
+		0x81, 0x02,
+		0x95, 0x01,
+		0x75, 0x03,
+		0x81, 0x01,
+		0x05, 0x01,
+		0x09, 0x30,
+		0x09, 0x31,
+		0x09, 0x38,
+		0x15, 0x81,
+		0x25, 0x7f,
+		0x75, 0x08,
+		0x95, 0x03,
+		0x81, 0x06,
+		0x05, 0x0c,
+		0x0a, 0x38, 0x02,
+		0x15, 0x81,
+		0x25, 0x7f,
+		0x75, 0x08,
+		0x95, 0x01,
+		0x81, 0x06,
+		0xc0,
+		0xc0
+	};
+
+	record = sdp_record_alloc();
+	memset(record, 0, sizeof(sdp_record_t));
+	record->handle = 0xffffffff;
+	bacpy(&src, BDADDR_ANY);
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	add_lang_attr(record);
+
+	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &hidkb_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, HID_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(0, profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	/* protocols */
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[1] = sdp_list_append(0, &l2cap_uuid);
+	psm = sdp_data_alloc(SDP_UINT16, &ctrl);
+	proto[1] = sdp_list_append(proto[1], psm);
+	apseq = sdp_list_append(0, proto[1]);
+
+	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
+	proto[2] = sdp_list_append(0, &hidp_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_list_free(root, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(proto[2], 0);
+	sdp_data_free(psm);
+
+	/* additional protocols */
+	proto[1] = sdp_list_append(0, &l2cap_uuid);
+	psm = sdp_data_alloc(SDP_UINT16, &intr);
+	proto[1] = sdp_list_append(proto[1], psm);
+	apseq = sdp_list_append(0, proto[1]);
+
+	sdp_uuid16_create(&hidp_uuid, HIDP_UUID);
+	proto[2] = sdp_list_append(0, &hidp_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_add_access_protos(record, aproto);
+
+	sdp_list_free(svclass_id, 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(proto[2], 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_data_free(psm);
+
+	sdp_set_info_attr(record, "HID Keyboard", NULL, NULL);
+
+	for (i = 0; i < sizeof(hid_attr) / 2; i++)
+		sdp_attr_add_new(record,
+					SDP_ATTR_HID_DEVICE_RELEASE_NUMBER + i,
+					SDP_UINT16, &hid_attr[i]);
+
+	dtds[0] = &dtd2;
+	values[0] = &hid_spec_type;
+	dtds[1] = &dtd_data;
+	values[1] = (uint8_t *) hid_spec;
+	leng[0] = 0;
+	leng[1] = sizeof(hid_spec);
+	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng, 2);
+	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
+	sdp_attr_add(record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
+
+	for (i = 0; i < sizeof(hid_attr_lang) / 2; i++) {
+		dtds2[i] = &dtd;
+		values2[i] = &hid_attr_lang[i];
+	}
+
+	lang_lst = sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang) / 2);
+	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);
+	sdp_attr_add(record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
+
+	sdp_attr_add_new(record, SDP_ATTR_HID_SDP_DISABLE,
+				SDP_UINT16, &hid_attr2[0]);
+
+	for (i = 0; i < sizeof(hid_attr2) / 2 - 1; i++)
+		sdp_attr_add_new(record, SDP_ATTR_HID_REMOTE_WAKEUP + i,
+						SDP_UINT16, &hid_attr2[i + 1]);

+	if (add_record_to_server(&src, record) < 0)
+		return -1;
+
+	adapt->sdp_record_handle = record->handle;
+
+	btd_debug("HID service registered with record handle %x", record->handle);
+
+	return 0;
+}


 static DBusMessage *send_event(DBusConnection *conn,

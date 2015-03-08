Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 2/2] profiles/input: Add support for SDP fallback for DualShock 3 clones
Date: Sun,  8 Mar 2015 17:08:30 +0100
Message-Id: <1425830910-9549-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
References: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some DualShock 3 clones were reported to not provide any SDP record.
In such case provide fallback SDP record (based on genuine DS3 record)
and retry setting input device channels before disconnecting.
---
 profiles/input/server.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 7 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf8..4b7b1e1 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -35,6 +35,7 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
+#include "lib/sdp_lib.h"
 
 #include "src/log.h"
 #include "src/uuid-helper.h"
@@ -72,29 +73,205 @@ struct sixaxis_data {
 	uint16_t psm;
 };
 
+static sdp_record_t *get_sixaxis_record(struct btd_device *device)
+{
+	sdp_record_t *record;
+	uint16_t vid, pid, hid_release, hid_parser, version, timeout;
+	uint8_t sdp_disable, battery, remote_wakeup, norm_connect, boot_device;
+	uint8_t subclass, country, virtual_cable, reconnect;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, hidkb_uuid, l2cap_uuid, hidp_uuid;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[3];
+	sdp_data_t *psm, *lang_lst, *lang_lst2, *hid_spec_lst, *hid_spec_lst2;
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
+	uint8_t hid_spec[] = {
+		0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02, 0x85, 0x01,
+		0x75, 0x08, 0x95, 0x01, 0x15, 0x00, 0x26, 0xff, 0x00, 0x81,
+		0x03, 0x75, 0x01, 0x95, 0x13, 0x15, 0x00, 0x25, 0x01, 0x35,
+		0x00, 0x45, 0x01, 0x05, 0x09, 0x19, 0x01, 0x29, 0x13, 0x81,
+		0x02, 0x75, 0x01, 0x95, 0x0d, 0x06, 0x00, 0xff, 0x81, 0x03,
+		0x15, 0x00, 0x26, 0xff, 0x00, 0x05, 0x01, 0x09, 0x01, 0xa1,
+		0x00, 0x75, 0x08, 0x95, 0x04, 0x35, 0x00, 0x46, 0xff, 0x00,
+		0x09, 0x30, 0x09, 0x31, 0x09, 0x32, 0x09, 0x35, 0x81, 0x02,
+		0xc0, 0x05, 0x01, 0x75, 0x08, 0x95, 0x27, 0x09, 0x01, 0x81,
+		0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0x91, 0x02, 0x75,
+		0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02,
+		0x85, 0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02,
+		0xc0, 0xa1, 0x02, 0x85, 0xee, 0x75, 0x08, 0x95, 0x30, 0x09,
+		0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02, 0x85, 0xef, 0x75, 0x08,
+		0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xc0, 0x00
+	};
+
+	vid = btd_device_get_vendor(device);
+	pid = btd_device_get_product(device);
+
+	/* only for DualShock 3 clones */
+	if (vid != 0x054c || pid != 0x0268)
+		return NULL;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_add_lang_attr(record);
+
+	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &hidkb_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HID_PROFILE_ID);
+	profile.version = 0x0100;
+	pfseq = sdp_list_append(0, &profile);
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
+	sdp_set_info_attr(record, "Wireless Controller",
+						"Sony Computer Entertainment",
+						"Wireless Controller");
+
+	hid_release = 0x0100;
+	sdp_attr_add_new(record, SDP_ATTR_HID_DEVICE_RELEASE_NUMBER, SDP_UINT16,
+								&hid_release);
+
+	hid_parser = 0x0100;
+	sdp_attr_add_new(record, SDP_ATTR_HID_PARSER_VERSION, SDP_UINT16,
+								&hid_parser);
+
+	subclass = 0x00;
+	sdp_attr_add_new(record, SDP_ATTR_HID_DEVICE_SUBCLASS, SDP_UINT8,
+								&subclass);
+
+	country = 0x21;
+	sdp_attr_add_new(record, SDP_ATTR_HID_COUNTRY_CODE, SDP_UINT8,
+								&country);
+
+	virtual_cable = 0x01;
+	sdp_attr_add_new(record, SDP_ATTR_HID_VIRTUAL_CABLE, SDP_BOOL,
+								&virtual_cable);
+
+	reconnect = 0x01;
+	sdp_attr_add_new(record, SDP_ATTR_HID_RECONNECT_INITIATE, SDP_BOOL,
+								&reconnect);
+
+	dtds[0] = &dtd2;
+	values[0] = &hid_spec_type;
+	dtds[1] = &dtd_data;
+	values[1] = hid_spec;
+	leng[0] = 0;
+	leng[1] = sizeof(hid_spec);
+	hid_spec_lst = sdp_seq_alloc_with_length(dtds, values, leng, 2);
+	hid_spec_lst2 = sdp_data_alloc(SDP_SEQ8, hid_spec_lst);
+	sdp_attr_add(record, SDP_ATTR_HID_DESCRIPTOR_LIST, hid_spec_lst2);
+
+	dtds2[0] = &dtd;
+	values2[0] = &hid_attr_lang[0];
+	dtds2[1] = &dtd;
+	values2[1] = &hid_attr_lang[1];
+	lang_lst = sdp_seq_alloc(dtds2, values2, sizeof(hid_attr_lang) / 2);
+	lang_lst2 = sdp_data_alloc(SDP_SEQ8, lang_lst);
+	sdp_attr_add(record, SDP_ATTR_HID_LANG_ID_BASE_LIST, lang_lst2);
+
+	sdp_disable = 0x00;
+	sdp_attr_add_new(record, SDP_ATTR_HID_SDP_DISABLE, SDP_BOOL,
+								&sdp_disable);
+
+	battery = 0x01;
+	sdp_attr_add_new(record, SDP_ATTR_HID_BATTERY_POWER, SDP_BOOL,
+								&battery);
+
+	remote_wakeup = 0x01;
+	sdp_attr_add_new(record, SDP_ATTR_HID_REMOTE_WAKEUP, SDP_BOOL,
+								&remote_wakeup);
+
+	version = 0x0100;
+	sdp_attr_add_new(record, SDP_ATTR_HID_PROFILE_VERSION, SDP_UINT16,
+								&version);
+
+	timeout = 0x3e80;
+	sdp_attr_add_new(record, SDP_ATTR_HID_SUPERVISION_TIMEOUT, SDP_UINT16,
+								&timeout);
+
+	norm_connect = 0x00;
+	sdp_attr_add_new(record, SDP_ATTR_HID_NORMALLY_CONNECTABLE, SDP_BOOL,
+								&norm_connect);
+
+	boot_device = 0x00;
+	sdp_attr_add_new(record, SDP_ATTR_HID_BOOT_DEVICE, SDP_BOOL,
+								&boot_device);
+
+	return record;
+}
+
 static void sixaxis_sdp_cb(struct btd_device *dev, int err, void *user_data)
 {
+	const bdaddr_t *src = btd_adapter_get_address(device_get_adapter(dev));
 	struct sixaxis_data *data = user_data;
-	const bdaddr_t *src;
 
 	DBG("err %d (%s)", err, strerror(-err));
 
 	if (err < 0)
-		goto fail;
-
-	src = btd_adapter_get_address(device_get_adapter(dev));
+		goto fallback;
 
 	if (input_device_set_channel(src, device_get_address(dev), data->psm,
 								data->chan) < 0)
-		goto fail;
+		goto fallback;
 
 	g_io_channel_unref(data->chan);
 	g_free(data);
 
 	return;
 
-fail:
-	g_io_channel_shutdown(data->chan, TRUE, NULL);
+fallback:
+	DBG("SDP search failed, attempting fallback");
+
+	btd_device_set_record(dev, HID_UUID, get_sixaxis_record(dev));
+
+	if (input_device_set_channel(src, device_get_address(dev),
+						data->psm, data->chan) < 0)
+		g_io_channel_shutdown(data->chan, TRUE, NULL);
+
 	g_io_channel_unref(data->chan);
 	g_free(data);
 }
-- 
2.1.4


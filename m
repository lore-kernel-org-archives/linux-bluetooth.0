Return-Path: <cyrus@holtmann.org>
From: nami <nami.li1984@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: nami <nami.li1984@gmail.com>
Subject: [PATCH] Change OPUSH sdp record when use sdptool for GOEP v2.0.
Date: Wed, 18 May 2011 17:27:12 +0800
Message-Id: <1305710832-11037-1-git-send-email-nami.li1984@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.h       |    5 +++++
 tools/sdptool.c |   11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index 5f7d271..bb217a5 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -312,6 +312,11 @@ extern "C" {
 #define SDP_ATTR_HID_BOOT_DEVICE		0x020e
 
 /*
+ * GoepL2capPsm attribute is added on GOEP v2.0 and later
+ */
+ #define SDP_ATTR_GOEP_L2CAP_PSM		0x0200
+
+/*
  * These identifiers are based on the SDP spec stating that
  * "base attribute id of the primary (universal) language must be 0x0100"
  *
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 140a46a..1b2117a 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1752,6 +1752,8 @@ static int add_opush(sdp_session_t *session, svc_info_t *si)
 	uint8_t dtd = SDP_UINT8;
 	sdp_data_t *sflist;
 	int ret = 0;
+	uint16_t psm = si->psm ? si->psm : 0x1015;
+	sdp_data_t *l2cappsm;
 
 	memset(&record, 0, sizeof(sdp_record_t));
 	record.handle = si->handle;
@@ -1765,7 +1767,9 @@ static int add_opush(sdp_session_t *session, svc_info_t *si)
 	sdp_set_service_classes(&record, svclass_id);
 
 	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
-	profile[0].version = 0x0100;
+	/* The profile version number in the BluetoothProfileDescriptorList attribute
+	shall be incremented for GOEPv2.0 and later. */
+	profile[0].version = 0x0102;
 	pfseq = sdp_list_append(0, profile);
 	sdp_set_profile_descs(&record, pfseq);
 
@@ -1795,6 +1799,10 @@ static int add_opush(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_info_attr(&record, "OBEX Object Push", 0, 0);
 
+	/* The SDP records shall include the GoepL2capPsm attribute for GOEPv2.0 and later. */
+	l2cappsm = sdp_data_alloc (SDP_UINT16, &psm);
+	sdp_attr_add (&record, SDP_ATTR_GOEP_L2CAP_PSM, l2cappsm);
+
 	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
 		printf("Service Record registration failed\n");
 		ret = -1;
@@ -1805,6 +1813,7 @@ static int add_opush(sdp_session_t *session, svc_info_t *si)
 
 end:
 	sdp_data_free(channel);
+	sdp_data_free(l2cappsm);
 	sdp_list_free(proto[0], 0);
 	sdp_list_free(proto[1], 0);
 	sdp_list_free(proto[2], 0);
-- 
1.7.1


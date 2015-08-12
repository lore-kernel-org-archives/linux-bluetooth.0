Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] tools/sdptool: Fix resource leaks
Date: Wed, 12 Aug 2015 18:07:09 +0300
Message-Id: <1439392033-11822-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/sdptool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index cbe8814..039e67d 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3312,6 +3312,7 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	sdp_record_t record;
 	sdp_list_t *root, *svclass;
 	uuid_t root_uuid, svclass_uuid;
+	int err;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3324,7 +3325,13 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
-	if (sdp_device_record_register(session, &interface, &record, SDP_RECORD_PERSIST) < 0) {
+	err = sdp_device_record_register(session, &interface, &record,
+							SDP_RECORD_PERSIST);
+
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass, NULL);
+
+	if (err < 0) {
 		printf("Service Record registration failed\n");
 		return -1;
 	}
-- 
2.4.3


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/2] input: Update uhid_copy.h to version from Linux 3.14
Date: Sat, 24 May 2014 20:53:57 +0200
Message-Id: <1400957638-18418-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/uhid_copy.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/input/uhid_copy.h b/profiles/input/uhid_copy.h
index 381b062..23a6287 100644
--- a/profiles/input/uhid_copy.h
+++ b/profiles/input/uhid_copy.h
@@ -30,7 +30,7 @@ enum uhid_event_type {
 	UHID_OPEN,
 	UHID_CLOSE,
 	UHID_OUTPUT,
-	UHID_OUTPUT_EV,
+	UHID_OUTPUT_EV,			/* obsolete! */
 	UHID_INPUT,
 	UHID_FEATURE,
 	UHID_FEATURE_ANSWER,
@@ -69,6 +69,8 @@ struct uhid_output_req {
 	__u8 rtype;
 } __attribute__((__packed__));
 
+/* Obsolete! Newer kernels will no longer send these events but instead convert
+ * it into raw output reports via UHID_OUTPUT. */
 struct uhid_output_ev_req {
 	__u16 type;
 	__u16 code;
@@ -86,7 +88,7 @@ struct uhid_feature_answer_req {
 	__u16 err;
 	__u16 size;
 	__u8 data[UHID_DATA_MAX];
-};
+} __attribute__((__packed__));
 
 struct uhid_event {
 	__u32 type;
-- 
2.0.0.rc4


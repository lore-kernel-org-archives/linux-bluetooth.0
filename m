Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 1/4] hog: import latest uhid.h definition
Date: Fri, 21 Nov 2014 15:41:43 +0100
Message-Id: <1416580906-22134-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Kernel 3.18 ships a new API for uhid devices. This API is retro-compatible
so we can keep the current symbols.
---
 profiles/input/uhid_copy.h | 117 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/profiles/input/uhid_copy.h b/profiles/input/uhid_copy.h
index 23a6287..0ef73d4 100644
--- a/profiles/input/uhid_copy.h
+++ b/profiles/input/uhid_copy.h
@@ -21,35 +21,49 @@
 
 #include <linux/input.h>
 #include <linux/types.h>
+#include <linux/hid.h>
 
 enum uhid_event_type {
-	UHID_CREATE,
+	__UHID_LEGACY_CREATE,
 	UHID_DESTROY,
 	UHID_START,
 	UHID_STOP,
 	UHID_OPEN,
 	UHID_CLOSE,
 	UHID_OUTPUT,
-	UHID_OUTPUT_EV,			/* obsolete! */
-	UHID_INPUT,
-	UHID_FEATURE,
-	UHID_FEATURE_ANSWER,
+	__UHID_LEGACY_OUTPUT_EV,
+	__UHID_LEGACY_INPUT,
+	UHID_GET_REPORT,
+	UHID_GET_REPORT_REPLY,
+	UHID_CREATE2,
+	UHID_INPUT2,
+	UHID_SET_REPORT,
+	UHID_SET_REPORT_REPLY,
 };
 
-struct uhid_create_req {
+struct uhid_create2_req {
 	__u8 name[128];
 	__u8 phys[64];
 	__u8 uniq[64];
-	__u8 *rd_data;
 	__u16 rd_size;
-
 	__u16 bus;
 	__u32 vendor;
 	__u32 product;
 	__u32 version;
 	__u32 country;
+	__u8 rd_data[HID_MAX_DESCRIPTOR_SIZE];
 } __attribute__((__packed__));
 
+enum uhid_dev_flag {
+	UHID_DEV_NUMBERED_FEATURE_REPORTS			= (1ULL << 0),
+	UHID_DEV_NUMBERED_OUTPUT_REPORTS			= (1ULL << 1),
+	UHID_DEV_NUMBERED_INPUT_REPORTS				= (1ULL << 2),
+};
+
+struct uhid_start_req {
+	__u64 dev_flags;
+};
+
 #define UHID_DATA_MAX 4096
 
 enum uhid_report_type {
@@ -58,9 +72,9 @@ enum uhid_report_type {
 	UHID_INPUT_REPORT,
 };
 
-struct uhid_input_req {
-	__u8 data[UHID_DATA_MAX];
+struct uhid_input2_req {
 	__u16 size;
+	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
 struct uhid_output_req {
@@ -69,20 +83,83 @@ struct uhid_output_req {
 	__u8 rtype;
 } __attribute__((__packed__));
 
-/* Obsolete! Newer kernels will no longer send these events but instead convert
- * it into raw output reports via UHID_OUTPUT. */
+struct uhid_get_report_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+} __attribute__((__packed__));
+
+struct uhid_get_report_reply_req {
+	__u32 id;
+	__u16 err;
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+} __attribute__((__packed__));
+
+struct uhid_set_report_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+} __attribute__((__packed__));
+
+struct uhid_set_report_reply_req {
+	__u32 id;
+	__u16 err;
+} __attribute__((__packed__));
+
+/*
+ * Compat Layer
+ * All these commands and requests are obsolete. You should avoid using them in
+ * new code. We support them for backwards-compatibility, but you might not get
+ * access to new feature in case you use them.
+ */
+
+enum uhid_legacy_event_type {
+	UHID_CREATE			= __UHID_LEGACY_CREATE,
+	UHID_OUTPUT_EV			= __UHID_LEGACY_OUTPUT_EV,
+	UHID_INPUT			= __UHID_LEGACY_INPUT,
+	UHID_FEATURE			= UHID_GET_REPORT,
+	UHID_FEATURE_ANSWER		= UHID_GET_REPORT_REPLY,
+};
+
+/* Obsolete! Use UHID_CREATE2. */
+struct uhid_create_req {
+	__u8 name[128];
+	__u8 phys[64];
+	__u8 uniq[64];
+	__u8 *rd_data;
+	__u16 rd_size;
+
+	__u16 bus;
+	__u32 vendor;
+	__u32 product;
+	__u32 version;
+	__u32 country;
+} __attribute__((__packed__));
+
+/* Obsolete! Use UHID_INPUT2. */
+struct uhid_input_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+} __attribute__((__packed__));
+
+/* Obsolete! Kernel uses UHID_OUTPUT exclusively now. */
 struct uhid_output_ev_req {
 	__u16 type;
 	__u16 code;
 	__s32 value;
 } __attribute__((__packed__));
 
+/* Obsolete! Kernel uses ABI compatible UHID_GET_REPORT. */
 struct uhid_feature_req {
 	__u32 id;
 	__u8 rnum;
 	__u8 rtype;
 } __attribute__((__packed__));
 
+/* Obsolete! Use ABI compatible UHID_GET_REPORT_REPLY. */
 struct uhid_feature_answer_req {
 	__u32 id;
 	__u16 err;
@@ -90,6 +167,15 @@ struct uhid_feature_answer_req {
 	__u8 data[UHID_DATA_MAX];
 } __attribute__((__packed__));
 
+/*
+ * UHID Events
+ * All UHID events from and to the kernel are encoded as "struct uhid_event".
+ * The "type" field contains a UHID_* type identifier. All payload depends on
+ * that type and can be accessed via ev->u.XYZ accordingly.
+ * If user-space writes short events, they're extended with 0s by the kernel. If
+ * the kernel writes short events, user-space shall extend them with 0s.
+ */
+
 struct uhid_event {
 	__u32 type;
 
@@ -99,7 +185,14 @@ struct uhid_event {
 		struct uhid_output_req output;
 		struct uhid_output_ev_req output_ev;
 		struct uhid_feature_req feature;
+		struct uhid_get_report_req get_report;
 		struct uhid_feature_answer_req feature_answer;
+		struct uhid_get_report_reply_req get_report_reply;
+		struct uhid_create2_req create2;
+		struct uhid_input2_req input2;
+		struct uhid_set_report_req set_report;
+		struct uhid_set_report_reply_req set_report_reply;
+		struct uhid_start_req start;
 	} u;
 } __attribute__((__packed__));
 
-- 
2.1.3

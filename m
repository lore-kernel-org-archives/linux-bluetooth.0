Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/avctp: Move struct definitions to header
Date: Tue, 28 Jan 2014 14:34:45 +0200
Message-Id: <1390912485-16357-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There is currently inconsistence in the avctp code with
AVC_HEADER_LENGTH defined in avctp.h but AVCTP_HEADER_LENGTH defined in
avctp.c. The patch moves structure definitions to the header in
consistent way.
---
 android/avctp.c | 42 ------------------------------------------
 android/avctp.h | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index af2046a..7aa0673 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -66,48 +66,6 @@
 #define AVCTP_PACKET_CONTINUE	2
 #define AVCTP_PACKET_END	3
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct avctp_header {
-	uint8_t ipid:1;
-	uint8_t cr:1;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint16_t pid;
-} __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
-
-struct avc_header {
-	uint8_t code:4;
-	uint8_t _hdr0:4;
-	uint8_t subunit_id:3;
-	uint8_t subunit_type:5;
-	uint8_t opcode;
-} __attribute__ ((packed));
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct avctp_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t cr:1;
-	uint8_t ipid:1;
-	uint16_t pid;
-} __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
-
-struct avc_header {
-	uint8_t _hdr0:4;
-	uint8_t code:4;
-	uint8_t subunit_type:5;
-	uint8_t subunit_id:3;
-	uint8_t opcode;
-} __attribute__ ((packed));
-
-#else
-#error "Unknown byte order"
-#endif
-
 struct avctp_control_req {
 	struct avctp_pending_req *p;
 	uint8_t code;
diff --git a/android/avctp.h b/android/avctp.h
index a22bf13..428eeb8 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -26,7 +26,6 @@
 #define AVCTP_BROWSING_PSM		27
 
 #define AVC_MTU 512
-#define AVC_HEADER_LENGTH 3
 
 /* ctype entries */
 #define AVC_CTYPE_CONTROL		0x0
@@ -80,6 +79,50 @@
 #define AVC_F3				0x73
 #define AVC_F4				0x74
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct avctp_header {
+	uint8_t ipid:1;
+	uint8_t cr:1;
+	uint8_t packet_type:2;
+	uint8_t transaction:4;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_LENGTH 3
+
+struct avc_header {
+	uint8_t code:4;
+	uint8_t _hdr0:4;
+	uint8_t subunit_id:3;
+	uint8_t subunit_type:5;
+	uint8_t opcode;
+} __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct avctp_header {
+	uint8_t transaction:4;
+	uint8_t packet_type:2;
+	uint8_t cr:1;
+	uint8_t ipid:1;
+	uint16_t pid;
+} __attribute__ ((packed));
+#define AVCTP_HEADER_LENGTH 3
+
+struct avc_header {
+	uint8_t _hdr0:4;
+	uint8_t code:4;
+	uint8_t subunit_type:5;
+	uint8_t subunit_id:3;
+	uint8_t opcode;
+} __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
+
+#else
+#error "Unknown byte order"
+#endif
+
 struct avctp;
 
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
-- 
1.8.3.2


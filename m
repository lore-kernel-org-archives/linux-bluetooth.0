Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 3/4] android/avctp: Add define for AV/C data MTU and offset
Date: Thu,  5 Jun 2014 14:45:46 +0300
Message-Id: <1401968747-11848-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
References: <1401968747-11848-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This defines the MTU and offset of AV/C data in AVCTP PDU.
---
 android/avctp.c | 4 ----
 android/avctp.h | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index be3fed1..a70ed52 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -76,7 +76,6 @@ struct avctp_header {
 	uint8_t transaction:4;
 	uint16_t pid;
 } __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
 
 struct avc_header {
 	uint8_t code:4;
@@ -85,7 +84,6 @@ struct avc_header {
 	uint8_t subunit_type:5;
 	uint8_t opcode;
 } __attribute__ ((packed));
-#define AVC_HEADER_LENGTH 3
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
@@ -96,7 +94,6 @@ struct avctp_header {
 	uint8_t ipid:1;
 	uint16_t pid;
 } __attribute__ ((packed));
-#define AVCTP_HEADER_LENGTH 3
 
 struct avc_header {
 	uint8_t _hdr0:4;
@@ -105,7 +102,6 @@ struct avc_header {
 	uint8_t subunit_id:3;
 	uint8_t opcode;
 } __attribute__ ((packed));
-#define AVC_HEADER_LENGTH 3
 
 #else
 #error "Unknown byte order"
diff --git a/android/avctp.h b/android/avctp.h
index 2b33858..f0da2b3 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -25,7 +25,11 @@
 #define AVCTP_CONTROL_PSM		23
 #define AVCTP_BROWSING_PSM		27
 
-#define AVC_MTU 512
+#define AVCTP_HEADER_LENGTH		3
+#define AVC_HEADER_LENGTH		3
+
+#define AVC_DATA_OFFSET			AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH
+#define AVC_DATA_MTU			512
 
 /* ctype entries */
 #define AVC_CTYPE_CONTROL		0x0
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/8] android/avctp: Move AVC_HEADER_LENGTH from avctp header
Date: Wed, 29 Jan 2014 14:36:06 +0200
Message-Id: <1390998967-24610-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There is currently inconsistence in the avctp code with
AVC_HEADER_LENGTH defined in avctp.h but AVCTP_HEADER_LENGTH defined in
avctp.c. Move definition to place it is actually used in consistent way.
---
 android/avctp.c | 2 ++
 android/avctp.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/avctp.c b/android/avctp.c
index d308ec1..8f35403 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -84,6 +84,7 @@ struct avc_header {
 	uint8_t subunit_type:5;
 	uint8_t opcode;
 } __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
@@ -103,6 +104,7 @@ struct avc_header {
 	uint8_t subunit_id:3;
 	uint8_t opcode;
 } __attribute__ ((packed));
+#define AVC_HEADER_LENGTH 3
 
 #else
 #error "Unknown byte order"
diff --git a/android/avctp.h b/android/avctp.h
index a22bf13..e7e0277 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -26,7 +26,6 @@
 #define AVCTP_BROWSING_PSM		27
 
 #define AVC_MTU 512
-#define AVC_HEADER_LENGTH 3
 
 /* ctype entries */
 #define AVC_CTYPE_CONTROL		0x0
-- 
1.8.3.2


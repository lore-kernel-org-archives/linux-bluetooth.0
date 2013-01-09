Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] unit: Rename x_pdu() macro on SDP test program
Date: Wed,  9 Jan 2013 11:19:21 -0400
Message-Id: <1357744762-5111-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using the "raw_data" name makes sense, given the macro is just casting
input (raw) data. It will also be reused in other tests with raw input
data.

Also fix this minor checkpatch.pl error:

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in
parenthesis
+#define raw_data(args...) (const unsigned char[]) { args }
---
 unit/test-sdp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index e9cbcdf..77a4c6c 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -51,20 +51,20 @@ struct test_data {
 	struct sdp_pdu *pdu_list;
 };
 
-#define x_pdu(args...) (const unsigned char[]) { args }
+#define raw_data(args...) ((const unsigned char[]) { args })
 
 #define raw_pdu(args...) \
 	{							\
 		.valid = true,					\
-		.raw_data = x_pdu(args),			\
-		.raw_size = sizeof(x_pdu(args)),		\
+		.raw_data = raw_data(args),			\
+		.raw_size = sizeof(raw_data(args)),		\
 	}
 
 #define raw_pdu_cont(cont, args...) \
 	{							\
 		.valid = true,					\
-		.raw_data = x_pdu(args),			\
-		.raw_size = sizeof(x_pdu(args)),		\
+		.raw_data = raw_data(args),			\
+		.raw_size = sizeof(raw_data(args)),		\
 		.cont_len = cont,				\
 	}
 
-- 
1.7.9.5


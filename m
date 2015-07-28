Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/sdptool: Remove unnecessary typecasts
Date: Tue, 28 Jul 2015 15:29:29 +0530
Message-id: <1438077569-8272-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed unnecessary typecasts of malloc return values.
---
 tools/sdptool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index cd8bfb6..cbe8814 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -921,9 +921,9 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	}
 
 	/* Create arrays */
-	dtdArray = (void **)malloc(argc * sizeof(void *));
-	valueArray = (void **)malloc(argc * sizeof(void *));
-	allocArray = (void **)malloc(argc * sizeof(void *));
+	dtdArray = malloc(argc * sizeof(void *));
+	valueArray = malloc(argc * sizeof(void *));
+	allocArray = malloc(argc * sizeof(void *));
 
 	if (!dtdArray || !valueArray || !allocArray) {
 		ret = -ENOMEM;
@@ -936,7 +936,7 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 		if (!strncasecmp(argv[i], "u0x", 3)) {
 			/* UUID16 */
 			uint16_t value_int = strtoul((argv[i]) + 3, NULL, 16);
-			uuid_t *value_uuid = (uuid_t *) malloc(sizeof(uuid_t));
+			uuid_t *value_uuid = malloc(sizeof(uuid_t));
 			if (!value_uuid) {
 				ret = -ENOMEM;
 				goto cleanup;
@@ -950,7 +950,7 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 			valueArray[i] = &value_uuid->value.uuid16;
 		} else if (!strncasecmp(argv[i], "0x", 2)) {
 			/* Int */
-			uint32_t *value_int = (uint32_t *) malloc(sizeof(int));
+			uint32_t *value_int = malloc(sizeof(int));
 			if (!value_int) {
 				ret = -ENOMEM;
 				goto cleanup;
-- 
2.1.4


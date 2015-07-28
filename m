Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH v2] tools/sdptool: Fix NULL pointer dereference
Date: Tue, 28 Jul 2015 12:50:19 +0530
Message-id: <1438068019-4094-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes NULL pointer dereferences in case malloc fails
and returns NULL.
---
 tools/sdptool.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 257964d..02e7f23 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -902,9 +902,9 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	uint32_t range = 0x0000ffff;
 	sdp_record_t *rec;
 	sdp_data_t *pSequenceHolder = NULL;
-	void **dtdArray;
-	void **valueArray;
-	void **allocArray;
+	void **dtdArray = NULL;
+	void **valueArray = NULL;
+	void **allocArray = NULL;
 	uint8_t uuid16 = SDP_UUID16;
 	uint8_t uint32 = SDP_UINT32;
 	uint8_t str8 = SDP_TEXT_STR8;
@@ -922,8 +922,22 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 
 	/* Create arrays */
 	dtdArray = (void **)malloc(argc * sizeof(void *));
+	if (!dtdArray) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	valueArray = (void **)malloc(argc * sizeof(void *));
+	if (!valueArray) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	allocArray = (void **)malloc(argc * sizeof(void *));
+	if (!allocArray) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
 
 	/* Loop on all args, add them in arrays */
 	for (i = 0; i < argc; i++) {
@@ -932,6 +946,11 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 			/* UUID16 */
 			uint16_t value_int = strtoul((argv[i]) + 3, NULL, 16);
 			uuid_t *value_uuid = (uuid_t *) malloc(sizeof(uuid_t));
+			if (!value_uuid) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
 			allocArray[i] = value_uuid;
 			sdp_uuid16_create(value_uuid, value_int);
 
@@ -941,6 +960,11 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 		} else if (!strncasecmp(argv[i], "0x", 2)) {
 			/* Int */
 			uint32_t *value_int = (uint32_t *) malloc(sizeof(int));
+			if (!value_int) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
 			allocArray[i] = value_int;
 			*value_int = strtoul((argv[i]) + 2, NULL, 16);
 
@@ -967,9 +991,14 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	} else
 		printf("Failed to create pSequenceHolder\n");
 
+cleanup:
+	if (ret == -ENOMEM)
+		printf("Memory allocation failed\n");
+
 	/* Cleanup */
 	for (i = 0; i < argc; i++)
-		free(allocArray[i]);
+		if (allocArray)
+			free(allocArray[i]);
 
 	free(dtdArray);
 	free(valueArray);
-- 
2.1.4


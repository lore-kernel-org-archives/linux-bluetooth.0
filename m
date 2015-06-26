Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/sdptool.c: Fix NULL pointer dereference
Date: Fri, 26 Jun 2015 12:10:54 +0530
Message-id: <1435300854-29820-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NULL return from malloc need to be checked to prevet crash due to NULL
pointer dereference.
---
 tools/sdptool.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 257964d..f665606 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -922,8 +922,25 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 
 	/* Create arrays */
 	dtdArray = (void **)malloc(argc * sizeof(void *));
+	if (!dtdArray) {
+		printf("Memory allocation failed for dtdArray.\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	valueArray = (void **)malloc(argc * sizeof(void *));
+	if (!valueArray) {
+		printf("Memory allocation failed for valueArray.\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	allocArray = (void **)malloc(argc * sizeof(void *));
+	if (!allocArray) {
+		printf("Memory allocation failed for allocArray.\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
 
 	/* Loop on all args, add them in arrays */
 	for (i = 0; i < argc; i++) {
@@ -932,6 +949,12 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 			/* UUID16 */
 			uint16_t value_int = strtoul((argv[i]) + 3, NULL, 16);
 			uuid_t *value_uuid = (uuid_t *) malloc(sizeof(uuid_t));
+			if (!value_uuid) {
+				printf("Failed to allocate memory for uuid.\n");
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
 			allocArray[i] = value_uuid;
 			sdp_uuid16_create(value_uuid, value_int);
 
@@ -941,6 +964,12 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 		} else if (!strncasecmp(argv[i], "0x", 2)) {
 			/* Int */
 			uint32_t *value_int = (uint32_t *) malloc(sizeof(int));
+			if (!value_int) {
+				printf("Failed to allocate memory.\n");
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
 			allocArray[i] = value_int;
 			*value_int = strtoul((argv[i]) + 2, NULL, 16);
 
@@ -967,13 +996,18 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	} else
 		printf("Failed to create pSequenceHolder\n");
 
+cleanup:
 	/* Cleanup */
 	for (i = 0; i < argc; i++)
-		free(allocArray[i]);
-
-	free(dtdArray);
-	free(valueArray);
-	free(allocArray);
+		if (allocArray[i])
+			free(allocArray[i]);
+
+	if (dtdArray)
+		free(dtdArray);
+	if (valueArray)
+		free(valueArray);
+	if (allocArray)
+		free(allocArray);
 
 	sdp_record_free(rec);
 
-- 
2.1.4


Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, p.sinha@samsung.com, sanjay.nm@samsung.com,
	bharat.panda@samsung.com, vikram.pal@samsung.com
Subject: [PATCH ] tools: Fix memory related stuffs
Date: Wed, 25 Jun 2014 15:47:36 +0530
Message-id: <1403691456-15688-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle memory (de)allocation scenarios.
---
 tools/hciattach_ath3k.c |  2 ++
 tools/sdptool.c         | 25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 23208c6..058def0 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -409,6 +409,8 @@ static int ath_parse_ps(FILE *stream)
 
 			tag->len = byte_count;
 			tag->data = (uint8_t *)malloc(byte_count);
+			if (!tag->data)
+				return -ENOMEM;
 
 			status.section = PS_DATA;
 			status.line_count = 0;
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 1600c3e..988379b 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -889,7 +889,7 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	uint8_t uuid16 = SDP_UUID16;
 	uint8_t uint32 = SDP_UINT32;
 	uint8_t str8 = SDP_TEXT_STR8;
-	int i, ret = 0;
+	int i, j, ret = 0;
 
 	/* Get the old SDP record */
 	attrid_list = sdp_list_append(NULL, &range);
@@ -903,8 +903,21 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 
 	/* Create arrays */
 	dtdArray = (void **)malloc(argc * sizeof(void *));
+	if (!dtdArray)
+		return -ENOMEM;
+
 	valueArray = (void **)malloc(argc * sizeof(void *));
+	if (!valueArray) {
+		free (dtdArray);
+		return -ENOMEM;
+	}
+
 	allocArray = (void **)malloc(argc * sizeof(void *));
+	if (!allocArray) {
+		free (dtdArray);
+		free (valueArray);
+		return -ENOMEM;
+	}
 
 	/* Loop on all args, add them in arrays */
 	for (i = 0; i < argc; i++) {
@@ -913,6 +926,11 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 			/* UUID16 */
 			uint16_t value_int = strtoul((argv[i]) + 3, NULL, 16);
 			uuid_t *value_uuid = (uuid_t *) malloc(sizeof(uuid_t));
+			if (!value_uuid) {
+				ret = -ENOMEM;
+				goto end;
+			}
+
 			allocArray[i] = value_uuid;
 			sdp_uuid16_create(value_uuid, value_int);
 
@@ -948,9 +966,10 @@ static int set_attribseq(sdp_session_t *session, uint32_t handle, uint16_t attri
 	} else
 		printf("Failed to create pSequenceHolder\n");
 
+end:
 	/* Cleanup */
-	for (i = 0; i < argc; i++)
-		free(allocArray[i]);
+	for (j = 0; j < i; j++)
+		free(allocArray[j]);
 
 	free(dtdArray);
 	free(valueArray);
-- 
1.9.1


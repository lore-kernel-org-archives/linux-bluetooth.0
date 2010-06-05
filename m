Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 3/3] sdptool: Fix 2 possible NULL dereference
Date: Sat,  5 Jun 2010 07:14:30 -0300
Message-Id: <1275732870-15889-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275732870-15889-3-git-send-email-gustavo@padovan.org>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
 <1275732870-15889-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issues found by smatch static check:
http://smatch.sourceforge.net/
---
 tools/sdptool.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 6fb2e90..89a497a 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -513,14 +513,16 @@ static void sdp_data_printf(sdp_data_t *sdpdata, struct attrib_context *context,
  */
 static void print_tree_attr_func(void *value, void *userData)
 {
-	sdp_data_t *sdpdata = NULL;
+	sdp_data_t *sdpdata = value;
 	uint16_t attrId;
 	struct service_context *service = (struct service_context *) userData;
 	struct attrib_context context;
 	struct attrib_def *attrDef = NULL;
 	int i;
 
-	sdpdata = (sdp_data_t *)value;
+	if (!sdpdata)
+		return;
+
 	attrId = sdpdata->attrId;
 	/* Search amongst the generic attributes */
 	for (i = 0; i < attrib_max; i++)
@@ -549,10 +551,7 @@ static void print_tree_attr_func(void *value, void *userData)
 	context.attrib = attrDef;
 	context.member_index = 0;
 	/* Parse attribute members */
-	if (sdpdata)
-		sdp_data_printf(sdpdata, &context, 2);
-	else
-		printf("  NULL value\n");
+	sdp_data_printf(sdpdata, &context, 2);
 	/* Update service */
 	service->service = context.service;
 }
@@ -723,6 +722,9 @@ static void print_raw_attr_func(void *value, void *userData)
 	struct attrib_def *def = NULL;
 	int i;
 
+	if (!data)
+		return;
+
 	/* Search amongst the generic attributes */
 	for (i = 0; i < attrib_max; i++)
 		if (attrib_names[i].num == data->attrId) {
@@ -735,10 +737,7 @@ static void print_raw_attr_func(void *value, void *userData)
 	else
 		printf("\tAttribute 0x%04x\n", data->attrId);
 
-	if (data)
-		print_raw_data(data, 2);
-	else
-		printf("  NULL value\n");
+	print_raw_data(data, 2);
 }
 
 static void print_raw_attr(sdp_record_t *rec)
-- 
1.7.1


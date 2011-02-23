Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Use attribute data list memory allocation function on attrib server
Date: Wed, 23 Feb 2011 19:33:13 -0300
Message-Id: <1298500393-4894-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298500393-4894-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298500393-4894-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7ec0f56..21868b3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -260,17 +260,17 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	length = g_slist_length(groups);
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = last_size + 4;	/* Length of each element */
-	adl->num = length;	/* Number of primary or secondary services */
-	adl->data = g_malloc(length * sizeof(uint8_t *));
+	adl = att_data_list_alloc(length, last_size + 4);
+	if (adl == NULL) {
+		length = 0;
+		goto failed;
+	}
 
 	for (i = 0, l = groups; l; l = l->next, i++) {
 		uint8_t *value;
 
 		cur = l->data;
 
-		adl->data[i] = g_malloc(adl->len);
 		value = (void *) adl->data[i];
 
 		att_put_u16(cur->handle, value);
@@ -281,6 +281,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	length = enc_read_by_grp_resp(adl, pdu, len);
 
+failed:
 	att_data_list_free(adl);
 	g_slist_foreach(groups, (GFunc) g_free, NULL);
 	g_slist_free(groups);
@@ -341,16 +342,16 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 	/* Handle length plus attribute value length */
 	length += 2;
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = length;	/* Length of each element */
-	adl->num = num;		/* Number of primary or secondary services */
-	adl->data = g_malloc(num * sizeof(uint8_t *));
+	adl = att_data_list_alloc(num, length);
+	if (adl == NULL) {
+		length = 0;
+		goto failed;
+	}
 
 	for (i = 0, l = types; l; i++, l = l->next) {
 		uint8_t *value;
 
 		a = l->data;
-		adl->data[i] = g_malloc(length);
 
 		value = (void *) adl->data[i];
 
@@ -362,6 +363,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 
 	length = enc_read_by_type_resp(adl, pdu, len);
 
+failed:
 	att_data_list_free(adl);
 	g_slist_free(types);
 
@@ -414,16 +416,16 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		format = 0x02;
 	}
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = length + 2;	/* Length of each element */
-	adl->num = num;		/* Number of primary or secondary services */
-	adl->data = g_malloc(num * sizeof(uint8_t *));
+	adl = att_data_list_alloc(num, length + 2);
+	if (adl == NULL) {
+		length = 0;
+		goto failed;
+	}
 
 	for (i = 0, l = info; l; i++, l = l->next) {
 		uint8_t *value;
 
 		a = l->data;
-		adl->data[i] = g_malloc(adl->len);
 
 		value = (void *) adl->data[i];
 
@@ -435,6 +437,7 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 
 	length = enc_find_info_resp(format, adl, pdu, len);
 
+failed:
 	att_data_list_free(adl);
 	g_slist_free(info);
 
-- 
1.7.4.1


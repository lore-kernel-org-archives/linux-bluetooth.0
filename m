Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 2/2] Use attribute data list memory allocation function on attrib server
Date: Thu, 24 Feb 2011 18:19:28 -0300
Message-Id: <1298582368-28819-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <=1298500393-4894-2-git-send-email-claudio.takahasi@openbossa.org>
References: <=1298500393-4894-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 62c10f4..2bfeed4 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -381,17 +381,13 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	length = g_slist_length(groups);
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = last_size + 4;	/* Length of each element */
-	adl->num = length;	/* Number of primary or secondary services */
-	adl->data = g_malloc(length * sizeof(uint8_t *));
+	adl = att_data_list_alloc(length, last_size + 4);
 
 	for (i = 0, l = groups; l; l = l->next, i++) {
 		uint8_t *value;
 
 		cur = l->data;
 
-		adl->data[i] = g_malloc(adl->len);
 		value = (void *) adl->data[i];
 
 		att_put_u16(cur->handle, value);
@@ -472,16 +468,12 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 	/* Handle length plus attribute value length */
 	length += 2;
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = length;	/* Length of each element */
-	adl->num = num;		/* Number of primary or secondary services */
-	adl->data = g_malloc(num * sizeof(uint8_t *));
+	adl = att_data_list_alloc(num, length);
 
 	for (i = 0, l = types; l; i++, l = l->next) {
 		uint8_t *value;
 
 		a = l->data;
-		adl->data[i] = g_malloc(length);
 
 		value = (void *) adl->data[i];
 
@@ -545,16 +537,12 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 		format = 0x02;
 	}
 
-	adl = g_new0(struct att_data_list, 1);
-	adl->len = length + 2;	/* Length of each element */
-	adl->num = num;		/* Number of primary or secondary services */
-	adl->data = g_malloc(num * sizeof(uint8_t *));
+	adl = att_data_list_alloc(num, length + 2);
 
 	for (i = 0, l = info; l; i++, l = l->next) {
 		uint8_t *value;
 
 		a = l->data;
-		adl->data[i] = g_malloc(adl->len);
 
 		value = (void *) adl->data[i];
 
-- 
1.7.4.1


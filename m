Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH v3 3/5] Check properties before setting client configs
Date: Wed, 23 Feb 2011 12:14:19 -0300
Message-Id: <1298474061-18410-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1298408491-11154-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1298408491-11154-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Dieb Martins <andre.dieb@signove.com>

Only enable notification/indication if the descriptor allows it.
---
 src/attrib-server.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 47ca5d9..21da17e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -199,13 +199,14 @@ static uint8_t client_set_notifications(struct attribute *attr,
 	struct gatt_channel *channel = user_data;
 	struct attribute *last_chr_val = NULL;
 	uint16_t cfg_val;
+	uint8_t props;
 	uuid_t uuid;
 	GSList *l;
 
 	cfg_val = att_get_u16(attr->data);
 
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	for (l = database; l != NULL; l = l->next) {
+	for (l = database, props = 0; l != NULL; l = l->next) {
 		struct attribute *a = l->data;
 		static uint16_t handle = 0;
 
@@ -213,6 +214,7 @@ static uint8_t client_set_notifications(struct attribute *attr,
 			break;
 
 		if (sdp_uuid_cmp(&a->uuid, &uuid) == 0) {
+			props = att_get_u8(&a->data[0]);
 			handle = att_get_u16(&a->data[1]);
 			continue;
 		}
@@ -224,8 +226,11 @@ static uint8_t client_set_notifications(struct attribute *attr,
 	if (last_chr_val == NULL)
 		return 0;
 
-	/* FIXME: Characteristic properties shall be checked for
-	 * Notification/Indication permissions. */
+	if ((cfg_val & 0x0001) && !(props & ATT_CHAR_PROPER_NOTIFY))
+		return ATT_ECODE_WRITE_NOT_PERM;
+
+	if ((cfg_val & 0x0002) && !(props & ATT_CHAR_PROPER_INDICATE))
+		return ATT_ECODE_WRITE_NOT_PERM;
 
 	if (cfg_val & 0x0001)
 		channel->notify = g_slist_append(channel->notify, last_chr_val);
-- 
1.7.0.4


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/8] mgmt: Remove not used members from controller_info
Date: Tue, 16 Oct 2012 12:12:57 +0200
Message-ID: <1350382379-30489-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

notified, version, manufacturer and dev_class were not used for
anything usefull. For debug print reply can be used directly.

---
 src/mgmt.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 8caabe8..627fb4b 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -61,13 +61,9 @@ struct pending_uuid {
 static int max_index = -1;
 static struct controller_info {
 	gboolean valid;
-	gboolean notified;
 	bdaddr_t bdaddr;
-	uint8_t version;
-	uint16_t manufacturer;
 	uint32_t supported_settings;
 	uint32_t current_settings;
-	uint8_t dev_class[3];
 	GSList *connections;
 	uint8_t discov_type;
 
@@ -1075,20 +1071,16 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	info = &controllers[index];
 
 	bacpy(&info->bdaddr, &rp->bdaddr);
-	info->version = rp->version;
-	info->manufacturer = bt_get_le16(&rp->manufacturer);
 
 	memcpy(&info->supported_settings, &rp->supported_settings,
 					sizeof(info->supported_settings));
 	memcpy(&info->current_settings, &rp->current_settings,
 					sizeof(info->current_settings));
 
-	memcpy(info->dev_class, rp->dev_class, sizeof(info->dev_class));
-
 	ba2str(&info->bdaddr, addr);
 	DBG("hci%u addr %s version %u manufacturer %u class 0x%02x%02x%02x\n",
-		index, addr, info->version, info->manufacturer,
-		info->dev_class[2], info->dev_class[1], info->dev_class[0]);
+		index, addr, rp->version, bt_get_le16(&rp->manufacturer),
+		rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
 	DBG("hci%u settings", index);
 	DBG("hci%u name %s", index, (char *) rp->name);
 	DBG("hci%u short name %s", index, (char *) rp->short_name);
-- 
1.7.9.5


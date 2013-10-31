Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/client: Don't alignt name property while printing
Date: Thu, 31 Oct 2013 14:22:01 +0100
Message-ID: <1383225721-7579-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Received name property is guaranteed to be NULL terminated so there is
no need to use length specifier. This also fix really long space while
printing due to text alignment to the right.
---
 android/client/if-bt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 16bd882..c9681fc 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -88,8 +88,7 @@ static char *btproperty2str(bt_property_t property)
 	switch (property.type) {
 	case BT_PROPERTY_BDNAME:
 	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		sprintf(p, "%*s", property.len,
-					((bt_bdname_t *) property.val)->name);
+		sprintf(p, "%s", ((bt_bdname_t *) property.val)->name);
 		break;
 
 	case BT_PROPERTY_BDADDR:
-- 
1.8.4.1


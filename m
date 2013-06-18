Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/AVRCP: Fix invalid response to RegisterNotification
Date: Tue, 18 Jun 2013 11:09:53 +0300
Message-Id: <1371542994-24510-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
References: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The response to RegisterNotification for event settings changed was
not setting the initial length properly which cause the code to send
malformed/invalid PDUs.
---
 profiles/audio/avrcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f0554fe..f028da9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1450,20 +1450,25 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
+		len = 1;
 		settings = player_list_settings(player);
 
-		pdu->params[++len] = g_list_length(settings);
+		pdu->params[len++] = g_list_length(settings);
 		for (; settings; settings = settings->next) {
 			const char *key = settings->data;
-			uint8_t attr = attr_to_val(key);
+			int attr;
 			int val;
 
+			attr = attr_to_val(key);
+			if (attr < 0)
+				continue;
+
 			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
 
-			pdu->params[++len] = attr;
-			pdu->params[++len] = val;
+			pdu->params[len++] = attr;
+			pdu->params[len++] = val;
 		}
 
 		break;
-- 
1.8.1.4


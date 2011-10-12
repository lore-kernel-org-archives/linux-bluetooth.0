Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 05/12] Move debug messages to their correspondent getters
Date: Wed, 12 Oct 2011 12:11:15 -0300
Message-Id: <1318432282-25002-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c36af5d..6bddf5b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -474,9 +474,15 @@ static int player_set_attribute(struct avrcp_player *player,
 
 static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
 {
-	DBG("Get attribute: %u", attr);
+	int value;
 
-	return player->cb->get_setting(attr, player->user_data);
+	DBG("attr %u", attr);
+
+	value = player->cb->get_setting(attr, player->user_data);
+	if (value < 0)
+		DBG("attr %u not supported by player", attr);
+
+	return value;
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
@@ -535,10 +541,8 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player *player,
 		goto done;
 
 	for (i = 1; i <= AVRCP_ATTRIBUTE_SCAN; i++) {
-		if (player_get_attribute(player, i) < 0) {
-			DBG("Ignoring setting %u: not supported by player", i);
+		if (player_get_attribute(player, i) < 0)
 			continue;
-		}
 
 		len++;
 		pdu->params[len] = i;
@@ -681,11 +685,8 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player *player
 		}
 
 		val = player_get_attribute(player, settings[i]);
-		if (val < 0) {
-			DBG("Ignoring %u: not supported by player",
-								settings[i]);
+		if (val < 0)
 			continue;
-		}
 
 		pdu->params[++len] = settings[i];
 		pdu->params[++len] = val;
-- 
1.7.7


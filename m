Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/7] AVRCP: Do not list values for unsupported attributes
Date: Mon, 10 Oct 2011 09:37:10 -0300
Message-Id: <1318250231-14001-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index ea175e3..0d9b6d0 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -565,11 +565,10 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
 	if (len != 1 || !player)
 		goto err;
 
-	len = attr_get_max_val(pdu->params[0]);
-	if (!len) {
-		error("Attribute is invalid: %u", pdu->params[0]);
+	if (player_get_attribute(player, pdu->params[0]) < 0)
 		goto err;
-	}
+
+	len = attr_get_max_val(pdu->params[0]);
 
 	for (i = 1; i <= len; i++)
 		pdu->params[i] = i;
-- 
1.7.7


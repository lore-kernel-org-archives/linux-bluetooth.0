Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 7/7] AVRCP: fix off-by-one in media attribute iteration
Date: Mon, 10 Oct 2011 09:37:11 -0300
Message-Id: <1318250231-14001-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 0d9b6d0..3576008 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -603,7 +603,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	nattr = pdu->params[8];
 
 	if (!nattr) {
-		for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
+		for (i = 1; i <= AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
 			size = player_get_media_attribute(player, i,
 							&pdu->params[pos],
 							AVRCP_PDU_MTU - pos);
-- 
1.7.7


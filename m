Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/7] Remove left over comment
Date: Mon, 10 Oct 2011 09:37:07 -0300
Message-Id: <1318250231-14001-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since "138f831 AVRCP: return empty string instead of rejecting" we
return empty strings for all the attributes when there isn't any value
set.
---
 audio/avrcp.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c36af5d..058fa83 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -600,10 +600,6 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	nattr = pdu->params[8];
 
 	if (!nattr) {
-		/*
-		 * Return all available information, at least
-		 * title must be returned.
-		 */
 		for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
 			size = player_get_media_attribute(player, i,
 							&pdu->params[pos],
-- 
1.7.7


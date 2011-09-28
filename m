Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] AVRCP: fix case when only one setting is provided
Date: Wed, 28 Sep 2011 19:35:57 -0300
Message-Id: <1317249357-1362-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If CT tries to change an Application Setting providing only one
setting, the size of the PDU will be 3 bytes. Therefore we should check
if the PDU is shorter than or equal 3, not only shorter.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index e7b0d1b..ac9a107 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1021,7 +1021,7 @@ static uint8_t avrcp_handle_set_player_value(struct media_player *mp,
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
-	if (len < 3)
+	if (len <= 3)
 		goto err;
 
 	len = 0;
-- 
1.7.6.4


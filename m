Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] AVRCP: fix loop over number of application settings
Date: Mon,  3 Oct 2011 23:56:00 -0300
Message-Id: <1317696960-1937-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

Hi, Luiz,

I applied this patch on top of yours. If you are able to test the "set_player_value"
at UPF, please apply this patch first.


Regards,

 audio/avrcp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index cfdb313..6969fac 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -719,6 +719,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
 	if (len <= 3)
 		goto err;
 
+	DBG("len %u", len);
 	len = 0;
 
 	/*
@@ -728,13 +729,14 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
 	 * attribute is valid, we respond with no parameters. Otherwise an
 	 * E_INVALID_PARAM is sent.
 	 */
-	for (i = 1; i < pdu->params[0]; i += 2) {
+	for (i = 1; i < (2 * pdu->params[0] + 1U); i += 2) {
 		uint8_t attr = pdu->params[i];
 		uint8_t val = pdu->params[i + 1];
 
 		if (player_set_attribute(player, attr, val) < 0)
 			continue;
 
+		DBG("set attr %u val %u", attr, val);
 		len++;
 	}
 
-- 
1.7.6.4


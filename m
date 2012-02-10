Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 13/22] audio: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:58 -0300
Message-Id: <1328910007-25604-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c9ec314..a07ffeb 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -638,13 +638,13 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
-	uint64_t *identifier = (uint64_t *) &pdu->params[0];
+	uint64_t identifier = bt_get_h64(pdu->params);
 	uint16_t pos;
 	uint8_t nattr;
 	GList *attr_ids;
 	uint16_t offset;
 
-	if (len < 9 || *identifier != 0)
+	if (len < 9 || identifier != 0)
 		goto err;
 
 	nattr = pdu->params[8];
@@ -661,10 +661,10 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 		len = g_list_length(attr_ids);
 	} else {
 		unsigned int i;
-		uint32_t *attr = (uint32_t *) &pdu->params[9];
+		uint32_t *attr = (void *) &pdu->params[9];
 
 		for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++, attr++) {
-			uint32_t id = ntohl(bt_get_unaligned(attr));
+			uint32_t id = bt_get_be32(attr);
 
 			/* Don't add invalid attributes */
 			if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
-- 
1.7.8.1


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 10/15] avrcp: Fix compilation errors due to unaligned memory access
Date: Fri, 31 Aug 2012 14:40:06 +0200
Message-ID: <1346416811-23484-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors on ARM.

  CC     audio/bluetoothd-avrcp.o
audio/avrcp.c: In function avrcp_handle_get_element_attributes:
audio/avrcp.c:667:25: error: cast increases required alignment of
	target type [-Werror=cast-align]
audio/avrcp.c:690:20: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [audio/bluetoothd-avrcp.o] Error 1
make: *** [all] Error 2

---
 audio/avrcp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index d925365..9c474f3 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -664,13 +664,13 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
-	uint64_t *identifier = (uint64_t *) &pdu->params[0];
+	uint64_t identifier = bt_get_64(&pdu->params[0]);
 	uint16_t pos;
 	uint8_t nattr;
 	GList *attr_ids;
 	uint16_t offset;
 
-	if (len < 9 || *identifier != 0)
+	if (len < 9 || identifier != 0)
 		goto err;
 
 	nattr = pdu->params[8];
@@ -687,10 +687,10 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 		len = g_list_length(attr_ids);
 	} else {
 		unsigned int i;
-		uint32_t *attr = (uint32_t *) &pdu->params[9];
+		for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++) {
+			uint32_t id;
 
-		for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++, attr++) {
-			uint32_t id = ntohl(bt_get_unaligned(attr));
+			id = bt_get_be32(&pdu->params[9] + (i * sizeof(id)));
 
 			/* Don't add invalid attributes */
 			if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
-- 
1.7.9.5


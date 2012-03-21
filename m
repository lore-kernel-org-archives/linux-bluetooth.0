Return-Path: <cyrus@holtmann.org>
From: Chethan T N <chethan.tn@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chethan T N <chethan.tn@samsung.com>
Subject: [PATCH] avrcp: Handle of GetPlayerApplicationSettingAttributeText pdu
Date: Wed, 21 Mar 2012 11:34:09 +0530
Message-id: <1332309849-4303-1-git-send-email-chethan.tn@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for TG role GetPlayerApplicationSettingAttributeText added
to pass PTS test case TP/PAS/BV-04-C
---
 audio/avrcp.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c9ec314..b09a777 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -800,6 +800,97 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static const char *attr_to_str(uint8_t attr)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		return "Equalizer";
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		return "Repeat";
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		return "Shuffle";
+	case AVRCP_ATTRIBUTE_SCAN:
+		return "Scan";
+	}
+
+	return NULL;
+}
+
+static uint8_t avrcp_handle_get_player_attribute_text(struct avrcp_player *player,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	uint8_t *settings = NULL;
+	unsigned int i = 0;
+	uint8_t no_of_attr = 0;
+	const char *attstr = NULL;
+
+	if (player == NULL || len <= 1 || pdu->params[0] != len - 1)
+		goto err;
+
+	/*
+	 * Save a copy of requested settings because we can override them
+	 * while responding
+	 */
+	settings = g_memdup(&pdu->params[1], pdu->params[0]);
+	len = 0;
+
+	/*
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent IDs
+	 * and send a response with the existent ones.
+	 */
+	for (i = 0; i < pdu->params[0]; i++) {
+
+		if (settings[i] < AVRCP_ATTRIBUTE_EQUALIZER ||
+					settings[i] > AVRCP_ATTRIBUTE_SCAN) {
+			DBG("Ignoring %u", settings[i]);
+			continue;
+		}
+
+		if (player_get_attribute(player, settings[i]) < 0)
+			continue;
+
+		/*
+		 * No of attributes that are supported by the player
+		 */
+		no_of_attr++;
+		pdu->params[++len] = settings[i];
+
+		/*
+		 * As per the MIBenum defined in IANA character set
+		 * document the value of displayable UTF-8 charater set
+		 * value is 0x006A
+		 */
+		pdu->params[++len] = 0x00;
+		pdu->params[++len] = 0x6A;
+		attstr = attr_to_str(settings[i]);
+
+		if (NULL != attstr) {
+			pdu->params[++len] = strlen(attstr);
+			len = len + 1;
+			strncpy((char *) (pdu->params + len), attstr, strlen(attstr));
+			len = len + strlen(attstr);
+		}
+	}
+
+	g_free(settings);
+
+	if (len) {
+		pdu->params[0] = no_of_attr;
+		pdu->params_len = htons(len + 1);
+
+		return AVC_CTYPE_STABLE;
+	}
+
+	error("No valid attributes in request");
+
+err:
+	pdu->params_len = htons(1);
+	pdu->params[0] = E_INVALID_PARAM;
+	return AVC_CTYPE_REJECTED;
+}
+
 static uint8_t avrcp_handle_displayable_charset(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -1015,7 +1106,7 @@ static struct pdu_handler {
 		{ AVRCP_SET_PLAYER_VALUE, AVC_CTYPE_CONTROL,
 					avrcp_handle_set_player_value },
 		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, AVC_CTYPE_STATUS,
-					NULL },
+					avrcp_handle_get_player_attribute_text },
 		{ AVRCP_GET_PLAYER_VALUE_TEXT, AVC_CTYPE_STATUS,
 					NULL },
 		{ AVRCP_DISPLAYABLE_CHARSET, AVC_CTYPE_STATUS,
-- 
1.7.5.4


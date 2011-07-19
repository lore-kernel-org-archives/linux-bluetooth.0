Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 05/19] avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
Date: Tue, 19 Jul 2011 16:49:16 -0300
Message-Id: <1311104970-18600-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index cd3beb7..884e01c 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -115,6 +115,7 @@
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 #define AVRCP_LIST_PLAYER_VALUES	0x12
+#define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -588,6 +589,64 @@ static int handle_vendordep_pdu(struct control *control,
 
 		return AVRCP_HEADER_LENGTH +
 				AVRCP_SPECAVCPDU_HEADER_LENGTH + len + 1;
+	case AVRCP_GET_CURRENT_PLAYER_VALUE:
+		if (len > 1 && pdu->params[0] == len - 1 &&
+						avrcp->code == CTYPE_STATUS) {
+			uint8_t settings[pdu->params[0]];
+
+			memcpy(settings, &pdu->params[1], len);
+			len = 0;
+
+			/*
+			 * From sec. 5.7 of AVRCP 1.3 spec, we should igore
+			 * non-existent IDs and send a response with the
+			 * existent ones. Only if all IDs are non-existent we
+			 * should send an error.
+			 */
+			for (i = 0; i < pdu->params[0]; i++) {
+				uint8_t val;
+
+				if (settings[i] < PLAYER_SETTING_EQUALIZER) {
+					DBG("Ignoring invalid setting %u",
+								settings[i]);
+					continue;
+				}
+
+				if (settings[i] > PLAYER_SETTING_SCAN) {
+					DBG("Ignoring invalid setting %u",
+								settings[i]);
+					continue;
+				}
+
+				val = control->player_setting[settings[i]];
+				if (!val) {
+					DBG("Ignoring setting %u since value"
+							"has never been set",
+							settings[i]);
+					continue;
+				}
+
+				pdu->params[len * 2 + 1] = settings[i];
+				pdu->params[len * 2 + 2] = val;
+				len++;
+			}
+
+			if (!len) {
+				error("GetCurrentPlayerValue: no valid "
+						"attribute found in request");
+				pdu->params[0] = E_INVALID_PARAM;
+				goto err_metadata;
+			}
+
+			avrcp->code = CTYPE_STABLE;
+			pdu->params[0] = len;
+			pdu->params_len = htons(2 * len + 1);
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + 2 * len + 1;
+		}
+
+		break;
 	}
 
 	/*
-- 
1.7.6


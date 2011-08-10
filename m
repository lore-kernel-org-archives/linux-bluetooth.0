Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 12/22] avrcp: handle InformDisplayableCharacterSet pdu
Date: Wed, 10 Aug 2011 10:06:26 -0300
Message-Id: <1312981596-7291-13-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 009cb81..6590cbb 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -119,6 +119,7 @@
 #define AVRCP_SET_PLAYER_VALUE		0x14
 #define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
+#define AVRCP_DISPLAYABLE_CHARSET	0x17
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -1043,6 +1044,26 @@ static int handle_vendordep_pdu(struct control *control,
 		 */
 		pdu->params[0] = E_INVALID_PARAM;
 		goto err_metadata;
+	case AVRCP_DISPLAYABLE_CHARSET:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		if (pdu->params[0] < 3) {
+			pdu->params[0] = E_INVALID_PARAM;
+			goto err_metadata;
+		}
+
+		/*
+		 * We acknowledge the commands, but we always use UTF-8 for
+		 * encoding since CT is obliged to support it.
+		 */
+		pdu->params_len = 0;
+		avrcp->code = CTYPE_STABLE;
+		len = 0;
+
+		break;
 	default:
 		/* Invalid pdu_id */
 		pdu->params[0] = E_INVALID_COMMAND;
-- 
1.7.6


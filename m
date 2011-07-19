Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 08/19] avrcp: handle InformDisplayableCharacterSet pdu
Date: Tue, 19 Jul 2011 16:49:19 -0300
Message-Id: <1311104970-18600-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 36f727f..2825e6c 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -119,6 +119,7 @@
 #define AVRCP_SET_PLAYER_VALUE		0x14
 #define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
+#define AVRCP_DISPLAYABLE_CHARSET	0x17
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -840,6 +841,18 @@ static int handle_vendordep_pdu(struct control *control,
 		 */
 		pdu->params[0] = E_INVALID_PARAM;
 		goto err_metadata;
+	case AVRCP_DISPLAYABLE_CHARSET:
+		if (len < 3 || avrcp->code != CTYPE_STATUS)
+			break;
+
+		/*
+		 * We acknowledge the commands, but we always use UTF-8 for
+		 * encoding since CT is obliged to support it
+		 */
+		pdu->params_len = 0;
+
+		return AVRCP_HEADER_LENGTH +
+			AVRCP_SPECAVCPDU_HEADER_LENGTH;
 	}
 
 	/*
-- 
1.7.6


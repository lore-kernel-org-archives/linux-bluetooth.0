Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/5] avrcp: fix overwrite of number of attributes
Date: Thu, 15 Sep 2011 01:21:34 -0300
Message-Id: <1316060497-4068-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The response of GetCurrentPlayerApplicationSettingValue expects the
first operand to be the number of attributes in response. Since we start
with len=0, we were overwriting this number with the value of the first
attribute.

Also use g_memdup instead of g_malloc + memcpy.
---
 audio/avrcp.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 9b1d797..783ba02 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -947,8 +947,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct media_player *mp,
 	 * Save a copy of requested settings because we can override them
 	 * while responding
 	 */
-	settings = g_malloc(pdu->params[0]);
-	memcpy(settings, &pdu->params[1], pdu->params[0]);
+	settings = g_memdup(&pdu->params[1], pdu->params[0]);
 	len = 0;
 
 	/*
@@ -972,16 +971,15 @@ static uint8_t avrcp_handle_get_current_player_value(struct media_player *mp,
 			continue;
 		}
 
-		pdu->params[len] = settings[i];
-		pdu->params[len + 1] = val;
-		len += 2;
+		pdu->params[++len] = settings[i];
+		pdu->params[++len] = val;
 	}
 
 	g_free(settings);
 
 	if (len) {
-		pdu->params[0] = len;
-		pdu->params_len = htons(2 * len + 1);
+		pdu->params[0] = len / 2;
+		pdu->params_len = htons(len + 1);
 
 		return AVC_CTYPE_STABLE;
 	}
-- 
1.7.6.1


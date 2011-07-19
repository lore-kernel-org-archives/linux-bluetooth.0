Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 15/19] avrcp: answer query for supported events
Date: Tue, 19 Jul 2011 16:49:26 -0300
Message-Id: <1311104970-18600-16-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 212e95c..88efdb5 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -745,6 +745,16 @@ static int handle_vendordep_pdu(struct control *control,
 			return AVRCP_HEADER_LENGTH +
 					AVRCP_SPECAVCPDU_HEADER_LENGTH + 1 +
 					3 * G_N_ELEMENTS(company_ids);
+		case CAP_EVENTS_SUPPORTED:
+			avrcp->code = CTYPE_STABLE;
+			/* CpabilityID + CapabilityCount + n_events */
+			pdu->params_len = htons(4);
+			pdu->params[1] = 2;
+			pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
+			pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + 4;
 		}
 
 		pdu->params[0] = E_INVALID_PARAM;
-- 
1.7.6


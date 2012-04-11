Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 1/3] AVRCP: Add missing capability for TrackReachedEnd
Date: Wed, 11 Apr 2012 13:05:18 +0200
Message-ID: <1334142318-24916-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <CABBYNZKK+6UyXxJ=eethVf9AOMknMsty93tFaKeP_gpkzrFtdg@mail.gmail.com>
References: <CABBYNZKK+6UyXxJ=eethVf9AOMknMsty93tFaKeP_gpkzrFtdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing capability for TrackReachedEnd.
---
 audio/avrcp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8eba046..6eb4bb1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -557,12 +557,13 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params_len = htons(5);
-		pdu->params[1] = 3;
+		pdu->params[1] = 4;
 		pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
+		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
 
+		pdu->params_len = htons(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
 	}
 
-- 
on behalf of ST-Ericsson


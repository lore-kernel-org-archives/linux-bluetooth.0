Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <vani.patel@stericsson.com>,
	<joohi.rastogi@stericsson.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 1/3] avrcp: Fix response ctype of AbortContinuingResponse
Date: Thu, 1 Mar 2012 15:45:33 +0100
Message-ID: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Request ctype of "AbortContinuingResponse" is CONTROL, so response should be
ACCEPTED instead of STABLE. This affect PTS Test Case for TP/RCR/BV-04-C.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c9ec314..4573133 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -986,7 +986,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
 	player_abort_pending_pdu(player);
 	pdu->params_len = 0;
 
-	return AVC_CTYPE_STABLE;
+	return AVC_CTYPE_ACCEPTED;
 
 err:
 	pdu->params_len = htons(1);
-- 
on behalf of ST-Ericsson


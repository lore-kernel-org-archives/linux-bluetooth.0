Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 02/19] avrcp: Fix the response ctype of
 SetPlayerApplicationSettingValue
Date: Thu, 12 Apr 2012 20:32:53 +0530
Message-id: <1334243001-17016-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Request ctype of "SetPlayerApplicationSettingValue" is CONTROL,
so response should be ACCEPTED instead of STABLE.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8eba046..70e5bbf 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -791,7 +791,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
 	if (len) {
 		pdu->params_len = 0;
 
-		return AVC_CTYPE_STABLE;
+		return AVC_CTYPE_ACCEPTED;
 	}
 
 err:
-- 
1.7.4.1


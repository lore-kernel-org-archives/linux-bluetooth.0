Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] AVRCP: fix changed notification
Date: Thu, 29 Sep 2011 14:07:28 -0300
Message-Id: <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We sure want to send notifications only when section is not NULL.
Otherwise we either crash or do not send the expected notification.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index ac9a107..e5b51db 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -549,7 +549,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
 	uint16_t size;
 	int err;
 
-	if (mp->session)
+	if (mp->session == NULL)
 		return -ENOTCONN;
 
 	if (!(mp->registered_events & (1 << id)))
-- 
1.7.6.4


Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] AVRCP: fix missing bytes on notification
Date: Thu, 29 Sep 2011 14:07:29 -0300
Message-Id: <1317316050-12855-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index e5b51db..6e8b8ff 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -591,7 +591,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
 
 	err = avctp_send_vendordep(mp->session, mp->transaction_events[id],
 					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
-					buf, size);
+					buf, size + AVRCP_HEADER_LENGTH);
 	if (err < 0)
 		return err;
 
-- 
1.7.6.4


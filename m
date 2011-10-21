Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/5] Add missing TRACK-REACHED-START event
Date: Fri, 21 Oct 2011 15:58:25 -0200
Message-Id: <1319219908-2819-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When track is changed, we automatically start to play it, therefore we
need to notify CT regarding this event.
---
 audio/media.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index a7647ea..ade2a4b 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1488,6 +1488,8 @@ static gboolean parse_player_metadata(struct media_player *mp,
 	uid = get_uid(mp);
 
 	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
+	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START,
+								NULL);
 
 	return TRUE;
 
-- 
1.7.7


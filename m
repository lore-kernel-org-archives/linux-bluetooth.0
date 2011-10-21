Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/5] Fix leak of GTimer
Date: Fri, 21 Oct 2011 15:58:26 -0200
Message-Id: <1319219908-2819-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index ade2a4b..5528ada 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -885,6 +885,7 @@ static void media_player_free(gpointer data)
 	if (mp->settings)
 		g_hash_table_unref(mp->settings);
 
+	g_timer_destroy(mp->timer);
 	g_free(mp->sender);
 	g_free(mp->path);
 	g_free(mp);
-- 
1.7.7


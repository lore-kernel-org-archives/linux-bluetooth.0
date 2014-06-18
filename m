Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 08/11] android/health: Remove unneeded check
Date: Wed, 18 Jun 2014 16:33:51 +0300
Message-Id: <1403098434-28193-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In case of error err is always set so the check is not needed.
---
 android/health.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/health.c b/android/health.c
index 0462e99..f893d0f 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1063,9 +1063,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 	if (!mcap_create_mcl(mcap, &channel->dev->dst, channel->dev->ccpsm,
 					create_mcl_cb, channel, NULL, &gerr)) {
 		error("error creating mcl %s", gerr->message);
-
-		if (gerr)
-			g_error_free(gerr);
+		g_error_free(gerr);
 
 		goto fail;
 	}
-- 
1.8.3.2


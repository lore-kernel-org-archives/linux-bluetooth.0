Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] android/health: Create mdep for ECHO channel
Date: Thu, 26 Jun 2014 15:04:23 +0300
Message-Id: <1403784265-1455-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/android/health.c b/android/health.c
index 6998913..a12933b 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1146,7 +1146,6 @@ static struct health_channel *create_channel(struct health_app *app,
 {
 	struct mdep_cfg *mdep;
 	struct health_channel *channel;
-	uint8_t index;
 	static unsigned int channel_id = 1;
 
 	DBG("mdep %u", mdep_index);
@@ -1154,10 +1153,23 @@ static struct health_channel *create_channel(struct health_app *app,
 	if (!dev || !app)
 		return NULL;
 
-	index = mdep_index + 1;
-	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(index));
-	if (!mdep)
-		return NULL;
+	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(mdep_index));
+	if (!mdep) {
+		if (mdep_index == HDP_MDEP_ECHO) {
+			mdep = new0(struct mdep_cfg, 1);
+			if (!mdep)
+				return NULL;
+
+			/* Leave other configuration zeroes */
+			mdep->id = HDP_MDEP_ECHO;
+
+			if (!queue_push_tail(app->mdeps, mdep)) {
+				free_mdep_cfg(mdep);
+				return NULL;
+			}
+		} else
+			return NULL;
+	}
 
 	/* create channel and push it to device */
 	channel = new0(struct health_channel, 1);
-- 
1.8.3.2


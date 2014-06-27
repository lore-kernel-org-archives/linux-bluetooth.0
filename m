Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/12] android/health: Improve debug
Date: Fri, 27 Jun 2014 14:25:01 +0300
Message-Id: <1403868303-8129-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/android/health.c b/android/health.c
index 9631d9e..093bdea 100644
--- a/android/health.c
+++ b/android/health.c
@@ -160,6 +160,8 @@ static void free_health_channel(void *data)
 {
 	struct health_channel *channel = data;
 
+	DBG("channel %p", channel);
+
 	if (!channel)
 		return;
 
@@ -1137,12 +1139,13 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	struct health_channel *channel = data;
 	struct health_device *dev;
 
-	DBG("");
-
 	if (!channel)
 		return;
 
 	dev = channel->dev;
+
+	DBG("device %p channel %p mdl %p", dev, channel, mdl);
+
 	/* mdl == NULL means, delete all mdls */
 	if (!mdl) {
 		queue_foreach(dev->channels, notify_channel, NULL);
@@ -1258,6 +1261,8 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 	struct health_channel *channel = NULL;
 	bdaddr_t addr;
 
+	DBG("mcl %p mdepid %u", mcl, mdepid);
+
 	mcap_mcl_get_addr(mcl, &addr);
 
 	/* TODO: Search app for mdepid */
@@ -1500,7 +1505,7 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	if (!get_mdep_from_rec(recs->data, mdep->role, mdep->data_type,
 								&mdep_id)) {
-		error("health: no matching MDEP found");
+		error("health: no matching MDEP: %u", channel->mdep_id);
 		goto fail;
 	}
 
-- 
1.8.3.2


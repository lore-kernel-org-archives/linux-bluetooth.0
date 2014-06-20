Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/7] android/health: Fix queue creation for mdeps and devices
Date: Fri, 20 Jun 2014 15:23:30 +0300
Message-Id: <1403267016-28422-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create queue for mdeps, devices and channels when creating app
and device struct. It is simpler to read code than on demand
creation.
---
 android/health.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/android/health.c b/android/health.c
index 0462e99..7553467 100644
--- a/android/health.c
+++ b/android/health.c
@@ -678,6 +678,14 @@ static struct health_app *create_health_app(const char *app_name,
 			goto fail;
 	}
 
+	app->mdeps = queue_new();
+	if (!app->mdeps)
+		goto fail;
+
+	app->devices = queue_new();
+	if (!app->devices)
+		goto fail;
+
 	return app;
 
 fail:
@@ -784,14 +792,6 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 		memcpy(mdep->descr, cmd->descr, cmd->descr_len);
 	}
 
-	if (app->num_of_mdep > 0 && !app->mdeps) {
-		app->mdeps = queue_new();
-		if (!app->mdeps) {
-			status = HAL_STATUS_FAILED;
-			goto fail;
-		}
-	}
-
 	if (!queue_push_tail(app->mdeps, mdep)) {
 		status = HAL_STATUS_FAILED;
 		goto fail;
@@ -1102,6 +1102,11 @@ static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
 
 	android2bdaddr(addr, &dev->dst);
 	dev->app_id = app_id;
+	dev->channels = queue_new();
+	if (!dev->channels) {
+		free_health_device(dev);
+		return NULL;
+	}
 
 	return dev;
 }
@@ -1159,21 +1164,9 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 
 	channel->dev = dev;
 
-	if (!app->devices) {
-		app->devices = queue_new();
-		if (!app->devices)
-			goto fail;
-	}
-
 	if (!queue_push_tail(app->devices, dev))
 		goto fail;
 
-	if (!dev->channels) {
-		dev->channels = queue_new();
-		if (!dev->channels)
-			goto fail;
-	}
-
 	if (!queue_push_tail(dev->channels, channel)) {
 		queue_remove(app->devices, dev);
 		goto fail;
-- 
1.9.1


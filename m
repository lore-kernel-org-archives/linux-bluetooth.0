Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/11] android/health: Refactor create_device
Date: Tue, 24 Jun 2014 15:12:01 +0300
Message-Id: <1403611922-26901-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

create_device() should not search for apps again since we have searched
already, and we do not have always app_id.
---
 android/health.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/android/health.c b/android/health.c
index 2613ca6..df97848 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1352,12 +1352,11 @@ static int connect_mcl(struct health_channel *channel)
 						search_cb, channel, NULL, 0);
 }
 
-static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
+static struct health_device *create_device(struct health_app *app,
+							const uint8_t *addr)
 {
-	struct health_app *app;
 	struct health_device *dev;
 
-	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
 	if (!app)
 		return NULL;
 
@@ -1367,7 +1366,6 @@ static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
 		return NULL;
 
 	android2bdaddr(addr, &dev->dst);
-	dev->app_id = app_id;
 	dev->channels = queue_new();
 	if (!dev->channels) {
 		free_health_device(dev);
@@ -1397,7 +1395,11 @@ static struct health_device *get_device(uint16_t app_id, const uint8_t *addr)
 	if (dev)
 		return dev;
 
-	return create_device(app_id, addr);
+	dev = create_device(app, addr);
+	if (dev)
+		dev->app_id = app_id;
+
+	return dev;
 }
 
 static struct health_channel *create_channel(uint16_t app_id,
-- 
1.8.3.2


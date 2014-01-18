Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] device: Remove addr from struct probe_data
Date: Sat, 18 Jan 2014 13:51:25 +0100
Message-Id: <1390049485-23503-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390049485-23503-1-git-send-email-szymon.janc@gmail.com>
References: <1390049485-23503-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used anywhere.
---
 src/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index aa663f7..bcc5561 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2504,7 +2504,6 @@ static bool device_match_profile(struct btd_device *device,
 struct probe_data {
 	struct btd_device *dev;
 	GSList *uuids;
-	char addr[18];
 };
 
 static void dev_probe(struct btd_profile *p, void *user_data)
@@ -2579,15 +2578,16 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 {
 	struct probe_data d = { device, uuids };
 	GSList *l;
+	char addr[18];
 
-	ba2str(&device->bdaddr, d.addr);
+	ba2str(&device->bdaddr, addr);
 
 	if (device->blocked) {
-		DBG("Skipping profiles for blocked device %s", d.addr);
+		DBG("Skipping profiles for blocked device %s", addr);
 		goto add_uuids;
 	}
 
-	DBG("Probing profiles for device %s", d.addr);
+	DBG("Probing profiles for device %s", addr);
 
 	btd_profile_foreach(dev_probe, &d);
 
-- 
1.8.5.3


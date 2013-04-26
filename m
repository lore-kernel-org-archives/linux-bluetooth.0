Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 08/27] input: Remove unused UUID field
Date: Fri, 26 Apr 2013 08:17:04 +0200
Message-Id: <1366957043-2383-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially remove the field because it's actually not being used.
---
 profiles/input/device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d191967..0688a02 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -66,7 +66,6 @@ enum reconnect_mode_t {
 struct input_device {
 	struct btd_device	*device;
 	char			*path;
-	char			*uuid;
 	bdaddr_t		src;
 	bdaddr_t		dst;
 	uint32_t		handle;
@@ -139,8 +138,6 @@ static void input_device_free(struct input_device *idev)
 	if (idev->reconnect_timer > 0)
 		g_source_remove(idev->reconnect_timer);
 
-	g_free(idev->uuid);
-
 	g_free(idev);
 }
 
@@ -885,8 +882,6 @@ int input_device_register(struct btd_device *device,
 		return -EINVAL;
 	}
 
-	idev->uuid = g_strdup(uuid);
-
 	devices = g_slist_append(devices, idev);
 
 	return 0;
-- 
1.8.1.4


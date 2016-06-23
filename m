Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Don't even attempt to load name if address is private
Date: Thu, 23 Jun 2016 14:40:28 +0300
Message-Id: <1466682028-10937-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device with private address does not have their name stored so it makes
not sense to attempt to load their names.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 83a794e..5506bc9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2655,6 +2655,9 @@ static char *load_cached_name(struct btd_device *device, const char *local,
 	char *str = NULL;
 	int len;
 
+	if (device_address_is_private(device))
+		return NULL;
+
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
 
 	key_file = g_key_file_new();
-- 
2.5.5


Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android: Do not resolve name if we have it in the cache
Date: Mon, 17 Feb 2014 17:26:30 +0100
Message-ID: <1392654390-19913-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1392654390-19913-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1392654390-19913-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, deamon will not ask kernel to resolve name of remote
device during inquiry in case device name is already in the local cache.
Instead Android will be updated with already known device name.
---
 android/bluetooth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1827834..ccfb461 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1186,6 +1186,14 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		bool resolve_name = true;
 
 		ba2str(bdaddr, addr);
+
+		/* Don't need to confirm name if we have it already in cache
+		 * Just check if device name is different than bdaddr */
+		if (g_strcmp0(dev->name, addr)) {
+			get_device_name(dev);
+			resolve_name = false;
+		}
+
 		info("Device %s needs name confirmation (resolve_name=%d)",
 							addr, resolve_name);
 		confirm_device_name(bdaddr, bdaddr_type, resolve_name);
-- 
1.8.4


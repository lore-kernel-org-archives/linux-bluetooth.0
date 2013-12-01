Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/4] sixaxis: Skip controller setup if already connected over Bluetooth
Date: Sun,  1 Dec 2013 14:41:55 +0100
Message-Id: <1385905316-21800-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
References: <1385905316-21800-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If controller is already connected over Bluetooth but was then
plugged-in via USB (eg. to charge battery) there is no need to do
any setup.
---
 plugins/sixaxis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index c3ca267..b8fe287 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -194,6 +194,12 @@ static void setup_device(int fd, int index, struct btd_adapter *adapter)
 	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
 		return;
 
+	/* This can happen if controller was plugged while already connected
+	 * eg. to charge up battery */
+	device = btd_adapter_find_device(adapter, &device_bdaddr);
+	if (device && btd_device_is_connected(device))
+		return;
+
 	adapter_bdaddr = btd_adapter_get_address(adapter);
 
 	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
-- 
1.8.5


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/5] sixaxis: Fix multi-line comments style
Date: Mon, 15 Jun 2015 20:28:30 +0200
Message-Id: <1434392910-31648-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/sixaxis.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 782a89f..9b6cad4 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -435,9 +435,11 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
 		return false;
 
-	/* This can happen if controller was plugged while already connected
+	/*
+	 * This can happen if controller was plugged while already connected
 	 * eg. to charge up battery.
-	 * Don't set LEDs in that case, hence return false */
+	 * Don't set LEDs in that case, hence return false
+	 */
 	device = btd_adapter_find_device(adapter, &device_bdaddr,
 							BDADDR_BREDR);
 	if (device && btd_device_is_connected(device))
@@ -533,8 +535,10 @@ static int get_js_number(struct udev_device *udevice)
 		if (!input_parent)
 			goto next;
 
-		/* check if this is the joystick relative to the hidraw device
-		 * above */
+		/*
+		 * check if this is the joystick relative to the hidraw device
+		 * above
+		 */
 		input_id = udev_device_get_sysattr_value(input_parent, "uniq");
 
 		/*
-- 
2.1.4


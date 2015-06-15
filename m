Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/5] profiles/input: Remove not needed sixaxis checks
Date: Mon, 15 Jun 2015 20:28:29 +0200
Message-Id: <1434392910-31648-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This check is now needed only for DualShock 4.
---
 profiles/input/server.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf8..101108b 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -131,18 +131,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	vid = btd_device_get_vendor(device);
 	pid = btd_device_get_product(device);
 
-	/* DualShock 3 */
-	if (vid == 0x054c && pid == 0x0268)
-		return true;
-
 	/* DualShock 4 */
 	if (vid == 0x054c && pid == 0x05c4)
 		return true;
 
-	/* Navigation Controller */
-	if (vid == 0x054c && pid == 0x042f)
-		return true;
-
 	return false;
 }
 
-- 
2.1.4


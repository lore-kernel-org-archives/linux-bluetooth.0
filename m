Return-Path: <cyrus@holtmann.org>
From: Shuah Khan <shuah.kh@samsung.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: Shuah Khan <shuah.kh@samsung.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuahkhan@gmail.com
Subject: [PATCH rebased] Bluetooth: Add missing reset_resume dev_pm_ops
Date: Tue, 21 May 2013 09:32:06 -0600
Message-Id: <1369150326-4476-1-git-send-email-shuah.kh@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing reset_resume dev_pm_ops. Missing reset_resume results in the
following message after power management device test. This change sets
reset_resume to btusb_resume().

[ 2506.936134] btusb 1-1.5:1.0: no reset_resume for driver btusb?
[ 2506.936137] btusb 1-1.5:1.1: no reset_resume for driver btusb?

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/bluetooth/btusb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a7e5f8..1eb90c0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1616,6 +1616,7 @@ static struct usb_driver btusb_driver = {
 #ifdef CONFIG_PM
 	.suspend	= btusb_suspend,
 	.resume		= btusb_resume,
+	.reset_resume	= btusb_resume,
 #endif
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
-- 
1.7.10.4

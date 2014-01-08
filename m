Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/7] sixaxis: Don't mark USB plugged device as trusted
Date: Wed,  8 Jan 2014 01:02:22 +0100
Message-Id: <1389139348-3552-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There were some valid conserns raised against marking plugged device
as trusted. Mainly due to posibility of crafted USB device. With this
patch user will be asked to confirm service connection and device can
be marked as trusted like any other devices.
---
 plugins/sixaxis.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1154c15..4fdeff3 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -228,7 +228,6 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
 				devices[index].pid, devices[index].version);
 	btd_device_set_temporary(device, FALSE);
-	btd_device_set_trusted(device, TRUE);
 
 	return true;
 }
-- 
1.8.5.2


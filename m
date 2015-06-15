Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/5] sixaxis: Fix PID for Navigation Controller
Date: Mon, 15 Jun 2015 20:28:26 +0200
Message-Id: <1434392910-31648-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Navigation Controller is using PID 0x042f over USB but PID 0x0268
(same as Dualshock 3) over BT.
---
 plugins/sixaxis.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index fcc93bc..50db6c1 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -54,6 +54,7 @@ static const struct {
 	uint16_t vid;
 	uint16_t pid;
 	uint16_t version;
+	uint16_t bt_pid;
 } devices[] = {
 	{
 		.name = "PLAYSTATION(R)3 Controller",
@@ -68,6 +69,7 @@ static const struct {
 		.vid = 0x054c,
 		.pid = 0x042f,
 		.version = 0x0000,
+		.bt_pid = 0x0268,
 	},
 };
 
@@ -300,8 +302,19 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	info("sixaxis: setting up new device");
 
 	btd_device_device_set_name(device, devices[index].name);
-	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
-				devices[index].pid, devices[index].version);
+
+	/* if device reports different pid/vid on BT prefer those over USB */
+	if (devices[index].bt_pid)
+		btd_device_set_pnpid(device, devices[index].source,
+					devices[index].vid,
+					devices[index].bt_pid,
+					devices[index].version);
+	else
+		btd_device_set_pnpid(device, devices[index].source,
+					devices[index].vid,
+					devices[index].pid,
+					devices[index].version);
+
 	btd_device_set_temporary(device, false);
 
 	return true;
-- 
2.1.4


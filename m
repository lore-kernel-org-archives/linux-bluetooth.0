Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/4] android/system-emulator: Update property used for start/stop services
Date: Tue, 14 Jan 2014 16:28:02 +0100
Message-Id: <1389713283-13038-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
References: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/system-emulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/system-emulator.c b/android/system-emulator.c
index f1c6622..0966a02 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -139,17 +139,17 @@ static void system_socket_callback(int fd, uint32_t events, void *user_data)
 
 	printf("Received %s\n", buf);
 
-	if (!strcmp(buf, "ctl.start=bluetoothd")) {
+	if (!strcmp(buf, "bluetooth.start=bluetoothd")) {
 		if (daemon_pid > 0)
 			return;
 
 		ctl_start();
-	} else if (!strcmp(buf, "ctl.start=bluetoothd-snoop")) {
+	} else if (!strcmp(buf, "bluetooth.start=bluetoothd-snoop")) {
 		if (snoop_pid > 0)
 			return;
 
 		snoop_start();
-	} else if (!strcmp(buf, "ctl.stop=bluetoothd-snoop")) {
+	} else if (!strcmp(buf, "bluetooth.stop=bluetoothd-snoop")) {
 		if (snoop_pid > 0)
 			snoop_stop();
 	}
-- 
1.8.3.2


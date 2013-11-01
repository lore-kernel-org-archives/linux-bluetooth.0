Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/socket: Log not implemented HAL functions
Date: Fri,  1 Nov 2013 15:52:45 +0200
Message-Id: <1383313965-30182-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383313965-30182-1-git-send-email-luiz.dentz@gmail.com>
References: <1383313965-30182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it easier to spot which functions the HAL is calling.
---
 android/socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 39709cd..b6eed6e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -34,11 +34,15 @@
 
 static int handle_listen(void *buf)
 {
+	DBG("Not implemented");
+
 	return -1;
 }
 
 static int handle_connect(void *buf)
 {
+	DBG("Not implemented");
+
 	return -1;
 }
 
-- 
1.8.3.1


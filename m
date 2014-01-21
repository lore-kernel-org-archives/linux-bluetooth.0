Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/ipc: Leave the connect callback to handle errors
Date: Tue, 21 Jan 2014 16:00:59 +0200
Message-Id: <1390312859-27349-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390312859-27349-1-git-send-email-luiz.dentz@gmail.com>
References: <1390312859-27349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is not necessary to check connect errors since there is a watch
created for that.
---
 android/ipc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 8098409..4f2428c 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -166,12 +166,7 @@ GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
 
 	memcpy(addr.sun_path, path, size);
 
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		error("IPC: failed to connect HAL socket %s: %d (%s)", &path[1],
-							errno, strerror(errno));
-		g_io_channel_unref(io);
-		return NULL;
-	}
+	connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-- 
1.8.4.2


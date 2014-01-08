Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/7] input: Fix check if device is sixaxis in auth_callback
Date: Wed,  8 Jan 2014 01:02:24 +0100
Message-Id: <1389139348-3552-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to accept connection if idev is not present but device is sixaxis.
This fix not doing so for sixaxis devices.
---
 profiles/input/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index f2e5836..d85d6a9 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -204,7 +204,7 @@ static void auth_callback(DBusError *derr, void *user_data)
 		goto reject;
 	}
 
-	if (!input_device_exists(&src, &dst) && dev_is_sixaxis(&src, &dst))
+	if (!input_device_exists(&src, &dst) && !dev_is_sixaxis(&src, &dst))
 		return;
 
 	if (!bt_io_accept(server->confirm, connect_event_cb, server,
-- 
1.8.5.2


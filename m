Return-Path: <cyrus@holtmann.org>
From: jaikumar@google.com
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix control channel shutdown in case of errors.
Date: Fri,  4 Feb 2011 13:51:45 -0800
Message-Id: <1296856305-54896-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jaikumar Ganesh <jaikumar@google.com>

When there are connection errors, like host is down, when
establishing the control channel connection, the control io
channel was not being shutdown. This will cause future
connections to fail.
---
 input/device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 5cb57ea..21f8329 100644
--- a/input/device.c
+++ b/input/device.c
@@ -856,6 +856,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 		error("%s", conn_err->message);
 		reply = btd_error_failed(iconn->pending_connect,
 						conn_err->message);
+		g_io_channel_shutdown(chan, TRUE, NULL);
 		goto failed;
 	}
 
-- 
1.7.3.1


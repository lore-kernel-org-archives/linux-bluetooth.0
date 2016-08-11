Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: SeulKi Shin <sskcorea@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: SeulKi Shin <sskcorea@gmail.com>
Subject: [PATCH] attrib/interactive: fix duplicate close
Date: Thu, 11 Aug 2016 14:04:00 +0900
Message-Id: <20160811050400.3900-1-sskcorea@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes following warning message when gatttool exits
interactive mode.
(gatttool:457): GLib-WARNING **: Invalid file descriptor.

Since g_attrib_unref closes GIOChannel's fd g_io_channel_shutdown should
not be called here. This is because GAttrib is always created with "close on
unref" flag.

Signed-off-by: SeulKi Shin <sskcorea@gmail.com>
---
 attrib/interactive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7d4786a..4c48ca9 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -192,7 +192,6 @@ static void disconnect_io()
 	attrib = NULL;
 	opt_mtu = 0;
 
-	g_io_channel_shutdown(iochannel, FALSE, NULL);
 	g_io_channel_unref(iochannel);
 	iochannel = NULL;
 
-- 
2.9.2.windows.1


Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 06/10] android/pan: Remove channel unref which causing disconnection
Date: Wed, 11 Dec 2013 12:13:41 +0200
Message-Id: <1386756825-934-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Channel unreferencing here causing calling watchdog_cb and eventually
connection is dismissed immediately. Channel is already freed
in bnep.c:free_bnep_connect().
---
 android/pan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index f74f1a7..a9557a0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -156,8 +156,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
 	dev->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 							bnep_watchdog_cb, dev);
-	g_io_channel_unref(dev->io);
-	dev->io = NULL;
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
-- 
1.8.3.2


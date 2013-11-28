Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] android/hidhost: Shutdown ctrl_io channel if intr_io fails
Date: Thu, 28 Nov 2013 16:38:03 +0200
Message-Id: <1385649486-19978-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fix possible memory leak.
---
 android/hidhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index d50c5b8..1f5aa5d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1219,8 +1219,12 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 				BT_IO_OPT_INVALID);
 	if (!intr_io) {
 		error("Failed to listen on intr channel: %s", err->message);
-		g_io_channel_unref(ctrl_io);
 		g_error_free(err);
+
+		g_io_channel_shutdown(ctrl_io, TRUE, NULL);
+		g_io_channel_unref(ctrl_io);
+		ctrl_io = NULL;
+
 		return false;
 	}
 
-- 
1.8.3.2


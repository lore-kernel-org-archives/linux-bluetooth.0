Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hidhost: Use correct error structure
Date: Wed, 13 Nov 2013 16:29:34 +0200
Message-Id: <1384352974-24036-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384352974-24036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384352974-24036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hidhost.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index ff3eae0..3c1f074 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1128,12 +1128,12 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		return;
 	}
 
-	bt_io_get(chan, &err,
+	bt_io_get(chan, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_PSM, &psm,
 			BT_IO_OPT_INVALID);
-	if (err) {
+	if (gerr) {
 		error("%s", gerr->message);
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		g_error_free(gerr);
-- 
1.7.10.4


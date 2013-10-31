Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hid: Add error message to error print
Date: Thu, 31 Oct 2013 16:45:05 +0200
Message-Id: <1383230705-18110-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383230705-18110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383230705-18110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hid.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 5caa25b..4075ecb 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -419,7 +419,7 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	if (!ctrl_io) {
-		error("Failed to listen on control channel");
+		error("Failed to listen on ctrl channel: %s", err->message);
 		g_error_free(err);
 		return false;
 	}
@@ -429,7 +429,7 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	if (!intr_io) {
-		error("Failed to listen on interrupt channel");
+		error("Failed to listen on intr channel: %s", err->message);
 		g_io_channel_unref(ctrl_io);
 		g_error_free(err);
 		return false;
-- 
1.7.10.4


Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/7] android/client: Fix set_info command
Date: Tue, 11 Feb 2014 14:32:29 -0400
Message-Id: <1392143552-11395-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Although this command is not implemented by BlueZ, make sure it is
callable from haltest so at least the IPC can be tested.

Also memset() the hid_info parameter to not pass uninitialized data
around.
---
 android/client/if-hh.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index 56eb698..0341d25 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -229,6 +229,9 @@ static void virtual_unplug_p(int argc, const char **argv)
 
 /* set_info */
 
+/* Same completion as connect_c */
+#define set_info_c connect_c
+
 static void set_info_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -236,8 +239,11 @@ static void set_info_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_hh);
 	VERIFY_ADDR_ARG(2, &addr);
-	/* TODO: set_info does not seem to be called anywhere */
 
+	memset(&hid_info, 0, sizeof(hid_info));
+
+	/* This command is intentionally not supported. See comment from
+	 * bt_hid_info() in android/hidhost.c */
 	EXEC(if_hh->set_info, &addr, hid_info);
 }
 
@@ -416,7 +422,7 @@ static struct method methods[] = {
 	STD_METHODCH(connect, "<addr>"),
 	STD_METHODCH(disconnect, "<addr>"),
 	STD_METHODCH(virtual_unplug, "<addr>"),
-	STD_METHOD(set_info),
+	STD_METHODCH(set_info, "<addr>"),
 	STD_METHODCH(get_protocol, "<addr> <mode>"),
 	STD_METHODCH(set_protocol, "<addr> <mode>"),
 	STD_METHODCH(get_report, "<addr> <type> <report_id> <size>"),
-- 
1.7.9.5


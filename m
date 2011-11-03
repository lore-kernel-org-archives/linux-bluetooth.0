Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] Add option to set priority for btiotest
Date: Thu,  3 Nov 2011 17:15:40 +0200
Message-Id: <1320333340-27112-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
References: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Setting  a priority outside the range 0 to 6 requires the CAP_NET_ADMIN
capability.
---
 test/btiotest.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index c02a25a..91fc1d5 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -225,7 +225,8 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 }
 
 static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
-						gint disconn, gint sec)
+						gint disconn, gint sec,
+						gint prio)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -242,6 +243,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
 						BT_IO_OPT_SEC_LEVEL, sec,
+						BT_IO_OPT_PRIORITY, prio,
 						BT_IO_OPT_INVALID);
 	else
 		data->io = bt_io_connect(BT_IO_L2CAP, connect_cb, data,
@@ -250,6 +252,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
 						BT_IO_OPT_SEC_LEVEL, sec,
+						BT_IO_OPT_PRIORITY, prio,
 						BT_IO_OPT_INVALID);
 
 	if (!data->io) {
@@ -466,6 +469,7 @@ static gint opt_disconn = -1;
 static gint opt_accept = DEFAULT_ACCEPT_TIMEOUT;
 static gint opt_sec = 0;
 static gboolean opt_master = FALSE;
+static gint opt_priority = 0;
 
 static GMainLoop *main_loop;
 
@@ -490,6 +494,10 @@ static GOptionEntry options[] = {
 				"Accept connection after N seconds" },
 	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_master,
 				"Master role switch (incoming connections)" },
+	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
+				"Transmission priority: Setting a priority "
+				"outside the range 0 to 6 requires the"
+				"CAP_NET_ADMIN capability." },
 	{ NULL },
 };
 
@@ -510,13 +518,15 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
-	printf("accept=%d, reject=%d, discon=%d, defer=%d, sec=%d\n",
-		opt_accept, opt_reject, opt_disconn, opt_defer, opt_sec);
+	printf("accept=%d, reject=%d, discon=%d, defer=%d, sec=%d, prio=%d\n",
+		opt_accept, opt_reject, opt_disconn, opt_defer, opt_sec,
+		opt_priority);
 
 	if (opt_psm) {
 		if (argc > 1)
 			l2cap_connect(opt_dev, argv[1], opt_psm,
-							opt_disconn, opt_sec);
+							opt_disconn, opt_sec,
+							opt_priority);
 		else
 			l2cap_listen(opt_dev, opt_psm, opt_defer, opt_reject,
 					opt_disconn, opt_accept, opt_sec,
-- 
1.7.6.4


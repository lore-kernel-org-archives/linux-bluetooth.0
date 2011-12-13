Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/5] Add support for passing the CID to btiotest
Date: Tue, 13 Dec 2011 20:57:31 -0300
Message-Id: <1323820654-16820-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/btiotest.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index 91fc1d5..f02711d 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -225,8 +225,8 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 }
 
 static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
-						gint disconn, gint sec,
-						gint prio)
+						uint16_t cid, gint disconn,
+						gint sec, gint prio)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -242,6 +242,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						BT_IO_OPT_SOURCE, src,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
+						BT_IO_OPT_CID, cid,
 						BT_IO_OPT_SEC_LEVEL, sec,
 						BT_IO_OPT_PRIORITY, prio,
 						BT_IO_OPT_INVALID);
@@ -251,6 +252,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						&err,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
+						BT_IO_OPT_CID, cid,
 						BT_IO_OPT_SEC_LEVEL, sec,
 						BT_IO_OPT_PRIORITY, prio,
 						BT_IO_OPT_INVALID);
@@ -470,6 +472,7 @@ static gint opt_accept = DEFAULT_ACCEPT_TIMEOUT;
 static gint opt_sec = 0;
 static gboolean opt_master = FALSE;
 static gint opt_priority = 0;
+static gint opt_cid = 0;
 
 static GMainLoop *main_loop;
 
@@ -478,6 +481,8 @@ static GOptionEntry options[] = {
 				"RFCOMM channel" },
 	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
 				"L2CAP PSM" },
+	{ "cid", 'j', 0, G_OPTION_ARG_INT, &opt_cid,
+				"L2CAP CID" },
 	{ "sco", 's', 0, G_OPTION_ARG_NONE, &opt_sco,
 				"Use SCO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
@@ -522,11 +527,10 @@ int main(int argc, char *argv[])
 		opt_accept, opt_reject, opt_disconn, opt_defer, opt_sec,
 		opt_priority);
 
-	if (opt_psm) {
+	if (opt_psm || opt_cid) {
 		if (argc > 1)
-			l2cap_connect(opt_dev, argv[1], opt_psm,
-							opt_disconn, opt_sec,
-							opt_priority);
+			l2cap_connect(opt_dev, argv[1], opt_psm, opt_cid,
+					opt_disconn, opt_sec, opt_priority);
 		else
 			l2cap_listen(opt_dev, opt_psm, opt_defer, opt_reject,
 					opt_disconn, opt_accept, opt_sec,
-- 
1.7.8


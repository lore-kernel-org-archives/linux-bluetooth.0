Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/3] Add support for passing the CID to btiotest
Date: Thu, 14 Apr 2011 21:06:42 -0300
Message-Id: <1302826003-5511-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302826003-5511-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302826003-5511-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/btiotest.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index c02a25a..c4d8f4f 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -225,7 +225,7 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 }
 
 static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
-						gint disconn, gint sec)
+					uint16_t cid, gint disconn, gint sec)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -241,6 +241,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						BT_IO_OPT_SOURCE, src,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
+						BT_IO_OPT_CID, cid,
 						BT_IO_OPT_SEC_LEVEL, sec,
 						BT_IO_OPT_INVALID);
 	else
@@ -249,6 +250,7 @@ static void l2cap_connect(const char *src, const char *dst, uint16_t psm,
 						&err,
 						BT_IO_OPT_DEST, dst,
 						BT_IO_OPT_PSM, psm,
+						BT_IO_OPT_CID, cid,
 						BT_IO_OPT_SEC_LEVEL, sec,
 						BT_IO_OPT_INVALID);
 
@@ -466,6 +468,7 @@ static gint opt_disconn = -1;
 static gint opt_accept = DEFAULT_ACCEPT_TIMEOUT;
 static gint opt_sec = 0;
 static gboolean opt_master = FALSE;
+static gint opt_cid = 0;
 
 static GMainLoop *main_loop;
 
@@ -474,6 +477,8 @@ static GOptionEntry options[] = {
 				"RFCOMM channel" },
 	{ "psm", 'p', 0, G_OPTION_ARG_INT, &opt_psm,
 				"L2CAP PSM" },
+	{ "cid", 'j', 0, G_OPTION_ARG_INT, &opt_cid,
+				"L2CAP CID" },
 	{ "sco", 's', 0, G_OPTION_ARG_NONE, &opt_sco,
 				"Use SCO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
@@ -513,9 +518,9 @@ int main(int argc, char *argv[])
 	printf("accept=%d, reject=%d, discon=%d, defer=%d, sec=%d\n",
 		opt_accept, opt_reject, opt_disconn, opt_defer, opt_sec);
 
-	if (opt_psm) {
+	if (opt_psm || opt_cid) {
 		if (argc > 1)
-			l2cap_connect(opt_dev, argv[1], opt_psm,
+			l2cap_connect(opt_dev, argv[1], opt_psm, opt_cid,
 							opt_disconn, opt_sec);
 		else
 			l2cap_listen(opt_dev, opt_psm, opt_defer, opt_reject,
-- 
1.7.4.3


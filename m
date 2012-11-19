Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] btiotest: Enable deferred setup for sco sockets
Date: Mon, 19 Nov 2012 16:50:44 +0100
Message-Id: <1353340244-16443-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1353340244-16443-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/btiotest.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index 4cafcc3..593bafc 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -461,24 +461,35 @@ static void sco_connect(const char *src, const char *dst, gint disconn)
 	}
 }
 
-static void sco_listen(const char *src, gint disconn)
+static void sco_listen(const char *src, gboolean defer, gint reject,
+				gint disconn, gint accept)
 {
 	struct io_data *data;
+	BtIOConnect conn;
+	BtIOConfirm cfm;
 	GIOChannel *sco_srv;
 	GError *err = NULL;
 
 	printf("Listening for SCO connections\n");
 
-	data = io_data_new(NULL, -1, disconn, -1);
+	if (defer) {
+		conn = NULL;
+		cfm = confirm_cb;
+	} else {
+		conn = connect_cb;
+		cfm = NULL;
+	}
+
+	data = io_data_new(NULL, reject, disconn, accept);
 
 	if (src)
-		sco_srv = bt_io_listen(connect_cb, NULL, data,
+		sco_srv = bt_io_listen(conn, cfm, data,
 					(GDestroyNotify) io_data_unref,
 					&err,
 					BT_IO_OPT_SOURCE, src,
 					BT_IO_OPT_INVALID);
 	else
-		sco_srv = bt_io_listen(connect_cb, NULL, data,
+		sco_srv = bt_io_listen(conn, cfm, data,
 					(GDestroyNotify) io_data_unref,
 					&err, BT_IO_OPT_INVALID);
 
@@ -588,7 +599,8 @@ int main(int argc, char *argv[])
 		if (argc > 1)
 			sco_connect(opt_dev, argv[1], opt_disconn);
 		else
-			sco_listen(opt_dev, opt_disconn);
+			sco_listen(opt_dev, opt_defer, opt_reject,
+					opt_disconn, opt_accept);
 	}
 
 	signal(SIGTERM, sig_term);
-- 
1.7.9.5


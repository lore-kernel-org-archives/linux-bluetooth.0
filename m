Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] tools/l2cap-tester: Test getsockopt(L2CAP_OPTIONS) on LE server
Date: Fri, 24 Jan 2014 21:54:02 -0400
Message-Id: <1390614842-28379-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btio layer always performs this operation when bt_io_get() is
called. Also check for getsockopt(BT_RCVMTU), which is supported on
kernels with CoC enabled.
---
 tools/l2cap-tester.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index d541f1b..78e7ce6 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1034,7 +1034,9 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	int sk, new_sk;
+	struct l2cap_options l2o;
+	int sk, new_sk, err;
+	socklen_t len;
 
 	data->io_id = 0;
 
@@ -1047,6 +1049,28 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	len = sizeof(l2o);
+	memset(&l2o, 0, len);
+
+	/* LE CoC enabled kernels should support BT_RCVMTU */
+	err = getsockopt(new_sk, SOL_BLUETOOTH, BT_RCVMTU, &l2o.imtu, &len);
+	if (err < 0 && errno != EPROTONOSUPPORT && errno != ENOPROTOOPT) {
+		tester_warn("getsockopt(BT_RCVMTU) failed: %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		return FALSE;
+	}
+
+	/* For non-LE CoC enabled kernels we need to fall back to L2CAP_OPTIONS,
+	 * so test support for it as well */
+	err = getsockopt(new_sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len);
+	if (err < 0) {
+		tester_warn("getsockopt(L2CAP_OPTIONS) failed: %s (%d)",
+							strerror(errno), errno);
+		tester_test_failed();
+		return FALSE;
+	}
+
 	if (l2data->read_data) {
 		struct bthost *bthost;
 		GIOChannel *new_io;
-- 
1.8.3.2


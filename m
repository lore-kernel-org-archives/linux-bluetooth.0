Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C10C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEUP1t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEUP1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:27:46 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B72DE
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:27:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D2A19240029
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:27:40 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPPbJ2Q4yz9rxG;
        Sun, 21 May 2023 17:27:40 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] iso-tester: always use DEFER_SETUP for multiple CIS in same CIG
Date:   Sun, 21 May 2023 15:27:34 +0000
Message-Id: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a race between multiple connect() for CIS in the same CIG.
connect() will both reconfigure the CIG and connect the CIS, but CIG
cannot be reconfigured once one CIS has already connected.  That these
tests pass currently relies on some timing/event ordering in the
emulator.

Connecting multiple CIS in same CIG is meant to be done using
DEFER_SETUP, so change the tests to use it, so we test the intended
usage.
---
 tools/iso-tester.c | 150 +++++++++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 46 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index c5c6f0aec..164cb465f 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -740,6 +740,12 @@ static const struct iso_client_data defer_16_2_1 = {
 	.defer = true,
 };
 
+static const struct iso_client_data defer_1_16_2_1 = {
+	.qos = QOS_1_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+};
+
 static const struct iso_client_data connect_16_2_1_defer_send = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -817,6 +823,7 @@ static const struct iso_client_data connect_ac_6i = {
 	.qos_2 = AC_6i_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_6ii = {
@@ -824,6 +831,7 @@ static const struct iso_client_data connect_ac_6ii = {
 	.qos_2 = AC_6ii_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_7i = {
@@ -831,6 +839,7 @@ static const struct iso_client_data connect_ac_7i = {
 	.qos_2 = AC_7i_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_7ii = {
@@ -838,6 +847,7 @@ static const struct iso_client_data connect_ac_7ii = {
 	.qos_2 = AC_7ii_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_8i = {
@@ -845,6 +855,7 @@ static const struct iso_client_data connect_ac_8i = {
 	.qos_2 = AC_8i_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_8ii = {
@@ -852,6 +863,7 @@ static const struct iso_client_data connect_ac_8ii = {
 	.qos_2 = AC_8ii_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_9i = {
@@ -859,6 +871,7 @@ static const struct iso_client_data connect_ac_9i = {
 	.qos_2 = AC_9i_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_9ii = {
@@ -866,6 +879,7 @@ static const struct iso_client_data connect_ac_9ii = {
 	.qos_2 = AC_9ii_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_11i = {
@@ -873,6 +887,7 @@ static const struct iso_client_data connect_ac_11i = {
 	.qos_2 = AC_11i_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data connect_ac_11ii = {
@@ -880,6 +895,7 @@ static const struct iso_client_data connect_ac_11ii = {
 	.qos_2 = AC_11ii_2,
 	.expect_err = 0,
 	.mcis = true,
+	.defer = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_send = {
@@ -1715,13 +1731,9 @@ static gboolean iso_connect2_cb(GIOChannel *io, GIOCondition cond,
 	return iso_connect(io, cond, user_data);
 }
 
-static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
+static int setup_sock(struct test_data *data, uint8_t num)
 {
-	const struct iso_client_data *isodata = data->test_data;
-	GIOChannel *io;
 	int sk, err;
-	char c;
-	struct pollfd pfd;
 
 	sk = create_iso_sock(data);
 	if (sk < 0) {
@@ -1729,7 +1741,8 @@ static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
 			tester_test_abort();
 		else
 			tester_test_failed();
-		return;
+
+		return sk;
 	}
 
 	err = connect_iso_sock(data, num, sk);
@@ -1743,65 +1756,106 @@ static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
 		else
 			tester_test_failed();
 
-		return;
+		return err;
 	}
 
-	if (isodata->defer) {
-		int defer;
-		socklen_t len;
-
-		/* Check if socket has DEFER_SETUP set */
-		len = sizeof(defer);
-		if (getsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &defer,
-				&len) < 0) {
-			tester_warn("getsockopt: %s (%d)", strerror(errno),
-								errno);
+	return sk;
+}
+
+static int connect_deferred(int sk)
+{
+	int defer;
+	socklen_t len;
+	struct pollfd pfd;
+	char c;
+
+	/* Check if socket has DEFER_SETUP set */
+	len = sizeof(defer);
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &defer,
+					&len) < 0) {
+		tester_warn("getsockopt: %s (%d)", strerror(errno),
+				errno);
+		tester_test_failed();
+		return 0;
+	}
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = sk;
+	pfd.events = POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		tester_warn("poll: %s (%d)", strerror(errno), errno);
+		tester_test_failed();
+		return -EIO;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		if (read(sk, &c, 1) < 0) {
+			tester_warn("read: %s (%d)", strerror(errno),
+					errno);
 			tester_test_failed();
-			return;
+			return -EIO;
 		}
+	}
+
+	return 0;
+}
 
-		memset(&pfd, 0, sizeof(pfd));
-		pfd.fd = sk;
-		pfd.events = POLLOUT;
+static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
+								GIOFunc *func)
+{
+	const struct iso_client_data *isodata = data->test_data;
+	int sk[256];
+	GIOChannel *io;
+	unsigned int i;
 
-		if (poll(&pfd, 1, 0) < 0) {
-			tester_warn("poll: %s (%d)", strerror(errno), errno);
-			tester_test_failed();
+	for (i = 0; i < n; ++i) {
+		sk[i] = setup_sock(data, num[i]);
+		if (sk[i] < 0)
 			return;
-		}
+	}
 
-		if (!(pfd.revents & POLLOUT)) {
-			if (read(sk, &c, 1) < 0) {
-				tester_warn("read: %s (%d)", strerror(errno),
-								errno);
-				tester_test_failed();
+	if (isodata->defer) {
+		for (i = 0; i < n; ++i)
+			if (connect_deferred(sk[i]) < 0)
 				return;
-			}
-		}
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	for (i = 0; i < n; ++i) {
+		io = g_io_channel_unix_new(sk[i]);
+		g_io_channel_set_close_on_unref(io, TRUE);
 
-	data->io_id[num] = g_io_add_watch(io, G_IO_OUT, func, NULL);
+		data->io_id[num[i]] = g_io_add_watch(io, G_IO_OUT, func[i],
+									NULL);
 
-	g_io_channel_unref(io);
+		g_io_channel_unref(io);
 
-	tester_print("Connect in progress");
+		tester_print("Connect %d in progress", num[i]);
 
-	data->step++;
+		data->step++;
+	}
+}
+
+static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
+{
+	return setup_connect_many(data, 1, &num, &func);
 }
 
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = test_data;
+	uint8_t n = 0;
+	GIOFunc func[2];
+	uint8_t num[2] = {0, 1};
 
-	setup_connect(data, 0, iso_connect_cb);
+	func[n++] = iso_connect_cb;
 
 	/* Check if configuration requires multiple CIS setup */
 	if (!isodata->bcast && isodata->mcis)
-		setup_connect(data, 1, iso_connect2_cb);
+		func[n++] = iso_connect2_cb;
+
+	setup_connect_many(data, n, num, func);
 }
 
 static void setup_reconnect(struct test_data *data, uint8_t num, GIOFunc func)
@@ -2066,9 +2120,10 @@ static void test_listen(const void *test_data)
 static void test_connect2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
 
-	setup_connect(data, 0, iso_connect_cb);
-	setup_connect(data, 1, iso_connect2_cb);
+	setup_connect_many(data, 2, num, funcs);
 }
 
 static void test_bcast(const void *test_data)
@@ -2212,10 +2267,6 @@ int main(int argc, char *argv[])
 	test_iso_rej("ISO Connect - Reject", &connect_reject, setup_powered,
 			test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 
-	test_iso2("ISO Connect2 CIG 0x01 - Success", &connect_1_16_2_1,
-							setup_powered,
-							test_connect2);
-
 	test_iso("ISO Send - Success", &connect_16_2_1_send, setup_powered,
 							test_connect);
 
@@ -2229,6 +2280,13 @@ int main(int argc, char *argv[])
 	test_iso("ISO Defer - Success", &defer_16_2_1, setup_powered,
 							test_defer);
 
+	test_iso("ISO Defer Connect - Success", &defer_16_2_1, setup_powered,
+							test_connect);
+
+	test_iso2("ISO Defer Connect2 CIG 0x01 - Success", &defer_1_16_2_1,
+							setup_powered,
+							test_connect2);
+
 	test_iso("ISO Defer Send - Success", &connect_16_2_1_defer_send,
 							setup_powered,
 							test_connect);
-- 
2.40.1


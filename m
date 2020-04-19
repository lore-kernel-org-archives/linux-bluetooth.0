Return-Path: <SRS0=BGse=6D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742E3C38A30
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Apr 2020 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D31C21744
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Apr 2020 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587330679;
	bh=tAlNDDF/rveRZkts9H2EploORCgvy18fXVIRmitWUTk=;
	h=From:To:Subject:Date:List-ID:From;
	b=vW/p8xAvZpU9erN2ValnATzXx6/2lrzRgnZ8Y8gadQqksso0eiPVurAHTBqp2904g
	 bIcZjXU/1Aba0kiV2VOfustXkPPim4k+UG5/vXKp3QRLskOUUQ8Ux0ZhJ1/rmsYnv1
	 WiZ3DaEPJIsoHRsEULAPZsQGgosj9C3kHqIV+3f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDSVLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgDSVLS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Apr 2020 17:11:18 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07672137B
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2020 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587330678;
        bh=tAlNDDF/rveRZkts9H2EploORCgvy18fXVIRmitWUTk=;
        h=From:To:Subject:Date:From;
        b=1Qm2dOy3rHQoZn/cqxyareYCfsByOGiz1jmWrehNgWp5AvD+4iXYI+bMCwHzha/5U
         uJ12a2Caguvyg1mymN3L/eZEYGqb3mh7iQr1omCq3BABp6G+tHaerWq42/1s5vKR2E
         jwnOgUkvKAxt/teF+hF+WkqyvINTJXfTutFKvEbk=
Received: by pali.im (Postfix)
        id C8CDF8A3; Sun, 19 Apr 2020 23:11:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] profile: Fix reporting error message when connection failed
Date:   Sun, 19 Apr 2020 23:10:58 +0200
Message-Id: <20200419211058.31987-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some bluetooth headsets do not support connecting more then one bluetooth
profile (e.g. in parallel A2DP and HSP, or HSP and HFP) and issuing
connect() syscall for second profile returns just ECONNREFUSED.

Prior this patch bluetooth daemon for such situation reported following
message to log:

  Unable to get connect data for Headset Voice gateway: getpeername: Transport endpoint is not connected (107)

Message is incorrect as connect() syscall failed, not getpeername(). This
patch fixes this problem and logs correct error message:

  Headset Voice gateway failed connect to XX:XX:XX:XX:XX:XX: Connection refused (111)

Main problem was in ext_connect() function which called bt_io_get() for
retrieving remote address (BT_IO_OPT_DEST) and if it failed then original
error from connect() syscall was masked. Because it is not possible to
retrieve BT_IO_OPT_DEST for unconnected socket, original destination
address for error message is propagated via connect_add() function in btio.

--

Having correct error message in logs is important. Due to this mangled
error message I was not able to easily debug why particular bluetooth
headset sometimes connection with nonsense error that Transport endpoint
was not connected.
---
 btio/btio.c   | 19 ++++++++++++++-----
 src/profile.c |  5 +++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index e7b4db16b..3ea73faea 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -85,6 +85,7 @@ struct connect {
 	BtIOConnect connect;
 	gpointer user_data;
 	GDestroyNotify destroy;
+	bdaddr_t dst;
 };
 
 struct accept {
@@ -214,6 +215,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 	GError *gerr = NULL;
 	int err, sk_err, sock;
 	socklen_t len = sizeof(sk_err);
+	char addr[18];
 
 	/* If the user aborted this connect attempt */
 	if ((cond & G_IO_NVAL) || check_nval(io))
@@ -226,8 +228,11 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		err = -sk_err;
 
-	if (err < 0)
-		ERROR_FAILED(&gerr, "connect error", -err);
+	if (err < 0) {
+		ba2str(&conn->dst, addr);
+		g_set_error(&gerr, BT_IO_ERROR, err,
+			"connect to %s: %s (%d)", addr, strerror(-err), -err);
+	}
 
 	conn->connect(io, gerr, conn->user_data);
 
@@ -286,7 +291,7 @@ static void server_add(GIOChannel *io, BtIOConnect connect,
 					(GDestroyNotify) server_remove);
 }
 
-static void connect_add(GIOChannel *io, BtIOConnect connect,
+static void connect_add(GIOChannel *io, BtIOConnect connect, bdaddr_t dst,
 				gpointer user_data, GDestroyNotify destroy)
 {
 	struct connect *conn;
@@ -296,6 +301,7 @@ static void connect_add(GIOChannel *io, BtIOConnect connect,
 	conn->connect = connect;
 	conn->user_data = user_data;
 	conn->destroy = destroy;
+	conn->dst = dst;
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, conn,
@@ -1671,6 +1677,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 	struct set_opts opts;
 	int err, sock;
 	gboolean ret;
+	char addr[18];
 
 	va_start(args, opt1);
 	ret = parse_set_opts(&opts, gerr, opt1, args);
@@ -1710,12 +1717,14 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 	}
 
 	if (err < 0) {
-		ERROR_FAILED(gerr, "connect", -err);
+		ba2str(&opts.dst, addr);
+		g_set_error(gerr, BT_IO_ERROR, err,
+				"connect to %s: %s (%d)", addr, strerror(-err), -err);
 		g_io_channel_unref(io);
 		return NULL;
 	}
 
-	connect_add(io, connect, user_data, destroy);
+	connect_add(io, connect, opts.dst, user_data, destroy);
 
 	return io;
 }
diff --git a/src/profile.c b/src/profile.c
index c2992e795..6961a107b 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1085,12 +1085,13 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 	if (!bt_io_get(io, &io_err,
 				BT_IO_OPT_DEST, addr,
 				BT_IO_OPT_INVALID)) {
-		error("Unable to get connect data for %s: %s", ext->name,
-							io_err->message);
 		if (err) {
+			error("%s failed %s", ext->name, err->message);
 			g_error_free(io_err);
 			io_err = NULL;
 		} else {
+			error("Unable to get connect data for %s: %s",
+				ext->name, io_err->message);
 			err = io_err;
 		}
 		goto drop;
-- 
2.20.1


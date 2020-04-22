Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458DFC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692E20776
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587574878;
	bh=o+auKcWMBhiFn+f+0TwDu8I9ke9YQGIDki/HrHb5IO0=;
	h=From:To:Subject:Date:List-ID:From;
	b=cdXAYPXfB0jPXpAXIDyiVHOQgXO2j1bsQbVUjXNOlyinzulzJSE0dirFNu0GTwqFh
	 bMCDcDy/ZvCFLTTqw4eIpW4G0s6ADs14mZEgj/QKYYFwq7064HkxUAsZ3ivAJwklan
	 FwAc4v7+RzQ8DbDmFn5ERRsBsPmlbgOrgRKIpDj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgDVRBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDVRBR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:01:17 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B316720776
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587574876;
        bh=o+auKcWMBhiFn+f+0TwDu8I9ke9YQGIDki/HrHb5IO0=;
        h=From:To:Subject:Date:From;
        b=qew4A3/sMoUmKwU2FHArjTbx6rmQeelDMSEYAdsY8VWmXirytyxcFjT7tAvQzzA0u
         cJAPalGYa1gRfFN652NA8Kfl1vYTLoMMk1Cng9xl+nD4nbqFlqg/GCBHMc8bENLBiZ
         uRWO2ap9QcYiRSG7+OXa9cwEdRHVis9HtYcSuAOE=
Received: by pali.im (Postfix)
        id A633C7E6; Wed, 22 Apr 2020 19:01:14 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] btio: Show destination address in connect error message
Date:   Wed, 22 Apr 2020 19:01:04 +0200
Message-Id: <20200422170105.29685-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When connect() fails it is not possible to retrieve destination address as
socket is not bound. So put destination address into error message.
---
 btio/btio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

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
-- 
2.20.1


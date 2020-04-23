Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD0C55186
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87882087E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684862;
	bh=jc+pwce+FAKpDeUnCInDDT1KlA3a8qO4l1yjaHp8kqs=;
	h=From:To:Subject:Date:List-ID:From;
	b=mzsSQ0ty7SLw7f1lIhDptaLI9QgdSaBraEOy/CYBotQsTSIL4RSc7QpwwR4lIIQyz
	 C32XGZcHkARHbC7b0lX3k9aQ1zEbDG2ZH/18UFwElN8n43ggpC4YgX5jzthk5Sed6S
	 XdpPO/iriBi1ZDyPrBeIdDmKttKPDEiJ7xSfuFxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgDWXeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgDWXeV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 19:34:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A01E2064A
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 23:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684861;
        bh=jc+pwce+FAKpDeUnCInDDT1KlA3a8qO4l1yjaHp8kqs=;
        h=From:To:Subject:Date:From;
        b=f89Ia6yQsxBtdwS5B9vlEbB5Chi81QNBDSt4ylHeZ472yKMOiaBSeXBkUlhNXvD+N
         FzCQTCAgiFCibFa/+Jd3FmBh2S2WWwREObKPe9E7iqjV+ShHEKuMuRdqtpvU7GR6jC
         Hl+ZZeCPc3IjK+HL2AQnpqMnvJkHYlA/cAlO+IiY=
Received: by pali.im (Postfix)
        id D30687E0; Fri, 24 Apr 2020 01:34:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] btio: Fix error number
Date:   Fri, 24 Apr 2020 01:34:14 +0200
Message-Id: <20200423233414.15141-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In commit d20ee8273e61e16c78582344f274254973cdf00f was unintentionally
negated error number. Fix this mistake.
---
 btio/btio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 460aaf5be..13c731062 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -230,7 +230,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (err < 0) {
 		ba2str(&conn->dst, addr);
-		g_set_error(&gerr, BT_IO_ERROR, err,
+		g_set_error(&gerr, BT_IO_ERROR, -err,
 			"connect to %s: %s (%d)", addr, strerror(-err), -err);
 	}
 
@@ -1718,7 +1718,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 
 	if (err < 0) {
 		ba2str(&opts.dst, addr);
-		g_set_error(gerr, BT_IO_ERROR, err,
+		g_set_error(gerr, BT_IO_ERROR, -err,
 				"connect to %s: %s (%d)", addr, strerror(-err),
 				-err);
 		g_io_channel_unref(io);
-- 
2.20.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA2C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 01:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGXBrf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 21:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjGXBrO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 21:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2F4C2D;
        Sun, 23 Jul 2023 18:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2627661050;
        Mon, 24 Jul 2023 01:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A647C433CA;
        Mon, 24 Jul 2023 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162478;
        bh=7/AE+pqIuZxmEbNYF2RAsJ9Vg9QulCzhxXO9kEtGqEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boh0Na/XtgeZv/P1lT/Z3leKsYaGtxeZySz1DcHSoyocwps0wrh6eVNZGfT3nw/hy
         4j8aTB7XK23hZKblrTHYTLq2N+WKQzEWjVF/WOrvXRYrZbWc25eEubhquMoOuweTWP
         VYDN6WHaq38D09myfZ+r1JBdDh9Z0gqRqSvaraOCx/QUFpHT8V6S35K/+0IodGUMjU
         TVmbm1xUCWHO/tsXZTVnWtAXnKQ1wBG0VjGUERD6J1cB/R2BnY2bwZUYQAYzC4IWaH
         okXuHfT2Jj1ZQpeTkCVcmGc2o25Cj4QPNKpjGNH9wtETovv4GyVpilpS5db6qV0Xo8
         Ee5uqubVyNGig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/12] Bluetooth: L2CAP: Fix use-after-free
Date:   Sun, 23 Jul 2023 21:34:21 -0400
Message-Id: <20230724013426.2333833-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013426.2333833-1-sashal@kernel.org>
References: <20230724013426.2333833-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Zhengping Jiang <jiangzp@google.com>

[ Upstream commit f752a0b334bb95fe9b42ecb511e0864e2768046f ]

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e56863587ea2e..61bf489265505 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5723,9 +5723,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.39.2


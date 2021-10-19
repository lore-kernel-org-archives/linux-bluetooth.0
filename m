Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2161373
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhJSQgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhJSQgD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 12:36:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0576138D;
        Tue, 19 Oct 2021 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634661230;
        bh=q4GRX3cEUy2zOh3aytfsHoTrZAc6YkSz8+sHaPeTM20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uexmfdCuzySHfTlJPvhSRTtEHDJ8IsJs+5nTXFojV/+2cKhRT4K2mzwCjjLpdLi9c
         LIBPTOi+tNoIu0B4iADYc6vIBzJMf/pikU7AbZCJreVDF/QAyd623bdP0q3rHFMXj3
         auUyWZkxYf0NYdfC00ohuh0Elr4qCQzEEHhA4KIRtACaK4QdCWLjXwQebEG9nEOY3y
         M5rsYHXHTGP2IqyL2diw7fCTva7AE8g2jZDXRytF17phrx8545zvoXZBZ14fDovFML
         E8Bq8UHxPldUQWy1bv1yOO9wMBvxwGpxCBNvoAP24FeVwmt6rZ0pSY8s/AEDtNxqde
         hCD5EGm3cBSZA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] bluetooth: use dev_addr_set()
Date:   Tue, 19 Oct 2021 09:33:46 -0700
Message-Id: <20211019163346.1384785-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019163346.1384785-1-kuba@kernel.org>
References: <20211019163346.1384785-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: marcel@holtmann.org
CC: johan.hedberg@gmail.com
CC: luiz.dentz@gmail.com
CC: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/6lowpan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index fd164a248569..133d7ea063fb 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -663,6 +663,7 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 {
 	struct net_device *netdev;
+	bdaddr_t addr;
 	int err;
 
 	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_btle_dev)),
@@ -672,7 +673,8 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 		return -ENOMEM;
 
 	netdev->addr_assign_type = NET_ADDR_PERM;
-	baswap((void *)netdev->dev_addr, &chan->src);
+	baswap(&addr, &chan->src);
+	__dev_addr_set(netdev, &addr, sizeof(addr));
 
 	netdev->netdev_ops = &netdev_ops;
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
-- 
2.31.1


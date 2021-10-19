Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC908C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7AC61372
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJSQgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234456AbhJSQgD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 12:36:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 633B261372;
        Tue, 19 Oct 2021 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634661230;
        bh=ZaQLp/pS9F6Hz5ysOk2gXAylDPpo6+Kx9KxsShtHXsA=;
        h=From:To:Cc:Subject:Date:From;
        b=e7NRs49SUQkBIoMBSmg6djWGyFLyDt0I9mHs9WiU38wA5dbJINTtZBhwNQkylOE/y
         WlSey/G+NWHg6etjwNGLIoJYCV1Ovcb89k3oGMjJhkvOAo65THfzCwhDiw2xGVdnO4
         2iF4RG7uCZfK12YiOhgnL2x91naIR40JTlnRXO0VxUa+y3YZVJZR2DoEEPl6nJzycP
         vfiYVdTZ0fE0HGjwUVm53GIiSfU+3vawC5ySbNTuqOSQFjbmGCfYUr6pgneuOtz/G+
         AU5w4OqPldm5i5wnign1C8Snkqsc+XCAWsgqyfm2oBlg5Wa8Lf4fMGolJhqYJFquye
         l4gy3GT6ZyaPQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] bluetooth: use eth_hw_addr_set()
Date:   Tue, 19 Oct 2021 09:33:45 -0700
Message-Id: <20211019163346.1384785-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Convert bluetooth from memcpy(... ETH_ADDR) to eth_hw_addr_set():

  @@
  expression dev, np;
  @@
  - memcpy(dev->dev_addr, np, ETH_ALEN)
  + eth_hw_addr_set(dev, np)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 72f47b372705..c9add7753b9f 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -594,7 +594,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	 * ie. eh.h_dest is our local address. */
 	memcpy(s->eh.h_dest,   &src, ETH_ALEN);
 	memcpy(s->eh.h_source, &dst, ETH_ALEN);
-	memcpy(dev->dev_addr, s->eh.h_dest, ETH_ALEN);
+	eth_hw_addr_set(dev, s->eh.h_dest);
 
 	s->dev   = dev;
 	s->sock  = sock;
-- 
2.31.1


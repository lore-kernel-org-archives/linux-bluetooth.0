Return-Path: <SRS0=T6Hm=DZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D045DC43457
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 08:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5D2222B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 08:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Uy+eosI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgJRILf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Oct 2020 04:11:35 -0400
Received: from mout02.posteo.de ([185.67.36.66]:47271 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgJRILe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Oct 2020 04:11:34 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 04:11:33 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 193BC2400FD
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2020 10:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1603008352; bh=vZxZj7oj7QUNuviH5VLiwbWy1JcPQBn1lLjXjgnPOCM=;
        h=From:To:Cc:Subject:Date:From;
        b=Uy+eosI/tVN1LiUOutIuliVmwqS8rcVadllIb8SjX/C7h6r+TwKxFpUIhL9VnbjRF
         +Z0qD9iB6SkeYxd6kuYGPX1g7V2siOe0sc7w/BlZuFKBiLB6THS2FS/+L1rDPJ0b4h
         dXJmrVy/GoIp/yQMyBEh/DRZhI6AesSBdZUHgYtXc9fSTfEFGiyP4Uax2qxye2DtGc
         emMT81QLbjufgkh/hvFN0a0rZBWcrQSdviyMMwXssIcHVOb1NV3p5xE0upqZX+aV5Y
         K11iXYr2gRQD4N/ojet2ybgS29DsyEBRQgg/wMhp6m3uURwj8+RXWhBiKGhi+tpBhr
         5aumUoWDrQoxw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CDXWd4W38z6tm9;
        Sun, 18 Oct 2020 10:05:49 +0200 (CEST)
From:   Stefan Gottwald <gotti79@posteo.net>
To:     marcel@holtmann.org
Cc:     gregkh@linuxfoundation.org, gottwald@igel.com, gotti79@posteo.net,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: A2MP: Do not set rsp.id to zero
Date:   Sun, 18 Oct 2020 10:05:32 +0200
Message-Id: <1603008332-8402-1-git-send-email-gotti79@posteo.net>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to security reasons the rsp struct is not zerod out in one case this will
also zero out the former set rsp.id which seems to be wrong.

Signed-off-by: Stefan Gottwald <gotti79@posteo.net>
---
 net/bluetooth/a2mp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index da7fd7c..7a1e0b7 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -381,10 +381,11 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	hdev = hci_dev_get(req->id);
 	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
-		rsp.id = req->id;
 
 		memset(&rsp, 0, sizeof(rsp));
 
+		rsp.id = req->id;
+
 		if (tmp) {
 			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
 			amp_mgr_put(tmp);
-- 
2.7.4


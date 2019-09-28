Return-Path: <SRS0=kOdZ=XX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A413CC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416BB20866
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 14:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="QOipZprK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfI1OPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Sep 2019 10:15:16 -0400
Received: from hoster906.com ([192.252.156.27]:42490 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfI1OPQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Sep 2019 10:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from:to
        :cc:subject:date:message-id; s=dkim; bh=cfhjBsRFCmAvDUFp0PnZU9bB
        sZ+E+BAVz+tIJE4AEIo=; b=QOipZprK9R/eEA5VWg3emZc5KOPQNAIET5HH/TAZ
        SM53h8lUG5m5CzGdC3NMohih3Lt5rwMi9zPkB8DmxO3BmLWjlqdFpVsf/6hHJJiI
        40CtEER+9NzpDwG7Xd+OzP0aLFApSGOZfWupbAwV9qp3KeXscWSvVe5nsRo8urTS
        01o=
Received: (qmail 32408 invoked by uid 503); 28 Sep 2019 14:15:14 -0000
Received: from unknown (HELO lespaul.Home) (mike@mnmoran.org@50.96.104.71)
  by hoster906.com with ESMTPA; 28 Sep 2019 14:15:14 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ] meshctl truncates GATT MTU
Date:   Sat, 28 Sep 2019 10:14:02 -0400
Message-Id: <1569680043-2874-1-git-send-email-mike@mnmoran.org>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Michael N. Moran" <mike@mnmoran.org>

This patch fixes a bug in meshctl that causes the
GATT MTU to be truncated resulting in incorrect
segmentation when the MTU is greater than 259.

Michael N. Moran (1):
  The meshctl sock_write() max_len variable is declared as
    uint8_t, which causes the calculation of the GATT MTU
	to be truncated when the MTU (write_mtu) is greater
	than 259. This error causes incorrect segmentation.

 tools/mesh/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1


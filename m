Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD2C43460
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9ACA610E7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhDIQxh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:53:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbhDIQx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 12:53:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lUuNf-0006UW-7O; Fri, 09 Apr 2021 16:53:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] Bluetooth: virtio_bt: add missing null pointer check on alloc_skb call return
Date:   Fri,  9 Apr 2021 17:53:14 +0100
Message-Id: <20210409165314.671165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to alloc_skb with the GFP_KERNEL flag can return a null sk_buff
pointer, so add a null check to avoid any null pointer deference issues.

Addresses-Coverity: ("Dereference null return value")
Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/virtio_bt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c804db7e90f8..5f82574236c0 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -34,6 +34,8 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 	int err;
 
 	skb = alloc_skb(1000, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 	sg_init_one(sg, skb->data, 1000);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
-- 
2.30.2


Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ABAC74A49
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E198021537
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGKHHv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:07:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36900 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGKHHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 03:07:51 -0400
Received: from [192.168.23.168] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4B70ECF2B8;
        Thu, 11 Jul 2019 09:16:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] Bluetooth: hci_qca: Use kfree_skb() instead of
 kfree()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190709013530.11865-1-weiyongjun1@huawei.com>
Date:   Thu, 11 Jul 2019 09:07:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <158FFFC4-162D-4E8B-AE67-8BF338295687@holtmann.org>
References: <20190709013530.11865-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wei,

> Use kfree_skb() instead of kfree() to free sk_buff.
> 
> Fixes: 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


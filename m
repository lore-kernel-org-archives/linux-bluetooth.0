Return-Path: <SRS0=vV7E=WL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6457C31E40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BFF20665
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfHOLgL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:36:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36366 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOLgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Aug 2019 07:36:11 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5739ACED16;
        Thu, 15 Aug 2019 13:44:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Use kfree_skb() instead of kfree()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190815083416.GF27238@mwanda>
Date:   Thu, 15 Aug 2019 13:36:09 +0200
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5B79868C-9C65-46AE-8BD7-D476EA389FD0@holtmann.org>
References: <20190815083416.GF27238@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> sk_buff structs need to be freed with kfree_skb().
> 
> Fixes: 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


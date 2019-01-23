Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C31C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFF321855
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfAWRq0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:46:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42347 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:46:26 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id A01A2CEFA4;
        Wed, 23 Jan 2019 18:54:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH net-next] Bluetooth: Mark expected switch fall-throughs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190123072031.GA9678@embeddedor>
Date:   Wed, 23 Jan 2019 18:46:25 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1AA1243F-A0CD-4124-A2D8-DB3648E4C922@holtmann.org>
References: <20190123072031.GA9678@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> net/bluetooth/rfcomm/core.c:479:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> net/bluetooth/l2cap_core.c:4223:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> net/bluetooth/l2cap_core.c  | 1 +
> net/bluetooth/rfcomm/core.c | 1 +
> 2 files changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


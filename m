Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7411C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71006137F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJSS3v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:29:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60413 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhJSS3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 14:29:51 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 81A70CED07;
        Tue, 19 Oct 2021 20:27:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 2/2] bluetooth: use dev_addr_set()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211019163346.1384785-2-kuba@kernel.org>
Date:   Tue, 19 Oct 2021 20:27:37 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AE0C60C4-E752-4516-87B1-325BC03CBB01@holtmann.org>
References: <20211019163346.1384785-1-kuba@kernel.org>
 <20211019163346.1384785-2-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: marcel@holtmann.org
> CC: johan.hedberg@gmail.com
> CC: luiz.dentz@gmail.com
> CC: linux-bluetooth@vger.kernel.org
> ---
> net/bluetooth/6lowpan.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

please also take this directly via net-next.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


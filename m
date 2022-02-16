Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F8CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 10:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiBPK3i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:29:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiBPK3X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 05:29:23 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A9B22219E;
        Wed, 16 Feb 2022 02:29:03 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id D047FCEE75;
        Wed, 16 Feb 2022 11:28:57 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: make array bt_uuid_any static const
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220214215130.66993-1-colin.i.king@gmail.com>
Date:   Wed, 16 Feb 2022 11:28:57 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E7AEF7CE-CD73-4B64-A67D-8C141F124690@holtmann.org>
References: <20220214215130.66993-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> Don't populate the read-only array bt_uuid_any on the stack but
> instead make it static const. Also makes the object code a little
> smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> net/bluetooth/mgmt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


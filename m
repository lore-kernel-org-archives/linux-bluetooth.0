Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7579C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244262AbiCGQvB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiCGQvA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 11:51:00 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC4E522BF1;
        Mon,  7 Mar 2022 08:50:03 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 765DCCED19;
        Mon,  7 Mar 2022 17:50:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: mgmt: remove redundant assignment to variable
 cur_len
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220307155338.140860-1-colin.i.king@gmail.com>
Date:   Mon, 7 Mar 2022 17:50:01 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Transfer-Encoding: 8BIT
Message-Id: <4B2F2958-85E4-42F6-9F45-1D7DA6396CB1@holtmann.org>
References: <20220307155338.140860-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> Variable cur_len is being ininitialized with a value in the start of
> a for-loop but this is never read, it is being re-assigned a new value
> on the first statement in the for-loop.  The initialization is redundant
> and can be removed.
> 
> Cleans up clang scan build warning:
> net/bluetooth/mgmt.c:7958:14: warning: Although the value stored to 'cur_len'
> is used in the enclosing expression, the value is never actually read
> from 'cur_len' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


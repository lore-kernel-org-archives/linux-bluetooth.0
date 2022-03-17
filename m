Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Mar 2022 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiCQLNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Mar 2022 07:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiCQLNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Mar 2022 07:13:43 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB9F1E31AF;
        Thu, 17 Mar 2022 04:12:26 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 63425CED0B;
        Thu, 17 Mar 2022 12:12:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: btmtkuart: fix error handling in
 mtk_hci_wmt_sync()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220317075740.GE25237@kili>
Date:   Thu, 17 Mar 2022 12:12:24 +0100
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E34E4BB0-C5DA-48A3-82DD-0F1788366E88@holtmann.org>
References: <20220317075740.GE25237@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> This code has an uninitialized variable warning:
> 
>    drivers/bluetooth/btmtkuart.c:184 mtk_hci_wmt_sync()
>    error: uninitialized symbol 'wc'.
> 
> But it also has error paths which have memory leaks.
> 
> Fixes: 8f550f55b155 ("Bluetooth: btmtkuart: rely on BT_MTK module")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> drivers/bluetooth/btmtkuart.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 17:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiCDRVp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiCDRVl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 12:21:41 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08A74151365;
        Fri,  4 Mar 2022 09:20:44 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id BECA7CECCD;
        Fri,  4 Mar 2022 18:20:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] net/bluetooth: use memset avoid memory leaks
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220225074152.2039466-1-chi.minghao@zte.com.cn>
Date:   Fri, 4 Mar 2022 18:20:42 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <593463EF-23A9-44C9-B7EE-EB3099463985@holtmann.org>
References: <20220225074152.2039466-1-chi.minghao@zte.com.cn>
To:     cgel.zte@gmail.com
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Minghao,

> Use memset to initialize structs to prevent memory leaks
> in l2cap_ecred_connect
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
> net/bluetooth/l2cap_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


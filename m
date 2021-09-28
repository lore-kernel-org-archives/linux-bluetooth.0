Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995A36138B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 22:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhI1WQ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:16:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42734 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbhI1WQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 18:16:23 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4ED8DCECE5;
        Wed, 29 Sep 2021 00:14:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH -next] ./drivers/bluetooth/btrsi.c: remove superfluous
 header files from btrsi.c
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210928195954.19629-1-liumh1@shanghaitech.edu.cn>
Date:   Wed, 29 Sep 2021 00:14:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6EC25777-CE57-4A75-8DC0-F1FF34F2AF8B@holtmann.org>
References: <20210928195954.19629-1-liumh1@shanghaitech.edu.cn>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mianhan,

> btrsi.c hasn't use any macro or function declared in net/genetlink.h.
> Thus, these files can be removed from btrsi.c safely without
> affecting the compilation of the ./drivers/bluetooth module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
> 
> ---
> drivers/bluetooth/btrsi.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


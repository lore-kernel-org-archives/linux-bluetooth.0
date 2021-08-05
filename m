Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AAEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F960F10
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbhHENGt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:06:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53490 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbhHENGt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 09:06:49 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id CC48ECECF0;
        Thu,  5 Aug 2021 15:06:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: increase BTNAMSIZ to 21 chars to fix potential
 buffer overflow
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210804150951.116814-1-colin.king@canonical.com>
Date:   Thu, 5 Aug 2021 15:06:32 +0200
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B3E07F67-11A7-4E96-B59D-2FE6D48BB538@holtmann.org>
References: <20210804150951.116814-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Colin,

> An earlier commit replaced using batostr to using %pMR sprintf for the
> construction of session->name. Static analysis detected that this new
> method can use a total of 21 characters (including the trailing '\0')
> so we need to increase the BTNAMSIZ from 18 to 21 to fix potential
> buffer overflows.
> 
> Addresses-Coverity: ("Out-of-bounds write")
> Fixes: fcb73338ed53 ("Bluetooth: Use %pMR in sprintf/seq_printf instead of batostr")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> net/bluetooth/cmtp/cmtp.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F389322D58
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbhAYSX5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:23:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38210 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbhAYSXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:23:52 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id B026DCECCA;
        Mon, 25 Jan 2021 19:30:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v5 trivial/resend] dt-bindings: net: btusb: DT fix
 s/interrupt-name/interrupt-names/
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210114131333.2234932-1-geert+renesas@glider.be>
Date:   Mon, 25 Jan 2021 19:22:41 +0100
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        netdev <netdev@vger.kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <26F0654A-4430-4354-A38B-FBDB8993061F@holtmann.org>
References: <20210114131333.2234932-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Geert,

> The standard DT property name is "interrupt-names".
> 
> Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rajat Jain <rajatja@google.com>
> ---
> Who takes this patch, before it celebrates its 4th birthday?
> 
> v5:
>  - Add Reviewed-by, Acked-by,
> 
> v4:
>  - Add Acked-by,
> 
> v3:
>  - New.
> ---
> Documentation/devicetree/bindings/net/btusb.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


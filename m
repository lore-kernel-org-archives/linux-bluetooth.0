Return-Path: <SRS0=kCXZ=IG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7301CC433E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3485565062
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 09:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHJ1z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:27:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44411 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHJ1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 04:27:46 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3C692CED12;
        Mon,  8 Mar 2021 10:35:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 1/2 v3] Bluetooth: btbcm: Rewrite bindings in YAML and add
 reset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210305183736.2123083-1-linus.walleij@linaro.org>
Date:   Mon, 8 Mar 2021 10:27:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F171CD75-ACD3-44BD-AAB5-6BE89FBBEC9E@holtmann.org>
References: <20210305183736.2123083-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

> This rewrites the Broadcom bluetooth bindings in YAML and
> adds a GPIO handle for the BT_RST_N line as used on some
> platforms.
> 
> The Ingenic UART binding was using this binding in its
> example DTS fragment, however mistakenly using "vcc-supply"
> for what is called "vbat-supply". The proper DTS files
> and the code in the kernel all use "vbat-supply" so
> fix up the example in this patch so we ge a clean
> check.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Actually fold in the required fix.
> ChangeLog v1->v2:
> - Fix the error in the Ingenic UART binding example as
>  part of adding this patch.
> ---
> .../bindings/net/broadcom-bluetooth.txt       |  56 ---------
> .../bindings/net/broadcom-bluetooth.yaml      | 117 ++++++++++++++++++
> .../bindings/serial/ingenic,uart.yaml         |   2 +-
> 3 files changed, 118 insertions(+), 57 deletions(-)
> delete mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml

patch has been applied to bluetooth-next tree.

Regards

Marcel


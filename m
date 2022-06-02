Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D220DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 16:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiFBQOK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbiFBQOJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 12:14:09 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D47A310D9;
        Thu,  2 Jun 2022 09:14:08 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fc30.dip0.t-ipconnect.de [79.249.252.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id ADDF5CED1A;
        Thu,  2 Jun 2022 18:14:07 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2 2/3] Bluetooth: btrtl: add support for the RTL8723CS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220524212155.16944-3-bage@debian.org>
Date:   Thu, 2 Jun 2022 18:14:07 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kubakici@wp.pl>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E187ED85-92B9-418E-9026-1EEEB90A9602@holtmann.org>
References: <20220524212155.16944-1-bage@debian.org>
 <20220524212155.16944-3-bage@debian.org>
To:     Bastian Germann <bage@debian.org>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

> The Realtek RTL8723CS is SDIO WiFi chip. It also contains a Bluetooth
> module which is connected via UART to the host.
> 
> It shares lmp subversion with 8703B, so Realtek's userspace
> initialization tool (rtk_hciattach) differentiates varieties of RTL8723CS
> (CG, VF, XX) with RTL8703B using vendor's command to read chip type.
> 
> Also this chip declares support for some features it doesn't support
> so add a quirk to indicate that these features are broken.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> [move former btrtl_apply_quirks to btrtl_set_quirks]
> [rebase on current tree]

I don’t know what these mean. Can you just remove them.

> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
> drivers/bluetooth/btrtl.c  | 120 +++++++++++++++++++++++++++++++++++--
> drivers/bluetooth/btrtl.h  |   5 ++
> drivers/bluetooth/hci_h5.c |   4 ++
> 3 files changed, 125 insertions(+), 4 deletions(-)

Regards

Marcel


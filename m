Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284AC05027
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 07:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBIHIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBIHIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Feb 2023 02:08:39 -0500
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 23:08:37 PST
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D405316AE7;
        Wed,  8 Feb 2023 23:08:37 -0800 (PST)
Received: from smtpclient.apple (p5b3d2eb0.dip0.t-ipconnect.de [91.61.46.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id 24484CECE7;
        Thu,  9 Feb 2023 08:02:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH v4 2/2] Bluetooth: btrtl: add support for the RTL8723CS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKnt5=dar6Rmav=Tv3QH1ghSUV2osZPnp7OQLcANp_1Tw@mail.gmail.com>
Date:   Thu, 9 Feb 2023 08:02:06 +0100
Cc:     Bastian Germann <bage@debian.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0B0EFD39-825F-4635-A7F3-CA96BCFED9A2@holtmann.org>
References: <20230208155220.1640-1-bage@debian.org>
 <20230208155220.1640-3-bage@debian.org>
 <CABBYNZKnt5=dar6Rmav=Tv3QH1ghSUV2osZPnp7OQLcANp_1Tw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> The Realtek RTL8723CS is a SDIO WiFi chip. It also contains a Bluetooth
>> module which is connected via UART to the host.
>> 
>> It shares lmp subversion with 8703B, so Realtek's userspace
>> initialization tool (rtk_hciattach) differentiates varieties of RTL8723CS
>> (CG, VF, XX) with RTL8703B using vendor's command to read the chip type.
> 
> Don't remember anything called rtk_hciattach, besides if that is based
> on hciattach that is already deprecated in favor of btattach.

and btattach is also deprecated. Write a proper serdev based driver.

The hci_ldisc line discipline crap needs to be removed.

Regards

Marcel


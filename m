Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42571C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F1C60EFF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhG2Tzu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:55:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60213 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhG2Tzu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:55:50 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id F04BFCED1E;
        Thu, 29 Jul 2021 21:55:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: btusb: Make the CSR clone chip force-suspend
 workaround more generic
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
Date:   Thu, 29 Jul 2021 21:55:45 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D11408EE-8541-4930-A438-6338F342EFB1@holtmann.org>
References: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ismael,

> Turns out Hans de Goede completed the work I started last year trying to
> improve Chinese-clone detection of CSR controller chips. Quirk after quirk
> these Bluetooth dongles are more usable now.
> 
> Even after a few BlueZ regressions; these clones are so fickle that some
> days they stop working altogether. Except on Windows, they work fine.
> 
> 
> But this force-suspend initialization quirk seems to mostly do the trick,
> after a lot of testing Bluetooth now seems to work *all* the time.
> 
> The only problem is that the solution ended up being masked under a very
> stringent check; when there are probably hundreds of fake dongle
> models out there that benefit from a good reset. Make it so.
> 
> 
> Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
> Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
> Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
> Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> 
> I've changed the warning line to make it easy to grep and detect if this updated
> workaround is part of the driver. Should make it much more obvious to users in
> case their dongle doesn't work for other reasons. There's a clear then-now.
> 
> Easy to narrow other future issues down. Let me know what you think.
> 
> drivers/bluetooth/btusb.c | 61 +++++++++++++++++++++------------------
> 1 file changed, 33 insertions(+), 28 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB49EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 11:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGLIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGGLHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 07:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8F1BD2;
        Fri,  7 Jul 2023 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD3CA618F1;
        Fri,  7 Jul 2023 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FBAC433C8;
        Fri,  7 Jul 2023 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688728069;
        bh=1kS8xpok5DlQK6AWLrgEr91mwJ7pD7DtontA3r8syII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTJqkkEgq8Rj3NoNl0+zfX54lw4TDNHWAQ5coqiDwPuUzELSPezr52JZcqyhRGMiK
         XLsVbxmDRzVNFhkA9S+WPlxnrIbpy8n9smVdqPN9cZBV0vCTZH+Z+04ckgRfyMbfWr
         VzkPKYJnlj6lUPSZbNBxCRdXJVck2CznML6ClLk/wumG2qW7hTTQpD036gWal1XM3d
         7E9t09LuOWeH5rFuC3aYgQRUYHu1oDCnCwH3wkQUlNcnyxLjYliOX5T5IhrFAdTby8
         anCz8yrZc87Y53SAip9zJnLQ86ha/I9B6IsWmwluk9mbcXi51ZX3Zieh35M+/tKt9L
         fwjhpFP8fRzTQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHjJv-0005M8-0v;
        Fri, 07 Jul 2023 13:08:15 +0200
Date:   Fri, 7 Jul 2023 13:08:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Message-ID: <ZKfyH4jRGlVlcLeY@hovoldconsulting.com>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org>
 <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jul 07, 2023 at 03:11:11PM +0530, Amit Pundir wrote:

> On Wed, 31 May 2023 at 14:35, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Devices that lack persistent storage for the device address can indicate
> > this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
> > to be marked as unconfigured until user space has set a valid address.
> >
> > The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
> > indicate that the device lacks a valid address but that one may be
> > specified in the devicetree.
> >
> > As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
> > BD_ADDR from fwnode property") that added and documented this quirk and
> > commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
> > HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
> > this flag should be treated as invalid until user space has had a chance
> > to configure the controller in case the devicetree property is missing.
> >
> > As it does not make sense to allow controllers with invalid addresses,
> > restore the original semantics, which also makes sure that the
> > implementation is consistent (e.g. get_missing_options() indicates that
> > the address must be set) and matches the documentation (including
> > comments in the code, such as, "In case any of them is set, the
> > controller has to start up as unconfigured.").

> This patch broke Bluetooth on Dragonboard 845c (SDM845) devboard.
> Reverting this patch fixes the BT breakage and I see the following
> messages in dmesg:
> 
> Bluetooth: hci0: setting up wcn399x
> Bluetooth: hci0: QCA Product ID   :0x0000000a
> Bluetooth: hci0: QCA SOC Version  :0x40010214
> Bluetooth: hci0: QCA ROM Version  :0x00000201
> Bluetooth: hci0: QCA Patch Version:0x00000001
> Bluetooth: hci0: QCA controller version 0x02140201
> Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> Bluetooth: hci0: QCA setup on UART is completed

That's odd. You should still see the above messages also with this patch
applied, but you may now need to provide a valid device address before
being able to use device in case the bootloader has not provided one
(e.g. using btmgmt).

Are there any error messages in the log when running with this patch?

Does

	btmgmt --index 0 public-addr <bdaddr>

work?

Johan

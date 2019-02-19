Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6FC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DEB21773
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550585659;
	bh=k/rZw+tctmTg7PN7nlanI4BJpNoPAyeRjRuqJeqf0WU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o4Ylsp9l/rcBX+p25HtIZd42YcQUjnN5clNvjhA92qQlumQTxIWv7vSpRDhgamss1
	 eKwZ2wO9LIS61DK3Jgs1h3HlDrOYoBhidQ8Abc2IAukIWBwIr1ZD5lS6QyeHtzTiCn
	 DWSti9gImScGrFgzo9VoALlUc3XXiwcIVcI2n8fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfBSOOQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBSOOQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 09:14:16 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4942183F;
        Tue, 19 Feb 2019 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550585655;
        bh=k/rZw+tctmTg7PN7nlanI4BJpNoPAyeRjRuqJeqf0WU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPRfY8EQFdseX3F6qJjxkBmeSTe2yI5Tch5++jCnFXoq5ah1TWLDtuhLzMhxPGsCn
         R85yDutANUG0iOoBd+pSwcS4vBLJgydIdquSx/N8cUvSeahBT7dbGAaoajGshvqiPy
         7pbXLe+rvWRiKw1kSj0XihztwQE1mnnZ32AV0Z4k=
Received: by mail-qk1-f182.google.com with SMTP id i5so12043099qkd.13;
        Tue, 19 Feb 2019 06:14:15 -0800 (PST)
X-Gm-Message-State: AHQUAubN7IQ074BcnHQGtLn/Izzv0WMBlpd40JU/+pkz1v3hJaL4E5jC
        cMAci3IsE2d02U5aPVvD95aAOPK5aeSbDnGswg==
X-Google-Smtp-Source: AHgI3IYc5KwnKwWTPjuSEh0Jb6BJKJjJqoLCQHyqVWbwXcDTKJW6hDOXo7TxrUH90dYOTrOhG/NulED6sADu7X1ZNFY=
X-Received: by 2002:a37:4a84:: with SMTP id x126mr20785022qka.326.1550585654176;
 Tue, 19 Feb 2019 06:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus> <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
In-Reply-To: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Feb 2019 08:14:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
Message-ID: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > new file mode 100644
> > > index 000000000000..8357f242ae4c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > @@ -0,0 +1,35 @@
> > > +RTL8723BS/RTL8723CS Bluetooth
> > > +---------------------
> > > +
> > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > +to upload firmware and change module speed.
> > > +
> > > +Required properties:
> > > +
> > > + - compatible: should be one of the following:
> > > +   * "realtek,rtl8723bs-bt"
> > > +   * "realtek,rtl8723cs-bt"
> > > +Optional properties:
> > > +
> > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > + - firmware-postfix: firmware postfix to be used for firmware config
> >
> > How is this used?
>
> rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
> another is firmware config which is specific to the board. If
> firmware-postfix is specified, driver appends it to the name of config
> and requests board-specific config while loading firmware. I.e. if
> 'pine64' is specified as firmware-postfix driver will load
> rtl8723bs_config-pine64.bin.

We already have 'firmware-name' defined and I'd prefer not to have
another way to do things. The difference is just you have to give the
full filename.

Also, on other chips with board specific config blobs, there's been
some discussion of converting those to DT properties. That depends on
you knowing what's in the blob and having a reasonable number of
parameter to make properties.

Rob

Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB53FC00319
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 22:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98622064C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKhfquQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfBRW22 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:28:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34410 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfBRW22 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 17:28:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so31050353oty.1;
        Mon, 18 Feb 2019 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtL0H++FC+hfD2NXTdoT9f5v8nuo8y/Ymvz/KKsVPOY=;
        b=myKhfquQZC8BXC9UXbVOA3qNJir4n64KHhHMJ5cF6ShGo9Cxt/jYHW5mJdpbIQRj+B
         OqZVKIGxy2IRbAudnZpTDQlvVDZ7DT+baBJDytxWAmWnQpWjbqbLNDXY9309TsAqLLn0
         eorMKqtgucbVXyXqaRYwfuMXacO/HxJHCuoDea9Y5gEzjSaFJundWZ3/5ESbeg8ef/Kj
         sEDVFrlZMoRtaVoNAkuMFrLXWsmlD8iGL5fJ7CJUT8EKnBvpjUlhk541jZ89/S6a57Jy
         0cKmVCMLAWhcoMdtiocWSDFEifhYv9s4/ceKw+9eDzSt7yejtViRva6JAbnqf8h2yNQC
         LgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtL0H++FC+hfD2NXTdoT9f5v8nuo8y/Ymvz/KKsVPOY=;
        b=P0DqRDMZVBtlvjxVp/a9ILP6Qh0aVk8Xdhp16/i2GHeU0/0Km6JRPfoB+B/48wqssI
         Lrof7J9EzeCqHzIxaZb0d4jeCW9yDr50SNFgzCnD+8fSmRe9GLFHrM42INdKCHekREDf
         S3MtgqkUr5pyGGC1LBb1mlYrFr6ls3vxlizXm4/iYK5qy2VcxROxBnqxUJXbVxa6EBPl
         CZV4U0vIrPPxrSYrre3ucfSYoRCxEWG8RQMOLBhrojXJs9A5+Sadc+0jImO9ZYakefAt
         TKq1JeHFEgFwkSQgPUzNGM34P5Spi39rop6FcRoFPlZDGfmvkohHtLLXQCl0hmgZj7Yl
         Mn0w==
X-Gm-Message-State: AHQUAubvYsSsXPsGyqK/R2u7mQNLRj/7Ynj3bTgPaeMj5aQ1oTv79Er8
        sjgjBP3iG2dPhTvoXmqMy/Z8I44nyFL9CWgqf+0=
X-Google-Smtp-Source: AHgI3Ia9kPLsHfHWsTs37LX1x7MeU2PA5jNHIytOBI1bGiCGtyv/MwjywGRaVLfH1oyDPx+56hAuzWvTdZ54NV3atk8=
X-Received: by 2002:aca:c142:: with SMTP id r63mr706734oif.98.1550528907259;
 Mon, 18 Feb 2019 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus> <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
In-Reply-To: <1245842044.588056.1550527701604@email.ionos.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 18 Feb 2019 14:28:01 -0800
Message-ID: <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        beagleboard@davidjohnsummers.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Vasily,

Hi Stefan,

> > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> >
> >
> > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > new file mode 100644
> > > > index 000000000000..8357f242ae4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > @@ -0,0 +1,35 @@
> > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > +---------------------
> > > > +
> > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > +to upload firmware and change module speed.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be one of the following:
> > > > +   * "realtek,rtl8723bs-bt"
> > > > +   * "realtek,rtl8723cs-bt"
> > > > +Optional properties:
> > > > +
> > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > >
>
> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
>
> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.

Looks good to me, but you may need to add firmware-postfix.

> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?

Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.

> Stefan

Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD5C10F00
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297FF21479
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 21:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzKgjW3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfBSV0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:26:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42161 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfBSV0O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 16:26:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so36789749oto.9;
        Tue, 19 Feb 2019 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tShKv+rCj4cb7oTii69qoiNaguPqqY5jERkY1mOdgTM=;
        b=DzKgjW3Ab2k8LY+wa0b4QdOUykt3EMt1/XZqpstcRerFKA9xBuMKrrdd+72r8XI9yy
         XaajW+aOFG7XEphSg4WkRmeiQDEwlRp+8RxL1vK0qiSHfOoFgdmKyqJWyMHWNMpAsSIn
         81Vp09gttURJG9sFlp8vaFeNp3McRcEgkjVD+BB4b5+nUbu1NKJHmLzaM6Y20eTy2H6x
         UWHbFbE2tfgCofhy4RE3V/65lx94pbnEnfUaWGMCNtOlqBTyLcurLJ3wTUriODulnw4M
         7UV1AtNgTeTLJ8NWMLT5uGj2dx2CHa44rWmMmc5gPnxLbYWIYMogrjB53QcwEsvuZMje
         6VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tShKv+rCj4cb7oTii69qoiNaguPqqY5jERkY1mOdgTM=;
        b=DiaPgXUG+WMIZeCGG3U2hP0xvAlsI0+bvyuNfKqM04h5apTgybbrNKGH7yv0iJXbF4
         qC32ccwl1hRohSM/1WrGh0vVhWUJyXmHIUy+WtsDILr4iC4rDEF5bKdZjjbHp5btIldQ
         VZ66mHJAtBJLYoy1GVF1U9mZ3YL3VLHliRp29mOlJ26qEc26XJnZwxAjde/xQ8Iet9Cg
         HGoS+o8OTf+nYDK9ACl8T0FpR5POpsq2YFblMkUBpvPyg1y9+CaRZ6sqGSc7lJA/SB67
         9guDpf3oN0NT89i8NFi/Jc2T0NUokWKPZKgcbBfJZYP55S9QcfPV1M0qdqOpp7sz+Gw6
         j4uA==
X-Gm-Message-State: AHQUAuYPBBud5FMWonP4islwXQn4sMMn1hJQbC98EOggIdmTvM4udxGW
        Q+zbUOMVOR+03X737SaIrAeFqChqhGXitNKkpa0=
X-Google-Smtp-Source: AHgI3IYscnf3cOH1ASQ/+LIT3zFXVhlWpKS6nUKk00gm3SV0dcsdihIG+KU/oX1k/KU6jcNTU0Z9MvuT4GcWox8Olo8=
X-Received: by 2002:aca:c142:: with SMTP id r63mr3962109oif.98.1550611573153;
 Tue, 19 Feb 2019 13:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus> <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 19 Feb 2019 13:25:46 -0800
Message-ID: <CA+E=qVf44XBEGHY6NoQZrvkodCs2UX7xFkHZ5vs6A5TCAXr1oA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Rob Herring <robh@kernel.org>
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

On Tue, Feb 19, 2019 at 6:14 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Feb 18, 2019 at 3:24 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
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
> > > How is this used?
> >
> > rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
> > another is firmware config which is specific to the board. If
> > firmware-postfix is specified, driver appends it to the name of config
> > and requests board-specific config while loading firmware. I.e. if
> > 'pine64' is specified as firmware-postfix driver will load
> > rtl8723bs_config-pine64.bin.
>
> We already have 'firmware-name' defined and I'd prefer not to have
> another way to do things. The difference is just you have to give the
> full filename.

OK

> Also, on other chips with board specific config blobs, there's been
> some discussion of converting those to DT properties. That depends on
> you knowing what's in the blob and having a reasonable number of
> parameter to make properties.

We'd have to RE binary format of this config first.

> Rob

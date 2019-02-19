Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07FEC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD38A21773
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550585855;
	bh=kgVVAdu9HfOcqLEZpYWWTN2e+/KsdaDxYdC/hQZo+tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LqrlZZupieOGkf9baOid/0o9VMua/JQoTqaKvUfTYAXU+r/irUo0JRhqQPDXWPPAY
	 uO46VivIwhSX4Khj8/cxidvn0uBb483WboLxt24oX1cAOSolKA4I5iolDwqUmqhScW
	 g9hxXWS3e/bD6tSZGYFRBIuJfxSWQwDEfoYLH1/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfBSORd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfBSORd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 09:17:33 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94490217D9;
        Tue, 19 Feb 2019 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550585851;
        bh=kgVVAdu9HfOcqLEZpYWWTN2e+/KsdaDxYdC/hQZo+tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=na5jOMAI7TISHYDd0h1IhE1F4mK2ZGB6u6xAt7UZPZz2Emd26nZZxWGcyRwsZIEQl
         ucnziU0XvtAypDniaxTyIeQtva0fr/lbdqTOXa5RlBfJCd7cXw7aPkNLyGllRNK0Aa
         1QDbWIBxgjduyFyOsdLp49fhtNkSYKtiTbTBvbIY=
Received: by mail-qk1-f174.google.com with SMTP id w204so12108618qka.2;
        Tue, 19 Feb 2019 06:17:31 -0800 (PST)
X-Gm-Message-State: AHQUAubQ95WygxJOhEs+3A2uMjyRu149B7pLZX5MY+ADPePj58RwqNL5
        AAxJNzKTQ1IoOzT0hKqWRfRnJlEr4n9yZ2l7tQ==
X-Google-Smtp-Source: AHgI3IYNtXTmYF83zRojl7RhSrGNKW0hKjNlqWsD7leb9M4NOft1QXZP/xfSeH44xsCIqjET5xSXGEWQ43NrGEXKmvk=
X-Received: by 2002:a37:674c:: with SMTP id b73mr19964353qkc.184.1550585850781;
 Tue, 19 Feb 2019 06:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus> <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de> <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
In-Reply-To: <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Feb 2019 08:17:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
Message-ID: <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        David Summers <beagleboard@davidjohnsummers.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 18, 2019 at 4:28 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > Hi Vasily,
>
> Hi Stefan,
>
> > > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> > >
> > >
> > > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > > >
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > > >  1 file changed, 35 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > > new file mode 100644
> > > > > index 000000000000..8357f242ae4c
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > > @@ -0,0 +1,35 @@
> > > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > > +---------------------
> > > > > +
> > > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > > +to upload firmware and change module speed.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible: should be one of the following:
> > > > > +   * "realtek,rtl8723bs-bt"
> > > > > +   * "realtek,rtl8723cs-bt"
> > > > > +Optional properties:
> > > > > +
> > > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > > >
> >
> > sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> >
> > I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
>
> Looks good to me, but you may need to add firmware-postfix.
>
> > Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
>
> Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.

Then why do we have both? Reset and enable are distinct. The inverse
of enable-gpios is typically powerdown-gpios, not reset-gpios.

Rob

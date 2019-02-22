Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D9C4360F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A97D20700
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZRiissr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfBVTV2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:21:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33831 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBVTV2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 14:21:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id g16so2610833oib.1;
        Fri, 22 Feb 2019 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BtRA5jFATl4sN49QGorYoPx/0L+cyC8J4w4Jj3KHjE=;
        b=SZRiissr8HGfunMRWVC2AAWH1/2JMzrB3WTXG62NgAN+bgT4gfZB8m5o4fW61UYp7V
         jA1eD8cVoC905saYOI/cMIROdeOZ2nPKK05hT7PKoQ+QIy0Etl0z4XW/PuwPNcmb9VXe
         mBw0Mp2k9rY52iTqA3r/zDnU7tcQ+lSGorqVWWGor/xPMi+SdyS9BObTd8wreOndLEfl
         X/KkNbmLZtc8DxT2IByJ2NshoImWeXXJjX52W8EXa01qX99xEIyiXpt9J1rV2WRpXMPu
         CAtKBC5nGcYxpLM3M9/TFBISJOdi4knw0j+UoXeOZsfQPo1E9W4TkLYW0c4ZW3tDgU66
         0phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BtRA5jFATl4sN49QGorYoPx/0L+cyC8J4w4Jj3KHjE=;
        b=iQekqdW8ZsQWzL1uRkTryR632muaJ9Xbmg+mODktM75A+0/oJOgZO7CH3eBGJawsBg
         mwAyMSKY5bfrtAkI5EvqwDB2iOS1qJSlu5F6W/HqPoKgDcmC9UjMwHI9SUpZ6sdPZZL/
         A6yVNjFDwpQnP2EtUHJAT/2JCJYw9Dh+ndodqsNHMbea5i8CITqiEk09KALve/xguxi/
         cLqSOea9h8ywjKCIPlRtFUIOrVl2/1aGGAPK1EjsV6pnfOn6yCkhJQBnq3j+Bg3pIJYB
         rduLeYWYjSowBk4sS2FCw/HaQn5juUkvV2UuTXcfQmo2Aj1m4vEQGDGBmvA3UFhpw3o5
         fWtQ==
X-Gm-Message-State: AHQUAuZch7JBJ6Owt4k57XksaTgOsrMmCF8n2GoExBz65BJ9xjyiYPTj
        Deilv7jHeJPVa9NoBazQSIk5Yr5OCcKrUAJ4PpnpTBvR
X-Google-Smtp-Source: AHgI3IYjH86SeI/Q2GCUCfQUpF8tJcgma8D2G6YUIFY7db4vbtwdJXN2Um8tTjifVXniJiMC8JESb4bwdLdv8u5ladk=
X-Received: by 2002:aca:ab11:: with SMTP id u17mr3587348oie.98.1550863286630;
 Fri, 22 Feb 2019 11:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus> <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de> <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
 <8b97f349-4416-058c-0d01-3be592b89a7d@davidjohnsummers.uk>
In-Reply-To: <8b97f349-4416-058c-0d01-3be592b89a7d@davidjohnsummers.uk>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 22 Feb 2019 11:21:00 -0800
Message-ID: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Feb 22, 2019 at 11:14 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> Hi Vasily,
>
> Just catching up with this series - good that you are doing it. We need
> it for users on ArchLinux ARM!
>
> On question though, what is "firmware-postfix" used for? I see in the
> documentation, that it points to the board name. But can't see where
> else it is used.

See h5_serdev_probe() in drivers/bluetooth/hci_h5.c. Basically it
specifies what firmware config to use.
I agree with Rob that we should probably use firmware-name here instead.

> Is there a need to have the board name?

As far as I understand firmware config depends on board, so I think
it's a good idea to use board name here.

> Anyway good work.

Thanks!

>
> David.
>
> On 18/02/2019 22:28, Vasily Khoruzhick wrote:
> > On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >> Hi Vasily,
> > Hi Stefan,
> >
> >>> Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> >>>
> >>>
> >>> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> >>>> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> >>>>> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> >>>>>
> >>>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >>>>> ---
> >>>>>   .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> >>>>>   1 file changed, 35 insertions(+)
> >>>>>   create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>> new file mode 100644
> >>>>> index 000000000000..8357f242ae4c
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >>>>> @@ -0,0 +1,35 @@
> >>>>> +RTL8723BS/RTL8723CS Bluetooth
> >>>>> +---------------------
> >>>>> +
> >>>>> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> >>>>> +BT is connected over serial. It speaks H5 protocol with few extra commands
> >>>>> +to upload firmware and change module speed.
> >>>>> +
> >>>>> +Required properties:
> >>>>> +
> >>>>> + - compatible: should be one of the following:
> >>>>> +   * "realtek,rtl8723bs-bt"
> >>>>> +   * "realtek,rtl8723cs-bt"
> >>>>> +Optional properties:
> >>>>> +
> >>>>> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> >>>>> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> >>>>> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> >>>>> + - firmware-postfix: firmware postfix to be used for firmware config
> >> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> >>
> >> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
> > Looks good to me, but you may need to add firmware-postfix.
> >
> >> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
> > Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.
> >
> >> Stefan
>
>

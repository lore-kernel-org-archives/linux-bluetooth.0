Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93341C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9BA20747
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 16:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpYNebC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgJ2Q7A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ2Q6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 12:58:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 09:58:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so4264966ioo.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0aWahw3wj81BLYdiwaVNvXbuQJUY8hlo1XqROU/p3fs=;
        b=BpYNebC2OQyCeOuzf1FdX3Xk8VpoyBaJV/dfdkYdjzPBap2/5auP1isspYbj+3IN/U
         xPTHv1CAJ1JfHLSdCXCqyYwGbX9mGn3SZZDUB0E9Y2+8C/KNWE5ggfs7yt3kdvdkKn0R
         pq0XGyTiU8DxQl+82ckMEg26qngsYOGNHmyqrj718o13W/bpblS7Xz2LNUlF5qAo6zN+
         DKTFzDHo/Dj+3TrYzwwmJK0F2CTNrr74Nhp91oStkJsJj7zZS8ZuG0cKlJVDclYrMNR/
         wDV9uFPQefAUX+x9tfuuP96mtymJY8b2+PWipEADfT4sqQWVak1tE8WoevPyyq8ozb4E
         UHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0aWahw3wj81BLYdiwaVNvXbuQJUY8hlo1XqROU/p3fs=;
        b=XMnUUlNRtdKTPP71TG5VKsJc+CVvYQ3Gm571tQYejqjOo++cycFXxRCKrcqRTjg8yC
         NCdWpo0HhUL8IhAXB/djQD+XjWvPPmax6M8MWgvJgvqiaI5O8zRJYxFOKwWqdb5oepeU
         f3pv4eL7XCsT51X3RFBSd2VSKFJWoba+SRw91+av9hytMA3JB8Yk0JEgTqh6QFUqFDqy
         1U+/zDuhiTmogBuNHcxW43Ly1nJDTNwazUcOdzWZmheQB8sKlkZMJApqpMCsbaNLhbOr
         6NoFXfpiVMVl5FYSbrQPh95/tierG4dW25CBvENlOiW/OH6UHZ9MeSa5Aa1yfH4fQGp+
         qN7w==
X-Gm-Message-State: AOAM532oko1VGY8i7pZNIc6JogJlTkaZ5UaP7tMVL7+MhPSN12RDG1WY
        TD4MYVeS1Vj+TDX1R5jMPXNJXmhYTg8bYMem1+Q=
X-Google-Smtp-Source: ABdhPJz9hLrbGh3oPRvPslRPGBXiXS/cMfY38Xmq3sNrICk/NOTtTLo/Tht5FoYdLPXyBDayn3FzQQgaOxqxrkEXqiY=
X-Received: by 2002:a6b:b807:: with SMTP id i7mr2434592iof.49.1603990680119;
 Thu, 29 Oct 2020 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
 <d492a9ad6467d881a7ff325d4210707194f534ca.camel@intel.com>
In-Reply-To: <d492a9ad6467d881a7ff325d4210707194f534ca.camel@intel.com>
From:   David Zakarias <david.zakarias@gmail.com>
Date:   Thu, 29 Oct 2020 17:57:49 +0100
Message-ID: <CAC_SeiyJYunkTt81Nh=kc7yFrEkx4iqJ=HE0N8Vd1QrgXmRx=g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek
 8822CE device
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

Is this what you are looking for?


T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480  Mx=
Ch=3D 4
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0002 Rev=3D 5.09
S:  Manufacturer=3DLinux 5.9.1 xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:02:00.3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0cb5 ProdID=3Dc547 Rev=3D 0.00
S:  Manufacturer=3DRealtek
S:  Product=3DBluetooth Radio
S:  SerialNumber=3D00e04c000001
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D10000 M=
xCh=3D 2
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 3.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D03 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0003 Rev=3D 5.09
S:  Manufacturer=3DLinux 5.9.1 xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:02:00.3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480  Mx=
Ch=3D 4
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0002 Rev=3D 5.09
S:  Manufacturer=3DLinux 5.9.1 xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:02:00.4
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D10000 M=
xCh=3D 2
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 3.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D03 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D1d6b ProdID=3D0003 Rev=3D 5.09
S:  Manufacturer=3DLinux 5.9.1 xhci-hcd
S:  Product=3DxHCI Host Controller
S:  SerialNumber=3D0000:02:00.4
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D256ms

An, Tedd <tedd.an@intel.com> ezt =C3=ADrta (id=C5=91pont: 2020. okt. 28., S=
ze, 22:26):
>
> Hi David
>
> On Tue, 2020-10-27 at 21:52 +0100, David Zakarias wrote:
> > My Redmibook 16 AMD laptop contains the RTL8822CE chip having the USB
> > identifier 0cb5:c547. This patch adds this Id to btusb.c's blacklist
> > table, enabling the loading of the Realtek firmware.
> > This, together with another patch by Edward Vear (hci_core: Fix
> > attempting to set RPA timeout when unsupported, see
> > https://marc.info/?l=3Dlinux-bluetooth&m=3D160378222632366&w=3D2) makes=
 my
> > bluetooth mouse work.
> >
> > Signed-off-by: David Zakarias <david.zakarias@gmail.com>
> > ---
> > --- bluetooth/drivers/bluetooth/btusb.c.orig 2020-10-27 21:24:51.331035=
974
> > +0100
> > +++ bluetooth/drivers/bluetooth/btusb.c 2020-10-27 21:21:46.000000000 +=
0100
> > @@ -386,6 +386,7 @@ static const struct usb_device_id blackl
> >
> >   /* Additional Realtek 8822CE Bluetooth devices */
> >   { USB_DEVICE(0x04ca, 0x4005), .driver_info =3D BTUSB_REALTEK },
> > + { USB_DEVICE(0x0cb5, 0xc547), .driver_info =3D BTUSB_REALTEK },
> >
> >   /* Silicon Wave based devices */
> >   { USB_DEVICE(0x0c10, 0x0000), .driver_info =3D BTUSB_SWAVE },
>
> Please include the content of /sys/kernel/debug/usb/devices for this devi=
ce in
> the commit message.
>
> Regards,
>
> Tedd Ho-Jeong An

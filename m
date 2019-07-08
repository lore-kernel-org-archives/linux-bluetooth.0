Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41BC606AC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1D420861
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW4ygU9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfGHNT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:19:57 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40834 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbfGHNT5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 09:19:57 -0400
Received: by mail-ot1-f52.google.com with SMTP id e8so16137624otl.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYNnPUEw/Akd6Ifti31vILFWYweFEc1BurOwv1xrJ58=;
        b=qW4ygU9lH0Jn+/Pdjh6XDf72iQKwUnzeR5DNGju9DIgWJsPDPmZs9c0L8P1uK7jTdo
         tDYo9UIJ3wOJrG5n6r+88KtKp7Mr9bBblW9DD+UmMSGivZGE4tFlfh7mu2RWgcR/4Ofx
         c2uKlQNBABexbNxzXUhz6hm3FmE+PC2P3HxbCi5y1/PWbh2k5Cw8A8TFciHsw8AQsaTS
         VheI5Gu2Kru5X6Ka8T64U6HA27mjDulDjNamHIxUsOoSXbQ1x6hA95mawBfOWkwuI8xX
         +z9RGfI8XqqO5ES0YsN/e3WL47mME5ay8EVAOSoZqCPgxVZrmRPw4FQrBWgbzJQubqlb
         xHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYNnPUEw/Akd6Ifti31vILFWYweFEc1BurOwv1xrJ58=;
        b=TbLSnYQjThvEyW3nKpT7a0FsujAayNwa/gRsuFG2Sx5hz6N+seWJaCynFEuJBF6iGe
         n9o+BLMMFIf59KHXEHjPXHfGba3aCEu8Ym3uvzAuHXjk5dR0fV93SWDSdDwmUhRjrVTO
         1E32TZuvRMYHF6eOzAt0TZijcO2joe+Q0lBInfG2DTWxu9XTo+l+HhwLiWWglivTVkac
         0azUqkuadaGQWWfQYqSxN5wqwv+p7j0nFdmKmimu0g8Qr6jjC0qaSBsPzBVSpjO++xee
         DwW9RncyLfCv/5z4Yatnbfe4pTysqy30QGSZIntixOe4KQEyBZI1xjuz5BWLeFaAGMzU
         95WA==
X-Gm-Message-State: APjAAAXzTQTdRp4zu74s3ujSnzrguKkc+gPHMsK+efGlxfHwXvicE0Xr
        XvgH2ldVFOUOgsJGMYVTJ9+kLPy4TD3gQniM/XQ=
X-Google-Smtp-Source: APXvYqxniXuR4ufqBKHy83gebs/PanSl9YS3blobi/M65YLrcb74hs7JUCml2q0yLueovDzR62mtA5LOU+pIX4HIy1Q=
X-Received: by 2002:a9d:7003:: with SMTP id k3mr15281145otj.28.1562591995811;
 Mon, 08 Jul 2019 06:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
In-Reply-To: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Jul 2019 16:19:45 +0300
Message-ID: <CABBYNZLyutV_DWGfu3OKn0UKaC+VUwpTJej477WP92WQcrPbRA@mail.gmail.com>
Subject: Re: bluetoothctl: list-attributes doesn't list services from example-gatt-server
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafal,

On Sun, Jul 7, 2019 at 2:53 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> w=
rote:
>
> Hi,
>
> I have 2 notebooks with Bluetooth running bluez 5.30. I called them:
> 1) "elitebook" with controller 20:16:B9:D8:A9:3B
> 2) "matebook" with controller 38:BA:F8:3F:7C:A7
>
> Normally, when I check elitebook from matebook I get this:
>
> [elitebook]# info 20:16:B9:D8:A9:3B
> Device 20:16:B9:D8:A9:3B (public)
>          Name: elitebook
>          Alias: elitebook
>          Class: 0x001c010c
>          Icon: computer
>          Paired: yes
>          Trusted: yes
>          Blocked: no
>          Connected: yes
>          LegacyPairing: no
>          UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9=
b34fb)
>          UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9=
b34fb)
>          UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9=
b34fb)
>          UUID: Headset                   (00001108-0000-1000-8000-00805f9=
b34fb)
>          UUID: Audio Source              (0000110a-0000-1000-8000-00805f9=
b34fb)
>          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9=
b34fb)
>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9=
b34fb)
>          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9=
b34fb)
>          UUID: Headset AG                (00001112-0000-1000-8000-00805f9=
b34fb)
>          UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9=
b34fb)
>          UUID: Message Access Server     (00001132-0000-1000-8000-00805f9=
b34fb)
>          UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9=
b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9=
b34fb)
>          UUID: Vendor specific           (00005005-0000-1000-8000-0002ee0=
00001)
>          Modalias: usb:v1D6Bp0246d0532
>
> I decided to test GATT. On elitebook I started:
> ./test/example-gatt-server
> and waited to let matebook refresh all info.
>
> After that I got:
>
> [elitebook]# info 20:16:B9:D8:A9:3B
> Device 20:16:B9:D8:A9:3B (public)
>          Name: elitebook
>          Alias: elitebook
>          Class: 0x001c010c
>          Icon: computer
>          Paired: yes
>          Trusted: yes
>          Blocked: no
>          Connected: yes
>          LegacyPairing: no
>          UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9=
b34fb)
>          UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9=
b34fb)
>          UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9=
b34fb)
>          UUID: Headset                   (00001108-0000-1000-8000-00805f9=
b34fb)
>          UUID: Audio Source              (0000110a-0000-1000-8000-00805f9=
b34fb)
>          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9=
b34fb)
>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9=
b34fb)
>          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9=
b34fb)
>          UUID: Headset AG                (00001112-0000-1000-8000-00805f9=
b34fb)
>          UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9=
b34fb)
>          UUID: Message Access Server     (00001132-0000-1000-8000-00805f9=
b34fb)
>          UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9=
b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9=
b34fb)
>          UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9=
b34fb)
>          UUID: Battery Service           (0000180f-0000-1000-8000-00805f9=
b34fb)
>          UUID: Vendor specific           (00005005-0000-1000-8000-0002ee0=
00001)
>          UUID: Vendor specific           (12345678-1234-5678-1234-56789ab=
cdef0)
>          Modalias: usb:v1D6Bp0246d0532
>
> That seems all correct for now. Test example-gatt-server registers
> Heart Rate, Battery & Test services. All of them appeared as expected.
>
> My problem is that I can't list GATT attributes. I don't any output.
> Is there anything I'm doing incorrectly?
>
> [elitebook]# menu gatt
> Menu gatt:
> Available commands:
> -------------------
> list-attributes [dev]                             List attributes
> select-attribute <attribute/UUID>                 Select attribute
> attribute-info [attribute/UUID]                   Select attribute
> read [offset]                                     Read attribute value
> write <data=3Dxx xx ...> [offset]                   Write attribute value
> acquire-write                                     Acquire Write file desc=
riptor
> release-write                                     Release Write file desc=
riptor
> acquire-notify                                    Acquire Notify file des=
criptor
> release-notify                                    Release Notify file des=
criptor
> notify <on/off>                                   Notify attribute value
> register-application [UUID ...]                   Register profile to con=
nect
> unregister-application                            Unregister profile
> register-service <UUID>                           Register application se=
rvice.
> unregister-service <UUID/object>                  Unregister application =
service
> register-includes <UUID>                          Register as Included se=
rvice in.
> unregister-includes <Service-UUID><Inc-UUID>      Unregister Included ser=
vice.
> register-characteristic <UUID> <Flags=3Dread,write,notify...>  Register a=
pplication characteristic
> unregister-characteristic <UUID/object>           Unregister application =
characteristic
> register-descriptor <UUID> <Flags=3Dread,write...>  Register application =
descriptor
> unregister-descriptor <UUID/object>               Unregister application =
descriptor
> back                                              Return to main menu
> version                                           Display version
> quit                                              Quit program
> exit                                              Quit program
> help                                              Display help about this=
 program
> export                                            Print evironment variab=
les
> [elitebook]# list-attributes
> [elitebook]# list-attributes 20:16:B9:D8:A9:3B

I guess what you are looking for is list-attributes local though that
only works for service register by bluetoothctl itself not by other
applications, those objects are normally accessible to bluetoothd only
and we don't expose objects from other application.
--=20
Luiz Augusto von Dentz

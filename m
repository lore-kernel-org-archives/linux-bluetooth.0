Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B4DC282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00DF2085A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la+oXgOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfAWR1W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:27:22 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:36317 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWR1W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:27:22 -0500
Received: by mail-it1-f177.google.com with SMTP id c9so299233itj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qejEDzE6KFDgrKR6Sommv4XJ2ZOUIt3hYRN1vZq60AA=;
        b=la+oXgOvJQv2j3lpS+NA7N3NvJopY7P6nD/3arCU/zHnKvIy2CyWqwxiSFy/0Zpg6r
         xEuePBOUm8tv8ZoCiNfDn9LOK1xAHqZcxKiOEyW7Kwl9Sb1ApwynxUpboOV4rQigAWAo
         gapQodg3VMdNG4mayCPBkDbpzKn6MHu6KqUO5/KTqy2mK0W2cJzpnfOASdoGt2nXQ9Si
         b+5mQGtTGSb9Dhe7Q7AHDJXor50N7t4ZBwsHxcVY/Nabx0Y4OTEeu/PYazMiokr3UHeI
         zks1LCAP7FigTjYGcIMAzoPi0696NugLs99Com7TjvoOuQTfAvQz6Tg0HKqnJZ6EtFf0
         QUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qejEDzE6KFDgrKR6Sommv4XJ2ZOUIt3hYRN1vZq60AA=;
        b=nhMkJP7QUWlMrQBhRObWwz0tACbOwhaN3L/RZg1ZBlEow45u7KffxlcYNLGS2FP027
         jvl5vnxQ2tbz/eGg4TkojA0aBqfHK4T8EoY/ooVKBQ/6Ea+ccyh9KujA7yYNAS4YiqIV
         OezmC9Z+d7tB2jAJBLQ4Mt/y/wWCyhxsYTdYlfKVbM+XRIXNqqSe1HI4asMRixjURljT
         RKZ/5OYNqj+ke+Zc2tJN/n8Lt5DFsV6INfSqpBMV8JQDFDcI8eHZK9LjFy9V8fIZUDSw
         XiMCvtX6AEqMIixUSMlq5j6TIzoMlC2FtXaUqUHBL/tCT0X9DLsCNqtiB9B3GYKTnZry
         gu3w==
X-Gm-Message-State: AJcUukd9Z/QVl0ek7iObSEm4jiRVMU64VIim1o9OqZMwySBbacAkHbsM
        wXHrAMR9wqBRqlLpDM6vVdV6IMK6WafjoXryharfJryJ
X-Google-Smtp-Source: ALg8bN4woKHlEJdMWulpe/Rhe3k9PWswKApT/rOi0M6nnz1UJIhg2LYKWvXM2s1EXaaCukyeG731pugeLwV4GD/1G1Y=
X-Received: by 2002:a02:7e5d:: with SMTP id h90mr2122111jac.106.1548264440597;
 Wed, 23 Jan 2019 09:27:20 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupyyrt4_3=1-8rHVoWFAKLX=adE3PopwTfczUCga=4k7gg@mail.gmail.com>
 <CABBYNZ+8Lkf5_f+CwXorUQhtON1hJ-Vyj0cd0QHPHGvUgq3m_A@mail.gmail.com>
In-Reply-To: <CABBYNZ+8Lkf5_f+CwXorUQhtON1hJ-Vyj0cd0QHPHGvUgq3m_A@mail.gmail.com>
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Wed, 23 Jan 2019 20:27:09 +0300
Message-ID: <CAAOqupzg6GN147uofDAyuFLid5QHOns0nkjOw=+=OicV=cezwA@mail.gmail.com>
Subject: Re: Battery level of energy
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It has such info:

[MDR-XB650BT]# info 00:18:09:C5:44:1E
Device 00:18:09:C5:44:1E
Name: MDR-XB650BT
Alias: MDR-XB650BT
Class: 0x240404
Icon: audio-card
Paired: yes
Trusted: yes
Blocked: no
Connected: yes
LegacyPairing: no
UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)

PS. Luiz, sorry for the direct copy!

=D1=81=D1=80, 23 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 20:04, Luiz August=
o von Dentz <luiz.dentz@gmail.com>:
>
> Hi Grigory,
> On Wed, Jan 23, 2019 at 6:22 PM Grigory Fateyev <gfborn@gmail.com> wrote:
> >
> > Hello!
> >
> > I have a bluetooth headset Sony MDR-XB650BT.
> >
> > # hcitool info 00:18:09:C5:44:1E
> > Requesting information ...
> > BD Address:  00:18:09:C5:44:1E
> > OUI Company: CRESYN (00-18-09)
> > Device Name: MDR-XB650BT
> > LMP Version: 4.0 (0x6) LMP Subversion: 0x2576
> > Manufacturer: Cambridge Silicon Radio (10)
> > Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
> > <3-slot packets> <5-slot packets> <encryption> <slot offset>
> > <timing accuracy> <role switch> <hold mode> <sniff mode>
> > <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
> > <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
> > <power control> <transparent SCO> <broadcast encrypt>
> > <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
> > <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
> > <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
> > <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
> > <sniff subrating> <pause encryption> <AFH cap. master>
> > <AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
> > <3-slot EDR eSCO> <extended inquiry> <simple pairing>
> > <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
> > <EPC> <extended features>
> > Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >
> > I'd like to get the energy level at least in shell. In which direction
> > I should look for? How to know if my device has GATT support? If it
> > connected with Android smartphone, where Android version is < 6.0, it
> > has an icon with level in percents. I want to get the same on my linux
> > machine.
>
> bluetoothd should be able to detect if there is a battery service,
> well at least if you are connect over LE, note that in past there
> exists ways to fetch the battery level of AVRCP and HFP via AT
> commands, so perhaps Android is using one of those, btw you should be
> able to see what bluetoothd has discover with:
>
> bluetoothctl> info <bdaddr>
>
> > Thank you!
> >
> > --
> > Grigory
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Grigory

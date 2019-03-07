Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B6C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 08:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ADC20675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8EruywA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfCGINp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:13:45 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40662 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGINp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 03:13:45 -0500
Received: by mail-ot1-f52.google.com with SMTP id v20so13339351otk.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2019 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4+KIUqaMF38+psYgDFe/FIGFxe9nu3lNvyWv0Quicw=;
        b=J8EruywAnjJ7orhBiByucOvXQhmGJCFPlXDJDD+wTny0Fln1h+Lj1UGT1PBBo7a0WO
         svmUzb6HzeoxbCuB3FwhzSCYjkx+elzb0sHbzl63MWpY9FnyKZvJFGdS9ObCRdwzYQQ8
         +GdH+aF8xCSKsL7TKz5NEwArJoiG2+D+WpcpFc/0SAhUPaXpaFvT4oghTb/cvmpTEdJF
         FwjQ4tNY3DRKaNZPUeisy9vy/EO0nPKb+qHlirznYFKJ0d76RTByA+MvmsVTRrbsygi+
         ABf/oNhs5/NNpxDq0W22EhH3E8zxQnD+IfzQ9c6q2iCQHG1YLnxOv4RcsucrnGyPOJn2
         i7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4+KIUqaMF38+psYgDFe/FIGFxe9nu3lNvyWv0Quicw=;
        b=G45OW+NUAAkDLktu7exZu02sCgMhxiTFlhC26VP6IU/TzLRBnLWm3xwZGWDaRO5Cur
         BLnSnGyxG03T+dJs0YfBfMu17esJrNBKCxysHlnN4h3zkp22cHTbwi18jClsfeFPXmMJ
         K67ZGCnbnwDUsoxcetl95Ow229Mtmx0QtVFtYW5yVAvv131x7Ic2Gwh9SBSFR4V6nY+B
         eH89V5ZDMQiYP8M+SBpdbUwb1Gk5662ICtRuawWm/cGEkaIs8W0yfknPXicXIBAmzEp9
         Y6ULonzygyZu0VKChGnDM73Eciw7glo8EAWqJzvMBU30hqTqJXBnNFQVlN1MwCzO78HK
         09jA==
X-Gm-Message-State: APjAAAXwpKBDCUdwfFAPx6Q9l/hUeun8IjjsdRf/W2Ff6v79HY+bYKXA
        qeSKGrub904xzNq8eX2T0GIwvXgTyNkGNDk9YrvHyR8gzPU=
X-Google-Smtp-Source: APXvYqw+pD0ewYUsn1e/7rrUGqJTT8dV9Han8gXffd49nk6N6uqtiqIs4vq0MuGsUJldi/XE5qa2OrI/aKD0/OOPKFQ=
X-Received: by 2002:a05:6830:1543:: with SMTP id l3mr7473713otp.84.1551946423782;
 Thu, 07 Mar 2019 00:13:43 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR03MB5076E7A27AB448DE6E97B248CE730@AM0PR03MB5076.eurprd03.prod.outlook.com>
In-Reply-To: <AM0PR03MB5076E7A27AB448DE6E97B248CE730@AM0PR03MB5076.eurprd03.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 Mar 2019 10:13:31 +0200
Message-ID: <CABBYNZJV3WWZ6WkNrQpfRhNjL_NCVOB0BXmXZMgHnV=DMA0=yg@mail.gmail.com>
Subject: Re: iBeacon with the dbus advertising-api
To:     Marco Okker <marco@epesi.nl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marco,
On Wed, Mar 6, 2019 at 5:53 PM Marco Okker <marco@epesi.nl> wrote:
>
> Dear Bluez advertising-api developers,
>
> I got a problem with the advertising-api. It seems to be impossible to make an iBeacon advertisement with the api.
> I know it can be done with my bluetooth module because it is possible with the hcitool*.
>
> An iBeacon sends the following at the start of an advertisement: 0x0201061aff4c000215.
>
> With the advertising-api I am able to advertise a big part of the iBeacon(with the manufacturer data property):
> 0x1AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC
>
> If I modify the bluetooth config(/etc/bluetooth/main.conf) setting "ControllerMode = le"  it will add  0x020104 to the packet(this is the closest I got to an iBeacon):
> 0x0201041AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC
>
> However I can't make the api advertise the following(the most important part at the start of the advertisement(0x020106) can't be done):
> 0x0201061AFF4C0002155E2B092544064DFEB06D66D7AFB0F84C59659D46AC
>
> I have tried all properties of the advertising-api, none of them seem to be able to add "0x020106" at the start of the advertisement.

So this is about the so called flags (ad type 0x01), you want it to be
set as 0x06, as opposed to 0x04, which is:

bit 1: LE General Discoveral Mode
bit 2: BR/EDR not Supported

I don't think the BR/EDR bit really matter so I guess all you need is
to switch the discoverable mode, which you can do as follow:

bluetoothctl> power on
bluetoothctl> advertise.discoverable on
bluetoothctl> advertise.manufacturer 0x004c [data...]
bluetoothctl> advertise on

@ MGMT Command: Add Advertising (0x003e) plen 19
        Instance: 1
        Flags: 0x00000001
          Switch into Connectable mode
        Duration: 0
        Timeout: 0
        Advertising data length: 8
        Company: Apple, Inc. (76)
        Flags: 0x02
          LE General Discoverable Mode
        Scan response length: 0

If the implementation is really pedantic about the BR/EDR flag then
you should probably attempt to enable it by setting ControllerMode =
le. If discoverable is not set perhaps you have an old version of
bluetoothd which don't have support for it, but as I show you above it
is possible to for Discoverable mode though that means the
advertisement would work as peripheral role since broadcast cannot
have flags:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/advertising.c#n1030

> To summarize, my question is:
> Can you modify the dbus advertising-api of Bluez so that it is possible to advertise an iBeacon?
>
> Greetings,
> Marco
>
> * hcitool example:
> ############################ 02 01 06 1A FF 4C 00 02 15 # Apple's fixed iBeacon advertising prefix
> hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 FB 0B 57 A2 82 28 44 CD 91 3A 94 A1 22 BA 12
> (Source: https://en.wikipedia.org/wiki/IBeacon)



-- 
Luiz Augusto von Dentz

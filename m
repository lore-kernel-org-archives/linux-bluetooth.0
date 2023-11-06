Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658EBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 16:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjKFQJk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 11:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFQJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 11:09:39 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600871BF
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 08:09:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso62661421fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Nov 2023 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699286974; x=1699891774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3IzhyZfTMO80XWT6eTLoTLHd1t1sTT/+n11RfwaQBw=;
        b=kCjUomipC4KJe0F29aZSvugZ22qS0LoQi/ENNbgIdF5anN53OSKRi5ckWzOVbur3kF
         bLicQrvAWV7xQH9wkWM6rZ4Li1R03iVAwGYwPxRAPAeXXj2Du7tiEC6GKEm/tI+NUljA
         vaq+DRrk0Z6CkoXFdQu4gtqxAx3CdQit33aFFDujSSuMJZzwyLrghWq9LdLJ0aqZRiTc
         8kicG8H2097fRpdfSlgB8DIbXw3+HmAkZEipU9pmVX2WOfAbGO8rMuXqBZRMzZ8YBlCj
         ILz3mmr+04hDbFNmqyzRgLwP+pcd/d3Yui2Ul+9AQEcOgJb6dQGOgAD7ZVZLSW9lPXz3
         beTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286974; x=1699891774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3IzhyZfTMO80XWT6eTLoTLHd1t1sTT/+n11RfwaQBw=;
        b=wGQYZWslzKfHraX+5syXAgZoLWq4z9yEY/UFLJDV8gznx+nD0YDbRsqUGMIznzZ0kg
         yWLEB4QVEZdOm8eVJRKpMglaL823Hpjhpy9Y+3EvNSXyBYS8FJygKKu+hc3yHuLeFPlA
         yhIleCpF+4ktUEC1pKXGm0RPgSpbfCxhhsbH7FvRPV3dATwFOcOpCLRJSI1ZpKgMoQco
         FzcR9yixlFn2zmFu6MCdgA1Z7aCo5/WKrSnZ+N9qkQWteJbhcpVU5Fhy562JRhYGARua
         N10XquehNhh8qvTbRTx/6Khtn/sqoh9xCnGPNfUGwZ0DJz5lVr/m63HsFuwwpaOm66ax
         MC/Q==
X-Gm-Message-State: AOJu0Yw1yI6VsUk7ujI/+jcegk/Ty68QRTZElJZjwHJKMhlHry1o7Hnb
        ohfXgCoQ0RCtI4sNF4Q4/AEbtKecD0Ma16eWSIOJJ49PUyv01g==
X-Google-Smtp-Source: AGHT+IHSM69AaPPjoUd+LuXymlWWikbR7UFhRhkS7NRlWD76wgglOOebyhoiUehnLJI/jS330VR8yymlNMw7heLiX+s=
X-Received: by 2002:a2e:9d08:0:b0:2c7:610:2dd1 with SMTP id
 t8-20020a2e9d08000000b002c706102dd1mr6450247lji.47.1699286974269; Mon, 06 Nov
 2023 08:09:34 -0800 (PST)
MIME-Version: 1.0
References: <c0df9d614f2a220bc93227eafcc68f73f1751528.camel@hadess.net>
In-Reply-To: <c0df9d614f2a220bc93227eafcc68f73f1751528.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Nov 2023 11:09:23 -0500
Message-ID: <CABBYNZJZrS1ZcGusfraLkUXwQvD98Zs5md5cXQRRu30ggstKxg@mail.gmail.com>
Subject: Re: Using Laird Connectivity Bluetooth LE PTS dongle with Linux
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Mon, Nov 6, 2023 at 9:35=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Hey,
>
> I bought the Laird Connectivity Bluetooth LE-only PTS dongle listed on:
> https://support.bluetooth.com/hc/en-us/articles/360049018492-What-is-the-=
difference-between-the-Profile-Tuning-Suite-PTS-Dongles-
> as I was hoping to have an easy to use Bluetooth LE only device for testi=
ng.

Never tried this one, the dual-mode should work though.

> But the device only shows up as a serial device under kernel 6.5 from
> my distribution.
>
> Is there anything specific that needs to be done for that device to be
> usable as a Bluetooth adapter under Linux? Or does it only work with
> the PTS?
>
> I spotted the ability to run specific software on the micro-controller
> itself when powered on, but nothing specific to using it as an adapter:
> http://assets.lairdtech.com/home/brandworld/files/BL654%20USB%20Dongle%20=
User%20Guide%20v1_0.pdf
>
> Full lsusb output for that device:
> Bus 001 Device 018: ID 1915:521f Nordic Semiconductor ASA Nordic Open
> DFU Bootloader
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1915 Nordic Semiconductor ASA
>   idProduct          0x521f
>   bcdDevice            1.00
>   iManufacturer           1 Laird Connectivity
>   iProduct                2 Nordic Open DFU Bootloader
>   iSerial                 3 E1BB9211FA41
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x004b
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          4 Default configuration
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower              100mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         2
>       bFunctionClass          2 Communications
>       bFunctionSubClass       2 Abstract (modem)
>       bFunctionProtocol       0
>       iFunction               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         2 Communications
>       bInterfaceSubClass      2 Abstract (modem)
>       bInterfaceProtocol      0
>       iInterface              0
>       CDC Header:
>         bcdCDC               1.10
>       CDC Call Management:
>         bmCapabilities       0x03
>           call management
>           use DataInterface
>         bDataInterface          1
>       CDC ACM:
>         bmCapabilities       0x02
>           line coding and serial state
>       CDC Union:
>         bMasterInterface        0
>         bSlaveInterface         1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval              16
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass        10 CDC Data
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> Device Status:     0x0001
>   Self Powered

If it is from Nordic you might want to check if it runs Zephyr on it,
perhaps there is some special command needed to switch to standard USB
Bluetooth Class.

> Cheers



--=20
Luiz Augusto von Dentz

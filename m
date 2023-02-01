Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A03C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBAVhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAVhy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 16:37:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DA3D0BD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 13:37:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi36so44917lfb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfP98jHx4mNOIZmWNeQxO8fp3OiQCCZsltXblMpcgQ4=;
        b=kNBhSPr+QaFHKvKoew7lzg5XFMjR91LOnvLSd8sjM6FPPFS0/bsr7Rtbxhj/jZ0kZd
         7xM7TK+b1Mogbw/Kl6yfAEb8K4jAygFdIm1c7xOtIQfqCkWexwAxUSUkuYY3TeyN5I+y
         zVai/SCz7hkzSmtfbiFG/wYxW/h3Dv42nQBIsf1GcM3uJ/HONYU2FeZt7Sq/GMO5Ej+g
         mV8v+pQg9wPb2EwQV4QZr4wCSxTNcG+oyxFHEG3ZdTtXgbHz3JVGr3h5+EDmQ9Jsml10
         9Bm1fiiBo1vZvtxMnQoCRly3dIufZKTRGbJAsqbhjNIFWE4Ka3TkLqUvd5FvnSeGAa1b
         kOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfP98jHx4mNOIZmWNeQxO8fp3OiQCCZsltXblMpcgQ4=;
        b=6sxnIdZGxa4qDqdsrwvLwzo419gU0kq6nBoQlga966Xph5neGoda3oK6D1IIyVbIaW
         jgH6r9+ie29jAHE+3soXTdzubIgK+TuUw60wg1Ck/4LadK2NW5UwDbB2gsrHJ2MzSK2I
         Chv9uRFY8DPah3E2CEcw7/KTJonxFBnUAQbbBifoUhXhLXOzWxG/NhNflsO2wdN40g3j
         5qJ+qRGRl+WumLQmQnyX9zb59FOPZACr7YiQhWO2NaaMMtquFHPS3z7bOw7TkkhJwEn5
         8yKh7NUIN3G+9EVcMTxOoM7cAZaXzbmyMQvHzmR/oaSfZBU8lYnF/0iJPFZyb/p2DUh0
         kkmw==
X-Gm-Message-State: AO0yUKVMkMphXlSTviWsLaj9EPzdxVsA4/xV2tAvDFuhGRFpGH8qppj9
        mPezH8g58HPvPevKElAIyr9fqgsIRAIJW4t7EAWhLvNJVwM=
X-Google-Smtp-Source: AK7set+AnJ1rypGEvIzb5yY53m2NgMhOwOD2D2/eaNBOh3r7n6BfvpTvoM5hO/uAAbjlSGqO38hca8+s20o2k8wdDbA=
X-Received: by 2002:a05:6512:799:b0:4d5:aef9:daa2 with SMTP id
 x25-20020a056512079900b004d5aef9daa2mr686817lfr.271.1675287471088; Wed, 01
 Feb 2023 13:37:51 -0800 (PST)
MIME-Version: 1.0
References: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
In-Reply-To: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Feb 2023 13:37:39 -0800
Message-ID: <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
Subject: Re: How to Automatically Re-Connect Bluetooth HID over GATT (HOG)
 Device when BlueZ Plugin "hog" is Disabled
To:     Martin Petzold <martin.petzold@tavla.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,

On Wed, Feb 1, 2023 at 1:25 PM Martin Petzold <martin.petzold@tavla.de> wrote:
>
> Hi,
>
> Linux 5.10, BlueZ 5.55
>
> I have a remote control which implements Bluetooth LE. If I use the
> default Bluetooth daemon, I am able to pair and trust using
> bluetoothctl. If the connection is lost after a while (or days) and a
> button on the remote control is pressed, the daemon re-connects
> automatically (because the device is paired). This is basically what I need.
>
> But, I would also like to manually set notifying for characteristics
> (Report) on the HID service within my application (Java via d-bus). This
> is not possible anymore (also not via bluetoothctl) because the "hog"
> (or "input") plugin manages the input device and the related HID
> services are now hidden.
>
> I then added "--noplugin=input,hog" to my Bluetooth daemon. Which is
> okay, because I don't need this support for Kernel HID. Great, now the
> HID services are available (also using bluetoothctl), but the peripheral
> does not re-connect automatically any more. I always have to connect
> manually first. I also have no signal on the d-bus when I press the
> button of the remote control, when it is disconnected.
>
> How can I enable automatic re-connect for devices, when these plugins
> are disabled?
>
> The only other way I was thinking of is to leave the "hog" plugin
> enabled and use the operating system HID interface. However, my
> application runs as non-root which makes it complicated and also I would
> like to have direct connection and control to my device.

https://github.com/bluez/bluez/blob/master/doc/gatt-api.txt#L390

> Thanks,
>
> Martin
>


-- 
Luiz Augusto von Dentz

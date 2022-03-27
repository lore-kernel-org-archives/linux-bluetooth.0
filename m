Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85763C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Mar 2022 23:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiC0XB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Mar 2022 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiC0XB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Mar 2022 19:01:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9D3FDAC
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Mar 2022 16:00:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so21868278lfg.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Mar 2022 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=1sQf1rNs1syspLdjDy0GyfYQAjqoEXaLo2hVeYGo3ZM=;
        b=BDrpZlkCuCoTWunz06nkZP11Dzg4IjluGHwkNY/7nu+4ehQekNm5kD11hpZEX/r8Qw
         OwUIXaQAfWhId5aYIXeIuUwmyQ4hS3eNrCi/KIcyRgqfJ3vvHNGzJoHtI4ogTtYGF3zv
         w8QGQtSKQhWGMiuBbcgEj+0u/LrI8V2EFpPFWwRiMyk5Limgg4MOy3+fjhM4/ieeaQfo
         8jbnIA2xCvqiKkIvGG4jM+rAgwCfN9rJXWj0CV71/I+h88hxbaIsfhOyH7mMut8CVNJ7
         A/H//hu+R0i5dNh9f+98KVDTJWHQFxXxYK0KhcKYT2mjXm02vgNwpkxoz3DRk4W5FLGV
         /Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=1sQf1rNs1syspLdjDy0GyfYQAjqoEXaLo2hVeYGo3ZM=;
        b=zlQAAs8LSXwCjGd6XQSrtQbpopgHgXH6vkoadH8Jr2eTjnJPXBwGn2fqDcx0Aq8hZI
         qW0N6+IUwfQa+U0LinTwZaPEbnTqsUD3a7S+MvVvHJ16KD/z8dxnGyWi5Z3seXr5GEoH
         o2R3ApP/9z/JUz/eLCYJgc6OZfuvC8pq6bPI5ZNftwkTfM6xTw26s2v3F/rORiuBp9O3
         AC+IT4EVm4NBAN2fuxEx8t0TSrgXxwp0ahFf/Wxm1flP9b/VMXVqdrcNlpbkkd8zeFVJ
         odFGYfH+AaOea586NVeDdPCpxnOO0aqKI9LBdUKV1bzxdjSt5nIIMuSv4proy1bIv78m
         antA==
X-Gm-Message-State: AOAM532cpm1RuGY+tKYhzcQrzkK3pQVrSBamDr3zrJmaj1Y3uPJ4KDZq
        AErW8YHPNKt7rUc8nBdO/rfaNkBemIhUxVZV
X-Google-Smtp-Source: ABdhPJw4iF0LNUzbH2uFCGyBJ7NtLzxTLnkVzSXJN278FhqUPTFXDAS4fXDndBMSQ8qIOhyrNPyIbQ==
X-Received: by 2002:ac2:43bb:0:b0:44a:1ee6:8c12 with SMTP id t27-20020ac243bb000000b0044a1ee68c12mr17418974lfl.683.1648422015827;
        Sun, 27 Mar 2022 16:00:15 -0700 (PDT)
Received: from [192.168.0.237] (91-159-86-107.elisa-laajakaista.fi. [91.159.86.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a2eb4a4000000b0024985ed51cdsm1555158ljm.114.2022.03.27.16.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 16:00:15 -0700 (PDT)
Message-ID: <1d7c168025a11b9c4d3e88f69ae0afdde77a2cd5.camel@gmail.com>
Subject: Re: [PATCH BlueZ] sixaxis: Fix Sony Navigation Controller pairing
From:   Jesse Pullinen <jesse12p@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 28 Mar 2022 02:00:41 +0300
In-Reply-To: <CABBYNZK9M8SC_01kuTUZ+d9kZ0hAWxx=pagrY1J3D01Umv+5TA@mail.gmail.com>
References: <20220314020245.135251-1-jesse12p@gmail.com>
         <CABBYNZK9M8SC_01kuTUZ+d9kZ0hAWxx=pagrY1J3D01Umv+5TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.43.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

sorry it took me this long to answer.

On Monday, 2022-03-14 15:11 -0700, Luiz Augusto von Dentz wrote:
> Actually shouldn't we try to have another call to get_pairing if it
> returns NULL to a specific name? That way the pid/vid is used as
> fallback if the name doesn't match since the name perhaps can be set
> by the user, or with a firmware update.

This could work, but I think the names should be fixed anyway, or the
USB HID name could be used as the Bluetooth device name which was one
of the ideas in the discussion https://github.com/bluez/bluez/issues/46
("SHANWAN PS3 GamePad - vibration issue when connected wirelessly")
which resulted in the commit 61745d2bb8b5f534278db49faf8e2cdb7e894529
("sixaxis: Fix Bluetooth PS3 clone joypad being named like the
original") so that the kernel detects the device and applies a quirk.

I think using the same name for USB and Bluetooth would be better as it
is more consistent and then the quirks in the kernel would be applied
correctly. There is already one other name detected in the kernel which
is not in the device list here.

I don't think the devices have a changeable HID name, but if they do
then the kernel would't recognize the changed name and wouldn't apply
the quirk. If it was changed in a firmware update, it would then need
to be changed here and in the kernel if quirky, unless the USB HID name
was used which would mean only the kernel would need the change.

I think I have some clone controller(s) somewhere so maybe I can
experiment with this more later.

TL;DR;

Some of the device names are wrong and then either of these should fix
the issue:
* Try matching without name if matching with name did not work and keep
adding new devices which need quirks or
* use the USB HID name as the Bluetooth device name and then only the
kernel needs to be modified to support quirky devices.

-Jesse


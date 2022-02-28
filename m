Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiB1SkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbiB1SkO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 13:40:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8502B18B4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:31:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx21so26594956ejb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDcn13bPQCr8cHPRRpNhcxUoS2UoplOHFj2nUV/6fkM=;
        b=SXucrCHuNJwoev+QNfisOQUAyyevzH/uoW/ETF/+OP9ksgUvWW6UBKqknhBNegk59t
         B8zZISvS3a0mhaCp6PWWjBP/OqPF/KJCzb53Jasu/2gwwpAMrbSt1mw4auIMP5ZTZUdU
         jeuSPRACK9d5LCyhHkRkaW/xsbFeVDtPPLQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDcn13bPQCr8cHPRRpNhcxUoS2UoplOHFj2nUV/6fkM=;
        b=1xMutrBalXd+Vx0u1k4Nx7Hgh1Ke9Y8F/mZXZ3hqPRYo+mnfXHhV7brMloYdxyrMYa
         hb9W1M22cTcNm33EetUzpSG4ymMLDT+YV2I9n9hNR8AOT2SiU56uyIBFkz0zh62fnkBM
         bNgabvvW8vyDZGIXkF94N+lMrXrH4+LVhifQqWqHnZuvdy9I6NsYbaCMoJvraNjaRsMi
         V+bBa18kDL3iqbBcfNgRBXsDZep8loj654NmP5RfLhd70qZE+cULQ3VAd1cwj+LhZIqu
         3NNeO/JHKTFr588ubuvbGvZHOwLkZzQ8gUpEcVAelm5Yi3Fe3yhWA9lKf2rUuPEKQB7u
         Sj9Q==
X-Gm-Message-State: AOAM532ryyKGopbTnaohWql5LImX71z7IVL0f7qNPDA1y3vrmew0ypS4
        I1S0j5ZqjbZZPCjVNWjUuz9FI80WTsGXbg==
X-Google-Smtp-Source: ABdhPJzQdZNj9+da+zohqcc13uqfIKmgRP67mZajoXmSKFhKb5PyIunJu23p7rqpqwTP2eARRthUWA==
X-Received: by 2002:a17:906:2c12:b0:6ce:88f7:474a with SMTP id e18-20020a1709062c1200b006ce88f7474amr15594242ejh.166.1646073092000;
        Mon, 28 Feb 2022 10:31:32 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090657d600b006ce3bc743b3sm4523053ejr.60.2022.02.28.10.31.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:31:31 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id p15so26642531ejc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:31:31 -0800 (PST)
X-Received: by 2002:a17:906:2b97:b0:6cd:6d67:ab5d with SMTP id
 m23-20020a1709062b9700b006cd6d67ab5dmr16346152ejg.723.1646073090863; Mon, 28
 Feb 2022 10:31:30 -0800 (PST)
MIME-Version: 1.0
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
In-Reply-To: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 28 Feb 2022 10:31:19 -0800
X-Gmail-Original-Message-ID: <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
Message-ID: <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
Subject: Re: Battery1 vs. GATT reporting
To:     Ed Beroset <beroset@mindspring.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ed,

Your understanding is correct about the purpose of that flag. So I can
confirm that (1) is true. For (2), I can confirm otherwise, since I am
able to get both battery values from GATT API and Battery1 API. Here
is my output:

```
// pair and connect to an LE device with battery service first (e.g an LE Mouse)
// [bluetoothctl]# gatt.list-attributes
// [bluetoothctl]# gatt.select-attribute
/org/bluez/hci0/dev_C6_XX/service000e/char000f

// via GATT API
[BluetoothMouse3600:/service000e/char000f]# gatt.read
Attempting to read /org/bluez/hci0/dev_C6_XX/service000e/char000f
[CHG] Attribute /org/bluez/hci0/dev_C6_XX/service000e/char000f Value:
  4d                                               M
  4d                                               M

// via Battery API
[BluetoothMouse3600:/service000e/char000f]# info
Device C6:XX (random)
        Name: BluetoothMouse3600
        Alias: BluetoothMouse3600
        ...
        Battery Percentage: 0x4e (78)
[BluetoothMouse3600:/service000e/char000f]#
```

Could you try the same with bluetoothctl and share the output?

On Mon, Feb 28, 2022 at 6:20 AM Ed Beroset <beroset@mindspring.com> wrote:
>
> In
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=713f6f09 a
> flag named "external" was added which, if I'm understanding correctly,
> is supposed to mark the Battery1 profile as safe to also share via GATT.
>   However, I was recently working on an application that relies on the
> GATT API for battery power and found that it only seemed to work as
> expected (reporting via both) if I set the flag to false rather than
> true as in the commit.  I looked through the code and it all looks
> correct, but my observation indicates that perhaps the sense of the flag
> is somehow inverted.
>
> Here's the project I was working on, with the relevant bug report.
> https://github.com/AsteroidOS/libasteroid/issues/13
>
> So can someone verify that:
> 1. the interface is intended to be shared via GATT and Battery1
> 2. that it does not work that way today
>
> Ed
>

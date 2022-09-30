Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiI3Tfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiI3TfG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 15:35:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5A3FED6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:34:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x29so5829337ljq.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZNqnBUIhtRaDYhEITGnJjonD6X2ZwwMW/F5xj9vtLW4=;
        b=Uwdv9nidno3l5TSZtjryQrPFWU02PbGK1SMmgp71j1QNCDR4rNeobrTy/a1OS0L/Ss
         FzHiDWB1oaLMXe1GRCLbc06VRpvZlCs7oEIYj/ZNhAHUHhhtnqGqz4mhVRA0XuXxBWrf
         4SAwIRcCe5Rz9yfk6LGzY0ZyzkFJGINeyDu1ELqCpNR5KQTqtFFs5n/M04ZXfwyIYSaS
         gFrPEQXD6qyJFad9rsu8A7/O3c9Jvz/3T+4uj2PeSSwlzTZvFBBKuawWn9V4XV9fEYw/
         d5cAChYLQf7cShqB0UbaRvgos6XfEF04gMvmTFRij3WChQgcSsFfRI48ptGxNXHtL1Mk
         lB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZNqnBUIhtRaDYhEITGnJjonD6X2ZwwMW/F5xj9vtLW4=;
        b=rV0Vc1bTlHqXY3wFjEnpR56dewRaeCWjbUwbZ2i1SDwI432l09Rc0nqdlLyJTgo/EJ
         r5S/Sea7L4rgDA2+OKZoxmVQ77W4enYPvaWEq5GdngabKVefwNsoBTeXOn8z+AQqFDkU
         cD5eCKO29bwNWxG+yHNbUiWN/rA8FmV16/3o52zdoDNoUStqpcimxJ6SP86ztlUH8a70
         +z26j8bdLOZxrNrwkHjw/NqvdK0cjJu2nrh9bmMG2ITaBV46bGaLAXKvcRX/H0fOcOol
         S17DiPNejIbM/KROQa55Xbw/+XAj4v8iWi10LzAj265syzAkQYQqtJ/ZmTKJcUKTze5G
         GFww==
X-Gm-Message-State: ACrzQf1wgnnqutD+1SToGsS5rWDDIAI+/3oVN1tm9pH5qjnG8BaoOmSa
        EE7Q2fT3KIYxYf17F/VwdHxPyEjRtba7M/w13BECDUsh
X-Google-Smtp-Source: AMsMyM4SBhPyP2lf/B6GV33jr3+ktZUaPz3Kz3WN43x0IpfLFe2D2HqRoXkVVaetHRqBeeQGIxsYDLKVMt/TkIbIG9w=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr3092864ljq.305.1664566420266; Fri, 30
 Sep 2022 12:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <1906152.PYKUYFuaPT@n95hx1g2>
In-Reply-To: <1906152.PYKUYFuaPT@n95hx1g2>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Sep 2022 12:33:28 -0700
Message-ID: <CABBYNZKZBmxNK4P+PR-xFcOsDoYPFi8xL12oyYaCGMktirU1vg@mail.gmail.com>
Subject: Re: bluetoothctl: Connecting to a GATT service using BR/EDR
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Fri, Sep 30, 2022 at 12:12 PM Christian Eggers <ceggers@arri.de> wrote:
>
> I am trying to connect to a GATT server using bluetoothctl.
>
> HW: dual mode adapters (server+client)
> SW: bluez-5.65
>
>
> 1st try: "simply connect" (BR/EDR + LE enabled)
> -------------------------------------
> [bluetooth]# connect 5C:F3:70:A3:94:E7
> Attempting to connect to 5C:F3:70:A3:94:E7
> [CHG] Device 5C:F3:70:A3:94:E7 TxPower: 0
> [CHG] Device 5C:F3:70:A3:94:E7 Modalias: usb:v1D6Bp0246d0541
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001823-0000-1000-8000-00805f9b34fb  <-- HTTP Proxy Service
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
> [CHG] Device 72:DF:6C:03:4A:6A RSSI: -81
> [CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: yes
> Failed to connect: org.bluez.Error.NotAvailable br-connection-profile-unavailable
> [CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: no
> [CHG] Device 5C:F3:70:A3:94:E7 Connected: no
>
> ok, it looks I need a profile for making a BR/EDR connection ...
>
>
> 2nd try: register profile beforehand (BR/EDR + LE enabled)
> -------------------------------------
> [bluetooth]# menu gatt
> [bluetooth]# register-application 00001823-0000-1000-8000-00805f9b34fb
> Application registered
> [bluetooth]# menu back
> [bluetooth]# connect 5C:F3:70:A3:94:E7
> Attempting to connect to 5C:F3:70:A3:94:E7
> [CHG] Device 5C:F3:70:A3:94:E7 Connected: yes
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 UUIDs: 00001823-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: yes
> Failed to connect: org.bluez.Error.Failed br-connection-not-supported
> [CHG] Device 5C:F3:70:A3:94:E7 ServicesResolved: no
> [CHG] Device 5C:F3:70:A3:94:E7 Connected: no
>
> Unfortunately the created GATT profile doesn't provide a connect() method ...
>
>
> What is the intended procedure for connecting to a GATT server over
> a BR/EDR link? The "connect" command works fine after disabling BR/EDR
> using btmgmt, but this is not what I wanted.

Connecting over BR/EDR as a central is currently not supported, it
will probably require some changes in order to enable it although the
likes of bt_att/bt_gatt_client shall have proper support for it.

> regards,
> Christian
>
>
>


-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD6C04E30
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 23:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E08020721
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuuGud3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLIX4a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:56:30 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:38277 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfLIX43 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 18:56:29 -0500
Received: by mail-io1-f42.google.com with SMTP id u7so16827692iop.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 15:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5xRbxJUmG9u2zPKNV0wb+TxQmojaTwS4/EUMaO1UzD8=;
        b=LuuGud3C8MCUTplOzoRNjf6hnez96tj0dG4LkB1JiT+45E0dlfoc/Fa7iF+PjC4Uy5
         NmAE2JgXiJun6pokQ6AwQ90fW2d3nZM7T3W3cyj5PdRI4AlFeum1nUfoCtSElJ4re5sg
         1bv6ZUnssIZzuSRcUlTm1qjm1CfjHNoiTz0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5xRbxJUmG9u2zPKNV0wb+TxQmojaTwS4/EUMaO1UzD8=;
        b=cYnZ1/yajV1pERxFnAKgwCLLxKkyH3Lv2KH8DoyizXcPQbXGD9cF+DqMpt9mUWD367
         mwbV8uE72q6LxLeINz+7WgUC9DHFWug2EAWjirJyz5lAl3AL4pUfhiKAYPtAgAPoIhhk
         cjNsIVs1NNOr++HRLlDhf/YUp4WFVy/immQ1QMLRFmfjHS1l2coNnIdG9CKNPXjIvd6P
         xxFxn16/WuFhcVLQ+QgoXRkkTQ0Ii9KZBPQ0ir5JC3lzb5QbdQoXlZjw9t/BNRqoa5+s
         FZCFGpCjbheCFee2k6G5tTxutqQGyhPk+lL8m3AUd9oontn+p/xnXD5Rw4qVYaLEVG56
         4jZA==
X-Gm-Message-State: APjAAAWuP4WgALWbySf2lDDLB6fBVGZfHZaNGfLrRIlpdo1UeSCRSIiY
        9A1OiR4Fr5jPHImA9HAv2ZdknGE7UBk=
X-Google-Smtp-Source: APXvYqxDmwjTPm5+xSCF3397knSdPJzxYETghQZxRY32KVOskz7WMK9/QQ5k38o0QNca/2PvjlMVtQ==
X-Received: by 2002:a6b:d912:: with SMTP id r18mr22413074ioc.306.1575935788755;
        Mon, 09 Dec 2019 15:56:28 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id v72sm313749ili.22.2019.12.09.15.56.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 15:56:27 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id p8so14416448iln.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 15:56:26 -0800 (PST)
X-Received: by 2002:a92:1547:: with SMTP id v68mr29151553ilk.58.1575935786525;
 Mon, 09 Dec 2019 15:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20191127223909.253873-1-abhishekpandit@chromium.org>
 <20191127223909.253873-2-abhishekpandit@chromium.org> <61639BAF-5AA0-4264-906F-E24E2A30088D@holtmann.org>
 <1788857.Va9C3Z3akr@diego>
In-Reply-To: <1788857.Va9C3Z3akr@diego>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Dec 2019 15:56:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xdrw1FC=DktQ8HjdEJcCKvdA3sx78gg-rn8=bBq=WrEw@mail.gmail.com>
Message-ID: <CAD=FV=Xdrw1FC=DktQ8HjdEJcCKvdA3sx78gg-rn8=bBq=WrEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Dec 8, 2019 at 4:03 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 9. Dezember 2019, 00:48:31 CET schrieb Marcel Holtmann:
> > > This enables the Broadcom uart bluetooth driver on uart0 and gives it
> > > ownership of its gpios. In order to use this, you must enable the
> > > following kconfig options:
> > > - CONFIG_BT_HCIUART_BCM
> > > - CONFIG_SERIAL_DEV
> > >
> > > This is applicable to rk3288-veyron series boards that use the bcm435=
40
> > > wifi+bt chips.
> > >
> > > As part of this change, also refactor the pinctrl across the various
> > > boards. All the boards using broadcom bluetooth shouldn't touch the
> > > bt_dev_wake pin.
> >
> > so have these changes being merged?
>
> not yet
>
> Doug wanted to give a Reviewed-by, once the underlying bluetooth
> changes got merged - not sure what the status is though.

I have been out for the last week and am a bit backlogged.

I notice that this landed in our 4.19 kernel with +Matthias's
Reviewed-by at <https://crrev.com/c/1772261>.  I don't feel any need
to re-review this myself if Matthias has taken a final look on it, so
unless he knows a reason why it shouldn't land then I'd say go ahead
and land it.

-Doug

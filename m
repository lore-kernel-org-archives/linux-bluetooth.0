Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4832EC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EC923AC0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 02:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbhAOCSc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbhAOCSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 21:18:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A8C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 18:17:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so10978919lfd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 18:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OLvsqob8gOgwBOBtOEKmXzO4XSLk9vifSK1jnM6SXWQ=;
        b=iAmL3yZ12K+1umXIme+9d6pyVBuYw0+7Qci2p0F9FnemqeMn70Z656nT3O0/hrbj65
         +5fntniLlwU4JjUd7qoPZqLzrTOOvsWhRkYnRtbeJKMP6D9JtUOLWO7PQEPBtZUb6bl+
         fTYJNm/EasTY1fvURJYFC1PtfjqxcNWdkzbF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OLvsqob8gOgwBOBtOEKmXzO4XSLk9vifSK1jnM6SXWQ=;
        b=qtrwe+szR/CFrIocGSmaSV10XDx2SelEzvNGdAKdMDJwgCI7r3vMha03xum2yR7eDa
         k6NLolJmqRPUpW2MvXiTC5Xj8vIVrKnIYDzJ78Cr38R/kx2S9AqSTeMU6Kbo4JRz+O2d
         52tU3tzf3U7r1OILaV/6teeJPlshGSPa7QT2QGKzWRbo/vwNl7zwN8xG4QpogITuDEZs
         73UPSXofu76vNU9oVDeT2V0XeDyQ/PVUFEiRAsOwJ1fTXvnd6UMFlVO9yrJOfYTjx41m
         +x3IbW6KdbbP2L57bRKaFx3MNqwgcUykL79ZPp+m2MeGTzqAhmfVskHjuFG9/L6pILFQ
         5jqg==
X-Gm-Message-State: AOAM530x08rlE46lumM1i+h6tBncwngdN+dsGD7sNk2/txYeX2e9PDSN
        A2Yo9jlCEK3aU4gDSgCzII91SwsPjg48PA3TyCfHcg==
X-Google-Smtp-Source: ABdhPJzjLdE0amD9P9lX5QeaeyPYNjANVjXxPVPlbMMtXVQ/OslHi8HhJP7W7Vda6PWHKoJct+d2EJyRYSv2brjAzEA=
X-Received: by 2002:a05:6512:944:: with SMTP id u4mr4626838lft.433.1610677069441;
 Thu, 14 Jan 2021 18:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
 <7B6FEB99-5102-4A67-986C-4A5DEFDE2166@holtmann.org>
In-Reply-To: <7B6FEB99-5102-4A67-986C-4A5DEFDE2166@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 14 Jan 2021 18:17:38 -0800
Message-ID: <CABmPvSGa0kuBUg-iHLobaA9R_-kCdP1ho8M228jFi+Gczh_iUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Bluetooth: Keep MSFT ext info throughout a
 hci_dev's life cycle
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Dec 18, 2020 at 1:39 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Miao-chen,
>
> > This moves msft_do_close() from hci_dev_do_close() to
> > hci_unregister_dev() to avoid clearing MSFT extension info. This also
> > avoids retrieving MSFT info upon every msft_do_open() if MSFT extension
> > has been initialized.
>
> what is the actual benefit of this?
>
> It is fundamentally one extra HCI command and that one does no harm. You =
are trying to outsmart the hdev->setup vs the !hdev->setup case. I don=E2=
=80=99t think this is a good idea.
>
> So unless I see a real argument why we want to do this, I am leaving this=
 patch out. And on a side note, I named these function exactly this way so =
they are symmetric with hci_dev_do_{open,close}.
>
> Regards
>
> Marcel
>
Thanks for pointing that out. I totally agree that it's not a wise
thing to outsmart the symmetric hci_dev_do_{open,close}. However, the
following two cases justify why we need this change.
(1) The current symmetric calls to msft_do{open,close} in
hci_dev_do_{open,close} cause incorrect MSFT features during
bluetoothd start-up. After the kernel powers on the controller to
register the hci_dev, it performs hci_dev_do_close() which call
msft_do_close() and MSFT data gets wiped out. And then during the
startup of bluetoothd, Adv Monitor Manager relies on reading the MSFT
features from the kernel to present the feature set of the controller
to D-Bus clients. However, the power state of the controller is off
during the init of D-Bus interfaces. As a result, invalid MSFT
features are returned by the kernel, since it was previously wiped out
due to hci_dev_do_close().
(2) Assuming bluetoothd has started, and users can be toggling the
power state of the adapter. Powering off the adapter invokes
hci_power_off()->hci_dev_do_close()->msft_do_close(), and MSFT
features get wiped out. During powered-off period, D-Bus client can
still add/remove monitor from the kernel, and the kernel needs to
issue corresponding MSFT HCI commands to the controller. However, the
MSFT opcode has been reset and invalid.

And here is the trace (for case 1 above) that I captured without this chang=
e.

2021-01-15T01:34:43.800155Z INFO kernel: [    2.754911] Bluetooth:
hci_power_on() @@ call hci_dev_do_open
2021-01-15T01:34:45.145025Z INFO kernel: [    4.272376] Bluetooth:
hci_dev_do_open() @@ call msft_do_open
2021-01-15T01:34:45.145050Z INFO kernel: [    4.272382] Bluetooth:
msft_do_open() @@
2021-01-15T01:34:45.146020Z INFO kernel: [    4.273139] Bluetooth:
read_supported_features() @@ features 000000000000003f
2021-01-15T01:34:47.176410Z INFO kernel: [    6.303439] Bluetooth:
hci_power_off() @@ call hci_dev_do_close
2021-01-15T01:34:47.189020Z INFO kernel: [    6.316152] Bluetooth:
hci_dev_do_close() @@ call msft_do_close
2021-01-15T01:34:47.189032Z INFO kernel: [    6.316158] Bluetooth:
msft_do_close() @@
2021-01-15T01:34:47.957401Z INFO bluetoothd[2591]: Bluetooth daemon 5.54
// skip some logs here
2021-01-15T01:34:48.004066Z INFO bluetoothd[2591]: Bluetooth
management interface 1.14 initialized
2021-01-15T01:34:48.167703Z INFO bluetoothd[2591]: @@ call
btd_adv_monitor_manager_create
2021-01-15T01:34:48.167832Z INFO bluetoothd[2591]: @@ call
MGMT_OP_READ_ADV_MONITOR_FEATURES
2021-01-15T01:34:48.167886Z INFO bluetoothd[2591]: Battery Provider
Manager created
2021-01-15T01:34:48.171924Z INFO bluetoothd[2591]: @@ features
supported_features 00000000 enabled_features 00000000
2021-01-15T01:34:48.172088Z INFO kernel: [    7.299305] Bluetooth:
hci_power_on() @@ call hci_dev_do_open
2021-01-15T01:34:48.172083Z INFO bluetoothd[2591]: Adv Monitor Manager
created with supported features:0x00000000, enabled
features:0x00000000, max number of supported monitors:32, max number
of supported patterns:16
2021-01-15T01:34:48.207800Z INFO bluetoothd[2591]: Endpoint
registered: sender=3D:1.52 path=3D/org/chromium/Cras/Bluetooth/A2DPSource
2021-01-15T01:34:48.212522Z INFO bluetoothd[2591]: Player registered:
sender=3D:1.52 path=3D/org/chromium/Cras/Bluetooth/DefaultPlayer
2021-01-15T01:34:48.214813Z INFO bluetoothd[2591]: BlueZ log level is set t=
o 1
2021-01-15T01:34:48.230035Z INFO kernel: [    7.357118] Bluetooth:
hci_dev_do_open() @@ call msft_do_open
2021-01-15T01:34:48.230063Z INFO kernel: [    7.357124] Bluetooth:
msft_do_open() @@
2021-01-15T01:34:48.231027Z INFO kernel: [    7.358131] Bluetooth:
read_supported_features() @@ features 000000000000003f
2021-01-15T01:34:48.248967Z INFO bluetoothd[2591]: adapter
/org/bluez/hci0 has been enabled
2021-01-15T01:34:49.176198Z INFO bluetoothd[2591]: adapter
/org/bluez/hci0 set power to 1

Thanks,
Miao

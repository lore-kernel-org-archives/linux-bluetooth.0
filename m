Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC923C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D496208DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhla6vIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbgKXTFN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgKXTFM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 14:05:12 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A763C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 11:05:12 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x13so7155633uar.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 11:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+W7jJwGCb4X3aPAYb2bHPal61y/DMNXzXOlkAo3IyKk=;
        b=dhla6vIb81DplBpzZLwmgSqIMb8/g00dQOHCA8f7CzfLhqNexO5v1F9qzMupZ/M44P
         JDyHyiO1hLjhNR86YyCqljUxDMrfYV0ZHB5zX8efRxxgVDl4JEfFDEvOYJSK+Aq5VWk1
         iQYuKHw1wr+jCurwMWlFlJs+R16OqgXWjn7vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+W7jJwGCb4X3aPAYb2bHPal61y/DMNXzXOlkAo3IyKk=;
        b=hyFT+tfKcC3meF78Eklx6z7Kh3ztDfedRJeLv9YIP99DH2hxj8oymQvNqvPAJSkLum
         wwwAdlJl+RQUQo3YGWuTI2I27YUTV/3kBw8dz3qq/svE5XJyPTGPOQ2Y5OWwcCVq3s9y
         PmxWfJSQ0K8hf+FlIZ15AK4WnI1TqqX06eR/r1fQsJahbGkyzTWWMrx2skcb/dRt32vd
         nEiRdkDje8eE5yvpC7qgXfW4H8c3XmhFHrXZj4klWn2cDksGUAijd9IbweetXJQo7SE7
         +jYvDewCIZqZHRJFr/AkSe4V4M7lN68H4eh80i8hAdnD94VcifKHVJP07otA1d8yczIm
         iJtQ==
X-Gm-Message-State: AOAM533mVRn7egP936xAXClfzpl6lKCVY90yqBRoWsC400jDC5RKnYrl
        W+yDhyKmzBm6YwdF4byZSX6AR8wFqTghZNBZbSbPCQ==
X-Google-Smtp-Source: ABdhPJyHTtIH9cQFnt3Xhe+ipjomhQWZ5hH5ArFW70nlKMDCzYjQRa9WqWHfKD2+DwU4kKasH0oOSf7Cdzg9e/Slh/c=
X-Received: by 2002:ab0:104c:: with SMTP id g12mr4823113uab.136.1606244710878;
 Tue, 24 Nov 2020 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20201118234352.2138694-1-abhishekpandit@chromium.org>
 <7235CD4E-963C-4BCB-B891-62494AD7F10D@holtmann.org> <CANFp7mVSGNbwCkWCj=bVzbE8L38nwu0+UMR9jkOYcYQmGBaAEw@mail.gmail.com>
In-Reply-To: <CANFp7mVSGNbwCkWCj=bVzbE8L38nwu0+UMR9jkOYcYQmGBaAEw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 24 Nov 2020 11:04:59 -0800
Message-ID: <CANFp7mU_5rU1VdgBFcyWtNH-TD1n3wOpAh5o_aAN_3s1+AkaFw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: Power down controller when suspending
To:     Marcel Holtmann <marcel@holtmann.org>, chin-ran.lo@nxp.com,
        amitkumar.karwar@nxp.com
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Daniel Winkler <danielwinkler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Re-send to NXP email addresses for Chin-Ran Lo and Amitkumar Karwar
(Marvell wireless IP acquired by NXP)



On Tue, Nov 24, 2020 at 11:02 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Marcel,
>
>
> On Mon, Nov 23, 2020 at 3:46 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Abhishek,
> >
> > > This patch series adds support for a quirk that will power down the
> > > Bluetooth controller when suspending and power it back up when resumi=
ng.
> > >
> > > On Marvell SDIO Bluetooth controllers (SD8897 and SD8997), we are see=
ing
> > > a large number of suspend failures with the following log messages:
> > >
> > > [ 4764.773873] Bluetooth: hci_cmd_timeout() hci0 command 0x0c14 tx ti=
meout
> > > [ 4767.777897] Bluetooth: btmrvl_enable_hs() Host sleep enable comman=
d failed
> > > [ 4767.777920] Bluetooth: btmrvl_sdio_suspend() HS not actived, suspe=
nd failed!
> > > [ 4767.777946] dpm_run_callback(): pm_generic_suspend+0x0/0x48 return=
s -16
> > > [ 4767.777963] call mmc2:0001:2+ returned -16 after 4882288 usecs
> > >
> > > The daily failure rate with this signature is quite significant and
> > > users are likely facing this at least once a day (and some unlucky us=
ers
> > > are likely facing it multiple times a day).
> > >
> > > Given the severity, we'd like to power off the controller during susp=
end
> > > so the driver doesn't need to take any action (or block in any way) w=
hen
> > > suspending and power on during resume. This will break wake-on-bt for
> > > users but should improve the reliability of suspend.
> > >
> > > We don't want to force all users of MVL8897 and MVL8997 to encounter
> > > this behavior if they're not affected (especially users that depend o=
n
> > > Bluetooth for keyboard/mouse input) so the new behavior is enabled vi=
a
> > > module param. We are limiting this quirk to only Chromebooks (i.e.
> > > laptop). Chromeboxes will continue to have the old behavior since use=
rs
> > > may depend on BT HID to wake and use the system.
> >
> > I don=E2=80=99t have a super great feeling with this change.
> >
> > So historically only hciconfig hci0 up/down was doing a power cycle of =
the controller and when adding the mgmt interface we moved that to the mgmt=
 interface. In addition we added a special case of power up via hdev->setup=
. We never had an intention that the kernel otherwise can power up/down the=
 controller as it pleases.
>
> Aside from the powered setting, the stack is resilient to the
> controller crashing (which would be akin to a power off and power on).
> From the view of bluez, adapter lost and power down should be almost
> equivalent right? ChromeOS has several platforms where Bluetooth has
> been reset after suspend, usually due USB being powered off in S3, and
> the stack is still well-behaving when that occurs.
>
> >
> > Can we ask Marvell first to investigate why this is fundamentally broke=
n with their hardware?
>
> +Chin-Ran Lo and +Amitkumar Karwar (added based on changes to
> drivers/bluetooth/btmrvl_main.c)
>
> Could you please take a look at the original cover letter and comment
> (or add others at Marvell who may be able to)? Is this a known issue
> or a fix?
>
> >Since what you are proposing is a pretty heavy change that might has sid=
e affects. For example the state machine for the mgmt interface has no conc=
ept of a power down/up from the kernel. It is all triggered by bluetoothd.
> >
> > I am careful here since the whole power up/down path is already complic=
ated enough.
> >
>
> That sounds reasonable. I have landed this within ChromeOS so we can
> test whether a) this improves stability enough and b) whether the
> power off/on in the kernel has significant side effects. This will go
> through our automated testing and dogfooding over the next few weeks
> and hopefully identify those side-effects. I will re-raise this topic
> with updates once we have more data.
>
> Also, in case it wasn't very clear, I put this behind a module param
> that defaults to False because this is so heavy handed. We're only
> using it on specific Chromebooks that are exhibiting the worst
> behavior and not disabling it wholesale for all btmrvl controllers.
>
> Thanks
> Abhishek
>
> > Regards
> >
> > Marcel
> >

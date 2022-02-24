Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiBXPWt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiBXPWX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 10:22:23 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61F21E16
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 07:21:41 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id v5so1944961ilm.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaxbd/ZSA2Vq/xzOMKynhS0W1ItrpewBLveoRh6a3Gw=;
        b=RvNosJsbD3zPwzI7O6D2B+yKuS9AdeHWSTsTxQhz+qG8SpXJ0vE6OQtz5UgI1AroJT
         WW078ruq/Q4XFHC5ZV5YaDrQyFRgiv2JYGYX+uyI5sqD6prm0spzizpmg09ioni/F+s0
         5EwDjcyUw1hhuC0AtJw1VewZlqSuQJc+VlLdZHmXUJj2a7Emhuu9s73Np2bfbe2oC3u2
         eSFYxk09L84StDhPWEAkYcMCKW9VI3005uCgePKvebOBtP/gCuduNpd8/RTZ4Xnvurni
         wS9kMQpwF2hgd3pqPhoZcqjDhL5miAAjgN0J9OTU1ajC/eyi6/zP8nSVwN9RVgXS8wUy
         DUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaxbd/ZSA2Vq/xzOMKynhS0W1ItrpewBLveoRh6a3Gw=;
        b=dEjLz+HWatD5yLQay3XClFrtWVi3N80HBCubTo3bl3+JbXTJefu7ZgCvEcZRK7GxRc
         P3gJaZGha5u+wz9PFa3D7QtBXlayowzKwlcfX2NLa2wj1Nrs8tGizYeeRnCLgCLy+JW+
         gcWS45SFDtr37o/i5fjIhne/Scd3TLQhlkZUZccyoKycK8uJXrIYXNYXf/reseiqUhC/
         zve2lRyKElzsb1qZMxN1YkVCKuAI+3LqENn0E0E68Gvhxacdx0Q68anZ2XkwNBgWkEVJ
         Spu1eBUkAYncW33+hRQxzHCPTYiC6gASE0dOx6FMZPConv3nBXuvmoJvy1KHxN41bIcI
         /XbA==
X-Gm-Message-State: AOAM531ZIVwlAMA6bOLjbW9fEEy6OYYYZhVaCXOuW/N3GPUCFRnuct4f
        UUtZ8yOAwy4Gw7zBvTrziqd2Xcs82RPU2infJCAz1Ycw
X-Google-Smtp-Source: ABdhPJxclwpTI0RRV4Q4zI2Zv0a0zVsa1BVKaFq6h7s4YJ80wxU6SlYWlt9lQ9xH5fgzQpa9awIBvT2pjpAMycn1PAg=
X-Received: by 2002:a92:cda3:0:b0:2c2:202e:e70c with SMTP id
 g3-20020a92cda3000000b002c2202ee70cmr2755652ild.181.1645716100285; Thu, 24
 Feb 2022 07:21:40 -0800 (PST)
MIME-Version: 1.0
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
 <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com> <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
In-Reply-To: <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Feb 2022 07:21:29 -0800
Message-ID: <CABBYNZKwzRTDSVeQuWV5pvAJbQcd0wT9KeUT+XSdScXn_zjMeA@mail.gmail.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maxim,

On Thu, Feb 24, 2022 at 5:01 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> > Hi Maxim,
> >
> > On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > Today I updated to a new kernel and I am bisecting few regressions:
> > >
> > > I noticed that if I open GNOME's bluetooth setting, it hangs for like minute or so,
> > > and then shows only the paired devices and no scan results.
> > >
> > > I bisected this to this commit.
> > >
> > > For reference I am running fairly old fedora 32 on this machine, and thus I have
> > > bluez 5.55 and stock GNOME from fedora 32.
> > >
> > > I can provide any more info on anything if required and/or test patches.
> > >
> > > I wasn't able tor revert this commit as it is part of a bigger rewrite of scanning
> > > which makes sense.
> > >
> > > I tried merging bluetooth-next master as of today,
> > > into my kernel but no noticeable improvement.
> >
> > Is there any error being reported in bluetoothd, does bluetoothctl
> > have the same problem? It would be great if you could provide an HCI
> > trace of the problem.
> >
> I haven't used bluetoothd much but that is what I see:
>
> [mlevitsk@starship ~]$bluetoothctl
> Agent registered
> [bluetooth]# scan on
> [bluetooth]# scan on
> Failed to start discovery: org.bluez.Error.InProgress
> [bluetooth]# scan on
> Failed to start discovery: org.bluez.Error.InProgress
> [bluetooth]#
>
> No results show up, attempting to scan again shows the InProgres error.

Please collect the HCI with btmon.

> On my AMD laptop on the other hand (also runs the same 5.17-rc5 kernel),
> after 'scan on' I start seeing lots of scan results of various devices near me.
>
>
> journalctl -u bluetooth -b0
>
> -- Logs begin at Wed 2022-01-12 11:47:00 IST, end at Thu 2022-02-24 14:50:59 IST. --
> Feb 23 22:16:45 starship systemd[1]: Starting Bluetooth service...
> Feb 23 22:16:45 starship bluetoothd[1825]: Bluetooth daemon 5.60
> Feb 23 22:16:45 starship systemd[1]: Started Bluetooth service.
> Feb 23 22:16:45 starship bluetoothd[1825]: Starting SDP server
> Feb 23 22:16:45 starship bluetoothd[1825]: profiles/network/bnep.c:bnep_init() kernel lacks bnep-protocol support
> Feb 23 22:16:45 starship bluetoothd[1825]: src/plugin.c:plugin_init() System does not support network plugin
> Feb 23 22:16:45 starship bluetoothd[1825]: Bluetooth management interface 1.21 initialized
> Feb 23 22:16:56 starship bluetoothd[1825]: Endpoint registered: sender=:1.251 path=/MediaEndpoint/A2DPSink/sbc
> Feb 23 22:16:56 starship bluetoothd[1825]: Endpoint registered: sender=:1.251 path=/MediaEndpoint/A2DPSource/sbc
> Feb 23 22:16:56 starship bluetoothd[1825]: src/profile.c:ext_start_servers() RFCOMM server failed for Headset Voice gateway: socket(STREAM, RFCOMM): Protocol not supported (93)
> Feb 23 22:16:56 starship bluetoothd[1825]: src/profile.c:ext_start_servers() RFCOMM server failed for Headset unit: socket(STREAM, RFCOMM): Protocol not supported (93)
> Feb 23 23:11:21 starship bluetoothd[1825]: Controller resume with wake event 0x0
> Feb 24 09:05:29 starship bluetoothd[1825]: Controller resume with wake event 0x0
>
>
> I do notice that even on 5.16 kernel, I am not able to use the HSF or whatever low quality bi-directional bluetooh protocol is called for my headset. Used to work, I don't
> know what broke it, likely not related to this.

Weird, looks like RFCOMM is not available in your system.

> I also updated bluez to 5.6 by installing fedora 33 package, and initiallly it seems to work, but after reboot, the issue shows up again.
> Looks like sometimes the scan does work. So far I wasn't able to make it work even once since then.
> Reloading btusb doesn't help.
> Can't install newer package due to deps on glib sadly. I might be able to compile it from source, but that will take some time to figure
> out how the components of the bluez stack are connected together.
>
> For the reference I have 'Intel Corp. AX200 Bluetooth' and I have the same device on my AMD laptop and both have USB ID 8087:0029
> My AMD laptop has Fedora 34 though.
>
> Best regards,
>         Maxim Levitsky
>
>
>


-- 
Luiz Augusto von Dentz

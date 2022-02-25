Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiBYW2K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiBYW2I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 17:28:08 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF5256433
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:27:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y189so8612115ybe.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qjsMp7xX3ynS5KcguIDmZLn/ntTYnkqaOeDF7REL5dA=;
        b=A2sFE6EmXvWJO2GAR4r6b0cc1TJATlcwe/jkDTL6KKfD7kWCXjBA0OJp+7VatR1IfQ
         0gSzTMb++NOLKEzUj5IEIxYnc1al6d6BEQUdbdDTngZ9ekcYmpKtswG6JqFo9og9EUWi
         BX63Nc6MrWESYakzPKKN3WhpBB9mm8yxRw2e7dSEp2b/+sjpTxCVI9wFxaui1cypYqv4
         EZFkYiyD3B0NFyeUnESI6CrR1dStT23+uH6EtLK/tbSVxEVWKPl9u7LgQpleNWiDNg6N
         VVe3tGyj4VvuAmV1ClyD4zF9xdpEql9eIgSVj3rMN1nLFORxpGsUF4J6aewYnr06CI/N
         2YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjsMp7xX3ynS5KcguIDmZLn/ntTYnkqaOeDF7REL5dA=;
        b=o7U6/K9bDvwcdnIh5u3k4vcC7noOz6EORfGzXyMfajtqRXzE3UTGw5TLvr7p+hQIbF
         UhVf2Q+18wR8nji0FMaOOPiRJm2ijmG00pNeUSHGiIJxlYnM5ZUG/97QNAqPOPQLg0IN
         ofzYMDrRWwo/IkVsPLF7s6PpEZkKdTESra245QyWxO31jE2asDW6kxyZnT89miUFVHPc
         QoMDciC2khy/uUKOkQoHXdvMeIWswqBzbSdm91WKRrV9M5XzAQ7+v/3PzKNrTMV8eKqt
         XbMM0U2LtWg/Owuc8vUShFGzvaS6OLS2G1/yvXirOzAy6OMkGPdntGQVEIfxHv6V0QX4
         IqSA==
X-Gm-Message-State: AOAM533W6uRTgxCmKGoEXKYXPaC0v7C4nGaC4lIfJqDtWaxvhuZhEKiP
        RVsgbxwUCemito6NLpWiWygpOY28Uv5lOnMeVG4=
X-Google-Smtp-Source: ABdhPJw4JB+s2Tipaofshsa4kLwDQ1Cj9YvrlXOFM2BQdrPATgVljrRMvwNDQcztknfzmZ2ASuQ36UzuGZTUldma9z8=
X-Received: by 2002:a25:a467:0:b0:61e:1b4a:7700 with SMTP id
 f94-20020a25a467000000b0061e1b4a7700mr9398736ybi.390.1645828053174; Fri, 25
 Feb 2022 14:27:33 -0800 (PST)
MIME-Version: 1.0
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
 <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
 <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
 <fc74637a-f3c8-7870-82ec-90bf55b60462@molgen.mpg.de> <0838aa454b7b127fab1b2a945180304088251b13.camel@redhat.com>
In-Reply-To: <0838aa454b7b127fab1b2a945180304088251b13.camel@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Feb 2022 14:27:22 -0800
Message-ID: <CABBYNZKMj6yhqsvkx=tcj=tz_9_78r87NBqk6TC1cyO6g4Pesw@mail.gmail.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maxim,

On Thu, Feb 24, 2022 at 8:29 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Thu, 2022-02-24 at 16:43 +0100, Paul Menzel wrote:
> > Dear Maxim,
> >
> >
> > Am 24.02.22 um 14:01 schrieb Maxim Levitsky:
> > > On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> > > > On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky wrote:
> > > > > Today I updated to a new kernel and I am bisecting few
> > > > > regressions:
> >
> > [=E2=80=A6]
> >
> > > I do notice that even on 5.16 kernel, I am not able to use the HSF
> > > or whatever low quality bi-directional bluetooh protocol is called
> > > for my headset. Used to work, I don't know what broke it, likely not
> > > related to this.
> > >
> > > I also updated bluez to 5.6 by installing fedora 33 package, and
> > > initially it seems to work, but after reboot, the issue shows up
> > > again. Looks like sometimes the scan does work. So far I wasn't able
> > > to make it work even once since then. Reloading btusb doesn't help.
> > > Can't install newer package due to deps on glib sadly. I might be
> > > able to compile it from source, but that will take some time to
> > > figure out how the components of the bluez stack are connected
> > > together.
> > >
> > > For the reference I have 'Intel Corp. AX200 Bluetooth' and I have
> > > the same device on my AMD laptop and both have USB ID 8087:0029 My
> > > AMD laptop has Fedora 34 though.
> >
> > Sorry, I lost track, if it=E2=80=99s still about one regression, you
> > successfully bisected or not.
> yes, I sucessfully bisected the regression. 1 commit before mentioned com=
mit
> the bluetooth works for me, and not after it, with same .config and every=
thing else.
>
>
> >
> > Anyway, passing through the USB Bluetooth device to QEMU helped me [1],
> > and might help you to overcome the dependency problems. (My steps
> > actually worked, but turned out the Linux kernel commit I tested with
> > had another regression not making the Bluetooth controller initialize.)
> First thing I tried, but alas it worked for me in fedora 34 VM I tried to=
 test with
> (with the same 5.17-rc5 kernel, albeet with different .config, more tailo=
red for a VM).

Give it a try with:

https://patchwork.kernel.org/project/bluetooth/patch/20220224232950.56204-1=
-brian.gix@intel.com/

Btw, are there any other users of the MGMT socket? Or it is just bluetoothd=
?

> Best regards,
>         Maxim Levitsky
>
> >
> > Marcel also replied, he is using btproxy to debug issues, but I did not
> > try it, as it wasn=E2=80=99t clear to me how to get it working easily, =
and he
> > also wrote something about non-public patches.
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > [1]:
> > https://lore.kernel.org/linux-bluetooth/5891f0d5-8d51-9da5-7663-718f301=
490b1@molgen.mpg.de/T/#u
> >
>
>


--=20
Luiz Augusto von Dentz

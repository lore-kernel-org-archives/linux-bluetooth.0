Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2773EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 20:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHUUJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHUUJD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 16:09:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55FE3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:09:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9a2033978so59266431fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692648538; x=1693253338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Or1cy9dRxfRtdHtl3c5wLqx3hRLVr3OcaxXKB58Q68=;
        b=rN5VJofywMuv7s7R99Vzosh4JHDkNT5/5wy891UVx4wRVGkQ0MaOShJq9NG0SDLOA0
         SmSWdFAIIkn0YuFRssl82H9ImKQloPlFg+6Je9QTkka7op6YIl6Jc8JDvJVn2ddDdaPO
         +bWPTWSL5aBV/Ij+AxQ28hmkaZ7CtRebHKICIKTNUkgMAnVggVHkhxqTjldGX7nMmdak
         AW/UhgixzukVGhMlEFdrQDC9j4W4hgJv/5rjPVKf/QTei9kCeIB17MNFx+nsZNHlSGxK
         3iDIyscEqTwSRjQuWW/T6Ufxc6udr6CFEYc8rwt8ld1qGRsgwUyEgJ4rczL6HcNtLb6b
         aahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692648538; x=1693253338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Or1cy9dRxfRtdHtl3c5wLqx3hRLVr3OcaxXKB58Q68=;
        b=Cff7b8DbPQNJumX1yo00omUYCLsCqy53VmVetcS9Au4dpi1M+rtbXKi8xANkMY1mtL
         OEw+hDq7k4P+I9q3KT3P/DILDLq7VfF+5z2W8NZs+x1LfCGUsa+8haczCNNE4gaGWUt3
         3N4NKX6aaaQnnQbDknwH5y0Ou4FLMcVonPeos7IEqOPO0leUb1ViR35AemY1ZcA5xMaa
         bKw6SXXcB64pwuYWxqBVUTih3CMX9Qq8aKHZSZoaZa8tBJ6W3fCprzybdC5eiv+Gk0Vz
         /cDiCtF4ZUXqLhqW3vwJDCUDFXBa5sDJYx65yvRo05GSfjpPjt8WYQuyD+y9FhAF3oo3
         QEPw==
X-Gm-Message-State: AOJu0YwZGqpvyzW9Q6uSMrmZAfptp6o5dJUYlHreqhdsQnRa1/ekRH1w
        hN0M2WT/564Ha9ulTJzpj4U+YZzK+5xMxJj1y8s=
X-Google-Smtp-Source: AGHT+IEws6q0b0dFoWgb4XbrBKlbWei8RPV5N6UIL+1OlocawRNo9E1J8v/3dtLkkiR0Cp4v7RyAMQvBlnfiBwDi1jo=
X-Received: by 2002:a2e:b012:0:b0:2ac:82c1:5a3d with SMTP id
 y18-20020a2eb012000000b002ac82c15a3dmr5671636ljk.23.1692648538012; Mon, 21
 Aug 2023 13:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <2300626.ElGaqSPkdT@bruno-beit> <5706628.DvuYhMxLoT@bruno-beit>
 <CABBYNZ+Nt3Rho2=VtVrspRLond2agnKhT1LmeLCGdY4fdxmusg@mail.gmail.com>
 <13020832.2lBWEU9m2C@bruno-beit> <CABBYNZLpHxGHKsB_JPh1Drg=V_gXMGTp=nqXB=W1MM2_6BNHQw@mail.gmail.com>
 <CABBYNZLo0WT+VovmB3AKPKNNLXPNPBdECNzf6MNu+aL6d91naQ@mail.gmail.com>
In-Reply-To: <CABBYNZLo0WT+VovmB3AKPKNNLXPNPBdECNzf6MNu+aL6d91naQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Aug 2023 13:08:45 -0700
Message-ID: <CABBYNZ+z_=ZfJQQJ=A-HC7Ox+1jueeb_oWwcerC0YKS8z0QMug@mail.gmail.com>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
To:     Bruno Pitrus <brunopitrus@hotmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruno,

On Mon, Aug 14, 2023 at 4:38=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bruno,
>
> On Mon, Aug 14, 2023 at 1:21=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bruno,
> >
> > On Mon, Aug 14, 2023 at 3:00=E2=80=AFAM Bruno Pitrus <brunopitrus@hotma=
il.com> wrote:
> > >
> > > Dnia pi=C4=85tek, 11 sierpnia 2023 19:11:50 CEST Luiz Augusto von Den=
tz pisze:
> > > > Hi Bruno,
> > > >
> > > > On Fri, Aug 11, 2023 at 4:25=E2=80=AFAM Bruno Pitrus <brunopitrus@h=
otmail.com> wrote:
> > > > >
> > > > > Dnia sobota, 5 sierpnia 2023 09:31:08 CEST Paul Menzel pisze:
> > > > > > [Cc: +regressions@]
> > > > > >
> > > > > > #regzbot introduced v6.3.9..v6.4.2
> > > > > >
> > > > > > Dear Bruno,
> > > > > >
> > > > > >
> > > > > > Thank you for your report.
> > > > > >
> > > > > > Am 04.08.23 um 20:55 schrieb Bruno Pitrus:
> > > > > > > I am using openSUSE Tumbleweed on a Dell Precision 3551 which=
 has a
> > > > > > > bluetooth adapter of ID 8087:0026 (Intel AX201). I am using a
> > > > > > > Logitech M575 trackball mouse which only supports Bluetooth L=
E.
> > > > > > >
> > > > > > > With kernel 6.4.2 or newer, scanning for devices =E2=80=94 us=
ing either the
> > > > > > > KDE gui or bluetoothctl =E2=80=94 most of the time returns on=
ly =E2=80=9Cclassic
> > > > > > > bluetooth=E2=80=9D devices like computers and phones, and not=
 the mouse. If
> > > > > > > the mouse was paired before, it works correctly however.
> > > > > > >
> > > > > > > With previous kernel versions (6.3.9 and before), pairing the=
 mouse
> > > > > > > worked correctly.
> > > > > >
> > > > > > Are you able to bisect the regression? Please also attach the L=
inux
> > > > > > messages. (You can also create a ticket in the Linux kernel Bug=
zilla [1]
> > > > > > and attach everything there.)
> > > > > >
> > > > > >
> > > > > > Kind regards,
> > > > > >
> > > > > > Paul
> > > > > >
> > > > > >
> > > > > > [1]: https://bugzilla.kernel.org/
> > > > > >
> > > > >
> > > > > The offending commit is https://github.com/SUSE/kernel/commit/288=
c90224eec55d13e786844b7954ef060752089 :
> > > > >
> > > > > > Bluetooth: Enable all supported LE PHY by default
> > > > > > This enables 2M and Coded PHY by default if they are marked as =
supported
> > > > > > in the LE features bits.
> > > > > >
> > > > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com=
>
> > > >
> > > > Do you have the btmon/HCI traces showing this, we also need the
> > > > firmware version as well since I suspect this is due to the control=
ler
> > > > setting the PHYs as supported but being unable to to use them
> > > > properly.
> > > >
> > > >
> > > hciconfig says the below: (I assume =E2=80=9CRevision=E2=80=9D is the=
 firmware version)
> >
> > You can find the firmware information on dmesg, e.g:
> >
> > [    7.982585] Bluetooth: hci1: Found Intel DDC parameters: intel/ibt-2=
0-1-3.ddc
> > [    7.984113] Bluetooth: hci1: Applying Intel DDC parameters completed
> > [    7.985111] Bluetooth: hci1: Firmware revision 0.3 build 144 week 11=
 2023
> >
> > > hci0:   Type: Primary  Bus: USB
> > >         BD Address: F0:9E:4A:E6:62:15  ACL MTU: 1021:4  SCO MTU: 96:6
> > >         UP RUNNING
> > >         RX bytes:150050 acl:8114 sco:0 events:270 errors:0
> > >         TX bytes:5970 acl:69 sco:0 commands:173 errors:0
> > >         Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
> > >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> > >         Link policy: RSWITCH SNIFF
> > >         Link mode: PERIPHERAL ACCEPT
> > >         Name: '[REDACTED]'
> > >         Class: 0x6c010c
> > >         Service Classes: Rendering, Capturing, Audio, Telephony
> > >         Device Class: Computer, Laptop
> > >         HCI Version: 5.2 (0xb)  Revision: 0x20ce
> > >         LMP Version: 5.2 (0xb)  Subversion: 0x20ce
> > >         Manufacturer: Intel Corp. (2)
> > >
> > > I'm unsure how to attach the btmon output as it is a binary file that=
 contains potentially private information (names of nearby devices)
> >
> > Well you can collect it manually and redacted the addresses, etc, up
> > to you, I'm usually not that paranoid of sharing this kind of
> > information if you scan for a short time, in the other hand I usually
> > use gist.github.com to do that so I can delete it later if needed.
>
> Seems to be working fine here (with AX201 and AX210):
>
> https://gist.github.com/Vudentz/d80ab63f4f62f9f216796edb4838c855

Can you try with the following patch:

https://patchwork.kernel.org/project/bluetooth/patch/20230821181848.3553863=
-1-luiz.dentz@gmail.com/

Looks like we were not storing the whole advertisement sometimes.

--=20
Luiz Augusto von Dentz

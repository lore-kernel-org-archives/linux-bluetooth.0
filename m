Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CEBC41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 20:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjHNUVv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 16:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjHNUVs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 16:21:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63CDBC
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 13:21:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-564af1b3a9fso3117296a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692044507; x=1692649307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ+M7f/h+HwPAdWYvLXLNo9bYAS6Fo7q8ryjxv8jwWE=;
        b=p7W/P+WJeVRW08VsvedN5GOj2m9u+MGc2tXg0Fi5MBWlimKCA6A/tK9wYB1LSyeSP/
         dVpRHgGn9HMtctB5D81S02e4Q2i0tkBjsdM7gNpf4gzPGhJIfvc08oqPkgccQkKu3HlE
         nGLLO1Jn5WSYj+buMRoHLEctE+WYkm/KuC65TiLy1IUqZfo0pXfwOlVVOk0vBZAotxkU
         Oo+fkKVSyWhpac1g/M25tR2CxBO5024Ik2D7Tyvga71NAIx2yI13wQAkvT3GVJjCXqEi
         XtvFieRUXfey/aMV0CCaydHt5JELEnHy4w0ZKK7sWwR2VUPjEpMQ6JuBUwVqm6RUkngX
         e3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044507; x=1692649307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ+M7f/h+HwPAdWYvLXLNo9bYAS6Fo7q8ryjxv8jwWE=;
        b=ll5VhorORASUZkSvLCdmX2dmHY+ycJGSRKMo4SoGGEfaKLoi0QsORHqzls90x/PzEP
         Hx70FS/oUMBJQSMqa6gOQlYI+iTgXeP5HTATtyAn5BAwPbdg9mD+LjJgIf61NgNaI102
         Rs4deLaEGX72kZRQQsSeUMAG6bOCTAwDl6zWEtqT3BlqIJilzWU8VhjvLK4ooQLQowDD
         mETsSTAaDSMrwdRkcLo2FY0hZPnWrv4qZ/OO8TBcfiqD/nha8xwVJJImSqDdDgtTjRKJ
         Imt9uX26dtZ60D5s7mgpPzeevBEY1nC8DqCAOevAUYW3OsES7SCT71IO1joj2MPtQ2Ik
         w7sg==
X-Gm-Message-State: AOJu0Yz9sDhrgjnDLkaBpcN+HzRYLSIDVV1i+SXsfi9L556b0xE1AEsh
        TxwHPd3qWDA/G80NafDy+0oQAWKz1NFu5x5owhY=
X-Google-Smtp-Source: AGHT+IE3I+xSmKYV7TiVALVIDS+rbUSKcWulKjBiqgvlCma24xB51n+uY/w/EZwhuc9a/lPAo9cAR+KBYhY+dnRmHro=
X-Received: by 2002:a17:90b:1c01:b0:268:798:a28b with SMTP id
 oc1-20020a17090b1c0100b002680798a28bmr7376pjb.23.1692044506949; Mon, 14 Aug
 2023 13:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <2300626.ElGaqSPkdT@bruno-beit> <5706628.DvuYhMxLoT@bruno-beit>
 <CABBYNZ+Nt3Rho2=VtVrspRLond2agnKhT1LmeLCGdY4fdxmusg@mail.gmail.com> <13020832.2lBWEU9m2C@bruno-beit>
In-Reply-To: <13020832.2lBWEU9m2C@bruno-beit>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Aug 2023 13:21:32 -0700
Message-ID: <CABBYNZLpHxGHKsB_JPh1Drg=V_gXMGTp=nqXB=W1MM2_6BNHQw@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 3:00=E2=80=AFAM Bruno Pitrus <brunopitrus@hotmail.c=
om> wrote:
>
> Dnia pi=C4=85tek, 11 sierpnia 2023 19:11:50 CEST Luiz Augusto von Dentz p=
isze:
> > Hi Bruno,
> >
> > On Fri, Aug 11, 2023 at 4:25=E2=80=AFAM Bruno Pitrus <brunopitrus@hotma=
il.com> wrote:
> > >
> > > Dnia sobota, 5 sierpnia 2023 09:31:08 CEST Paul Menzel pisze:
> > > > [Cc: +regressions@]
> > > >
> > > > #regzbot introduced v6.3.9..v6.4.2
> > > >
> > > > Dear Bruno,
> > > >
> > > >
> > > > Thank you for your report.
> > > >
> > > > Am 04.08.23 um 20:55 schrieb Bruno Pitrus:
> > > > > I am using openSUSE Tumbleweed on a Dell Precision 3551 which has=
 a
> > > > > bluetooth adapter of ID 8087:0026 (Intel AX201). I am using a
> > > > > Logitech M575 trackball mouse which only supports Bluetooth LE.
> > > > >
> > > > > With kernel 6.4.2 or newer, scanning for devices =E2=80=94 using =
either the
> > > > > KDE gui or bluetoothctl =E2=80=94 most of the time returns only =
=E2=80=9Cclassic
> > > > > bluetooth=E2=80=9D devices like computers and phones, and not the=
 mouse. If
> > > > > the mouse was paired before, it works correctly however.
> > > > >
> > > > > With previous kernel versions (6.3.9 and before), pairing the mou=
se
> > > > > worked correctly.
> > > >
> > > > Are you able to bisect the regression? Please also attach the Linux
> > > > messages. (You can also create a ticket in the Linux kernel Bugzill=
a [1]
> > > > and attach everything there.)
> > > >
> > > >
> > > > Kind regards,
> > > >
> > > > Paul
> > > >
> > > >
> > > > [1]: https://bugzilla.kernel.org/
> > > >
> > >
> > > The offending commit is https://github.com/SUSE/kernel/commit/288c902=
24eec55d13e786844b7954ef060752089 :
> > >
> > > > Bluetooth: Enable all supported LE PHY by default
> > > > This enables 2M and Coded PHY by default if they are marked as supp=
orted
> > > > in the LE features bits.
> > > >
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Do you have the btmon/HCI traces showing this, we also need the
> > firmware version as well since I suspect this is due to the controller
> > setting the PHYs as supported but being unable to to use them
> > properly.
> >
> >
> hciconfig says the below: (I assume =E2=80=9CRevision=E2=80=9D is the fir=
mware version)

You can find the firmware information on dmesg, e.g:

[    7.982585] Bluetooth: hci1: Found Intel DDC parameters: intel/ibt-20-1-=
3.ddc
[    7.984113] Bluetooth: hci1: Applying Intel DDC parameters completed
[    7.985111] Bluetooth: hci1: Firmware revision 0.3 build 144 week 11 202=
3

> hci0:   Type: Primary  Bus: USB
>         BD Address: F0:9E:4A:E6:62:15  ACL MTU: 1021:4  SCO MTU: 96:6
>         UP RUNNING
>         RX bytes:150050 acl:8114 sco:0 events:270 errors:0
>         TX bytes:5970 acl:69 sco:0 commands:173 errors:0
>         Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH SNIFF
>         Link mode: PERIPHERAL ACCEPT
>         Name: '[REDACTED]'
>         Class: 0x6c010c
>         Service Classes: Rendering, Capturing, Audio, Telephony
>         Device Class: Computer, Laptop
>         HCI Version: 5.2 (0xb)  Revision: 0x20ce
>         LMP Version: 5.2 (0xb)  Subversion: 0x20ce
>         Manufacturer: Intel Corp. (2)
>
> I'm unsure how to attach the btmon output as it is a binary file that con=
tains potentially private information (names of nearby devices)

Well you can collect it manually and redacted the addresses, etc, up
to you, I'm usually not that paranoid of sharing this kind of
information if you scan for a short time, in the other hand I usually
use gist.github.com to do that so I can delete it later if needed.

>


--=20
Luiz Augusto von Dentz

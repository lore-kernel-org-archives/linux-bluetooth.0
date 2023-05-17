Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A1C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjEQV6f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQV6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 17:58:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649FA2D4D
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 14:58:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac90178fdaso13394261fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684360710; x=1686952710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odpHa82GGpWaiWgT4raJedjocOqW3w3jxgcgAamqO5E=;
        b=hjPAsJJwejbNRnAwzpf0cRSVKU78WCRdxq5gqHW2pj3YvJilybaKGrs77wY5sErC2l
         tq/h9BYkx8F6PRLcmrzP23gZRORIM0MWAge4jug7mHi1d9VsV/c0kwBXKpupWJKLYVZC
         JIaC9hTHO7w6fElBGsagZtHMs9j290Wg1rFuAJT7FJobnxsctVg/RNQrpEDEtAcqglm3
         MJ5QnKVfG362J4+FETk0tNfT40Yt6kcfWRnM3k56IzixOkXmzAers8PWz5ebR7VM0yHy
         IsKWCPwOjpoKjUnjV4DJvZDdmm71mdhIOcOeMbTMoKZmq08v+ohyPShzrt7ely8jTX5H
         btRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360710; x=1686952710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odpHa82GGpWaiWgT4raJedjocOqW3w3jxgcgAamqO5E=;
        b=ducGCnNEU6uIw31hN5k1AgPqSK0QqU3DCa2pj/MLPlz86Nn1yRbAYKE+nsxDAfv1lK
         4IIOeC33sAnArZhs17VTYye/4LY82dFJyG5kF1S/rFrD94k6SCQjt0z1rLhaFN4GXXIY
         OWoxhdjsCZ9wcUJijCANwMjy678rxxJVY+VWlo7ZOubjlf1uIV4BhOdLPPsZg9hgNm9Y
         Slmp346pPjXB8NKIMo5WNwlIWy+iV2HCgsZGy0NO0zewJ3vVntJaXb9frgds7JwK4rE6
         s0Pb4wTG//gasa5F5yCYekas1Nh0bn1MstHnZgaO0UFyXDzAxjcNj7HhfNUsjkrUH/DD
         lo4A==
X-Gm-Message-State: AC+VfDyNvxADKbOSRDsrO8sMzsC8O4xU8/bmbVggfSt20MWGXjBcT08e
        T+jdJvBTUzTL3cMxSm7L1K7KK1oWqKtHpY+m9U8VUEb1pn8=
X-Google-Smtp-Source: ACHHUZ4bbUfqHZul5P3oK3yVXgM9LFMo6RE/CZmB7fhIdbS74C7JXW40mftB0mGb5gsFMhm+cA1e9Pc8oXfmEEE67EI=
X-Received: by 2002:a2e:8745:0:b0:2ad:90b2:62ff with SMTP id
 q5-20020a2e8745000000b002ad90b262ffmr10366346ljj.49.1684360710401; Wed, 17
 May 2023 14:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
 <645fc6ce.630a0220.1799b.9542@mx.google.com> <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
 <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi> <CABBYNZKu7pPE0EddZyzv1mbEW0nePOzf_dawkDJ-e6+ReJvS-A@mail.gmail.com>
 <25523ad612ce4491281743bc8d5a6ccf7673aa76.camel@iki.fi> <CABBYNZJQQQMMbhZBO_4hkvrJwStqTfVjqQ8uphs7acMPGevtyQ@mail.gmail.com>
 <8991642e1279b0d7548482a6102e5c75306d6009.camel@iki.fi> <CABBYNZJvBY9_kzdoLOkOJEFO32h5k5DeAuY4tWC_SdPr4umvug@mail.gmail.com>
 <17725c9488b0d5eb5e39404bcff873d58a1e3edb.camel@iki.fi> <CABBYNZKzCYtNzaDXr3yqaTMsi=7jho9HvSpGGWDtFF53aD0XYw@mail.gmail.com>
In-Reply-To: <CABBYNZKzCYtNzaDXr3yqaTMsi=7jho9HvSpGGWDtFF53aD0XYw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 May 2023 14:58:18 -0700
Message-ID: <CABBYNZKF-xsnfXBkQ+Aj8rTH9UWYWHDDqO=7b63QjiTLwxwJRA@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, May 17, 2023 at 2:50=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Wed, May 17, 2023 at 2:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >
> > ke, 2023-05-17 kello 14:25 -0700, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >
> > > On Wed, May 17, 2023 at 2:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > ke, 2023-05-17 kello 13:53 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > > Hi Pauli,
> > > > >
> > > > > On Wed, May 17, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki.f=
i> wrote:
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > ke, 2023-05-17 kello 12:34 -0700, Luiz Augusto von Dentz kirjoi=
tti:
> > > > > > > Hi Pauli,
> > > > > > >
> > > > > > > On Mon, May 15, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@i=
ki.fi> wrote:
> > > > > > > >
> > > > > > > > Hi Luiz,
> > > > > > > >
> > > > > > > > ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz ki=
rjoitti:
> > > > > > > > > Hi Pauli,
> > > > > > > > >
> > > > > > > > > On Sat, May 13, 2023 at 10:41=E2=80=AFAM <bluez.test.bot@=
gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This is automated email and please do not reply to this=
 email!
> > > > > > > > > >
> > > > > > > > > > Dear submitter,
> > > > > > > > > >
> > > > > > > > > > Thank you for submitting the patches to the linux bluet=
ooth mailing list.
> > > > > > > > > > This is a CI test results with your patch series:
> > > > > > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/=
list/?series=3D747273
> > > > > > > > > >
> > > > > > > > > > ---Test result---
> > > > > > > > > >
> > > > > > > > > > Test Summary:
> > > > > > > > > > CheckPatch                    FAIL      1.14 seconds
> > > > > > > > > > GitLint                       PASS      0.52 seconds
> > > > > > > > > > BuildEll                      PASS      26.21 seconds
> > > > > > > > > > BluezMake                     PASS      745.32 seconds
> > > > > > > > > > MakeCheck                     PASS      11.04 seconds
> > > > > > > > > > MakeDistcheck                 PASS      151.18 seconds
> > > > > > > > > > CheckValgrind                 PASS      243.86 seconds
> > > > > > > > > > CheckSmatch                   PASS      326.99 seconds
> > > > > > > > > > bluezmakeextell               PASS      98.83 seconds
> > > > > > > > > > IncrementalBuild              PASS      1262.88 seconds
> > > > > > > > > > ScanBuild                     WARNING   964.73 seconds
> > > > > > > > > >
> > > > > > > > > > Details
> > > > > > > > > > ##############################
> > > > > > > > > > Test: CheckPatch - FAIL
> > > > > > > > > > Desc: Run checkpatch.pl script
> > > > > > > > > > Output:
> > > > > > > > > > [BlueZ,v3,1/2] test-runner: revert udevd and audio supp=
ort
> > > > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52=
efb0751fab396b2b9026c9186b10b88', maybe rebased or not pulled?
> > > > > > > > > > #49:
> > > > > > > > > > This reverts commit 91a48af52efb0751fab396b2b9026c9186b=
10b88
> > > > > > > > > >
> > > > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b0=
5c7edb74255c9b092916ac5bb99c97f', maybe rebased or not pulled?
> > > > > > > > > > #50:
> > > > > > > > > > This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb9=
9c97f
> > > > > > > > > >
> > > > > > > > > > /github/workspace/src/src/13240258.patch total: 0 error=
s, 2 warnings, 193 lines checked
> > > > > > > > > >
> > > > > > > > > > NOTE: For some of the reported defects, checkpatch may =
be able to
> > > > > > > > > >       mechanically convert to the typical style using -=
-fix or --fix-inplace.
> > > > > > > > > >
> > > > > > > > > > /github/workspace/src/src/13240258.patch has style prob=
lems, please review.
> > > > > > > > > >
> > > > > > > > > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MAC=
RO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICEN=
SE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> > > > > > > > > >
> > > > > > > > > > NOTE: If any of the errors are false positives, please =
report
> > > > > > > > > >       them to the maintainer, see CHECKPATCH in MAINTAI=
NERS.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ##############################
> > > > > > > > > > Test: ScanBuild - WARNING
> > > > > > > > > > Desc: Run Scan Build
> > > > > > > > > > Output:
> > > > > > > > > > tools/test-runner.c:924:2: warning: 2nd function call a=
rgument is an uninitialized value
> > > > > > > > > >         printf("Running command %s\n", cmdname ? cmdnam=
e : argv[0]);
> > > > > > > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> > > > > > > > > > 1 warning generated.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > Regards,
> > > > > > > > > > Linux Bluetooth
> > > > > > > > >
> > > > > > > > > I tried running on fedora but it looks like something is =
missing in my setup:
> > > > > > > > >
> > > > > > > > > [E][00003.767959] spa.dbus     | [          dbus.c:  329
> > > > > > > > > impl_connection_get()] Failed to connect to session bus: =
Unable to
> > > > > > > > > autolaun1
> > > > > > > > > [E][00003.769967] mod.portal   | [ module-portal.c:  326
> > > > > > > > > pipewire__module_init()] Failed to connect to session bus=
:
> > > > > > > > > Input/output error
> > > > > > > >
> > > > > > > > I have those two "errors" too, they should be harmless as t=
he xdg-
> > > > > > > > desktop-portal module is optional. With `test-runner -d -l =
-A` you
> > > > > > > > should get the Bluetooth endpoints to appear.
> > > > > > > >
> > > > > > > > Removing the mod.portal from the configuration can't be don=
e with drop-
> > > > > > > > in config files currently, and I didn't want to include a f=
ull config
> > > > > > > > file here as it has some tens of lines of mandatory boilerp=
late.
> > > > > > >
> > > > > > > Ok, looks like it configuring the endpoints:
> > > > > > >
> > > > > > > https://gist.github.com/Vudentz/0d8851e719affd9f2dc1f4081ce32=
fb7
> > > > > > >
> > > > > > > That said I probably need to compile pipewire from source in =
order to
> > > > > > > have the LE Audio endpoints registered, btw do you have any
> > > > > > > instructions on how to build it, do I need to build wireplumb=
er as
> > > > > > > well?
> > > > > >
> > > > > > Should be along these lines to install under $PWD/install and e=
nable
> > > > > > BAP parts:
> > > > > >
> > > > > > git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
> > > > > > cd pipewire
> > > > > > LDFLAGS=3D"-Wl,-rpath=3D$PWD/install/lib64" \
> > > > > >    meson setup builddir --prefix=3D$PWD/install \
> > > > > >        -Dsystemd-user-service=3Ddisabled \
> > > > > >        -Dudevrulesdir=3D$PWD/install/lib/udev/rules.d \
> > > > > >        -Dbluez5-codec-lc3=3Denabled
> > > > > > meson install -C builddir
> > > > > >
> > > > > > Meson will clone and install Wireplumber too. Turning experimen=
tal on
> > > > > > in src/main.conf and it should give
> > > > > >
> > > > > > $ ./tools/test-runner -d -l --audio=3D/home/pauli/tmp/pipewire/=
install/bin/pipewire -k../linux/arch/x86_64/boot/bzImage sleep 5
> > > > > > ...
> > > > > > bluetoothd[29]: profiles/audio/media.c:endpoint_init_pac() PAC =
:1.1:/MediaEndpointLE/BAPSource/lc3 registered
> > > > > > bluetoothd[29]: Endpoint registered: sender=3D:1.1 path=3D/Medi=
aEndpointLE/BAPSource/lc3
> > > > > > bluetoothd[29]: profiles/audio/media.c:client_ready_cb() Media =
application registered: :1.1:/MediaEndpointLE
> > > > > > ...
> > > > >
> > > > > Thanks, something is not quite right for me since I don't see any
> > > > > objects on MediaEndpointLE:
> > > > >
> > > > > https://gist.github.com/Vudentz/242e4e2bfb8907acfdfdf18b458eec1d
> > > >
> > > > It gets "No object received" when trying to register the BAP
> > > > application, so probably the LC3 codec is missing somehow.
> > > >
> > > > meson setup should have reported
> > > > "Bluetooth audio codecs ... LC3 : YES".
> > >
> > > Yep, that shows as enabled.
> > >
> > > > `ldd install/bin/pipewire` should link to libpipewire-0.3.so.0 unde=
r
> > > > the install/ prefix and not to system lib. If not, the rpath in
> > > > compilation accordingly should be adjusted accordingly, or set
> > > > LD_LIBRARY_PATH there.
> > >
> > > libpipewire-0.3.so.0 =3D>
> > > /home/vudentz/git/pipewire/install/lib64/libpipewire-0.3.so.0
> > > (0x00007f3b8e947000)
> > >
> > > > Also the codec plugin
> > > > install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so should exis=
t.
> > >
> > > -rwxr-xr-x. 1 **** **** 166592 May 17 13:39
> > > install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so
> >
> > Does `ldd libspa-codec-bluez5-lc3.so` show it finds liblc3.so?
>
> I guess we found the problem:
>
>     liblc3.so.1 =3D> not found

sudo ln -s liblc3.so liblc3.so.1 fixed it for me, not sure if we
should inform liblc3 folks that this is not done properly when
installing or what.


--=20
Luiz Augusto von Dentz

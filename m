Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ACC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjERTUw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjERTUu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 15:20:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3F95
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 12:20:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so719484e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684437646; x=1687029646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01W0n/C5SlAYyaoPehbE2c2MAbElKZ6n3bQNjUAq84s=;
        b=JJ8CHjrjYgwaMvSVpRKhoGswnjAk+JJ84XOTu8SpfBvL0EC8QAhrQJgeLM/l0s3P+s
         OANMOSVdIxCFglNRZdoTVO3k7lnPOWFmLPk7yyl8bznnkZihAFzKe3YSB6sMoS45bwaV
         ELvCwLk6D7XxY5uX8303fIXEQSZTL3haLoYNwVtXudQkNYbJFOlLD9IuaUE2TBAQ9c7l
         t7MYR2uxJqbyowRiuUjA9a2OyiQyHqOdkdEBJQZbBRweMzm0FUEh7fPMTMy6a1EOiNJr
         3kcnoV9YG+8NQHz09+qQlhaHWqQCWBfYdUuZNlIL7tqsrZ0tiTobVrzYfEuOHmG0le6K
         lYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684437646; x=1687029646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01W0n/C5SlAYyaoPehbE2c2MAbElKZ6n3bQNjUAq84s=;
        b=KHkAbMmjurxygPsnqw71/TUg0QP+a+tiuWA/iJXnsu6+VqOJLcleOu3jf3b2ymg3fd
         lP2uu4Cdkr4g2Qxr4oCFOMqvkpb6VgC+nzRhH6K8GNiw0uRLoaMv8cqdzWtVwAH89xU1
         BWOWOWyyncSTczYNdtNhcdFQAAoGFEiySeUnqNG5dwU593xC1r4vqiUtzGnpWRW0siZN
         RpKxKw9FCsTNHdtHPkZSNpXQ00Mxsf+6UYT4w51aJlDknx/Yl2Q3WOI2TebXdN7AMz1Q
         Wpl5AwkjzDkJjw9GyEQXOhlqaD5jM/u1sR7A/NLfsJmB5dmzjNljq1fPgkwtXntJAUQ7
         sHHA==
X-Gm-Message-State: AC+VfDx01nUgdD3aaQJRV+5XdPYMNDQJgsxIwqFKOc2zMJwc0IjnVt3J
        qK+xQJ9ESLja74KNeV6fEaFykuov0TpV61/NFgLY/iMR/kE=
X-Google-Smtp-Source: ACHHUZ4iy8gLQf2GD5FkVgPfFRGFX7B1qFzTtbXWgUQNjge6EGWhfRTHSExL1yUmIVGmfYfflmzJIOrtJ7sNtz6YiZo=
X-Received: by 2002:ac2:4352:0:b0:4f0:124:b56b with SMTP id
 o18-20020ac24352000000b004f00124b56bmr12247lfl.7.1684437645860; Thu, 18 May
 2023 12:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
 <645fc6ce.630a0220.1799b.9542@mx.google.com> <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
 <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi> <CABBYNZKu7pPE0EddZyzv1mbEW0nePOzf_dawkDJ-e6+ReJvS-A@mail.gmail.com>
 <25523ad612ce4491281743bc8d5a6ccf7673aa76.camel@iki.fi> <CABBYNZJQQQMMbhZBO_4hkvrJwStqTfVjqQ8uphs7acMPGevtyQ@mail.gmail.com>
 <8991642e1279b0d7548482a6102e5c75306d6009.camel@iki.fi> <CABBYNZJvBY9_kzdoLOkOJEFO32h5k5DeAuY4tWC_SdPr4umvug@mail.gmail.com>
 <17725c9488b0d5eb5e39404bcff873d58a1e3edb.camel@iki.fi> <CABBYNZKzCYtNzaDXr3yqaTMsi=7jho9HvSpGGWDtFF53aD0XYw@mail.gmail.com>
 <e70afeae8f6351243a0534de186b40064a46278b.camel@iki.fi>
In-Reply-To: <e70afeae8f6351243a0534de186b40064a46278b.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 May 2023 12:20:33 -0700
Message-ID: <CABBYNZL-TPXNRO=idgzCmX0Ay-Uva7d0MiC9JV2V4iA5PveE9Q@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, May 17, 2023 at 3:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2023-05-17 kello 14:50 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, May 17, 2023 at 2:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > ke, 2023-05-17 kello 14:25 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > Hi Pauli,
> > > >
> > > > On Wed, May 17, 2023 at 2:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > ke, 2023-05-17 kello 13:53 -0700, Luiz Augusto von Dentz kirjoitt=
i:
> > > > > > Hi Pauli,
> > > > > >
> > > > > > On Wed, May 17, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki=
.fi> wrote:
> > > > > > >
> > > > > > > Hi Luiz,
> > > > > > >
> > > > > > > ke, 2023-05-17 kello 12:34 -0700, Luiz Augusto von Dentz kirj=
oitti:
> > > > > > > > Hi Pauli,
> > > > > > > >
> > > > > > > > On Mon, May 15, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav=
@iki.fi> wrote:
> > > > > > > > >
> > > > > > > > > Hi Luiz,
> > > > > > > > >
> > > > > > > > > ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz =
kirjoitti:
> > > > > > > > > > Hi Pauli,
> > > > > > > > > >
> > > > > > > > > > On Sat, May 13, 2023 at 10:41=E2=80=AFAM <bluez.test.bo=
t@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > This is automated email and please do not reply to th=
is email!
> > > > > > > > > > >
> > > > > > > > > > > Dear submitter,
> > > > > > > > > > >
> > > > > > > > > > > Thank you for submitting the patches to the linux blu=
etooth mailing list.
> > > > > > > > > > > This is a CI test results with your patch series:
> > > > > > > > > > > PW Link:https://patchwork.kernel.org/project/bluetoot=
h/list/?series=3D747273
> > > > > > > > > > >
> > > > > > > > > > > ---Test result---
> > > > > > > > > > >
> > > > > > > > > > > Test Summary:
> > > > > > > > > > > CheckPatch                    FAIL      1.14 seconds
> > > > > > > > > > > GitLint                       PASS      0.52 seconds
> > > > > > > > > > > BuildEll                      PASS      26.21 seconds
> > > > > > > > > > > BluezMake                     PASS      745.32 second=
s
> > > > > > > > > > > MakeCheck                     PASS      11.04 seconds
> > > > > > > > > > > MakeDistcheck                 PASS      151.18 second=
s
> > > > > > > > > > > CheckValgrind                 PASS      243.86 second=
s
> > > > > > > > > > > CheckSmatch                   PASS      326.99 second=
s
> > > > > > > > > > > bluezmakeextell               PASS      98.83 seconds
> > > > > > > > > > > IncrementalBuild              PASS      1262.88 secon=
ds
> > > > > > > > > > > ScanBuild                     WARNING   964.73 second=
s
> > > > > > > > > > >
> > > > > > > > > > > Details
> > > > > > > > > > > ##############################
> > > > > > > > > > > Test: CheckPatch - FAIL
> > > > > > > > > > > Desc: Run checkpatch.pl script
> > > > > > > > > > > Output:
> > > > > > > > > > > [BlueZ,v3,1/2] test-runner: revert udevd and audio su=
pport
> > > > > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af=
52efb0751fab396b2b9026c9186b10b88', maybe rebased or not pulled?
> > > > > > > > > > > #49:
> > > > > > > > > > > This reverts commit 91a48af52efb0751fab396b2b9026c918=
6b10b88
> > > > > > > > > > >
> > > > > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0=
b05c7edb74255c9b092916ac5bb99c97f', maybe rebased or not pulled?
> > > > > > > > > > > #50:
> > > > > > > > > > > This reverts commit e20e7e0b05c7edb74255c9b092916ac5b=
b99c97f
> > > > > > > > > > >
> > > > > > > > > > > /github/workspace/src/src/13240258.patch total: 0 err=
ors, 2 warnings, 193 lines checked
> > > > > > > > > > >
> > > > > > > > > > > NOTE: For some of the reported defects, checkpatch ma=
y be able to
> > > > > > > > > > >       mechanically convert to the typical style using=
 --fix or --fix-inplace.
> > > > > > > > > > >
> > > > > > > > > > > /github/workspace/src/src/13240258.patch has style pr=
oblems, please review.
> > > > > > > > > > >
> > > > > > > > > > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_M=
ACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LIC=
ENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> > > > > > > > > > >
> > > > > > > > > > > NOTE: If any of the errors are false positives, pleas=
e report
> > > > > > > > > > >       them to the maintainer, see CHECKPATCH in MAINT=
AINERS.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > ##############################
> > > > > > > > > > > Test: ScanBuild - WARNING
> > > > > > > > > > > Desc: Run Scan Build
> > > > > > > > > > > Output:
> > > > > > > > > > > tools/test-runner.c:924:2: warning: 2nd function call=
 argument is an uninitialized value
> > > > > > > > > > >         printf("Running command %s\n", cmdname ? cmdn=
ame : argv[0]);
> > > > > > > > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> > > > > > > > > > > 1 warning generated.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > Regards,
> > > > > > > > > > > Linux Bluetooth
> > > > > > > > > >
> > > > > > > > > > I tried running on fedora but it looks like something i=
s missing in my setup:
> > > > > > > > > >
> > > > > > > > > > [E][00003.767959] spa.dbus     | [          dbus.c:  32=
9
> > > > > > > > > > impl_connection_get()] Failed to connect to session bus=
: Unable to
> > > > > > > > > > autolaun1
> > > > > > > > > > [E][00003.769967] mod.portal   | [ module-portal.c:  32=
6
> > > > > > > > > > pipewire__module_init()] Failed to connect to session b=
us:
> > > > > > > > > > Input/output error
> > > > > > > > >
> > > > > > > > > I have those two "errors" too, they should be harmless as=
 the xdg-
> > > > > > > > > desktop-portal module is optional. With `test-runner -d -=
l -A` you
> > > > > > > > > should get the Bluetooth endpoints to appear.
> > > > > > > > >
> > > > > > > > > Removing the mod.portal from the configuration can't be d=
one with drop-
> > > > > > > > > in config files currently, and I didn't want to include a=
 full config
> > > > > > > > > file here as it has some tens of lines of mandatory boile=
rplate.
> > > > > > > >
> > > > > > > > Ok, looks like it configuring the endpoints:
> > > > > > > >
> > > > > > > > https://gist.github.com/Vudentz/0d8851e719affd9f2dc1f4081ce=
32fb7
> > > > > > > >
> > > > > > > > That said I probably need to compile pipewire from source i=
n order to
> > > > > > > > have the LE Audio endpoints registered, btw do you have any
> > > > > > > > instructions on how to build it, do I need to build wireplu=
mber as
> > > > > > > > well?
> > > > > > >
> > > > > > > Should be along these lines to install under $PWD/install and=
 enable
> > > > > > > BAP parts:
> > > > > > >
> > > > > > > git clone https://gitlab.freedesktop.org/pipewire/pipewire.gi=
t
> > > > > > > cd pipewire
> > > > > > > LDFLAGS=3D"-Wl,-rpath=3D$PWD/install/lib64" \
> > > > > > >    meson setup builddir --prefix=3D$PWD/install \
> > > > > > >        -Dsystemd-user-service=3Ddisabled \
> > > > > > >        -Dudevrulesdir=3D$PWD/install/lib/udev/rules.d \
> > > > > > >        -Dbluez5-codec-lc3=3Denabled
> > > > > > > meson install -C builddir
> > > > > > >
> > > > > > > Meson will clone and install Wireplumber too. Turning experim=
ental on
> > > > > > > in src/main.conf and it should give
> > > > > > >
> > > > > > > $ ./tools/test-runner -d -l --audio=3D/home/pauli/tmp/pipewir=
e/install/bin/pipewire -k../linux/arch/x86_64/boot/bzImage sleep 5
> > > > > > > ...
> > > > > > > bluetoothd[29]: profiles/audio/media.c:endpoint_init_pac() PA=
C :1.1:/MediaEndpointLE/BAPSource/lc3 registered
> > > > > > > bluetoothd[29]: Endpoint registered: sender=3D:1.1 path=3D/Me=
diaEndpointLE/BAPSource/lc3
> > > > > > > bluetoothd[29]: profiles/audio/media.c:client_ready_cb() Medi=
a application registered: :1.1:/MediaEndpointLE
> > > > > > > ...
> > > > > >
> > > > > > Thanks, something is not quite right for me since I don't see a=
ny
> > > > > > objects on MediaEndpointLE:
> > > > > >
> > > > > > https://gist.github.com/Vudentz/242e4e2bfb8907acfdfdf18b458eec1=
d
> > > > >
> > > > > It gets "No object received" when trying to register the BAP
> > > > > application, so probably the LC3 codec is missing somehow.
> > > > >
> > > > > meson setup should have reported
> > > > > "Bluetooth audio codecs ... LC3 : YES".
> > > >
> > > > Yep, that shows as enabled.
> > > >
> > > > > `ldd install/bin/pipewire` should link to libpipewire-0.3.so.0 un=
der
> > > > > the install/ prefix and not to system lib. If not, the rpath in
> > > > > compilation accordingly should be adjusted accordingly, or set
> > > > > LD_LIBRARY_PATH there.
> > > >
> > > > libpipewire-0.3.so.0 =3D>
> > > > /home/vudentz/git/pipewire/install/lib64/libpipewire-0.3.so.0
> > > > (0x00007f3b8e947000)
> > > >
> > > > > Also the codec plugin
> > > > > install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so should ex=
ist.
> > > >
> > > > -rwxr-xr-x. 1 **** **** 166592 May 17 13:39
> > > > install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so
> > >
> > > Does `ldd libspa-codec-bluez5-lc3.so` show it finds liblc3.so?
> >
> > I guess we found the problem:
> >
> >     liblc3.so.1 =3D> not found
> >
> > > > Perhaps we need to enable more debugs for pipewire to sort this out=
?
> > >
> > > ./tools/test-runner -d -l --audio=3D/home/pauli/tmp/pipewire/install/=
bin/pipewire -k../linux/arch/x86_64/boot/bzImage -- /bin/bash
> > > ... inside vm: ...
> > > pkill wireplumber
> > > export XDG_CONFIG_HOME=3D/run/conf
> > > export XDG_STATE_HOME=3D/run
> > > export XDG_RUNTIME_DIR=3D/run
> > > export WIREPLUMBER_DEBUG=3D4
> > > /home/pauli/tmp/pipewire/install/bin/wireplumber
> > >
> > > should spit out what it tried to do.
> >
> > Yep, here is the full trace:
> >
> > https://gist.github.com/Vudentz/36f9acdc62b623c85e978883ea29c2d3
> >
> > But I think the problem is with the linking of liblc3, are you running
> > with the latest from git? Perhaps I need to install it also in the
> > same path?
>
> Copying liblc3.so* under install/lib64/ probably works since rpath is
> set there. Or maybe /usr/local if not.
>
> I've been running on some older liblc3 git version, but current liblc3
> git 1.0.3 also works.

Btw, do you know gjhenrique? He wrote a very detailed post about the
overall architecture of pipewire with respect to Bluetooth:

https://gjhenrique.com/pipewire/

I'm actually thinking on incorporating something he has done for
capturing TX latency, etc, which is probably going to be useful for LE
as well:

https://github.com/gjhenrique/bluetooth_exporter

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

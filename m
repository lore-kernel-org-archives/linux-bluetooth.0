Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97AC77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 20:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEQUyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEQUyF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 16:54:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A9106
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 13:54:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af0eb50b4aso7956791fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684356842; x=1686948842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIS5fDkn8KI1qYSftwLQktaKZQujRLCh64jZZ24yp2Y=;
        b=H624y5Vn2JRxdiiWYnNhKdTVZ4CfCz+Nv+tByfwbqTYg75XNh2ppT4rsnV85YTswh4
         gxnh6tgYZdUnZzheVmWNCgCa/ChRDERwXlBhzqkuOd5V+GBI+OpZznEkVrtkx6NMfAxc
         lXQOq6oRARRNWCYaE5BdrZ+jtseFgrIkctQVjMfDRiP1Rw0spmzCq2W+p6sDzif/wwY9
         LZNKJTy1l9HaF0uhFas1xsyQRtqcMMa0LABG9kBe4vkLduMMC+YJoxnx+vZNBVtoX7Ck
         nOGMIyYlBNnMAqpTZtwZ/VOaz83O029IZuPuPhaQd8NXjjwHotcJlGEJm7JVEdX4idJG
         DuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684356842; x=1686948842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIS5fDkn8KI1qYSftwLQktaKZQujRLCh64jZZ24yp2Y=;
        b=l9HqLkK0sSE89QtSAPhWh/gAjzmTNvC/p9zXBipK6PLn87915uKBfOEwKWjSfdleJS
         eDamSDPqn9qFd7m+lsH5klTOo2RyjSv4sl7fS8krFjC1MVPyhOgeEtNqUzhk5FVvemHf
         +jjps3m3/XysqMRcB35dC5PQFOiRly8M9mX1TtfinisiSeKfwWCIjCeJi+J+mMCuivZw
         BOUyuHDcSHiOWerptsDWo9lFXXVwd122dNJ8jv0NFF35ixcSk9krBflbWdAgWgqi3TiQ
         y6d4wT6SPtBx6Ot4Q2DflTLbU8sGRj0Nk1xzPy0HyYGpKTz7P4NeoSV0AC5+0dmkd+an
         cBrw==
X-Gm-Message-State: AC+VfDwJSOkMWiSnCwTuz/Fsl+E8Yrg2977quq1NY307eTXldJeD1HDS
        djnBivYxxf38cnndxhfYZ4zCFzVZBe9KfPi3097nQCKDMi8=
X-Google-Smtp-Source: ACHHUZ7f8AFiaKJMB+CmoWAakJRkrGE4GI67Vzetn07AQY/ZAwxWXLlU2yL8DSBxh/MGfHr9efW2hTukqJV0OWK7SjE=
X-Received: by 2002:a2e:b605:0:b0:2a9:f589:1b0 with SMTP id
 r5-20020a2eb605000000b002a9f58901b0mr10323020ljn.15.1684356841714; Wed, 17
 May 2023 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
 <645fc6ce.630a0220.1799b.9542@mx.google.com> <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
 <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi> <CABBYNZKu7pPE0EddZyzv1mbEW0nePOzf_dawkDJ-e6+ReJvS-A@mail.gmail.com>
 <25523ad612ce4491281743bc8d5a6ccf7673aa76.camel@iki.fi>
In-Reply-To: <25523ad612ce4491281743bc8d5a6ccf7673aa76.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 May 2023 13:53:49 -0700
Message-ID: <CABBYNZJQQQMMbhZBO_4hkvrJwStqTfVjqQ8uphs7acMPGevtyQ@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, May 17, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-05-17 kello 12:34 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, May 15, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > Hi Pauli,
> > > >
> > > > On Sat, May 13, 2023 at 10:41=E2=80=AFAM <bluez.test.bot@gmail.com>=
 wrote:
> > > > >
> > > > > This is automated email and please do not reply to this email!
> > > > >
> > > > > Dear submitter,
> > > > >
> > > > > Thank you for submitting the patches to the linux bluetooth maili=
ng list.
> > > > > This is a CI test results with your patch series:
> > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?seri=
es=3D747273
> > > > >
> > > > > ---Test result---
> > > > >
> > > > > Test Summary:
> > > > > CheckPatch                    FAIL      1.14 seconds
> > > > > GitLint                       PASS      0.52 seconds
> > > > > BuildEll                      PASS      26.21 seconds
> > > > > BluezMake                     PASS      745.32 seconds
> > > > > MakeCheck                     PASS      11.04 seconds
> > > > > MakeDistcheck                 PASS      151.18 seconds
> > > > > CheckValgrind                 PASS      243.86 seconds
> > > > > CheckSmatch                   PASS      326.99 seconds
> > > > > bluezmakeextell               PASS      98.83 seconds
> > > > > IncrementalBuild              PASS      1262.88 seconds
> > > > > ScanBuild                     WARNING   964.73 seconds
> > > > >
> > > > > Details
> > > > > ##############################
> > > > > Test: CheckPatch - FAIL
> > > > > Desc: Run checkpatch.pl script
> > > > > Output:
> > > > > [BlueZ,v3,1/2] test-runner: revert udevd and audio support
> > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab=
396b2b9026c9186b10b88', maybe rebased or not pulled?
> > > > > #49:
> > > > > This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
> > > > >
> > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb7425=
5c9b092916ac5bb99c97f', maybe rebased or not pulled?
> > > > > #50:
> > > > > This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
> > > > >
> > > > > /github/workspace/src/src/13240258.patch total: 0 errors, 2 warni=
ngs, 193 lines checked
> > > > >
> > > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > > >       mechanically convert to the typical style using --fix or --=
fix-inplace.
> > > > >
> > > > > /github/workspace/src/src/13240258.patch has style problems, plea=
se review.
> > > > >
> > > > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_S=
TRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPL=
IT_STRING SSCANF_TO_KSTRTO
> > > > >
> > > > > NOTE: If any of the errors are false positives, please report
> > > > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > > >
> > > > >
> > > > > ##############################
> > > > > Test: ScanBuild - WARNING
> > > > > Desc: Run Scan Build
> > > > > Output:
> > > > > tools/test-runner.c:924:2: warning: 2nd function call argument is=
 an uninitialized value
> > > > >         printf("Running command %s\n", cmdname ? cmdname : argv[0=
]);
> > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> > > > > 1 warning generated.
> > > > >
> > > > >
> > > > >
> > > > > ---
> > > > > Regards,
> > > > > Linux Bluetooth
> > > >
> > > > I tried running on fedora but it looks like something is missing in=
 my setup:
> > > >
> > > > [E][00003.767959] spa.dbus     | [          dbus.c:  329
> > > > impl_connection_get()] Failed to connect to session bus: Unable to
> > > > autolaun1
> > > > [E][00003.769967] mod.portal   | [ module-portal.c:  326
> > > > pipewire__module_init()] Failed to connect to session bus:
> > > > Input/output error
> > >
> > > I have those two "errors" too, they should be harmless as the xdg-
> > > desktop-portal module is optional. With `test-runner -d -l -A` you
> > > should get the Bluetooth endpoints to appear.
> > >
> > > Removing the mod.portal from the configuration can't be done with dro=
p-
> > > in config files currently, and I didn't want to include a full config
> > > file here as it has some tens of lines of mandatory boilerplate.
> >
> > Ok, looks like it configuring the endpoints:
> >
> > https://gist.github.com/Vudentz/0d8851e719affd9f2dc1f4081ce32fb7
> >
> > That said I probably need to compile pipewire from source in order to
> > have the LE Audio endpoints registered, btw do you have any
> > instructions on how to build it, do I need to build wireplumber as
> > well?
>
> Should be along these lines to install under $PWD/install and enable
> BAP parts:
>
> git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
> cd pipewire
> LDFLAGS=3D"-Wl,-rpath=3D$PWD/install/lib64" \
>    meson setup builddir --prefix=3D$PWD/install \
>        -Dsystemd-user-service=3Ddisabled \
>        -Dudevrulesdir=3D$PWD/install/lib/udev/rules.d \
>        -Dbluez5-codec-lc3=3Denabled
> meson install -C builddir
>
> Meson will clone and install Wireplumber too. Turning experimental on
> in src/main.conf and it should give
>
> $ ./tools/test-runner -d -l --audio=3D/home/pauli/tmp/pipewire/install/bi=
n/pipewire -k../linux/arch/x86_64/boot/bzImage sleep 5
> ...
> bluetoothd[29]: profiles/audio/media.c:endpoint_init_pac() PAC :1.1:/Medi=
aEndpointLE/BAPSource/lc3 registered
> bluetoothd[29]: Endpoint registered: sender=3D:1.1 path=3D/MediaEndpointL=
E/BAPSource/lc3
> bluetoothd[29]: profiles/audio/media.c:client_ready_cb() Media applicatio=
n registered: :1.1:/MediaEndpointLE
> ...

Thanks, something is not quite right for me since I don't see any
objects on MediaEndpointLE:

https://gist.github.com/Vudentz/242e4e2bfb8907acfdfdf18b458eec1d

Ive used the following command line though to use a real controller:

sudo tools/test-runner -u -d
-A/home/vudentz/git/pipewire/install/bin/pipewire -k
~/git/linux/arch/x86/boot/bzImage -- /bin/bash

Starting with -l instead of -u didn't seem to fix the problem either,
starting bluetoothctl -e does work though:

bluetoothd[35]: profiles/audio/media.c:endpoint_init_pac() PAC
:1.2:/local/endpoint/ep2 registered
bluetoothd[35]: Endpoint registered: sender=3D:1.2 path=3D/local/endpoint/e=
p2

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

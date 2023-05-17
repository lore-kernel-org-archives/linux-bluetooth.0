Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214BC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 21:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEQVmR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQVmQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 17:42:16 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB6213E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 14:42:14 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id BB27924013E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 23:42:11 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QM65H275Lz9rxH;
        Wed, 17 May 2023 23:42:11 +0200 (CEST)
Message-ID: <17725c9488b0d5eb5e39404bcff873d58a1e3edb.camel@iki.fi>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 17 May 2023 21:42:10 +0000
In-Reply-To: <CABBYNZJvBY9_kzdoLOkOJEFO32h5k5DeAuY4tWC_SdPr4umvug@mail.gmail.com>
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
         <645fc6ce.630a0220.1799b.9542@mx.google.com>
         <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
         <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi>
         <CABBYNZKu7pPE0EddZyzv1mbEW0nePOzf_dawkDJ-e6+ReJvS-A@mail.gmail.com>
         <25523ad612ce4491281743bc8d5a6ccf7673aa76.camel@iki.fi>
         <CABBYNZJQQQMMbhZBO_4hkvrJwStqTfVjqQ8uphs7acMPGevtyQ@mail.gmail.com>
         <8991642e1279b0d7548482a6102e5c75306d6009.camel@iki.fi>
         <CABBYNZJvBY9_kzdoLOkOJEFO32h5k5DeAuY4tWC_SdPr4umvug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ke, 2023-05-17 kello 14:25 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Wed, May 17, 2023 at 2:16 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Hi Luiz,
> > 
> > ke, 2023-05-17 kello 13:53 -0700, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > > 
> > > On Wed, May 17, 2023 at 1:30 PM Pauli Virtanen <pav@iki.fi> wrote:
> > > > 
> > > > Hi Luiz,
> > > > 
> > > > ke, 2023-05-17 kello 12:34 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > > Hi Pauli,
> > > > > 
> > > > > On Mon, May 15, 2023 at 1:30 PM Pauli Virtanen <pav@iki.fi> wrote:
> > > > > > 
> > > > > > Hi Luiz,
> > > > > > 
> > > > > > ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > > > > Hi Pauli,
> > > > > > > 
> > > > > > > On Sat, May 13, 2023 at 10:41 AM <bluez.test.bot@gmail.com> wrote:
> > > > > > > > 
> > > > > > > > This is automated email and please do not reply to this email!
> > > > > > > > 
> > > > > > > > Dear submitter,
> > > > > > > > 
> > > > > > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > > > > > This is a CI test results with your patch series:
> > > > > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747273
> > > > > > > > 
> > > > > > > > ---Test result---
> > > > > > > > 
> > > > > > > > Test Summary:
> > > > > > > > CheckPatch                    FAIL      1.14 seconds
> > > > > > > > GitLint                       PASS      0.52 seconds
> > > > > > > > BuildEll                      PASS      26.21 seconds
> > > > > > > > BluezMake                     PASS      745.32 seconds
> > > > > > > > MakeCheck                     PASS      11.04 seconds
> > > > > > > > MakeDistcheck                 PASS      151.18 seconds
> > > > > > > > CheckValgrind                 PASS      243.86 seconds
> > > > > > > > CheckSmatch                   PASS      326.99 seconds
> > > > > > > > bluezmakeextell               PASS      98.83 seconds
> > > > > > > > IncrementalBuild              PASS      1262.88 seconds
> > > > > > > > ScanBuild                     WARNING   964.73 seconds
> > > > > > > > 
> > > > > > > > Details
> > > > > > > > ##############################
> > > > > > > > Test: CheckPatch - FAIL
> > > > > > > > Desc: Run checkpatch.pl script
> > > > > > > > Output:
> > > > > > > > [BlueZ,v3,1/2] test-runner: revert udevd and audio support
> > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab396b2b9026c9186b10b88', maybe rebased or not pulled?
> > > > > > > > #49:
> > > > > > > > This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
> > > > > > > > 
> > > > > > > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb74255c9b092916ac5bb99c97f', maybe rebased or not pulled?
> > > > > > > > #50:
> > > > > > > > This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
> > > > > > > > 
> > > > > > > > /github/workspace/src/src/13240258.patch total: 0 errors, 2 warnings, 193 lines checked
> > > > > > > > 
> > > > > > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > > > > > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > > > > > > 
> > > > > > > > /github/workspace/src/src/13240258.patch has style problems, please review.
> > > > > > > > 
> > > > > > > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> > > > > > > > 
> > > > > > > > NOTE: If any of the errors are false positives, please report
> > > > > > > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > ##############################
> > > > > > > > Test: ScanBuild - WARNING
> > > > > > > > Desc: Run Scan Build
> > > > > > > > Output:
> > > > > > > > tools/test-runner.c:924:2: warning: 2nd function call argument is an uninitialized value
> > > > > > > >         printf("Running command %s\n", cmdname ? cmdname : argv[0]);
> > > > > > > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > 1 warning generated.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > ---
> > > > > > > > Regards,
> > > > > > > > Linux Bluetooth
> > > > > > > 
> > > > > > > I tried running on fedora but it looks like something is missing in my setup:
> > > > > > > 
> > > > > > > [E][00003.767959] spa.dbus     | [          dbus.c:  329
> > > > > > > impl_connection_get()] Failed to connect to session bus: Unable to
> > > > > > > autolaun1
> > > > > > > [E][00003.769967] mod.portal   | [ module-portal.c:  326
> > > > > > > pipewire__module_init()] Failed to connect to session bus:
> > > > > > > Input/output error
> > > > > > 
> > > > > > I have those two "errors" too, they should be harmless as the xdg-
> > > > > > desktop-portal module is optional. With `test-runner -d -l -A` you
> > > > > > should get the Bluetooth endpoints to appear.
> > > > > > 
> > > > > > Removing the mod.portal from the configuration can't be done with drop-
> > > > > > in config files currently, and I didn't want to include a full config
> > > > > > file here as it has some tens of lines of mandatory boilerplate.
> > > > > 
> > > > > Ok, looks like it configuring the endpoints:
> > > > > 
> > > > > https://gist.github.com/Vudentz/0d8851e719affd9f2dc1f4081ce32fb7
> > > > > 
> > > > > That said I probably need to compile pipewire from source in order to
> > > > > have the LE Audio endpoints registered, btw do you have any
> > > > > instructions on how to build it, do I need to build wireplumber as
> > > > > well?
> > > > 
> > > > Should be along these lines to install under $PWD/install and enable
> > > > BAP parts:
> > > > 
> > > > git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
> > > > cd pipewire
> > > > LDFLAGS="-Wl,-rpath=$PWD/install/lib64" \
> > > >    meson setup builddir --prefix=$PWD/install \
> > > >        -Dsystemd-user-service=disabled \
> > > >        -Dudevrulesdir=$PWD/install/lib/udev/rules.d \
> > > >        -Dbluez5-codec-lc3=enabled
> > > > meson install -C builddir
> > > > 
> > > > Meson will clone and install Wireplumber too. Turning experimental on
> > > > in src/main.conf and it should give
> > > > 
> > > > $ ./tools/test-runner -d -l --audio=/home/pauli/tmp/pipewire/install/bin/pipewire -k../linux/arch/x86_64/boot/bzImage sleep 5
> > > > ...
> > > > bluetoothd[29]: profiles/audio/media.c:endpoint_init_pac() PAC :1.1:/MediaEndpointLE/BAPSource/lc3 registered
> > > > bluetoothd[29]: Endpoint registered: sender=:1.1 path=/MediaEndpointLE/BAPSource/lc3
> > > > bluetoothd[29]: profiles/audio/media.c:client_ready_cb() Media application registered: :1.1:/MediaEndpointLE
> > > > ...
> > > 
> > > Thanks, something is not quite right for me since I don't see any
> > > objects on MediaEndpointLE:
> > > 
> > > https://gist.github.com/Vudentz/242e4e2bfb8907acfdfdf18b458eec1d
> > 
> > It gets "No object received" when trying to register the BAP
> > application, so probably the LC3 codec is missing somehow.
> > 
> > meson setup should have reported
> > "Bluetooth audio codecs ... LC3 : YES".
> 
> Yep, that shows as enabled.
> 
> > `ldd install/bin/pipewire` should link to libpipewire-0.3.so.0 under
> > the install/ prefix and not to system lib. If not, the rpath in
> > compilation accordingly should be adjusted accordingly, or set
> > LD_LIBRARY_PATH there.
> 
> libpipewire-0.3.so.0 =>
> /home/vudentz/git/pipewire/install/lib64/libpipewire-0.3.so.0
> (0x00007f3b8e947000)
> 
> > Also the codec plugin
> > install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so should exist.
> 
> -rwxr-xr-x. 1 **** **** 166592 May 17 13:39
> install/lib64/spa-0.2/bluez5/libspa-codec-bluez5-lc3.so

Does `ldd libspa-codec-bluez5-lc3.so` show it finds liblc3.so?

> Perhaps we need to enable more debugs for pipewire to sort this out?

./tools/test-runner -d -l --audio=/home/pauli/tmp/pipewire/install/bin/pipewire -k../linux/arch/x86_64/boot/bzImage -- /bin/bash
... inside vm: ...
pkill wireplumber
export XDG_CONFIG_HOME=/run/conf
export XDG_STATE_HOME=/run
export XDG_RUNTIME_DIR=/run
export WIREPLUMBER_DEBUG=4
/home/pauli/tmp/pipewire/install/bin/wireplumber

should spit out what it tried to do.

-- 
Pauli Virtanen

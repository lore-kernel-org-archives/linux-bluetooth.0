Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Wed, 21 Mar 2018 16:21:31 +0100
Message-ID: <CAOT_U5ZvVd35LTMMBAm332htfFpStzzXkG+6t=Yedtw5i_WTOQ@mail.gmail.com>
Subject: Building BlueZ master from git in Yocto
To: Yocto-mailing-list <yocto@yoctoproject.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Started this issue a few days ago thinking it was a problem with
the bluez flags. I guess it might still be given it tries to build obex
even when it's been configured that is shouldn't...

The exact issue seems to point it's a Yocto related
or might be both (hence both lists). I have configured
BlueZ to build without any flags.

In terms of BlueZ code this means:

    git clone https://git.kernel.org/pub/scm/bluetooth/bluez.git
    cd bluez
    ./bootstrap
    make

This is built correctly for x86.

Trying to replicate that to Yocto, I've extended the recipe to
not to pass any feature configuration flags:

    $ bitbake bluez5 -e | grep EXTRA_OECONF
    ...
    EXTRA_OECONF=""

Before hand did all the steps so that BlueZ is correctly pulled
from master, and no patches from Yocto are applied to it.

Building it with Yocto results in the mentioned error:

| ../git/src/genbuiltin hostname wiimote autopair policy   a2dp avrcp
network input hog  gap scanparam deviceinfo  battery > src/builtin.h
| ../git/obexd/src/genbuiltin filesystem bluetooth  opp ftp irmc pbap
mas mns > obexd/src/builtin.h
| /bin/bash: obexd/src/builtin.h: No such file or directory
| Makefile:9431: recipe for target 'obexd/src/builtin.h' failed
| make: *** [obexd/src/builtin.h] Error 1
| make: *** Waiting for unfinished jobs....
| ERROR: oe_runmake failed
| WARNING: exit code 1 from a shell command.


It seems that for some reason in Yocto, make can't redirect into
`obexd/src/builtin.h` while
it does so successfully for native build.

Open for comments/critics on how to diagnose this.... :)

Be Well,
Alan





On Fri, Mar 16, 2018 at 5:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alan,
>
> On Fri, Mar 16, 2018 at 4:50 PM, Alan Martinovic
> <alan.martinovic@senic.com> wrote:
> > Hi,
> > I'm trying to cross compile a BLE BlueZ master.
> > Am having build issues pointing to obex.
> > I'm building it using Yocto but have stripped it down
> > to the essentials:
> >
> > ./configure
> >   --build=x86_64-linux
> >   --host=arm-linux-gnueabi
> >   --target=arm-linux-gnueabi
> >   --prefix=/usr
> >   --exec_prefix=/usr
> >   --bindir=/usr/bin
> >   --sbindir=/usr/sbin
> >   --libexecdir=/usr/libexec
> >   --datadir=/usr/share
> >   --sysconfdir=/etc
> >   --sharedstatedir=/com
> >   --localstatedir=/var
> >   --libdir=/usr/lib
> >   --includedir=/usr/include
> >   --oldincludedir=/usr/include
> >   --infodir=/usr/share/info
> >   --mandir=/usr/share/man
> >   --disable-silent-rules
> >   --disable-dependency-tracking
> >   --with-libtool-sysroot=/home/alan/senic-os/build/tmp-glibc/work/cortexa7hf-neon-vfpv4-senic-linux-gnueabi/bluez5/5.49+gitAUTOINC+969dfae9a7-r0/recipe-sysroot
> >   --enable-test
> >   --enable-datafiles
> >   --enable-library
> >   --enable-a2dp
> >   --enable-avrcp
> >   --disable-cups
> >   --enable-deprecated
> >   --disable-health
> >   --enable-hid
> >   --enable-hog
> >   --disable-midi
> >   --enable-network
> >   --disable-nfc
> >   --disable-obex
> >   --enable-client
> >   --disable-sap
> >   --disable-sixaxis
> >   --enable-systemd
> >   --disable-testing
> >   --disable-threads
> >   --enable-tools
> > make -j 16
> >
> > This results in a build error:
> >
> >  ../git/obexd/src/genbuiltin filesystem bluetooth  opp ftp  mas mns >
> > obexd/src/builtin.h
> >  /bin/bash: obexd/src/builtin.h: No such file or directory
> >  Makefile:9431: recipe for target 'obexd/src/builtin.h' failed
> >
> >
> > Given that I don't need it for BLE, what else is required
> > besides "--disable-obex" to bypass this error?
>
> Obviously, it is a bug in the way we handle --disable-obex so we will
> need to fix it.
>
> --
> Luiz Augusto von Dentz

Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] tools: Add initial code for btmon-logger
Date: Tue, 16 Jan 2018 15:15:16 +0100
Message-ID: <7086609.337NVEs3t0@ix>
In-Reply-To: <F0C80F8E-0CEA-4FEA-92C8-65005D188020@holtmann.org>
References: <20180112142546.31424-1-szymon.janc@codecoup.pl> <3417178.fibeJ9uDTt@ix> <F0C80F8E-0CEA-4FEA-92C8-65005D188020@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Monday, 15 January 2018 16:08:30 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> >>> This is intended for use for automted logging or unatrended systems.
> >>> It doesn't contain any packet decoding functionality which results
> >>> in much smaller binary.
> >>> ---
> >>> .gitignore           |   1 +
> >>> Makefile.tools       |   6 +
> >>> tools/btmon-logger.c | 359
> >>> +++++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, =
366
> >>> insertions(+)
> >>> create mode 100644 tools/btmon-logger.c
> >>>=20
> >>> diff --git a/.gitignore b/.gitignore
> >>> index 47808059b..33ec66048 100644
> >>> --- a/.gitignore
> >>> +++ b/.gitignore
> >>> @@ -118,6 +118,7 @@ tools/btconfig
> >>> tools/btmgmt
> >>> tools/btsnoop
> >>> tools/btpclient
> >>> +tools/btmon-logger
> >>> peripheral/btsensor
> >>> monitor/btmon
> >>> emulator/btvirt
> >>> diff --git a/Makefile.tools b/Makefile.tools
> >>> index 651ff00ca..1accfb4f0 100644
> >>> --- a/Makefile.tools
> >>> +++ b/Makefile.tools
> >>> @@ -62,6 +62,12 @@ monitor_btmon_SOURCES =3D monitor/main.c monitor/b=
t.h \
> >>>=20
> >>> 				monitor/tty.h
> >>>=20
> >>> monitor_btmon_LDADD =3D lib/libbluetooth-internal.la \
> >>>=20
> >>> 				src/libshared-mainloop.la @UDEV_LIBS@
> >>>=20
> >>> +
> >>> +
> >>=20
> >> one empty line.
> >>=20
> >>> +noinst_PROGRAMS +=3D tools/btmon-logger
> >>> +
> >>> +tools_btmon_logger_SOURCES =3D tools/btmon-logger.c
> >>> +tools_btmon_logger_LDADD =3D src/libshared-mainloop.la
> >>> endif
> >>>=20
> >>> if TESTING
> >>> diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> >>> new file mode 100644
> >>> index 000000000..fe5f101b4
> >>> --- /dev/null
> >>> +++ b/tools/btmon-logger.c
> >>> @@ -0,0 +1,359 @@
> >>> +/*
> >>> + *
> >>> + *  BlueZ - Bluetooth protocol stack for Linux
> >>> + *
> >>> + *  Copyright (C) 2017  Codecoup
> >>=20
> >> Lets assume that some of the code is copied from existing btmon sources
> >> and
> >> so lets keep Intel copyright in place as well :)
> >>=20
> >>> + *
> >>> + *
> >>> + *  This program is free software; you can redistribute it and/or
> >>> modify
> >>> + *  it under the terms of the GNU General Public License as published
> >>> by
> >>> + *  the Free Software Foundation; either version 2 of the License, or
> >>> + *  (at your option) any later version.
> >>> + *
> >>> + *  This program is distributed in the hope that it will be useful,
> >>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + *  GNU General Public License for more details.
> >>> + *
> >>> + *  You should have received a copy of the GNU General Public License
> >>> + *  along with this program; if not, write to the Free Software
> >>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA=20
> >>> 02110-1301
> >>> USA + *
> >>> + */
> >>> +
> >>> +#ifdef HAVE_CONFIG_H
> >>> +#include <config.h>
> >>> +#endif
> >>> +
> >>> +#include <stdio.h>
> >>> +#include <stdlib.h>
> >>> +#include <limits.h>
> >>> +#include <string.h>
> >>> +#include <time.h>
> >>> +#include <getopt.h>
> >>> +#include <unistd.h>
> >>> +#include <sys/socket.h>
> >>> +
> >>> +#include "lib/bluetooth.h"
> >>> +#include "lib/hci.h"
> >>> +#include "lib/mgmt.h=E2=80=9D
> >>=20
> >> the mgmt.h should not be needed.
> >=20
> > This is needed for struct mgmt_hdr definition.
>=20
> hmmm. That seems like an odd dependency and I think we need to get rid of
> it. I know that the headers are alike, but that is more a coincidence than
> something that should bleed through in the code.

So how do I move this forward? Should we have separate lib/mgmt_monitor.h w=
ith=20
those? Or just simple src/shared/monitor.c that would wrap this and allows =
to=20
handle monitoring on top of provided sk (it would be quite simple I suppose=
)?=20

=2D-=20
pozdrawiam
Szymon Janc

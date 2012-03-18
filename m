Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>
CC: "Ganir, Chen" <chen.ganir@ti.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] GATT: Change the way GATT Plugins are
 enabled/disabled
Date: Sun, 18 Mar 2012 06:47:50 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B451054@DNCE02.ent.ti.com>
References: <1331723767-21436-1-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331723767-21436-1-git-send-email-chen.ganir@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Johan, Marcell,

What about this patch set ?

Thanks,
Chen Ganir


> -----Original Message-----
> From: Chen Ganir [mailto:chen.ganir@gmail.com] On Behalf Of Ganir, Chen
> Sent: Wednesday, March 14, 2012 1:16 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Ganir, Chen
> Subject: [PATCH v3 0/3] GATT: Change the way GATT Plugins are
> enabled/disabled
>=20
> From: Chen Ganir <chen.ganir@ti.com>
>=20
> This patch set is a result of the discussion on the #bluez channel.
>=20
> Consolidate the --enable_<profile> for gatt profiles into a single
> switch, called --enable_gatt.
>=20
> In addition, modify the AttributeServer propery in the main.conf to
> EnableGatt option (default=3Dfalse) and make sure all GATT plugins query
> this option before trying to load (in the _init function of the
> plugin)
>=20
> This is v3 of the patch set - fixed as suggested on the mailing list.
>=20
> Chen Ganir (3):
>   GATT: Remove individual config switches
>   GATT: Rename Attribute Server switch
>   GATT: Profile support for EnableGatt
>=20
>  Makefile.am            |   38 ++++++++++----------------------------
>  Makefile.tools         |    8 +++++---
>  acinclude.m4           |   32 ++++----------------------------
>  alert/main.c           |    9 +++++----
>  bootstrap-configure    |    6 +-----
>  plugins/gatt-example.c |    6 +++---
>  proximity/main.c       |   10 +++++++++-
>  proximity/reporter.c   |    7 ++++---
>  src/adapter.c          |    8 ++++----
>  src/hcid.h             |    2 +-
>  src/main.c             |    4 ++--
>  src/main.conf          |    5 ++---
>  thermometer/main.c     |   11 +++++++++++
>  time/main.c            |    9 +++++----
>  14 files changed, 66 insertions(+), 89 deletions(-)
>=20
> --
> 1.7.4.1

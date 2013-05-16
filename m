Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368466988-13651-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368466988-13651-1-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 16 May 2013 12:31:29 -0300
Message-ID: <CAMOw1v7fkpJjD7tUBVSQEfw2fmo3YragfS_ev-s9q1YHtX1RJA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build-sys: Don't build gdbus several times
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Marcel


On Mon, May 13, 2013 at 2:43 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>
> We are currently compiling gdbus 3 times: one for tests, one for
> bluetoothd and another for obexd.
>
> $ ls gdbus/*watch.o
> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
>
> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
> a convenience library.
> ---
>  Makefile.am    | 16 +++++++++++-----
>  Makefile.obexd |  4 ++--
>  Makefile.tools | 24 ++++++++++++------------
>  3 files changed, 25 insertions(+), 19 deletions(-)

Ping

Lucas De Marchi


>
>
> diff --git a/Makefile.am b/Makefile.am
> index da87a21..19574fc 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -112,6 +112,11 @@ builtin_nodist =
>
>  include Makefile.plugins
>
> +noinst_LTLIBRARIES += gdbus/libgdbus.la
> +gdbus_libgdbus_la_SOURCES = $(gdbus_sources)
> +gdbus_libgdbus_la_LDFLAGS = $(AM_LDFLAGS) @DBUS_LIBS@ @GLIB_LIBS@
> +gdbus_libgdbus_la_CFLAGS = $(AM_CFLAGS) @DBUS_CFLAGS@ @GLIB_CFLAGS@
> +
>  if MAINTAINER_MODE
>  plugin_LTLIBRARIES += plugins/external-dummy.la
>  plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
> @@ -122,7 +127,7 @@ endif
>
>  libexec_PROGRAMS += src/bluetoothd
>
> -src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
> +src_bluetoothd_SOURCES = $(builtin_sources) \
>                         $(attrib_sources) $(btio_sources) \
>                         src/bluetooth.ver \
>                         src/main.c src/log.h src/log.c \
> @@ -148,8 +153,9 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
>                         src/eir.h src/eir.c \
>                         src/shared/util.h src/shared/util.c \
>                         src/shared/mgmt.h src/shared/mgmt.c
> -src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
> -                                                               -ldl -lrt
> +src_bluetoothd_LDADD = lib/libbluetooth-private.la gdbus/libgdbus.la \
> +                       @GLIB_LIBS@ @DBUS_LIBS@ \
> +                       -ldl -lrt
>  src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
>                                 -Wl,--version-script=$(srcdir)/src/bluetooth.ver
>
> @@ -245,8 +251,8 @@ unit_test_sdp_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
>
>  unit_tests += unit/test-gdbus-client
>
> -unit_test_gdbus_client_SOURCES = $(gdbus_sources) unit/test-gdbus-client.c
> -unit_test_gdbus_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
> +unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
> +unit_test_gdbus_client_LDADD = gdbus/libgdbus.la @GLIB_LIBS@ @DBUS_LIBS@
>
>  unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
>                         unit/test-gobex-transfer unit/test-gobex-apparam
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 5824e0a..37aa2d9 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -54,7 +54,7 @@ obexd_builtin_sources += obexd/client/mns.c obexd/src/map_ap.h \
>
>  libexec_PROGRAMS += obexd/src/obexd
>
> -obexd_src_obexd_SOURCES = $(gdbus_sources) $(btio_sources) $(gobex_sources) \
> +obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
>                         $(obexd_builtin_sources) \
>                         obexd/src/main.c obexd/src/obexd.h \
>                         obexd/src/plugin.h obexd/src/plugin.c \
> @@ -78,7 +78,7 @@ obexd_src_obexd_SOURCES = $(gdbus_sources) $(btio_sources) $(gobex_sources) \
>                         obexd/client/dbus.h obexd/client/dbus.c \
>                         obexd/client/driver.h obexd/client/driver.c \
>                         obexd/src/map_ap.h
> -obexd_src_obexd_LDADD = lib/libbluetooth-private.la \
> +obexd_src_obexd_LDADD = gdbus/libgdbus.la lib/libbluetooth-private.la \
>                                 @ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
>
>  obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
> diff --git a/Makefile.tools b/Makefile.tools
> index 0de0a0d..c35d785 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -2,11 +2,12 @@
>  if CLIENT
>  bin_PROGRAMS += client/bluetoothctl
>
> -client_bluetoothctl_SOURCES = $(gdbus_sources) client/main.c \
> +client_bluetoothctl_SOURCES = client/main.c \
>                                         client/display.h client/display.c \
>                                         client/agent.h client/agent.c \
>                                         monitor/uuid.h monitor/uuid.c
> -client_bluetoothctl_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
> +client_bluetoothctl_LDADD = gdbus/libgdbus.la @GLIB_LIBS@ @DBUS_LIBS@ \
> +                               -lreadline
>  endif
>
>  if MONITOR
> @@ -47,13 +48,12 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
>                                 src/shared/tester.h src/shared/tester.c
>  tools_mgmt_tester_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
>
> -tools_gap_tester_SOURCES = $(gdbus_sources) \
> -                               tools/gap-tester.c monitor/bt.h \
> +tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
>                                 emulator/btdev.h emulator/btdev.c \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 src/shared/hciemu.h src/shared/hciemu.c \
>                                 src/shared/tester.h src/shared/tester.c
> -tools_gap_tester_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
> +tools_gap_tester_LDADD = gdbus/libgdbus.la @GLIB_LIBS@ @DBUS_LIBS@
>  endif
>
>  if TOOLS
> @@ -176,8 +176,8 @@ tools_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
>  tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
>  tools_btiotest_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
>
> -tools_mpris_player_SOURCES = $(gdbus_sources) tools/mpris-player.c
> -tools_mpris_player_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
> +tools_mpris_player_SOURCES = tools/mpris-player.c
> +tools_mpris_player_LDADD = gdbus/libgdbus.la @GLIB_LIBS@ @DBUS_LIBS@
>
>  EXTRA_DIST += tools/bdaddr.1
>  endif
> @@ -206,8 +206,8 @@ endif
>  if EXPERIMENTAL
>  noinst_PROGRAMS += profiles/iap/iapd
>
> -profiles_iap_iapd_SOURCES = $(gdbus_sources) profiles/iap/main.c
> -profiles_iap_iapd_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
> +profiles_iap_iapd_SOURCES = profiles/iap/main.c
> +profiles_iap_iapd_LDADD = gdbus/libgdbus.la @GLIB_LIBS@ @DBUS_LIBS@
>  endif
>
>  if CUPS
> @@ -215,14 +215,14 @@ cupsdir = $(libdir)/cups/backend
>
>  cups_PROGRAMS = profiles/cups/bluetooth
>
> -profiles_cups_bluetooth_SOURCES = $(gdbus_sources) profiles/cups/main.c \
> +profiles_cups_bluetooth_SOURCES = profiles/cups/main.c \
>                                         profiles/cups/cups.h \
>                                         profiles/cups/sdp.c \
>                                         profiles/cups/spp.c \
>                                         profiles/cups/hcrp.c
>
> -profiles_cups_bluetooth_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ \
> -                               lib/libbluetooth-private.la
> +profiles_cups_bluetooth_LDADD = gdbus/libgdbus.la lib/libbluetooth-private.la \
> +                               @GLIB_LIBS@ @DBUS_LIBS@
>  endif
>
>  test_scripts += test/sap_client.py test/bluezutils.py \
> --
> 1.8.2.3
>

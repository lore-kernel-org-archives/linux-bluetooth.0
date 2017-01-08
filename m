Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 08 Jan 2017 10:48:07 +0100
In-Reply-To: <20170104133401.3636-1-luiz.dentz@gmail.com>
References: <20170104133401.3636-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH BlueZ 1/3] build: Hide deprecated tools under --enable-deprecated
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
From: Felipe Ferreri Tonello <eu@felipetonello.com>
Message-ID: <208F040D-7BC8-43BD-B34A-DCA35E3E48DA@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,=20

On January 4, 2017 2:33:59 PM GMT+01:00, Luiz Augusto von Dentz <luiz=2Ede=
ntz@gmail=2Ecom> wrote:
>From: Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>
>
>This marks the following tools as deprecated as they are not longer
>maintained or have been replaced by other tools:
>
>  hciattach hciconfig hcitool hcidump rfcomm sdptool ciptool gatttool

Perhaps you could add a patch to this set to document --enable-midi option=
 as well=2E I could so it myself but I am on holiday and this is such a sim=
ple patch=2E If not I can send it later=2E=20

It could be something like this:
Enable MIDI support via ALSA Sequencer=2E bluetoothd will create a new ALS=
A Sequencer client and port for each device connected that supports the MID=
I GATT primary service=2E=20


>---
>Makefile=2Etools | 86
>++++++++++++++++++++++++++++++++--------------------------
> README         | 11 ++++++++
> configure=2Eac   |  2 +-
> 3 files changed, 59 insertions(+), 40 deletions(-)
>
>diff --git a/Makefile=2Etools b/Makefile=2Etools
>index 7706dc7=2E=2E9841d31 100644
>--- a/Makefile=2Etools
>+++ b/Makefile=2Etools
>@@ -154,11 +154,35 @@ tools_userchan_tester_LDADD =3D
>lib/libbluetooth-internal=2Ela \
> endif
>=20
> if TOOLS
>-bin_PROGRAMS +=3D tools/hciattach tools/hciconfig tools/hcitool
>tools/hcidump \
>-			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
>-			tools/sdptool tools/ciptool tools/bccmd \
>+bin_PROGRAMS +=3D tools/rctest tools/l2test tools/l2ping tools/bccmd \
> 			tools/bluemoon tools/hex2hcd tools/mpris-proxy
>=20
>+tools_rctest_LDADD =3D lib/libbluetooth-internal=2Ela
>+
>+tools_l2test_LDADD =3D lib/libbluetooth-internal=2Ela
>+
>+tools_l2ping_LDADD =3D lib/libbluetooth-internal=2Ela
>+
>+tools_bccmd_SOURCES =3D tools/bccmd=2Ec tools/csr=2Eh tools/csr=2Ec \
>+			tools/csr_hci=2Ec tools/csr_usb=2Ec \
>+			tools/csr_h4=2Ec tools/csr_3wire=2Ec \
>+			tools/csr_bcsp=2Ec tools/ubcsp=2Eh tools/ubcsp=2Ec
>+tools_bccmd_LDADD =3D lib/libbluetooth-internal=2Ela
>+
>+tools_bluemoon_SOURCES =3D tools/bluemoon=2Ec monitor/bt=2Eh
>+tools_bluemoon_LDADD =3D src/libshared-mainloop=2Ela
>+
>+tools_hex2hcd_SOURCES =3D tools/hex2hcd=2Ec
>+
>+tools_mpris_proxy_SOURCES =3D tools/mpris-proxy=2Ec
>+tools_mpris_proxy_LDADD =3D gdbus/libgdbus-internal=2Ela @GLIB_LIBS@
>@DBUS_LIBS@
>+
>+dist_man_MANS +=3D tools/rctest=2E1 tools/l2ping=2E1 tools/bccmd=2E1
>+
>+if DEPRECATED
>+bin_PROGRAMS +=3D tools/hciattach tools/hciconfig tools/hcitool
>tools/hcidump \
>+			tools/rfcomm tools/sdptool tools/ciptool
>+
> tools_hciattach_SOURCES =3D tools/hciattach=2Ec tools/hciattach=2Eh \
> 						tools/hciattach_st=2Ec \
> 						tools/hciattach_ti=2Ec \
>@@ -200,44 +224,25 @@ tools_hcidump_SOURCES =3D tools/hcidump=2Ec \
> 				tools/parser/ericsson=2Ec \
> 				tools/parser/csr=2Ec \
> 				tools/parser/bpa=2Ec
>-tools_hcidump_LDADD =3D lib/libbluetooth-internal=2Ela
>-
>-tools_rfcomm_LDADD =3D lib/libbluetooth-internal=2Ela
>-
>-tools_rctest_LDADD =3D lib/libbluetooth-internal=2Ela
>-
>-tools_l2test_LDADD =3D lib/libbluetooth-internal=2Ela
>-
>-tools_l2ping_LDADD =3D lib/libbluetooth-internal=2Ela
>=20
> tools_sdptool_SOURCES =3D tools/sdptool=2Ec src/sdp-xml=2Eh src/sdp-xml=
=2Ec
> tools_sdptool_LDADD =3D lib/libbluetooth-internal=2Ela @GLIB_LIBS@
>=20
> tools_ciptool_LDADD =3D lib/libbluetooth-internal=2Ela
>+tools_hcidump_LDADD =3D lib/libbluetooth-internal=2Ela
>=20
>-tools_bccmd_SOURCES =3D tools/bccmd=2Ec tools/csr=2Eh tools/csr=2Ec \
>-			tools/csr_hci=2Ec tools/csr_usb=2Ec \
>-			tools/csr_h4=2Ec tools/csr_3wire=2Ec \
>-			tools/csr_bcsp=2Ec tools/ubcsp=2Eh tools/ubcsp=2Ec
>-tools_bccmd_LDADD =3D lib/libbluetooth-internal=2Ela
>-
>-tools_bluemoon_SOURCES =3D tools/bluemoon=2Ec monitor/bt=2Eh
>-tools_bluemoon_LDADD =3D src/libshared-mainloop=2Ela
>-
>-tools_hex2hcd_SOURCES =3D tools/hex2hcd=2Ec
>-
>-tools_mpris_proxy_SOURCES =3D tools/mpris-proxy=2Ec
>-tools_mpris_proxy_LDADD =3D gdbus/libgdbus-internal=2Ela @GLIB_LIBS@
>@DBUS_LIBS@
>+tools_rfcomm_LDADD =3D lib/libbluetooth-internal=2Ela
>=20
> dist_man_MANS +=3D tools/hciattach=2E1 tools/hciconfig=2E1 \
> 			tools/hcitool=2E1 tools/hcidump=2E1 \
>-			tools/rfcomm=2E1 tools/rctest=2E1 tools/l2ping=2E1 \
>-			tools/sdptool=2E1 tools/ciptool=2E1 tools/bccmd=2E1
>+			tools/rfcomm=2E1 tools/sdptool=2E1 tools/ciptool=2E1
> else
> EXTRA_DIST +=3D tools/hciattach=2E1 tools/hciconfig=2E1 \
> 			tools/hcitool=2E1 tools/hcidump=2E1 \
>-			tools/rfcomm=2E1 tools/rctest=2E1 tools/l2ping=2E1 \
>-			tools/sdptool=2E1 tools/ciptool=2E1 tools/bccmd=2E1
>+			tools/rfcomm=2E1 tools/sdptool=2E1 tools/ciptool=2E1
>+endif
>+else
>+EXTRA_DIST +=3D tools/rctest=2E1 tools/l2ping=2E1 tools/bccmd=2E1
> endif
>=20
> if HID2HCI
>@@ -343,18 +348,9 @@ EXTRA_DIST +=3D tools/btattach=2E1
> endif
>=20
> if READLINE
>-noinst_PROGRAMS +=3D attrib/gatttool tools/btmgmt \
>-			tools/obex-client-tool tools/obex-server-tool \
>+noinst_PROGRAMS +=3D tools/btmgmt tools/obex-client-tool
>tools/obex-server-tool \
> 			tools/bluetooth-player tools/obexctl
>=20
>-attrib_gatttool_SOURCES =3D attrib/gatttool=2Ec attrib/att=2Ec attrib/ga=
tt=2Ec
>\
>-				attrib/gattrib=2Ec btio/btio=2Ec \
>-				attrib/gatttool=2Eh attrib/interactive=2Ec \
>-				attrib/utils=2Ec src/log=2Ec client/display=2Ec \
>-				client/display=2Eh
>-attrib_gatttool_LDADD =3D lib/libbluetooth-internal=2Ela \
>-			src/libshared-glib=2Ela @GLIB_LIBS@ -lreadline
>-
> tools_obex_client_tool_SOURCES =3D $(gobex_sources) $(btio_sources) \
> 						tools/obex-client-tool=2Ec
> tools_obex_client_tool_LDADD =3D lib/libbluetooth-internal=2Ela \
>@@ -377,6 +373,18 @@ tools_obexctl_LDADD =3D gdbus/libgdbus-internal=2Ela=
 \
>tools_btmgmt_SOURCES =3D tools/btmgmt=2Ec src/uuid-helper=2Ec
>client/display=2Ec
>tools_btmgmt_LDADD =3D lib/libbluetooth-internal=2Ela
>src/libshared-mainloop=2Ela \
> 				-lreadline
>+if DEPRECATED
>+noinst_PROGRAMS +=3D attrib/gatttool
>+
>+attrib_gatttool_SOURCES =3D attrib/gatttool=2Ec attrib/att=2Ec attrib/ga=
tt=2Ec
>\
>+				attrib/gattrib=2Ec btio/btio=2Ec \
>+				attrib/gatttool=2Eh attrib/interactive=2Ec \
>+				attrib/utils=2Ec src/log=2Ec client/display=2Ec \
>+				client/display=2Eh
>+attrib_gatttool_LDADD =3D lib/libbluetooth-internal=2Ela \
>+			src/libshared-glib=2Ela @GLIB_LIBS@ -lreadline
>+
>+endif
> endif
>=20
> if EXPERIMENTAL
>diff --git a/README b/README
>index 7b6001b=2E=2Ec42a113 100644
>--- a/README
>+++ b/README
>@@ -166,6 +166,17 @@ For a working system, certain configuration
>options need to be enabled:
> 		systems=2E The behavior of the experimental tools is unstable
> 		and might still change=2E
>=20
>+	--enable-deprecated
>+
>+		Enable deprecated tools
>+
>+		By defauld all tools that are no longer maintained are
>+		disabled=2E This option can be used to enable them=2E
>+
>+		It is not recommended to enable this option for production
>+		systems=2E The behavior of the deprecated tools may be unstable
>+		or simply don't work anymore=2E
>+
> 	--enable-nfc
>=20
> 		This option enable NFC pairing support=2E
>diff --git a/configure=2Eac b/configure=2Eac
>index 2b0363c=2E=2Efb8deab 100644
>--- a/configure=2Eac
>+++ b/configure=2Eac
>@@ -291,7 +291,7 @@ AC_ARG_ENABLE(experimental,
>AC_HELP_STRING([--enable-experimental],
> AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" =3D "yes")
>=20
> AC_ARG_ENABLE(deprecated, AC_HELP_STRING([--enable-deprecated],
>-			[enable deprecated plugins (BLE services, =2E=2E=2E)]),
>+			[enable deprecated tools]),
> 					[enable_deprecated=3D${enableval}])
> AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" =3D "yes")
>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

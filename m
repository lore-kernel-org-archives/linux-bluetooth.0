Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1376922779-11802-2-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
	<1376922779-11802-2-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 20 Aug 2013 15:28:04 +0300
Message-ID: <CABBYNZKBB-KyOkKvRT_GZhkt6xWCjxcsMEun8wrKn3WCWrSBiA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix not checking readline.h for bluetooth-player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 19, 2013 at 5:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If --disable-client is passed to configure script is possible to build
> BlueZ without readline which would cause the following error:
>
> tools/bluetooth-player.c:36:31: fatal error: readline/readline.h: No such file or directory
>  #include <readline/readline.h>
>                                ^
> ---
>  Makefile.tools | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 3bb0e82..4bcb18e 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -172,8 +172,7 @@ if EXPERIMENTAL
>  noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest tools/scotest \
>                         tools/hcieventmask tools/hcisecfilter tools/hwdb \
>                         tools/btmgmt tools/btattach tools/btsnoop \
> -                       tools/btiotest tools/mpris-player \
> -                       tools/bluetooth-player
> +                       tools/btiotest tools/mpris-player
>
>  tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
>  tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
> @@ -199,17 +198,13 @@ tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
>  tools_mpris_player_SOURCES = tools/mpris-player.c
>  tools_mpris_player_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
>
> -tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
> -                               client/display.h client/display.c
> -tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
> -
>  EXTRA_DIST += tools/bdaddr.1
>  endif
>
>  if READLINE
>  noinst_PROGRAMS += attrib/gatttool \
> -                       tools/obex-client-tool tools/obex-server-tool
> +                       tools/obex-client-tool tools/obex-server-tool \
> +                       tools/bluetooth-player
>
>  attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
>                                 attrib/gattrib.c btio/btio.c \
> @@ -226,6 +221,11 @@ tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
>  tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
>                                                 tools/obex-server-tool.c
>  tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +
> +tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
> +                               client/display.h client/display.c
> +tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
> +                               @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
>  endif
>
>  if EXPERIMENTAL
> --
> 1.8.3.1

I went ahead and applied this one.


-- 
Luiz Augusto von Dentz

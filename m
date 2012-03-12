Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331470642-23924-2-git-send-email-chen.ganir@ti.com>
References: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
	<1331470642-23924-2-git-send-email-chen.ganir@ti.com>
Date: Sun, 11 Mar 2012 21:29:09 -0300
Message-ID: <CAKT1EBdh5JGHg0rVjTGXOjSg+f0DtJkpeW3HLjCeagfQ=5JZDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Added DeviceInformation GATT Client
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir:

On Sun, Mar 11, 2012 at 9:57 AM,  <chen.ganir@gmail.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Added the DeviceInformation GATT Client plugin skeleton.
> ---
>  Makefile.am             |    7 ++++
>  acinclude.m4            |    6 +++
>  deviceinfo/deviceinfo.c |   89 +++++++++++++++++++++++++++++++++++++++++++++
>  deviceinfo/deviceinfo.h |   26 +++++++++++++
>  deviceinfo/main.c       |   60 ++++++++++++++++++++++++++++++
>  deviceinfo/manager.c    |   92 +++++++++++++++++++++++++++++++++++++++++++++++
>  deviceinfo/manager.h    |   25 +++++++++++++
>  7 files changed, 305 insertions(+), 0 deletions(-)
>  create mode 100644 deviceinfo/deviceinfo.c
>  create mode 100644 deviceinfo/deviceinfo.h
>  create mode 100644 deviceinfo/main.c
>  create mode 100644 deviceinfo/manager.c
>  create mode 100644 deviceinfo/manager.h
>
> diff --git a/Makefile.am b/Makefile.am
> index bd587eb..c2c61d6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -244,6 +244,13 @@ builtin_sources += thermometer/main.c \
>                        thermometer/thermometer.h thermometer/thermometer.c
>  endif
>
> +if DEVICEINFOPLUGIN
> +builtin_modules += deviceinfo
> +builtin_sources += deviceinfo/main.c \
> +                       deviceinfo/manager.h deviceinfo/manager.c \
> +                       deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
> +endif
> +
>  builtin_modules += hciops mgmtops
>  builtin_sources += plugins/hciops.c plugins/mgmtops.c
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index b0f790c..14b7a4c 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -220,6 +220,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>        dbusoob_enable=no
>        wiimote_enable=no
>        thermometer_enable=no
> +       deviceinfo_enable=no
>
>        AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
>                optimization_enable=${enableval}
> @@ -372,6 +373,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>                thermometer_enable=${enableval}
>        ])
>
> +       AC_ARG_ENABLE(deviceinfo, AC_HELP_STRING([--enable-deviceinfo], [enable deviceinfo plugin]), [
> +               deviceinfo_enable=${enableval}
> +       ])
> +
>        if (test "${fortify_enable}" = "yes"); then
>                CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
>        fi
> @@ -429,4 +434,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>        AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
>        AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
>        AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
> +       AM_CONDITIONAL(DEVICEINFOPLUGIN, test "${deviceinfo_enable}" = "yes")
>  ])
> diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
> new file mode 100644
> index 0000000..30920e3
> --- /dev/null
> +++ b/deviceinfo/deviceinfo.c
> @@ -0,0 +1,89 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
> + *  Copyright (C) 2012 Texas Instruments, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <gdbus.h>
> +#include <errno.h>
> +#include <bluetooth/uuid.h>
> +
> +#include "dbus-common.h"
> +#include "adapter.h"
> +#include "device.h"
> +#include "error.h"
> +#include "log.h"
> +#include "gattrib.h"
> +#include "attio.h"
> +#include "att.h"
> +#include "gatt.h"
> +#include "deviceinfo.h"
> +#include "glib-compat.h"

It seems that you are including some unnecessary headers.

> +
> +struct deviceinfo {
> +       DBusConnection          *conn;          /* The connection to the bus */
> +       struct btd_device       *dev;           /* Device reference */
> +       GAttrib                 *attrib;                /* GATT connection */

attrib is not being used.

> +};
> +
> +static GSList *deviceinfoservers = NULL;
> +
> +static gint cmp_device(gconstpointer a, gconstpointer b)
> +{
> +       const struct deviceinfo *d = a;
> +       const struct btd_device *dev = b;
> +
> +       if (dev == d->dev)
> +               return 0;
> +
> +       return -1;
> +}
> +
> +int deviceinfo_register(DBusConnection *connection, struct btd_device *device,
> +                                               struct att_primary *dattr)
> +{
> +       const gchar *path = device_get_path(device);

path is not used

> +       struct deviceinfo *d;
> +
> +       d = g_new0(struct deviceinfo, 1);
> +       d->conn = dbus_connection_ref(connection);
> +       d->dev = btd_device_ref(device);
> +
> +       deviceinfoservers = g_slist_prepend(deviceinfoservers, d);
> +
> +       return 0;
> +}
> +
> +void deviceinfo_unregister(struct btd_device *device)
> +{
> +       struct deviceinfo *d;
> +       GSList *l;
> +
> +       l = g_slist_find_custom(deviceinfoservers, device, cmp_device);
> +       if (l == NULL)
> +               return;
> +
> +       d = l->data;
> +       deviceinfoservers = g_slist_remove(deviceinfoservers, d);

memory leak(deviceinfo)

> +}
> diff --git a/deviceinfo/deviceinfo.h b/deviceinfo/deviceinfo.h
> new file mode 100644
> index 0000000..eedcf8f
> --- /dev/null
> +++ b/deviceinfo/deviceinfo.h
> @@ -0,0 +1,26 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
> + *  Copyright (C) 2012 Texas Instruments, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +int deviceinfo_register(DBusConnection *connection, struct btd_device *device,
> +                                               struct att_primary *tattr);
> +void deviceinfo_unregister(struct btd_device *device);
> diff --git a/deviceinfo/main.c b/deviceinfo/main.c
> new file mode 100644
> index 0000000..3bf0e9c
> --- /dev/null
> +++ b/deviceinfo/main.c
> @@ -0,0 +1,60 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
> + *  Copyright (C) 2012 Texas Instruments, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <glib.h>
> +#include <errno.h>
> +#include <gdbus.h>
> +
> +#include "plugin.h"
> +#include "manager.h"
> +
> +static DBusConnection *connection = NULL;
> +
> +static int deviceinfo_init(void)
> +{
> +       connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);

DBusConnection reference is not being used. IMO, DIS doesn't need to
expose D-Bus properties or methods.

BR,
Claudio

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352898430-3383-1-git-send-email-s.syam@samsung.com>
References: <1352898430-3383-1-git-send-email-s.syam@samsung.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 14 Nov 2012 13:13:23 -0200
Message-ID: <CAMOw1v6O4rLDGqsu_aAmWD4bLGe2WEkRQF-2Oub6CM6OFqEgZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] gdbus: Fix compilation error due to missing #defines
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 14, 2012 at 11:07 AM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> Since these are simple #define strings, we are defining it here
> instead of upgrading to D-Bus 1.5 or later.
>
> Log:
>   CC     gdbus/object.o
> gdbus/object.c: In function ‘properties_set’:
> gdbus/object.c:876:7: error: ‘DBUS_ERROR_UNKNOWN_PROPERTY’ undeclared
>  (first use in this function)
> gdbus/object.c:876:7: note: each undeclared identifier is reported
>  only once for each function it appears in
> gdbus/object.c:881:6: error: ‘DBUS_ERROR_PROPERTY_READ_ONLY’
>  undeclared (first use in this function)
> make[1]: *** [gdbus/object.o] Error 1
> make: *** [all] Error 2
> ---
>  gdbus/object.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index e3ad067..3101ca6 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -39,6 +39,14 @@
>
>  #define DBUS_INTERFACE_OBJECT_MANAGER "org.freedesktop.DBus.ObjectManager"
>
> +#ifndef DBUS_ERROR_UNKNOWN_PROPERTY
> +#define DBUS_ERROR_UNKNOWN_PROPERTY "org.freedesktop.DBus.Error.UnknownProperty"
> +#endif
> +
> +#ifndef DBUS_ERROR_PROPERTY_READ_ONLY
> +#define DBUS_ERROR_PROPERTY_READ_ONLY "org.freedesktop.DBus.Error.PropertyReadOnly"
> +#endif
> +
>  struct generic_data {
>         unsigned int refcount;
>         DBusConnection *conn;
> --
> 1.7.4.1


Ack
Lucas De Marchi

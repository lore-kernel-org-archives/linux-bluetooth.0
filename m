Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394597040-4483-2-git-send-email-armansito@chromium.org>
References: <1394597040-4483-1-git-send-email-armansito@chromium.org>
	<1394597040-4483-2-git-send-email-armansito@chromium.org>
Date: Fri, 14 Mar 2014 10:24:20 -0400
Message-ID: <CAJdJm_MkCLLXsO6va+ZZ1n79Hh2d4FTiRp6UP_aZy+1EYik+ZQ@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/2] gatt-dbus: Add remote GATT service objects.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: armansito@chromium.org
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Mar 12, 2014 at 12:03 AM,  <armansito@chromium.org> wrote:
> From: Arman Uguray <armansito@chromium.org>
>
> This CL adds the initial GATT client D-Bus API support for remote primary GATT

What does "CL" mean?

Regarding coding style: we mostly follow kernel style, so be sure that
your patches pass the "checkpatch.pl" script (available on the kernel
sources). You can use this call as a start (which is what I use
personally):

~/trees/linux.git/scripts/checkpatch.pl \
                --no-signoff --ignore
INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE,CAMELCASE,FSF_MAILING_ADDRESS
--show-types --mailback -

See below for comments on the most obvious issues, but I suggest you
clear all errors/warnings reported by checkpatch. Also make sure you
are building your code using "./bootstrap-configure && make" and that
you have run "make check && make distcheck" at least once.

> services. Characteristics, descriptors, and included services are not yet
> handled.
> ---
>  src/device.c    | 47 +++++++++++++++++++++++++++--
>  src/gatt-dbus.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/gatt-dbus.h | 25 ++++++++++++++++
>  3 files changed, 158 insertions(+), 6 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index e624445..0623e4d 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -65,6 +65,7 @@
>  #include "textfile.h"
>  #include "storage.h"
>  #include "attrib-server.h"
> +#include "gatt.h"
>
>  #define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
>
> @@ -186,6 +187,7 @@ struct btd_device {
>         GSList          *uuids;
>         GSList          *primaries;             /* List of primary services */
>         GSList          *services;              /* List of btd_service */
> +       GSList          *gatt_services;         /* List of GATT DBus Services */
>         GSList          *pending;               /* Pending services */
>         GSList          *watches;               /* List of disconnect_data */
>         gboolean        temporary;
> @@ -511,11 +513,18 @@ static void svc_dev_remove(gpointer user_data)
>         g_free(cb);
>  }
>
> +static void gatt_dbus_service_free(gpointer user_data)
> +{
> +       struct btd_gatt_dbus_service *service = user_data;
> +       btd_gatt_dbus_service_free(service);
> +}
> +
>  static void device_free(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
>
>         g_slist_free_full(device->uuids, g_free);
> +       g_slist_free_full(device->gatt_services, gatt_dbus_service_free);
>         g_slist_free_full(device->primaries, g_free);
>         g_slist_free_full(device->attios, g_free);
>         g_slist_free_full(device->attios_offline, g_free);
> @@ -2287,6 +2296,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
>
>         str2ba(address, &device->bdaddr);
>         device->adapter = adapter;
> +       device->gatt_services = NULL;

You do not need to initialize with NULL because device is allocated
with g_try_malloc0() (which zeroes memory).

>
>         return btd_device_ref(device);
>  }
> @@ -3317,6 +3327,35 @@ done:
>         return FALSE;
>  }
>
> +static void expose_btd_dbus_gatt_services(struct btd_device *device)
> +{
> +       GSList *l;
> +
> +       /* Clear current list of GATT services. */
> +       g_slist_free_full(device->gatt_services, gatt_dbus_service_free);
> +       device->gatt_services = NULL;

Coding style issue: add an empty line here.

> +       for (l = device->primaries; l; l = g_slist_next(l)) {
> +               struct gatt_primary *prim = l->data;
> +
> +               /* Don't create objects for the GAP and GATT services. */
> +               if (bt_uuid_strcmp(prim->uuid, GATT_UUID) == 0) {

Current style is to use "if (!bt_uuid_strcmp(...))" for new code.

> +                       DBG("Skipping GATT UUID for GATT service objects.");
> +                       continue;
> +               }
> +               if (bt_uuid_strcmp(prim->uuid, GAP_UUID) == 0) {

Same as above.

> +                       DBG("Skipping GAP UUID for GATT service objects.");
> +                       continue;
> +               }

Why are you skipping those services from The D-Bus API? Some
application why want access to the "raw" data such as GAP Appearance.

> +
> +               struct btd_gatt_dbus_service *service;

Declarations should come at the beginning of the code block (e.g. function).

> +               service = btd_gatt_dbus_service_create(device, prim);
> +               if (service == NULL)
> +                       continue;

Better print an error() above before continue?

> +               device->gatt_services = g_slist_append(device->gatt_services,
> +                                                       service);
> +       }
> +}
> +
>  static void register_all_services(struct browse_req *req, GSList *services)
>  {
>         struct btd_device *device = req->device;
> @@ -3329,6 +3368,8 @@ static void register_all_services(struct browse_req *req, GSList *services)
>
>         device_register_primaries(device, g_slist_copy(services), -1);
>
> +       expose_btd_dbus_gatt_services(device);
> +
>         device_probe_profiles(device, req->profiles_added);
>
>         if (device->attios == NULL && device->attios_offline == NULL)
> @@ -3501,10 +3542,10 @@ done:
>                 bonding_request_free(device->bonding);
>         }
>
> -       if (device->connect) {
> -               if (!device->le_state.svc_resolved)
> -                       device_browse_primary(device, NULL);
> +       if (!device->le_state.svc_resolved)
> +               device_browse_primary(device, NULL);
>
> +       if (device->connect) {


Are these changes related your last point on the cover letter? If yes,
please move it to a separate commit with a descriptive commit message
explaining the problem.

>                 if (err < 0)
>                         reply = btd_error_failed(device->connect,
>                                                         strerror(-err));
> [...]
> diff --git a/src/gatt-dbus.h b/src/gatt-dbus.h
> index 310cfa9..08d3f11 100644
> --- a/src/gatt-dbus.h
> +++ b/src/gatt-dbus.h
> @@ -21,5 +21,30 @@
>   *
>   */
>
> +struct btd_gatt_dbus_service;
> +struct btd_device;
> +struct gatt_primary;

Usually declarations like the above, unless the symbols are local to
the C file. What you need to do is make sure the files #including
gatt-dbus.h also #include "src/device.h" before.

> +
>  gboolean gatt_dbus_manager_register(void);
>  void gatt_dbus_manager_unregister(void);
> +
> +/*
> + * btd_gatt_dbus_service_create - Create a GATT service that represents a remote

To keep consistency with nomenclature used on the gatt-api.txt, I
would call these:

btd_gatt_dbus_service_register()
btd_gatt_dbus_service_unregister()

> + * primary GATT service and expose it via D-Bus.
> + *
> + * @device:    The remote device that hosts the GATT service.
> + * @primary:   The primary GATT service.
> + *
> + * Returns a reference to the GATT service object. In case of error, NULL is
> + * returned.
> + */
> +struct btd_gatt_dbus_service *btd_gatt_dbus_service_create(
> +               struct btd_device *device, struct gatt_primary *primary);
> +
> +/*
> + * btd_gatt_dbus_service_free - Unregister a GATT service as a D-Bus object and
> + * free up its memory.
> + *
> + * @service: The GATT service object to remove.
> + */
> +void btd_gatt_dbus_service_free(struct btd_gatt_dbus_service* service);

Also a general comment regarding indentation:

BlueZ has a specific (but simple to remember) indentation rule: if a
line goes over 80 columns, break it into multiple lines, such as:

- line continuations of function calls and declarations are after the
opening "(" of the first line.
- line continuations are aligned to the left, up to the 80 column limit
- line continuations are aligned to right between themselves.

You can break this rule to keep readability (e.g. when function name
is too long), but I recommend trying to stick to it when possible. If
in doubt, take a look at recent files on BlueZ source for examples,
e.g. src/shared/btsnoop.h.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

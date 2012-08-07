Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343194947-13659-3-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
	<1343194947-13659-3-git-send-email-chen.ganir@ti.com>
Date: Tue, 7 Aug 2012 13:29:18 -0300
Message-ID: <CAAngNMaaZXDpX-voj+KLf+fmsJ-dQY_UCQY9OE8bOSi74BztjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] Battery: Add connection logic
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Add connection logic to the Battery Plugin. When the driver is
> loaded, it will request a connection to the remote device and
> release the connection request when destroyed.
> ---
>  profiles/batterystate/batterystate.c |   78 +++++++++++++++++++++++++++++++++-
>  profiles/batterystate/batterystate.h |    3 +-
>  profiles/batterystate/manager.c      |   22 +++++++++-
>  3 files changed, 99 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
> index 04c2e5e..40663f6 100644
> --- a/profiles/batterystate/batterystate.c
> +++ b/profiles/batterystate/batterystate.c
> @@ -29,17 +29,29 @@
>
>  #include "adapter.h"
>  #include "device.h"
> +#include "gattrib.h"
> +#include "attio.h"
>  #include "att.h"
>  #include "gattrib.h"
>  #include "gatt.h"
>  #include "batterystate.h"
> +#include "log.h"
>
>  struct battery {
>         struct btd_device       *dev;           /* Device reference */
> +       GAttrib                 *attrib;        /* GATT connection */
> +       guint                   attioid;        /* Att watcher id */
> +       struct att_range        *svc_range;     /* Battery range */
> +       GSList                  *chars;         /* Characteristics */
>  };
>
>  static GSList *servers;
>
> +struct characteristic {
> +       struct gatt_char        attr;   /* Characteristic */
> +       struct battery          *batt;  /* Parent Battery Service */
> +};
> +
>  static gint cmp_device(gconstpointer a, gconstpointer b)
>  {
>         const struct battery *batt = a;
> @@ -55,20 +67,84 @@ static void batterystate_free(gpointer user_data)
>  {
>         struct battery *batt = user_data;
>
> +       if (batt->chars != NULL)
> +               g_slist_free_full(batt->chars, g_free);
> +
> +       if (batt->attioid > 0)
> +               btd_device_remove_attio_callback(batt->dev, batt->attioid);
> +
> +       if (batt->attrib != NULL)
> +               g_attrib_unref(batt->attrib);
> +
>         btd_device_unref(batt->dev);
>         g_free(batt);
>  }
>
> +static void configure_batterystate_cb(GSList *characteristics, guint8 status,
> +                                                       gpointer user_data)
> +{
> +       struct battery *batt = user_data;
> +       GSList *l;
> +
> +       if (status != 0) {
> +               error("Discover batterystate characteristics: %s",
> +                                                       att_ecode2str(status));
> +               return;
> +       }
>
> -int batterystate_register(struct btd_device *device)
> +       for (l = characteristics; l; l = l->next) {
> +               struct gatt_char *c = l->data;
> +               struct characteristic *ch;
> +
> +               ch = g_new0(struct characteristic, 1);
> +               ch->attr.handle = c->handle;
> +               ch->attr.properties = c->properties;
> +               ch->attr.value_handle = c->value_handle;
> +               memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
> +               ch->batt = batt;
> +
> +               batt->chars = g_slist_append(batt->chars, ch);
> +       }
> +}
> +
> +static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
> +{
> +       struct battery *batt = user_data;
> +
> +       batt->attrib = g_attrib_ref(attrib);
> +
> +       if (batt->chars == NULL) {
> +               gatt_discover_char(batt->attrib, batt->svc_range->start,
> +                                       batt->svc_range->end, NULL,
> +                                       configure_batterystate_cb, batt);
> +       }
> +}
> +
> +static void attio_disconnected_cb(gpointer user_data)
> +{
> +       struct battery *batt = user_data;
> +
> +       g_attrib_unref(batt->attrib);
> +       batt->attrib = NULL;
> +}
> +
> +int batterystate_register(struct btd_device *device,
> +                               struct gatt_primary *prim)
>  {
>         struct battery *batt;
>
>         batt = g_new0(struct battery, 1);
>         batt->dev = btd_device_ref(device);
>
> +       batt->svc_range = g_new0(struct att_range, 1);
> +       batt->svc_range->start = prim->range.start;
> +       batt->svc_range->end = prim->range.end;
> +
>         servers = g_slist_prepend(servers, batt);
>
> +       batt->attioid = btd_device_add_attio_callback(device,
> +                               attio_connected_cb, attio_disconnected_cb,
> +                               batt);
>         return 0;
>  }
>
> diff --git a/profiles/batterystate/batterystate.h b/profiles/batterystate/batterystate.h
> index 9aedae7..2d30028 100644
> --- a/profiles/batterystate/batterystate.h
> +++ b/profiles/batterystate/batterystate.h
> @@ -19,6 +19,5 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
>   */
> -
> -int batterystate_register(struct btd_device *device);
> +int batterystate_register(struct btd_device *device, struct gatt_primary *prim);
>  void batterystate_unregister(struct btd_device *device);
> diff --git a/profiles/batterystate/manager.c b/profiles/batterystate/manager.c
> index 6718acf..62076ac 100644
> --- a/profiles/batterystate/manager.c
> +++ b/profiles/batterystate/manager.c
> @@ -34,9 +34,29 @@
>
>  #define BATTERY_SERVICE_UUID           "0000180f-0000-1000-8000-00805f9b34fb"
>
> +static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
> +{
> +       const struct gatt_primary *prim = a;
> +       const char *uuid = b;
> +
> +       return g_strcmp0(prim->uuid, uuid);
> +}
> +
>  static int batterystate_driver_probe(struct btd_device *device, GSList *uuids)
>  {
> -       return batterystate_register(device);
> +       struct gatt_primary *prim;
> +       GSList *primaries, *l;
> +
> +       primaries = btd_device_get_primaries(device);
> +
> +       l = g_slist_find_custom(primaries, BATTERY_SERVICE_UUID,
> +                                                       primary_uuid_cmp);

No need to check for the BATTERY_SERVICE_UUID. If driver has been
probed its because the remote implements this service, since it's
declared on the .uuids field of the plugin struct.

> +       if (l == NULL)
> +               return -EINVAL;
> +
> +       prim = l->data;
> +
> +       return batterystate_register(device, prim);

Getting the primary service pointer (manly used for handle range
information could be done from inside batterystate_register() itself
on batterystate.c instead of doing so on the manager code. This way
the plugin keeps more self-contained.

>  }
>
>  static void batterystate_driver_remove(struct btd_device *device)
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
João Paulo Rechi Vita
Openbossa Labs - INdT

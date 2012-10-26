Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351176228-5789-11-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com> <1351176228-5789-11-git-send-email-andrzej.kaczmarek@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 26 Oct 2012 02:49:35 -0200
Message-ID: <CAMOw1v5iCL5j=m7n1PnyrCTXKeDES2uecuBw+gvzvCZ4WS1=WA@mail.gmail.com>
Subject: Re: [RFC 10/18] cyclingspeed: Add DBus.Properties for
 org.bluez.CyclingSpeed interface
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 25, 2012 at 12:43 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  profiles/cyclingspeed/cyclingspeed.c | 99 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
> index f7ffd2e..4f48121 100644
> --- a/profiles/cyclingspeed/cyclingspeed.c
> +++ b/profiles/cyclingspeed/cyclingspeed.c
> @@ -43,6 +43,7 @@
>
>  #define CYCLINGSPEED_MANAGER_INTERFACE "org.bluez.CyclingSpeedManager"
>  #define CYCLINGSPEED_WATCHER_INTERFACE "org.bluez.CyclingSpeedWatcher"
> +#define CYCLINGSPEED_INTERFACE         "org.bluez.CyclingSpeed"
>
>  #define WHEEL_REV_SUPPORT              0x01
>  #define CRANK_REV_SUPPORT              0x02
> @@ -102,6 +103,21 @@ struct characteristic {
>
>  static GSList *csc_adapters = NULL;
>
> +static const char * const location_enum[] = {
> +       "other", "top-of-shoe", "in-shoe", "hip", "front-wheel", "left-crank",
> +       "right-crank", "left-pedal", "right-pedal", "front-hub",
> +       "rear-dropout", "chainstay", "rear-wheel", "rear-hub"
> +};
> +
> +static const gchar *location2str(uint8_t value)
> +{
> +       if (value < G_N_ELEMENTS(location_enum))
> +               return location_enum[value];
> +
> +       info("Body Sensor Location [%d] is RFU", value);
> +       return location_enum[0];
> +}
> +
>  static gint cmp_adapter(gconstpointer a, gconstpointer b)
>  {
>         const struct csc_adapter *cadapter = a;
> @@ -687,6 +703,74 @@ void csc_adapter_unregister(struct btd_adapter *adapter)
>                                         CYCLINGSPEED_MANAGER_INTERFACE);
>  }
>
> +static gboolean property_get_location(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct csc *csc = data;
> +       char *loc;
> +
> +       if (!csc->has_location)
> +               return FALSE;
> +
> +       loc = g_strdup(location2str(csc->location));
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &loc);
> +
> +       g_free(loc);

you don't need to dup/free the string

Lucas De Marchi

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171121175034.22459-1-hadess@hadess.net>
References: <20171121175034.22459-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Nov 2017 21:57:10 +0200
Message-ID: <CABBYNZ+AvcJ7F_K_AjgB4DpCT2FrEbnZugi6gQ9QBox5UhFofg@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Fix Bluetooth LE mouse "Connected" prop not updating
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Nov 21, 2017 at 7:50 PM, Bastien Nocera <hadess@hadess.net> wrote:
> When a Bluetooth LE mouse with the Battery1 interface gets disconnected,
> the "Connected" property is queued for update and then the Battery1
> interface gets removed.
>
> But as remove_interface() sets data->pending_prop to FALSE without
> checking on the other interfaces, the queued property changes on the
> other interfaces are just ignored.
>
> They would eventually be flushed when other properties of that device
> eventually changed.
>
> We fix this by only setting the data->pending_prop value to FALSE when
> we're certain to have processed all the interfaces, and when we've
> checked other interfaces don't have any pending props.
> ---
>  gdbus/object.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index afb458764..3301f2bd3 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -651,6 +651,21 @@ static void add_pending(struct generic_data *data)
>         pending = g_slist_append(pending, data);
>  }
>
> +static gboolean
> +interfaces_have_pending_prop (GSList *interfaces)
> +{
> +       GSList *l;
> +
> +       for (l = interfaces; l; l = l->next) {
> +               struct interface_data *iface = l->data;
> +
> +               if (iface->pending_prop != NULL)
> +                       return TRUE;
> +       }
> +
> +       return FALSE;
> +}
> +
>  static gboolean remove_interface(struct generic_data *data, const char *name)
>  {
>         struct interface_data *iface;
> @@ -662,6 +677,7 @@ static gboolean remove_interface(struct generic_data *data, const char *name)
>         process_properties_from_interface(data, iface);
>
>         data->interfaces = g_slist_remove(data->interfaces, iface);
> +       data->pending_prop = interfaces_have_pending_prop (data->interfaces);
>
>         if (iface->destroy) {
>                 iface->destroy(iface->user_data);
> @@ -1659,8 +1675,6 @@ static void process_properties_from_interface(struct generic_data *data,
>         DBusMessageIter iter, dict, array;
>         GSList *invalidated;
>
> -       data->pending_prop = FALSE;
> -
>         if (iface->pending_prop == NULL)
>                 return;
>
> @@ -1727,6 +1741,8 @@ static void process_property_changes(struct generic_data *data)
>
>                 process_properties_from_interface(data, iface);
>         }
> +
> +       data->pending_prop = FALSE;
>  }
>
>  void g_dbus_emit_property_changed_full(DBusConnection *connection,
> --
> 2.14.3

I have a similar fix on my tree already.


-- 
Luiz Augusto von Dentz

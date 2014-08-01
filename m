Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406805075-16150-6-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406805075-16150-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1406805075-16150-6-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 1 Aug 2014 11:50:35 +0300
Message-ID: <CABBYNZ+n75zwYi9opO7KeS-edmFCDJA9m9QUgmh_kjtNJNa_VA@mail.gmail.com>
Subject: Re: [PATCH 5/6] android/gatt: Use kernel auto connect feature if possible
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jul 31, 2014 at 2:11 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  android/gatt.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 448bcb8..de0912d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1383,6 +1383,8 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>
>         device_set_state(dev, DEVICE_CONNECTED);
>
> +       bt_auto_connect_remove(&dev->bdaddr);

In cases like HoG it would be better to have it permanent on the auto
connect list, we could perhaps add this as a flag to
bt_gatt_register_app (along with initial security level?) otherwise we
have to manually retrigger every time.

>         /* Send exchange mtu request as we assume being client and server */
>         /* TODO: Dont exchange mtu if no client apps */
>         send_exchange_mtu_request(dev);
> @@ -1529,6 +1531,10 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>                                                 sizeof(*ev) + ev->len, ev);
>
>  connect:
> +       /* We use auto connect feature from kernel if possible */
> +       if (main_opts.kernel_conn_control)
> +               return;
> +
>         dev = find_device_by_addr(addr);
>         if (!dev) {
>                 if (!bonded)
> @@ -1749,6 +1755,19 @@ static int connect_bredr(struct gatt_device *dev)
>         return 0;
>  }
>
> +static bool auto_connect(struct gatt_device *dev)
> +{
> +       bool err;
> +
> +       err = bt_auto_connect_add(&dev->bdaddr);
> +       if (!err)
> +               return false;
> +
> +       device_set_state(dev, DEVICE_CONNECT_INIT);
> +
> +       return true;
> +}
> +
>  static bool trigger_connection(struct app_connection *connection)
>  {
>         bool ret;
> @@ -1763,6 +1782,13 @@ static bool trigger_connection(struct app_connection *connection)
>                                                                 BDADDR_BREDR)
>                         return connect_bredr(connection->device) == 0;
>
> +               /*
> +                * For LE devices use auto connect feature if possible
> +                * Note: Connection state is handled inside auto_connect() func
> +                */
> +               if (main_opts.kernel_conn_control)
> +                       return auto_connect(connection->device);
> +
>                 /* Trigger discovery if not already started */
>                 if (!scanning) {
>                         if (!bt_le_discovery_start()) {
> @@ -1771,6 +1797,7 @@ static bool trigger_connection(struct app_connection *connection)
>                                 break;
>                         }
>                 }
> +
>                 ret = true;
>                 device_set_state(connection->device, DEVICE_CONNECT_INIT);
>                 break;
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

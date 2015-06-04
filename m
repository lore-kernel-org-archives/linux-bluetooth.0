Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1433353221-12338-1-git-send-email-jpawlowski@google.com>
References: <1433353221-12338-1-git-send-email-jpawlowski@google.com>
Date: Thu, 4 Jun 2015 14:10:05 +0300
Message-ID: <CABBYNZJ12-Vb+h4tNEd9+4-s0Hgm-kuy73sth9UM-KkUJnXD_A@mail.gmail.com>
Subject: Re: [PATCH v1] core: Fix connection to already paired device.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jun 3, 2015 at 8:40 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Currently, when BlueZ tries to connect to already paired device that
> just rotated its RPA MAC address, it would use old address and fail
> to connect. In order to fix that, "General Connection Establisment
> Procedure" must be used. It is already implemented in kernel.
>
> This patch changes connection procedure behaviour for paired devices.
> Instead of directly calling "connect" with last known RPA, it'll add
> device to kernel whitelist and start scan. If advertisement is received,
> it'll be compared against whitelist and then trigger connection if it
> matches.
>
> le_connect_timeout field was added to btd_device. If it's set, device
> was marked for autoconnect because someone tried to connect to it. When
> the connection is succesully estabilished, or after timeout this field
> is cleared, and device is removed from autoconnect whitelist. It's value
> is handle to timeout timer. If device is not found for 10 seconds, we
> cancel connection procedure.
> ---
>  src/device.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index ce96ab5..3fe52e4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -78,6 +78,7 @@
>
>  #define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
>
> +#define LE_CONNECT_TIMEOUT 10
>  #define DISCONNECT_TIMER       2
>  #define DISCOVERY_TIMER                1
>
> @@ -256,6 +257,8 @@ struct btd_device {
>         gboolean        disable_auto_connect;
>         gboolean        general_connect;
>
> +       guint           le_connect_timeout;
> +
>         bool            legacy;
>         int8_t          rssi;
>         int8_t          tx_power;
> @@ -2392,6 +2395,19 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(dev, bdaddr_type);
>
> +       if (dev->le_connect_timeout) {
> +               g_source_remove(dev->le_connect_timeout);
> +               dev->le_connect_timeout = 0;
> +               device_set_auto_connect(dev, false);
> +
> +               if (dev->connect) {
> +                       g_dbus_send_message(dbus_conn,
> +                               dbus_message_new_method_return(dev->connect));
> +                       dbus_message_unref(dev->connect);
> +                       dev->connect = NULL;
> +               }
> +       }
> +
>         device_update_last_seen(dev, bdaddr_type);
>
>         if (state->connected) {
> @@ -4459,6 +4475,37 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
>         }
>  }
>
> +static gboolean le_connect_timeout(gpointer user_data)
> +{
> +       struct btd_device *dev = user_data;
> +       char addr[18];
> +
> +       ba2str(&dev->bdaddr, addr);
> +       DBG("Connection attempt to: %s was aborted after timeout", addr);

Most likely the debug above will either crash or print trash if the
device is already freed, what you really need to do is to remove this
source if anything like that happen. Btw, while at it please add a
similar logic to Disconnect as it should stop the timer and remove the
device auto connect flag if it was not set previous to Connect call.

> +       if (!dev->le_connect_timeout)
> +               return FALSE;
> +
> +       dev->le_connect_timeout = 0;
> +       device_set_auto_connect(dev, false);
> +
> +       if (!dev->connect)
> +               return FALSE;
> +
> +       if (dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
> +                                                               "Connect")) {
> +               DBG("returning response to %s",
> +                                       dbus_message_get_sender(dev->connect));
> +
> +               g_dbus_send_message(dbus_conn,
> +                               btd_error_failed(dev->connect, strerror(20)));
> +               dbus_message_unref(dev->connect);
> +               dev->connect = NULL;
> +       }
> +
> +       return FALSE;
> +}
> +
>  int device_connect_le(struct btd_device *dev)
>  {
>         struct btd_adapter *adapter = dev->adapter;
> @@ -4469,13 +4516,22 @@ int device_connect_le(struct btd_device *dev)
>         char addr[18];
>
>         /* There is one connection attempt going on */
> -       if (dev->att_io)
> +       if ((dev->le_state.paired && dev->auto_connect) || dev->att_io)
>                 return -EALREADY;
>
>         ba2str(&dev->bdaddr, addr);
>
>         DBG("Connection attempt to: %s", addr);
>
> +       if (dev->le_state.paired) {
> +               device_set_auto_connect(dev, true);
> +               dev->le_connect_timeout = g_timeout_add_seconds(
> +                                                       LE_CONNECT_TIMEOUT,
> +                                                       le_connect_timeout,
> +                                                       dev);
> +               return 0;
> +       }

I guess you should check dev.bdaddr_type == BDADDR_LE_RANDOM along
with paired flag and check if the device is already set in for auto
connect, if it already is you can probably have a different callback
since you will not need to call device_set_auto_connect there.

>         attcb = g_new0(struct att_callbacks, 1);
>         attcb->err = att_error_cb;
>         attcb->user_data = dev;
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

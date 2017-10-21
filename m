Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171020122114.11887-1-luiz.dentz@gmail.com>
References: <20171020122114.11887-1-luiz.dentz@gmail.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Fri, 20 Oct 2017 17:26:27 -0700
Message-ID: <CALvjcs_dQREztepm938z_ca52irmST-7Tev06SOwJ1LuFK98kQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Clear subscriptions for device not paired
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

I assume that you wanna see that server application try to do
send_notification_to_device,  device is NULL/disconnected, then
bluetoothd would clear status for subscription.

However, when ble is disconnected, send_notification_to_device might
not be triggered any more so that device state cannot be cleaned. In
server I have used StartNotify and AcquireNotify to verify it, and
send_notification_to_device cannot be triggered after ble is
disconnected even though server application has tried to send data.

Here are two ideas:

In gatt-datebase.c, could you invoke clear_ccc_state inside pipe_up?
When server application destroy pipe, the corresponding pipe_up in
bluetoothd could remove GATT states that related to notify_io.

Another idea:
When disconnected event is detected in adapter.c or device.c, could
you call clear_ccc_state to clear all states for all characteristic,
reset them to original status.

Thanks
Best wishes
Yunhan

On Fri, Oct 20, 2017 at 5:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the device is no longer valid or is not considered bonded anymore
> clear its CCC states before removing otherwise application may continue
> to notify when there are no devices listening.
> ---
>  src/gatt-database.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 47304704a..d6d1e4d13 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -891,6 +891,23 @@ static void conf_cb(void *user_data)
>         }
>  }
>
> +static void clear_ccc_state(void *data, void *user_data)
> +{
> +       struct ccc_state *ccc = data;
> +       struct btd_gatt_database *db = user_data;
> +       struct ccc_cb_data *ccc_cb;
> +
> +       if (!ccc->value[0])
> +               return;
> +
> +       ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
> +                                               UINT_TO_PTR(ccc->handle));
> +       if (!ccc_cb)
> +               return;
> +
> +       ccc_cb->callback(NULL, 0, ccc_cb->user_data);
> +}
> +
>  static void send_notification_to_device(void *data, void *user_data)
>  {
>         struct device_state *device_state = data;
> @@ -940,8 +957,11 @@ static void send_notification_to_device(void *data, void *user_data)
>
>  remove:
>         /* Remove device state if device no longer exists or is not paired */
> -       if (queue_remove(notify->database->device_states, device_state))
> +       if (queue_remove(notify->database->device_states, device_state)) {
> +               queue_foreach(device_state->ccc_states, clear_ccc_state,
> +                                               notify->database);
>                 device_state_free(device_state);
> +       }
>  }
>
>  static void send_notification_to_devices(struct btd_gatt_database *database,
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

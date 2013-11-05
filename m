Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1383641621-25933-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383641621-25933-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 5 Nov 2013 11:05:16 +0200
Message-ID: <CABBYNZKJV-h82WQ5_J3z+ArC3=Gy00qTpKHhWSF7v+fFC7KTrA@mail.gmail.com>
Subject: Re: [PATCH] android/daemon: Send update name notification on mgmt evt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 5, 2013 at 10:53 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Wehen receiving mgmt event local_name_changed we shall send notification
> to the HAL that local name is changed.
> ---
>  android/adapter.c |   46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/android/adapter.c b/android/adapter.c
> index 383cf07..b6f6096 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -66,6 +66,28 @@ struct bt_adapter {
>  static struct bt_adapter *adapter;
>  static GSList *found_devices = NULL;
>
> +static void adapter_name_changed(const uint8_t *name)
> +{
> +       struct hal_ev_adapter_props_changed *ev;
> +       size_t len = strlen((const char *) name);
> +       uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) + len];
> +
> +       memset(buf, 0, sizeof(buf));
> +       ev = (void *) buf;
> +
> +       ev->num_props = 1;
> +       ev->status = HAL_STATUS_SUCCESS;
> +       ev->props[0].type = HAL_PROP_ADAPTER_NAME;
> +       /* Android expects value without NULL terminator */
> +       ev->props[0].len = len;
> +       memcpy(ev->props->val, name, len);
> +
> +       DBG("Adapter name changed to: %s", name);
> +
> +       ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
> +                       HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
> +}
> +
>  static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -84,7 +106,7 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
>         g_free(adapter->name);
>         adapter->name = g_strdup((const char *) rp->name);
>
> -       /* TODO Update services if needed */
> +       adapter_name_changed(rp->name);
>  }

This is okay, but you should call this function from
set_adapter_name_complete to make sure we are synchronized with the
upper stack.

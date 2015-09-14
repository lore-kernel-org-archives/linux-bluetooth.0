Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441816924-3585-1-git-send-email-jpawlowski@google.com>
References: <1441816924-3585-1-git-send-email-jpawlowski@google.com>
Date: Mon, 14 Sep 2015 16:15:13 +0300
Message-ID: <CABBYNZJz+Xe7ZvRoM_-g8Bp6_SeRVBBuLvzTXEzLHUownm8FGA@mail.gmail.com>
Subject: Re: [PATCH] core/device: Store services after pairing.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Sep 9, 2015 at 7:42 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Service caching works only for paired devices. Right now caching is
> triggered only right after discovery finishes. That means that if you
> connect to new device, then pair during this connection, your services
> won't be cached until reconnect. This will require full service discovery
> which is slow.
> This patch fixes that by trying to cache services right after successful
> pairing.
> ---
>  src/device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 8184508..d31620e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5315,6 +5315,11 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>          * request
>          */
>         if (state->svc_resolved && bonding) {
> +               /* Attept to store services for this device failed because it
> +                * was not paired. Now that we're paired retry. */
> +               if (device->bdaddr_type != BDADDR_BREDR)
> +                       store_gatt_db(device);
> +
>                 g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
>                 bonding_request_free(bonding);
>                 return;
> --
> 2.1.4

Id probably put this into gatt_client_ready_cb or even better
gatt_services_changed since both gatt_service_added and
gatt_service_removed should also call it. I might actually remove the
checks for bt_gatt_client_is_ready from them because we should be able
to operate them right away since we don't have the limitation of not
being able to read/write anything while bt_gatt_client is not ready.


-- 
Luiz Augusto von Dentz

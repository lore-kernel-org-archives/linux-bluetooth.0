Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415266238-12423-4-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1415266238-12423-4-git-send-email-jakub.tyszkowski@tieto.com>
Date: Thu, 6 Nov 2014 15:43:14 +0200
Message-ID: <CABBYNZ+dZTiaMqw6F256zRzXP-0Z4oq8puGOegu_wXiMT6muBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] android/gatt: Use proper identity address for auto connect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Nov 6, 2014 at 11:30 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> We should behave the same as whe nwe connect using active scan.
> ---
>  android/gatt.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 47dadc2..8cc7536 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -583,8 +583,24 @@ static void device_set_state(struct gatt_device *dev, uint32_t state)
>  static bool auto_connect_le(struct gatt_device *dev)
>  {
>         /*  For LE devices use auto connect feature if possible */
> -       if (bt_kernel_conn_control())
> -               return  bt_auto_connect_add(&dev->bdaddr);
> +       if (bt_kernel_conn_control()) {
> +               const bdaddr_t *bdaddr;
> +
> +               /*
> +                * If address type is random it might be that IRK was received
> +                * and random is just for faking Android Framework. ID address
> +                * should be used for connection if present.
> +                */
> +               if (dev->bdaddr_type == BDADDR_LE_RANDOM) {
> +                       bdaddr = bt_get_id_addr(&dev->bdaddr, NULL);
> +                       if (!bdaddr)
> +                               return -EINVAL;
> +               } else {
> +                       bdaddr = &dev->bdaddr;
> +               }
> +
> +               return bt_auto_connect_add(bdaddr);
> +       }
>
>         /* Trigger discovery if not already started */
>         if (!scanning) {
> --
> 1.9.1

Perhaps this would be better done inside bt_auto_connect_add since
anyway bt_get_id_addr is in bluetooth.c, actually perhaps
auto_connect_le is not really necessary since bt_auto_connect_add
should be able to do the checks done here.



-- 
Luiz Augusto von Dentz

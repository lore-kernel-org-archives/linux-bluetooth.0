Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1437043681-32403-1-git-send-email-luiz.dentz@gmail.com>
References: <1437043681-32403-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2015 13:27:35 +0300
Message-ID: <CABBYNZJKeXf5fPmXUUGUXbRa5HPaPU+pNx1XckrOsjA68eMj7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 16, 2015 at 1:48 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The discovery shall not be interrupted in case Exchange MTU is not
> supported, instead we shall continue using the default MTU as stated by
> the spec:
>
> BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part G] page 546:
>   "If the Error Response is sent by the server with the Error Code set
>    to Request Not Supported , the Attribute Opcode is not supported and
>    the default MTU shall be used."
> ---
>  src/shared/gatt-client.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 0bd306c..24aef18 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1066,6 +1066,15 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
>                                 "MTU Exchange failed. ATT ECODE: 0x%02x",
>                                 att_ecode);
>
> +               /*
> +                * BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part G] page 546
> +                * If the Error Response is sent by the server with the Error
> +                * Code set to RequestNot Supported , the Attribute Opcode is
> +                * not supported and the default MTU shall be used.
> +                */
> +               if (att_ecode == BT_ATT_ERROR_REQUEST_NOT_SUPPORTED)
> +                       goto discover;
> +
>                 client->in_init = false;
>                 notify_client_ready(client, success, att_ecode);
>
> @@ -1076,6 +1085,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
>                                         "MTU exchange complete, with MTU: %u",
>                                         bt_att_get_mtu(client->att));
>
> +discover:
>         client->discovery_req = bt_gatt_discover_all_primary_services(
>                                                         client->att, NULL,
>                                                         discover_primary_cb,
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz

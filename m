Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-11-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
	<1419024965-10375-11-git-send-email-armansito@chromium.org>
Date: Mon, 22 Dec 2014 12:42:33 -0200
Message-ID: <CABBYNZJhdByiQ8d90hEKxeveCxd55c73PKk=HN7kwh_o0q6SgQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 10/17] shared/gatt-client: Expose MTU.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 7:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds the bt_gatt_client_get_mtu function. It also includes a
> minor fix in which the signature of the "value" argument of write
> methods are changed from "uint8_t *" to "const uint8_t *".

We better split this changes.

> ---
>  src/shared/gatt-client.c | 14 +++++++++++---
>  src/shared/gatt-client.h |  8 +++++---
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index f7a90d1..6768892 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1599,6 +1599,14 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
>         return true;
>  }
>
> +uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client)
> +{
> +       if (!client || !client->att)
> +               return 0;
> +
> +       return bt_att_get_mtu(client->att);
> +}
> +
>  struct read_op {
>         bt_gatt_client_read_callback_t callback;
>         void *user_data;
> @@ -1955,7 +1963,7 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>  bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
>                                         bool signed_write,
> -                                       uint8_t *value, uint16_t length) {
> +                                       const uint8_t *value, uint16_t length) {
>         uint8_t pdu[2 + length];
>
>         if (!client)
> @@ -2011,7 +2019,7 @@ done:
>
>  bool bt_gatt_client_write_value(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
> -                                       uint8_t *value, uint16_t length,
> +                                       const uint8_t *value, uint16_t length,
>                                         bt_gatt_client_callback_t callback,
>                                         void *user_data,
>                                         bt_gatt_client_destroy_func_t destroy)
> @@ -2260,7 +2268,7 @@ done:
>  bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>                                 bool reliable,
>                                 uint16_t value_handle, uint16_t offset,
> -                               uint8_t *value, uint16_t length,
> +                               const uint8_t *value, uint16_t length,
>                                 bt_gatt_client_write_long_callback_t callback,
>                                 void *user_data,
>                                 bt_gatt_client_destroy_func_t destroy)
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 984c23f..42eeaec 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -70,6 +70,8 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
>                                         void *user_data,
>                                         bt_gatt_client_destroy_func_t destroy);
>
> +uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client);
> +
>  bool bt_gatt_client_read_value(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
>                                         bt_gatt_client_read_callback_t callback,
> @@ -89,17 +91,17 @@ bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
>  bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
>                                         bool signed_write,
> -                                       uint8_t *value, uint16_t length);
> +                                       const uint8_t *value, uint16_t length);
>  bool bt_gatt_client_write_value(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
> -                                       uint8_t *value, uint16_t length,
> +                                       const uint8_t *value, uint16_t length,
>                                         bt_gatt_client_callback_t callback,
>                                         void *user_data,
>                                         bt_gatt_client_destroy_func_t destroy);
>  bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>                                 bool reliable,
>                                 uint16_t value_handle, uint16_t offset,
> -                               uint8_t *value, uint16_t length,
> +                               const uint8_t *value, uint16_t length,
>                                 bt_gatt_client_write_long_callback_t callback,
>                                 void *user_data,
>                                 bt_gatt_client_destroy_func_t destroy);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
	<1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
Date: Sat, 27 Sep 2014 00:35:37 +0200
Message-ID: <CAN_7+YbQFq0=mvwhsHmduguDu-b0ji8L0+HqW-iDaHB_xO-3+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] shared/gatt-client: Add CSRK part to support
 signed write
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

On Fri, Sep 26, 2014 at 9:48 AM, Gu Chaojie <chao.jie.gu@intel.com> wrote:
> Compared with patch v2, remove type enum in CSRK funciton for btgatt-client
> tool to easy use this API.
>
> ---
>  src/shared/gatt-client.c |   27 ++++++++++++++++++++++-----
>  src/shared/gatt-client.h |    4 ++++
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 6dc8e95..aee3969 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1753,19 +1753,26 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>  bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
>                                         uint16_t value_handle,
>                                         bool signed_write,
> -                                       uint8_t *value, uint16_t length) {
> +                                       uint8_t *value, uint16_t length)
> +{
>         uint8_t pdu[2 + length];
>
>         if (!client)
>                 return 0;
>
> -       /* TODO: Support this once bt_att_send supports signed writes. */
> -       if (signed_write)
> -               return 0;
> -
>         put_le16(value_handle, pdu);
>         memcpy(pdu + 2, value, length);
>
> +       if (signed_write) {
> +               if (bt_att_local_csrk_is_valid(client->att))

In my opinion bt_att_local_csrk_is_valid API seems to be unnecessary
as CSRK can be checked inside bt_att_send function directly.

BR
\Łukasz

> +                       return bt_att_send(client->att,
> +                                       BT_ATT_OP_SIGNED_WRITE_CMD,
> +                                       pdu, sizeof(pdu), NULL, NULL, NULL);
> +               else
> +                       return 0;
> +
> +       }
> +
>         return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
>                                                         NULL, NULL, NULL);
>  }
> @@ -2246,3 +2253,13 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>         client->need_notify_cleanup = true;
>         return true;
>  }
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +                               bool valid_local_csrk,
> +                               uint8_t key[16])
> +{
> +       if (!client)
> +               return false;
> +
> +       return bt_att_set_local_csrk(client->att, valid_local_csrk, key);
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 6807f6b..0684f30 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -162,3 +162,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>                                 bt_gatt_client_destroy_func_t destroy);
>  bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>                                                         unsigned int id);
> +
> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
> +                               bool valid_local_csrk,
> +                               uint8_t key[16]);
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

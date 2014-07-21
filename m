Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1405718037-15401-3-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
	<1405718037-15401-3-git-send-email-armansito@chromium.org>
Date: Mon, 21 Jul 2014 09:37:59 +0200
Message-ID: <CAMv5GbdR1FeFNHMk4CHAsdyo-4ZsUu5t2Y47ShKbSFPdjGGM+g@mail.gmail.com>
Subject: Re: [PATCH 02/11] shared/gatt: Implement bt_gatt_exchange_mtu.
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,


On 18 July 2014 23:13, Arman Uguray <armansito@chromium.org> wrote:
>
> This patch implements the helper function bt_gatt_exchange_mtu, which performs
> an ATT "Exchange MTU" request and resizes the internal buffer based on the
> result.
> ---
>  src/shared/gatt-helpers.c | 87 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 3d85868..9cf05cf 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -30,14 +30,97 @@
>  #include "src/shared/att.h"
>  #include "lib/uuid.h"
>  #include "src/shared/gatt-helpers.h"
> +#include "src/shared/util.h"
> +
> +#ifndef MIN
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +#endif
> +
> +struct mtu_op {
> +       struct bt_att *att;
> +       uint16_t client_rx_mtu;
> +       bt_gatt_result_callback_t callback;
> +       void *user_data;
> +       bt_gatt_destroy_func_t destroy;
> +};
> +
> +static void destroy_mtu_op(void *user_data)
> +{
> +       struct mtu_op *op = user_data;
> +
> +       if (op->destroy)
> +               op->destroy(op->user_data);
> +
> +       free(op);
> +}
> +
> +static uint16_t process_error(const void *pdu, uint16_t length)
> +{
> +       if (!pdu || length != 4)
> +               return BT_GATT_ERROR_INVALID_RSP;
> +
> +       return (uint16_t)((uint8_t *) pdu)[3];
> +}
> +
> +static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
> +                                                               void *user_data)
> +{
> +       struct mtu_op *op = user_data;
> +       uint16_t result = 0;
> +       uint16_t server_rx_mtu;
> +
> +       if (opcode == BT_ATT_OP_ERROR_RSP) {
> +               result = process_error(pdu, length);
> +               goto done;
> +       }
> +
> +       if (opcode != BT_ATT_OP_MTU_RSP || !pdu || length != 2) {
> +               result = BT_GATT_ERROR_INVALID_RSP;
> +               goto done;
> +       }
> +
> +       server_rx_mtu = get_le16(pdu);
> +       bt_att_set_mtu(op->att, MIN(op->client_rx_mtu, server_rx_mtu));
> +
> +done:
> +       if (op->callback)
> +               op->callback(result, op->user_data);
> +}
>
>  bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
>                                         bt_gatt_result_callback_t callback,
>                                         void *user_data,
>                                         bt_gatt_destroy_func_t destroy)
>  {
> -       /* TODO */
> -       return false;
> +       struct mtu_op *op;
> +       uint8_t pdu[2];
> +
> +       if (!att)
> +               return false;
> +
> +       if (!client_rx_mtu)
> +               return false;
> +
Would it be better to include att and client_rx_mtu check in one "if"
statement ? (both of them return false)

> +       op = new0(struct mtu_op, 1);
> +       if (!op)
> +               return false;
> +
> +       op->att = att;
> +       op->client_rx_mtu = client_rx_mtu;
> +       op->callback = callback;
> +       op->user_data = user_data;
> +       op->destroy = destroy;
> +
> +       put_le16(client_rx_mtu, pdu);
> +
> +       if (!bt_att_send(att, BT_ATT_OP_MTU_REQ, pdu, sizeof(pdu),
> +                                                       mtu_cb, op,
> +                                                       destroy_mtu_op)) {
> +               free(op);
> +               return false;
> +       }
> +
> +       return true;
>  }
>
>  bool bt_gatt_discover_primary_services(struct bt_att *att,
> --
> 2.0.0.526.g5318336
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best regards,
Grzegorz

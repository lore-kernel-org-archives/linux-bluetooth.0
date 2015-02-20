Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424428710-8907-1-git-send-email-luiz.dentz@gmail.com>
References: <1424428710-8907-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 20 Feb 2015 13:04:10 +0100
Message-ID: <CAN_7+YYgVvZXsu1X=8xP6Pvj1-G-Gh0OoUR4F5txv2eK2K9jfg@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/3] shared/att.c: Add signing key support
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 20, 2015 at 11:38 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds support for setting local and remote signing keys along with
> a callback for fetching/updating signing counter.
> ---
>  src/shared/att.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/att.h |   6 ++++
>  2 files changed, 104 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 152f49c..5363907 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -36,6 +36,7 @@
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
>  #include "src/shared/att.h"
> +#include "src/shared/crypto.h"
>
>  #define ATT_MIN_PDU_LEN                        1  /* At least 1 byte for the opcode. */
>  #define ATT_OP_CMD_MASK                        0x40
> @@ -52,6 +53,9 @@
>  #define BT_ERROR_ALREADY_IN_PROGRESS           0xfe
>  #define BT_ERROR_OUT_OF_RANGE                  0xff
>
> +/* Length of signature in write signed packet */
> +#define BT_ATT_SIGNATURE_LEN           12
> +
>  struct att_send_op;
>
>  struct bt_att {
> @@ -85,6 +89,17 @@ struct bt_att {
>         bt_att_debug_func_t debug_callback;
>         bt_att_destroy_func_t debug_destroy;
>         void *debug_data;
> +
> +       struct bt_crypto *crypto;
> +
> +       struct sign_write_info *local_info;
> +       struct sign_write_info *remote_info;
> +};
> +
> +struct sign_write_info {
> +       uint8_t key[16];
> +       bt_att_counter_func_t counter;
> +       void *user_data;
>  };
>
>  enum att_op_type {
> @@ -184,6 +199,8 @@ struct att_send_op {
>         bt_att_response_func_t callback;
>         bt_att_destroy_func_t destroy;
>         void *user_data;
> +
> +       struct bt_att *att;
>  };
>
>  static void destroy_att_send_op(void *data)
> @@ -266,6 +283,12 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>                                                 uint16_t length, uint16_t mtu)
>  {
>         uint16_t pdu_len = 1;
> +       struct bt_att *att = op->att;
> +       struct sign_write_info *info;
> +       uint32_t sign_cnt;
> +
> +       if (op->opcode & ATT_OP_SIGNED_MASK)
> +               pdu_len += BT_ATT_SIGNATURE_LEN;
>
>         if (length && pdu)
>                 pdu_len += length;
> @@ -282,17 +305,36 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>         if (pdu_len > 1)
>                 memcpy(op->pdu + 1, pdu, length);
>
> -       return true;
> +       if (!(op->opcode & ATT_OP_SIGNED_MASK))
> +               return true;
> +
> +       info = att->local_info;
> +       if (!info)
> +               goto fail;
> +
> +       if (!info->counter(&sign_cnt, info->user_data))
> +               goto fail;
> +
> +       if ((bt_crypto_sign_att(att->crypto, info->key, op->pdu, 1 + length,
> +                               sign_cnt, &((uint8_t *) op->pdu)[1 + length])))
> +               return true;
> +
> +fail:
> +       free(op->pdu);
> +       return false;
>  }
>
> -static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
> -                                               uint16_t length, uint16_t mtu,
> +static struct att_send_op *create_att_send_op(uint8_t opcode,
> +                                               const void *pdu,
> +                                               uint16_t length,
> +                                               struct bt_att *att,
>                                                 bt_att_response_func_t callback,
>                                                 void *user_data,
>                                                 bt_att_destroy_func_t destroy)
>  {
>         struct att_send_op *op;
>         enum att_op_type op_type;
> +       uint16_t mtu = att->mtu;
>
>         if (length && !pdu)
>                 return NULL;
> @@ -323,6 +365,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
>         op->callback = callback;
>         op->destroy = destroy;
>         op->user_data = user_data;
> +       op->att = att;
>
>         if (!encode_pdu(op, pdu, length, mtu)) {
>                 free(op);
> @@ -810,6 +853,7 @@ static void bt_att_free(struct bt_att *att)
>                 destroy_att_send_op(att->pending_ind);
>
>         io_destroy(att->io);
> +       bt_crypto_unref(att->crypto);
>
>         queue_destroy(att->req_queue, NULL);
>         queue_destroy(att->ind_queue, NULL);
> @@ -841,6 +885,8 @@ struct bt_att *bt_att_new(int fd)
>
>         att->fd = fd;
>
> +       att->local_info = NULL;
> +       att->remote_info = NULL;
>         att->mtu = BT_ATT_DEFAULT_LE_MTU;
>         att->buf = malloc(att->mtu);
>         if (!att->buf)
> @@ -850,6 +896,10 @@ struct bt_att *bt_att_new(int fd)
>         if (!att->io)
>                 goto fail;
>
> +       att->crypto = bt_crypto_new();
> +       if (!att->crypto)
> +               goto fail;
> +
>         att->req_queue = queue_new();
>         if (!att->req_queue)
>                 goto fail;
> @@ -964,6 +1014,16 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
>         if (!buf)
>                 return false;
>
> +       if (att->local_info) {
> +               free(att->local_info);
> +               att->local_info = NULL;
> +       }
> +
> +       if (att->remote_info) {
> +               free(att->remote_info);
> +               att->remote_info = NULL;
> +       }
> +

Why we want to do it here?

I think we should add it bt_att_free() instead.

>         free(att->buf);
>
>         att->mtu = mtu;
> @@ -1047,7 +1107,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>         if (!att || !att->io)
>                 return 0;
>
> -       op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
> +       op = create_att_send_op(opcode, pdu, length, att, callback,
>                                                         user_data, destroy);

This should be probably separate patch.

\Lukasz

>         if (!op)
>                 return 0;
> @@ -1307,3 +1367,37 @@ bool bt_att_set_sec_level(struct bt_att *att, int level)
>
>         return true;
>  }
> +
> +static bool sign_info_set_key(struct sign_write_info **info, uint8_t key[16],
> +                               bt_att_counter_func_t func, void *user_data)
> +{
> +       if (!(*info)) {
> +               *info = new0(struct sign_write_info, 1);
> +               if (!(*info))
> +                       return false;
> +       }
> +
> +       (*info)->counter = func;
> +       (*info)->user_data = user_data;
> +       memcpy((*info)->key, key, 16);
> +
> +       return true;
> +}
> +
> +bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
> +                               bt_att_counter_func_t func, void *user_data)
> +{
> +       if (!att)
> +               return false;
> +
> +       return sign_info_set_key(&att->local_info, sign_key, func, user_data);
> +}
> +
> +bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
> +                               bt_att_counter_func_t func, void *user_data)
> +{
> +       if (!att)
> +               return false;
> +
> +       return sign_info_set_key(&att->remote_info, sign_key, func, user_data);
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 5256ff9..a440aaf 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -46,6 +46,7 @@ typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
>  typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
>                                                         void *user_data);
>  typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
> +typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
>
>  bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
>                                 void *user_data, bt_att_destroy_func_t destroy);
> @@ -84,3 +85,8 @@ bool bt_att_unregister_all(struct bt_att *att);
>
>  int bt_att_get_sec_level(struct bt_att *att);
>  bool bt_att_set_sec_level(struct bt_att *att, int level);
> +
> +bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
> +                       bt_att_counter_func_t func, void *user_data);
> +bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
> +                       bt_att_counter_func_t func, void *user_data);
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

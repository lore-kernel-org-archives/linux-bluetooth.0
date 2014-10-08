Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412758479-13214-2-git-send-email-chao.jie.gu@intel.com>
References: <1412758479-13214-1-git-send-email-chao.jie.gu@intel.com>
	<1412758479-13214-2-git-send-email-chao.jie.gu@intel.com>
Date: Wed, 8 Oct 2014 14:43:29 +0300
Message-ID: <CABBYNZ+NW=1aW6_sMppq2kU4FUou0pK5DhHQ7ykhUFkf4dCCsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] shared/att.c: Add signed command outgoing and CSRK function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 8, 2014 at 11:54 AM, Gu Chaojie <chao.jie.gu@intel.com> wrote:
> ---
>  src/shared/att-types.h |    3 ++
>  src/shared/att.c       |  122 ++++++++++++++++++++++++++++++++++++++++++++++--
>  src/shared/att.h       |   16 +++++++
>  3 files changed, 138 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index b85c969..da8b6ae 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -25,6 +25,9 @@
>
>  #define BT_ATT_DEFAULT_LE_MTU 23
>
> +/* Length of signature in write signed packet */
> +#define BT_ATT_SIGNATURE_LEN           12
> +
>  /* ATT protocol opcodes */
>  #define BT_ATT_OP_ERROR_RSP                    0x01
>  #define BT_ATT_OP_MTU_REQ                      0x02
> diff --git a/src/shared/att.c b/src/shared/att.c
> index de35aef..b4921d9 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -36,6 +36,7 @@
>  #include "lib/uuid.h"
>  #include "src/shared/att.h"
>  #include "src/shared/att-types.h"
> +#include "src/shared/crypto.h"
>
>  #define ATT_MIN_PDU_LEN                        1  /* At least 1 byte for the opcode. */
>  #define ATT_OP_CMD_MASK                        0x40
> @@ -77,6 +78,16 @@ struct bt_att {
>         bt_att_debug_func_t debug_callback;
>         bt_att_destroy_func_t debug_destroy;
>         void *debug_data;
> +
> +       struct bt_crypto *crypto;
> +
> +       bool valid_local_csrk;
> +       uint8_t local_csrk[16];
> +       uint32_t local_sign_cnt;
> +
> +       bool valid_remote_csrk;
> +       uint8_t remote_csrk[16];
> +       uint32_t remote_sign_cnt;

Maybe it is better to have pointers to a structs so you can free the
data once it becomes invalid and it also removes the necessity of
extra flags just to tell if the data is still valid since you can
check if the pointer is not NULL then it must be valid.

>  };
>
>  enum att_op_type {
> @@ -176,6 +187,8 @@ struct att_send_op {
>         bt_att_response_func_t callback;
>         bt_att_destroy_func_t destroy;
>         void *user_data;
> +
> +       struct bt_att *att;
>  };
>
>  static void destroy_att_send_op(void *data)
> @@ -277,6 +290,10 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>                                                 uint16_t length, uint16_t mtu)
>  {
>         uint16_t pdu_len = 1;
> +       struct bt_att *att = op->att;
> +
> +       if (op->opcode & ATT_OP_SIGNED_MASK)
> +               pdu_len += BT_ATT_SIGNATURE_LEN;
>
>         if (length && pdu)
>                 pdu_len += length;
> @@ -293,17 +310,32 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>         if (pdu_len > 1)
>                 memcpy(op->pdu + 1, pdu, length);
>
> +       if (op->opcode & ATT_OP_SIGNED_MASK) {
> +               if (bt_crypto_sign_att(att->crypto,
> +                                       att->local_csrk,
> +                                       op->pdu,
> +                                       1 + length,
> +                                       att->local_sign_cnt,
> +                                       &((uint8_t *) op->pdu)[1 + length]))
> +                       att->local_sign_cnt++;
> +               else
> +                       return false;
> +       }
> +

You can probably bail out early if you check !(op->opcode &
ATT_OP_SIGNED_MASK), also perhaps it is a good idea to start defining
structs for the PDUs to simplify the access.

>         return true;
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
> @@ -334,6 +366,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
>         op->callback = callback;
>         op->destroy = destroy;
>         op->user_data = user_data;
> +       op->att = att;
>
>         if (!encode_pdu(op, pdu, length, mtu)) {
>                 free(op);
> @@ -701,6 +734,10 @@ struct bt_att *bt_att_new(int fd)
>
>         att->fd = fd;
>
> +       att->local_sign_cnt = 0;
> +       att->remote_sign_cnt = 0;
> +       att->valid_local_csrk = false;
> +       att->valid_remote_csrk = false;
>         att->mtu = BT_ATT_DEFAULT_LE_MTU;
>         att->buf = malloc(att->mtu);
>         if (!att->buf)
> @@ -710,6 +747,10 @@ struct bt_att *bt_att_new(int fd)
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
> @@ -744,6 +785,7 @@ fail:
>         queue_destroy(att->write_queue, NULL);
>         queue_destroy(att->notify_list, NULL);
>         queue_destroy(att->disconn_list, NULL);
> +       bt_crypto_unref(att->crypto);
>         io_destroy(att->io);
>         free(att->buf);
>         free(att);
> @@ -934,7 +976,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>         if (!att || !att->io)
>                 return 0;
>
> -       op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
> +       op = create_att_send_op(opcode, pdu, length, att, callback,
>                                                         user_data, destroy);
>         if (!op)
>                 return 0;
> @@ -1119,3 +1161,77 @@ bool bt_att_unregister_all(struct bt_att *att)
>
>         return true;
>  }
> +
> +bool bt_att_set_local_csrk(struct bt_att *att, bool valid_local_csrk,
> +                                               uint8_t key[16])
> +{
> +       if (!att)
> +               return false;
> +
> +       att->valid_local_csrk = valid_local_csrk;
> +       memcpy(att->local_csrk, key, 16);
> +
> +       return true;
> +}
> +
> +bool bt_att_set_remote_csrk(struct bt_att *att, bool valid_remote_csrk,
> +                                               uint8_t key[16])
> +{
> +       if (!att)
> +               return false;
> +
> +       att->valid_remote_csrk = valid_remote_csrk;
> +       memcpy(att->remote_csrk, key, 16);
> +
> +       return true;
> +
> +}
> +
> +bool bt_att_get_local_csrk(struct bt_att *att, uint8_t key[16],
> +                                       uint32_t *local_sign_cnt)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (att->valid_local_csrk) {
> +               memcpy(key, att->local_csrk, 16);
> +               *local_sign_cnt = att->local_sign_cnt;
> +       } else {
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool bt_att_get_remote_csrk(struct bt_att *att, uint8_t key[16],
> +                                       uint32_t *remote_sign_cnt)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (att->valid_remote_csrk) {
> +               memcpy(key, att->remote_csrk, 16);
> +               *remote_sign_cnt = att->remote_sign_cnt;
> +       } else {
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool bt_att_local_csrk_is_valid(struct bt_att *att)
> +{
> +       if (!att)
> +               return false;
> +
> +       return att->valid_local_csrk;
> +}
> +
> +bool bt_att_remote_csrk_is_valid(struct bt_att *att)
> +{
> +       if (!att)
> +               return false;
> +
> +       return att->valid_remote_csrk;
> +
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 1063021..306d44c 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -76,3 +76,19 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
>  bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
>
>  bool bt_att_unregister_all(struct bt_att *att);
> +
> +bool bt_att_set_local_csrk(struct bt_att *att, bool valid_local_csrk,
> +                                               uint8_t key[16]);
> +
> +bool bt_att_set_remote_csrk(struct bt_att *att, bool valid_remote_csrk,
> +                                               uint8_t key[16]);
> +
> +bool bt_att_get_local_csrk(struct bt_att *att, uint8_t key[16],
> +                                       uint32_t *local_sign_cnt);
> +
> +bool bt_att_get_remote_csrk(struct bt_att *att, uint8_t key[16],
> +                                       uint32_t *remote_sign_cnt);
> +
> +bool bt_att_local_csrk_is_valid(struct bt_att *att);
> +
> +bool bt_att_remote_csrk_is_valid(struct bt_att *att);
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

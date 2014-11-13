Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415839007-21196-2-git-send-email-armansito@chromium.org>
References: <1415839007-21196-1-git-send-email-armansito@chromium.org>
	<1415839007-21196-2-git-send-email-armansito@chromium.org>
Date: Thu, 13 Nov 2014 18:10:46 +0200
Message-ID: <CABBYNZJnzR7=z36HAvmjnqacdnNaORAJN9eDz_vxO84MAxV1mQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/7] shared/att: Add API for encoding ATT error response.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Nov 13, 2014 at 2:36 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds bt_att_encode_error_rsp which allows encoding an ATT
> protocol error response by correctly converting system errnos to ATT
> protocol error codes. struct bt_att_pdu_error_rsp is introduced to
> represent an error response PDU which can be sent directly over the
> wire once properly encoded in network order.
> ---
>  src/shared/att-types.h    |  12 ++++
>  src/shared/att.c          |  58 +++++++++++++++++-
>  src/shared/att.h          |   3 +
>  src/shared/gatt-client.c  |   8 ++-
>  src/shared/gatt-helpers.c |   8 ++-
>  src/shared/gatt-server.c  | 153 +++++++++++++++++++++++-----------------------
>  6 files changed, 160 insertions(+), 82 deletions(-)
>
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index 24bf3da..3d8829a 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -23,6 +23,10 @@
>
>  #include <stdint.h>
>
> +#ifndef __packed
> +#define __packed __attribute__((packed))
> +#endif
> +
>  #define BT_ATT_DEFAULT_LE_MTU 23
>
>  /* ATT protocol opcodes */
> @@ -55,6 +59,14 @@
>  #define BT_ATT_OP_HANDLE_VAL_IND               0x1D
>  #define BT_ATT_OP_HANDLE_VAL_CONF              0x1E
>
> +/* Packed struct definitions for ATT protocol PDUs */
> +/* TODO: Complete these definitions for all opcodes */
> +struct bt_att_pdu_error_rsp {
> +       uint8_t opcode;
> +       uint16_t handle;
> +       uint8_t ecode;
> +} __packed;
> +
>  /* Special opcode to receive all requests (legacy servers) */
>  #define BT_ATT_ALL_REQUESTS 0x00
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 6e1e538..e831078 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -35,13 +35,22 @@
>  #include "src/shared/timeout.h"
>  #include "lib/uuid.h"
>  #include "src/shared/att.h"
> -#include "src/shared/att-types.h"
>
>  #define ATT_MIN_PDU_LEN                        1  /* At least 1 byte for the opcode. */
>  #define ATT_OP_CMD_MASK                        0x40
>  #define ATT_OP_SIGNED_MASK             0x80
>  #define ATT_TIMEOUT_INTERVAL           30000  /* 30000 ms */
>
> +/*
> + * Common Profile and Service Error Code descriptions (see Supplement to the
> + * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
> + * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
> + * following:
> + */
> +#define BT_ERROR_CCC_IMPROPERLY_CONFIGURED     0xfd
> +#define BT_ERROR_ALREADY_IN_PROGRESS           0xfe
> +#define BT_ERROR_OUT_OF_RANGE                  0xff
> +
>  struct att_send_op;
>
>  struct bt_att {
> @@ -1218,3 +1227,50 @@ bool bt_att_unregister_all(struct bt_att *att)
>
>         return true;
>  }
> +
> +static uint8_t att_ecode_from_error(int err)
> +{
> +       /*
> +        * If the error fits in a single byte, treat it as an ATT protocol
> +        * error as is. Since "0" is not a valid ATT protocol error code, we map
> +        * that to UNLIKELY below.
> +        */
> +       if (err > 0 && err < UINT8_MAX)
> +               return err;
> +
> +       /*
> +        * Since we allow UNIX errnos, map them to appropriate ATT protocol
> +        * and "Common Profile and Service" error codes.
> +        */
> +       switch (err) {
> +       case -ENOENT:
> +               return BT_ATT_ERROR_INVALID_HANDLE;
> +       case -ENOMEM:
> +               return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> +       case -EALREADY:
> +               return BT_ERROR_ALREADY_IN_PROGRESS;
> +       case -EOVERFLOW:
> +               return BT_ERROR_OUT_OF_RANGE;
> +       }
> +
> +       return BT_ATT_ERROR_UNLIKELY;
> +}
> +
> +bool bt_att_encode_error_rsp(uint8_t opcode, uint16_t handle, int error,
> +                                       struct bt_att_pdu_error_rsp *pdu)
> +{
> +       uint8_t ecode;
> +
> +       if (!pdu)
> +               return false;
> +
> +       ecode = att_ecode_from_error(error);
> +
> +       memset(pdu, 0, sizeof(*pdu));
> +
> +       pdu->opcode = opcode;
> +       put_le16(handle, &pdu->handle);
> +       pdu->ecode = ecode;
> +
> +       return true;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 1063021..a1a4821 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -76,3 +76,6 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
>  bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
>
>  bool bt_att_unregister_all(struct bt_att *att);
> +
> +bool bt_att_encode_error_rsp(uint8_t opcode, uint16_t handle, int error,
> +                                       struct bt_att_pdu_error_rsp *pdu);

Lets drop the encode part from the name, it should be implicit that it
will encode before sending. Also Im not sure why you have chosen to
pass the parameter as a struct, you could have passed separately by
value so encoding does not affect the caller stack, also I was
assuming that it would send the PDU after encoding it.

> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 30b271e..1f82048 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1285,10 +1285,14 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
>
>  static uint8_t process_error(const void *pdu, uint16_t length)
>  {
> -       if (!pdu || length != 4)
> +       const struct bt_att_pdu_error_rsp *error_pdu;
> +
> +       if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
>                 return 0;
>
> -       return ((uint8_t *) pdu)[3];
> +       error_pdu = pdu;
> +
> +       return error_pdu->ecode;
>  }
>
>  static void enable_ccc_callback(uint8_t opcode, const void *pdu,
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 220d0eb..9c8a3ba 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -430,10 +430,14 @@ static void destroy_mtu_op(void *user_data)
>
>  static uint8_t process_error(const void *pdu, uint16_t length)
>  {
> -       if (!pdu || length != 4)
> +       const struct bt_att_pdu_error_rsp *error_pdu;
> +
> +       if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
>                 return 0;
>
> -       return ((uint8_t *) pdu)[3];
> +       error_pdu = pdu;
> +
> +       return error_pdu->ecode;
>  }
>
>  static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 2ca318a..3262992 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include <sys/uio.h>
> +#include <errno.h>
>
>  #include "src/shared/att.h"
>  #include "lib/uuid.h"
> @@ -29,7 +30,6 @@
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/gatt-server.h"
>  #include "src/shared/gatt-helpers.h"
> -#include "src/shared/att-types.h"
>  #include "src/shared/util.h"
>
>  #ifndef MAX
> @@ -133,22 +133,6 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
>         free(server);
>  }
>
> -static uint8_t att_ecode_from_error(int err)
> -{
> -       if (err < 0 || err > UINT8_MAX)
> -               return 0xff;
> -
> -       return err;
> -}
> -
> -static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
> -                                                               uint8_t pdu[4])
> -{
> -       pdu[0] = opcode;
> -       pdu[3] = ecode;
> -       put_le16(handle, pdu + 1);
> -}
> -
>  static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
>  {
>         uint128_t u128;
> @@ -315,8 +299,9 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
>
>  error:
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
> +       rsp_len = sizeof(struct bt_att_pdu_error_rsp);
> +       bt_att_encode_error_rsp(opcode, ehandle, ecode,
> +                               (struct bt_att_pdu_error_rsp *) rsp_pdu);
>
>  done:
>         queue_destroy(q, NULL);
> @@ -355,13 +340,13 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
>
>         /* Terminate the operation if there was an error */
>         if (err) {
> -               uint8_t pdu[4];
> -               uint8_t att_ecode = att_ecode_from_error(err);
> +               struct bt_att_pdu_error_rsp error_pdu;
>
> -               encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, handle, att_ecode,
> -                                                                       pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
> -                                                               NULL, NULL);
> +               bt_att_encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, handle, err,
> +                                                               &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
> +                                                       NULL, NULL, NULL);
>                 async_read_op_destroy(op);
>                 return;
>         }
> @@ -437,8 +422,9 @@ static void process_read_by_type(struct async_read_op *op)
>  error:
>         ehandle = gatt_db_attribute_get_handle(attr);
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, ehandle, ecode, op->pdu);
> +       rsp_len = sizeof(struct bt_att_pdu_error_rsp);
> +       bt_att_encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, ehandle, ecode,
> +                               (struct bt_att_pdu_error_rsp *) op->pdu);
>
>  done:
>         bt_att_send(server->att, rsp_opcode, op->pdu, rsp_len, NULL,
> @@ -452,7 +438,7 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
>         struct bt_gatt_server *server = user_data;
>         uint16_t start, end;
>         bt_uuid_t type;
> -       uint8_t rsp_pdu[4];
> +       struct bt_att_pdu_error_rsp error_pdu;
>         uint16_t ehandle = 0;
>         uint8_t ecode;
>         struct queue *q = NULL;
> @@ -524,9 +510,10 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
>         return;
>
>  error:
> -       encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
> +       bt_att_encode_error_rsp(opcode, ehandle, ecode, &error_pdu);
>         queue_destroy(q, NULL);
> -       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
> +       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
>                                                         NULL, NULL, NULL);
>  }
>
> @@ -665,8 +652,9 @@ static void find_info_cb(uint8_t opcode, const void *pdu,
>
>  error:
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
> +       rsp_len = sizeof(struct bt_att_pdu_error_rsp);
> +       bt_att_encode_error_rsp(opcode, ehandle, ecode,
> +                               (struct bt_att_pdu_error_rsp *) rsp_pdu);
>
>  done:
>         queue_destroy(q, NULL);
> @@ -697,11 +685,11 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
>         handle = gatt_db_attribute_get_handle(attr);
>
>         if (err) {
> -               uint8_t rsp_pdu[4];
> -               uint8_t att_ecode = att_ecode_from_error(err);
> +               struct bt_att_pdu_error_rsp error_pdu;
>
> -               encode_error_rsp(op->opcode, handle, att_ecode, rsp_pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
> +               bt_att_encode_error_rsp(op->opcode, handle, err, &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
>                                                         NULL, NULL, NULL);
>         } else {
>                 bt_att_send(server->att, BT_ATT_OP_WRITE_RSP, NULL, 0,
> @@ -717,7 +705,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
>         struct bt_gatt_server *server = user_data;
>         struct gatt_db_attribute *attr;
>         uint16_t handle = 0;
> -       uint8_t rsp_pdu[4];
> +       struct bt_att_pdu_error_rsp error_pdu;
>         struct async_write_op *op = NULL;
>         uint8_t ecode;
>         uint32_t perm;
> @@ -777,8 +765,9 @@ error:
>         if (opcode == BT_ATT_OP_WRITE_CMD)
>                 return;
>
> -       encode_error_rsp(opcode, handle, ecode, rsp_pdu);
> -       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
> +       bt_att_encode_error_rsp(opcode, handle, ecode, &error_pdu);
> +       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
>                                                         NULL, NULL, NULL);
>  }
>
> @@ -824,12 +813,12 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
>         handle = gatt_db_attribute_get_handle(attr);
>
>         if (err) {
> -               uint8_t pdu[4];
> -               uint8_t att_ecode = att_ecode_from_error(err);
> +               struct bt_att_pdu_error_rsp error_pdu;
>
> -               encode_error_rsp(op->opcode, handle, att_ecode, pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
> -                                                               NULL, NULL);
> +               bt_att_encode_error_rsp(op->opcode, handle, err, &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
> +                                                       NULL, NULL, NULL);
>                 async_read_op_destroy(op);
>                 return;
>         }
> @@ -846,7 +835,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
>                                                                 uint16_t handle,
>                                                                 uint16_t offset)
>  {
> -       uint8_t error_pdu[4];
> +       struct bt_att_pdu_error_rsp error_pdu;
>         struct gatt_db_attribute *attr;
>         uint8_t ecode;
>         uint32_t perm;
> @@ -898,9 +887,10 @@ error:
>         if (op)
>                 async_read_op_destroy(op);
>
> -       encode_error_rsp(opcode, handle, ecode, error_pdu);
> -       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, error_pdu, 4, NULL, NULL,
> -                                                                       NULL);
> +       bt_att_encode_error_rsp(opcode, handle, ecode, &error_pdu);
> +       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
> +                                                       NULL, NULL, NULL);
>  }
>
>  static void read_cb(uint8_t opcode, const void *pdu,
> @@ -910,11 +900,13 @@ static void read_cb(uint8_t opcode, const void *pdu,
>         uint16_t handle;
>
>         if (length != 2) {
> -               uint8_t pdu[4];
> +               struct bt_att_pdu_error_rsp error_pdu;
>
> -               encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
> -                                                               NULL, NULL);
> +               bt_att_encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU,
> +                                                               &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
> +                                                       NULL, NULL, NULL);
>                 return;
>         }
>
> @@ -930,11 +922,13 @@ static void read_blob_cb(uint8_t opcode, const void *pdu,
>         uint16_t handle, offset;
>
>         if (length != 4) {
> -               uint8_t pdu[4];
> +               struct bt_att_pdu_error_rsp error_pdu;
>
> -               encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
> -                                                               NULL, NULL);
> +               bt_att_encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU,
> +                                                               &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                                       sizeof(error_pdu),
> +                                                       NULL, NULL, NULL);
>                 return;
>         }
>
> @@ -1031,8 +1025,9 @@ error:
>                 prep_write_data_destroy(prep_data);
>
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       encode_error_rsp(opcode, handle, ecode, rsp_pdu);
> +       rsp_len = sizeof(struct bt_att_pdu_error_rsp);
> +       bt_att_encode_error_rsp(opcode, handle, ecode,
> +                               (struct bt_att_pdu_error_rsp *) rsp_pdu);
>
>  done:
>         bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
> @@ -1040,30 +1035,29 @@ done:
>  }
>
>  static void exec_next_prep_write(struct bt_gatt_server *server,
> -                                       uint16_t ehandle, uint8_t att_ecode);
> +                                               uint16_t ehandle, int err);
>
>  static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>                                                                 void *user_data)
>  {
>         struct bt_gatt_server *server = user_data;
>         uint16_t handle = gatt_db_attribute_get_handle(attr);
> -       uint16_t att_ecode = att_ecode_from_error(err);
>
> -       exec_next_prep_write(server, handle, att_ecode);
> +       exec_next_prep_write(server, handle, err);
>  }
>
>  static void exec_next_prep_write(struct bt_gatt_server *server,
> -                                       uint16_t ehandle, uint8_t att_ecode)
> +                                               uint16_t ehandle, int err)
>  {
>         struct prep_write_data *next = NULL;
>         uint8_t rsp_opcode = BT_ATT_OP_EXEC_WRITE_RSP;
> -       uint8_t error_pdu[4];
> +       struct bt_att_pdu_error_rsp error_pdu;
>         uint8_t *rsp_pdu = NULL;
>         uint16_t rsp_len = 0;
>         struct gatt_db_attribute *attr;
>         bool status;
>
> -       if (att_ecode)
> +       if (err)
>                 goto error;
>
>         next = queue_pop_head(server->prep_queue);
> @@ -1072,7 +1066,7 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>
>         attr = gatt_db_get_attribute(server->db, next->handle);
>         if (!attr) {
> -               att_ecode = BT_ATT_ERROR_UNLIKELY;
> +               err = BT_ATT_ERROR_UNLIKELY;
>                 goto error;
>         }
>
> @@ -1086,14 +1080,15 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>         if (status)
>                 return;
>
> -       att_ecode = BT_ATT_ERROR_UNLIKELY;
> +       err = BT_ATT_ERROR_UNLIKELY;
>
>  error:
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       rsp_pdu = error_pdu;
> -       encode_error_rsp(BT_ATT_OP_EXEC_WRITE_REQ, ehandle, att_ecode, rsp_pdu);
> +       rsp_len = sizeof(error_pdu);
> +       bt_att_encode_error_rsp(BT_ATT_OP_EXEC_WRITE_REQ, ehandle, err,
> +                                                               &error_pdu);
>
> +       rsp_pdu = (uint8_t *) &error_pdu;
>  done:
>         bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
>                                                                         NULL);
> @@ -1106,7 +1101,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
>         uint8_t flags;
>         uint8_t ecode;
>         uint8_t rsp_opcode;
> -       uint8_t error_pdu[4];
> +       struct bt_att_pdu_error_rsp error_pdu;
>         uint8_t *rsp_pdu = NULL;
>         uint16_t rsp_len = 0;
>         bool write;
> @@ -1143,9 +1138,10 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
>
>  error:
>         rsp_opcode = BT_ATT_OP_ERROR_RSP;
> -       rsp_len = 4;
> -       rsp_pdu = error_pdu;
> -       encode_error_rsp(opcode, 0, ecode, rsp_pdu);
> +       rsp_len = sizeof(error_pdu);
> +       bt_att_encode_error_rsp(opcode, 0, ecode, &error_pdu);
> +
> +       rsp_pdu = (uint8_t *) &error_pdu;
>
>  done:
>         bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
> @@ -1158,12 +1154,15 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
>         struct bt_gatt_server *server = user_data;
>         uint16_t client_rx_mtu;
>         uint16_t final_mtu;
> -       uint8_t rsp_pdu[4];
> +       uint8_t rsp_pdu[2];
>
>         if (length != 2) {
> -               encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, rsp_pdu);
> -               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu,
> -                                       sizeof(rsp_pdu), NULL, NULL, NULL);
> +               struct bt_att_pdu_error_rsp error_pdu;
> +
> +               bt_att_encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU,
> +                                                               &error_pdu);
> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, &error_pdu,
> +                                       sizeof(error_pdu), NULL, NULL, NULL);
>                 return;
>         }
>
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

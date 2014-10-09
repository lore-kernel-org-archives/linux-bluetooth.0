Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412629304-3391-5-git-send-email-armansito@chromium.org>
References: <1412629304-3391-1-git-send-email-armansito@chromium.org>
	<1412629304-3391-5-git-send-email-armansito@chromium.org>
Date: Thu, 9 Oct 2014 11:24:51 +0300
Message-ID: <CABBYNZ+Nx9iWAYEJiZY5CSE8x_ynjRFpfawB5c-6+eCKNOHcwg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/4] shared/gatt-server: Support Read By Group
 Type request.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Oct 7, 2014 at 12:01 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds handling for the Read By Group Type request.
> ---
>  src/shared/gatt-server.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 169 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index c7b0873..3ea8c59 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -45,6 +45,7 @@ struct bt_gatt_server {
>         uint16_t mtu;
>
>         unsigned int mtu_id;
> +       unsigned int read_by_grp_type_id;
>
>         bt_gatt_server_debug_func_t debug_callback;
>         bt_gatt_server_destroy_func_t debug_destroy;
> @@ -54,6 +55,7 @@ struct bt_gatt_server {
>  static void gatt_server_unregister_handlers(struct bt_gatt_server *server)
>  {
>         bt_att_unregister(server->att, server->mtu_id);
> +       bt_att_unregister(server->att, server->read_by_grp_type_id);
>  }
>
>  static void gatt_server_cleanup(struct bt_gatt_server *server)
> @@ -71,6 +73,157 @@ static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
>         put_le16(handle, pdu + 1);
>  }
>
> +static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
> +{
> +       uint128_t u128;
> +
> +       switch (len) {
> +       case 2:
> +               bt_uuid16_create(out_uuid, get_le16(uuid));
> +               return true;
> +       case 16:
> +               bswap_128(uuid, &u128.data);
> +               bt_uuid128_create(out_uuid, u128);
> +               return true;
> +       default:
> +               return false;
> +       }
> +
> +       return false;
> +}
> +
> +static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct bt_gatt_server *server = user_data;
> +       uint16_t start, end;
> +       bt_uuid_t type;
> +       bt_uuid_t prim, snd;
> +       uint16_t mtu = bt_att_get_mtu(server->att);
> +       uint8_t rsp_pdu[mtu];
> +       uint16_t rsp_len;
> +       uint8_t rsp_opcode;
> +       uint8_t ecode = 0;
> +       uint16_t ehandle = 0;
> +       struct queue *q = NULL;
> +       int iter = 0;
> +       uint8_t data_val_len;
> +
> +       if (length != 6 && length != 20) {
> +               ecode = BT_ATT_ERROR_INVALID_PDU;
> +               goto error;
> +       }
> +
> +       q = queue_new();
> +       if (!q) {
> +               ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> +               goto error;
> +       }
> +
> +       start = get_le16(pdu);
> +       end = get_le16(pdu + 2);
> +       get_uuid_le(pdu + 4, length - 4, &type);
> +
> +       util_debug(server->debug_callback, server->debug_data,
> +                               "Read By Grp Type - start: 0x%04x end: 0x%04x",
> +                               start, end);
> +
> +       if (!start || !end) {
> +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
> +               goto error;
> +       }
> +
> +       ehandle = start;
> +
> +       if (start > end) {
> +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
> +               goto error;
> +       }
> +
> +       /* GATT defines that only the <<Primary Service>> and
> +        * <<Secondary Service>> group types can be used for the
> +        * "Read By Group Type" request (Core v4.1, Vol 3, sec 2.5.3). Return an
> +        * error if any other group type is given.
> +        */
> +       bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
> +       bt_uuid16_create(&snd, GATT_SND_SVC_UUID);
> +       if (bt_uuid_cmp(&type, &prim) && bt_uuid_cmp(&type, &snd)) {
> +               ecode = BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE;
> +               goto error;
> +       }
> +
> +       gatt_db_read_by_group_type(server->db, start, end, type, q);
> +
> +       if (queue_isempty(q)) {
> +               ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
> +               goto error;
> +       }

This function is quite long, perhaps using queue_foreach be better
than iterating inline since you destroy the queue at end but it would
be a problem if one of items fails to be encoded, the funny thing is
that it is possible to do the same with queue_find and return true to
interrupt in case of failure but it would be a obvious abuse of the
API so perhaps queue_foreach_func_t could have a return as well and in
case it return false we stop.

> +       rsp_len = 0;
> +       while (queue_peek_head(q)) {
> +               uint16_t start_handle = PTR_TO_UINT(queue_pop_head(q));
> +               uint16_t end_handle;
> +               uint8_t *value = NULL;
> +               int value_len = 0;
> +
> +               /* TODO: Figure out how to check permissions based on security
> +                * level on a bt_att, which sits on a generic io.
> +                */
> +
> +               if (!gatt_db_read(server->db, start_handle, 0, opcode, NULL,
> +                                                       &value, &value_len)) {
> +                       ecode = BT_ATT_ERROR_UNLIKELY;
> +                       goto error;
> +               }
> +
> +               if (value_len < 0) {
> +                       /* This should never happen for primary/secondary
> +                        * service declarations.
> +                        */
> +                       ecode = BT_ATT_ERROR_UNLIKELY;
> +                       goto error;
> +               }
> +
> +               /* Use the first attribute to determine the length of each
> +                * attribute data unit. Stop the list when a different attribute
> +                * value is seen.
> +                */
> +               if (iter == 0) {
> +                       data_val_len = value_len;
> +                       rsp_pdu[0] = data_val_len + 4;
> +                       iter++;
> +               } else if (value_len != data_val_len)
> +                       break;
> +
> +               /* Stop if this unit would surpass the MTU */
> +               if (iter + data_val_len + 4 > mtu)
> +                       break;
> +
> +               end_handle = gatt_db_get_end_handle(server->db, start_handle);
> +
> +               put_le16(start_handle, rsp_pdu + iter);
> +               put_le16(end_handle, rsp_pdu + iter + 2);
> +               memcpy(rsp_pdu + iter + 4, value, value_len);
> +
> +               iter += data_val_len + 4;
> +       }
> +
> +       rsp_opcode = BT_ATT_OP_READ_BY_GRP_TYPE_RSP;
> +       rsp_len = iter;
> +
> +       goto done;
> +
> +error:
> +       rsp_opcode = BT_ATT_OP_ERROR_RSP;
> +       rsp_len = 4;
> +       encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
> +
> +done:
> +       queue_destroy(q, NULL);
> +       bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len,
> +                                                       NULL, NULL, NULL);
> +}
> +
>  static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
>                                         uint16_t length, void *user_data)
>  {
> @@ -97,18 +250,33 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
>         /* Set MTU to be the minimum */
>         server->mtu = final_mtu;
>         bt_att_set_mtu(server->att, final_mtu);
> +
> +       util_debug(server->debug_callback, server->debug_data,
> +                       "MTU exchange complete, with MTU: %u", final_mtu);
>  }
>
>  static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
>  {
> -       /* EXCHANGE MTU request */
> +       /* Exchange MTU */
>         server->mtu_id = bt_att_register(server->att, BT_ATT_OP_MTU_REQ,
>                                                                 exchange_mtu_cb,
>                                                                 server, NULL);
>         if (!server->mtu_id)
>                 return false;
>
> +       /* Read By Group Type */
> +       server->read_by_grp_type_id = bt_att_register(server->att,
> +                                               BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
> +                                               read_by_grp_type_cb,
> +                                               server, NULL);
> +       if (!server->read_by_grp_type_id)
> +               goto fail;
> +
>         return true;
> +
> +fail:
> +       gatt_server_unregister_handlers(server);
> +       return false;
>  }
>
>  struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

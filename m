Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLcVmOq5pxwWekpXDDFYmMc-dYp1wWQfCzXuJApXS8wRA@mail.gmail.com>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
	<1415392919-17572-4-git-send-email-armansito@chromium.org>
	<CABBYNZLcVmOq5pxwWekpXDDFYmMc-dYp1wWQfCzXuJApXS8wRA@mail.gmail.com>
Date: Mon, 10 Nov 2014 08:18:12 -0800
Message-ID: <CAHrH25T4ghCpXuo6XgX156W8gMtbZE7voptSQ6kX2L4taKkaTg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 03/11] shared/gatt-server: Implement "Write"
 request and command.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon, Nov 10, 2014 at 3:57 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Fri, Nov 7, 2014 at 10:41 PM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch implements the "Write" request and command for the GATT
>> server role. Writes are delegated to the attribute's write handler,
>> which is also responsible for performing certain permission checks.
>> ---
>>  src/shared/gatt-server.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 146 insertions(+)
>>
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>> index ddb714d..db002db 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -50,6 +50,11 @@ struct async_read_op {
>>         struct queue *db_data;
>>  };
>>
>> +struct async_write_op {
>> +       struct bt_gatt_server *server;
>> +       uint8_t opcode;
>> +};
>> +
>>  struct bt_gatt_server {
>>         struct gatt_db *db;
>>         struct bt_att *att;
>> @@ -60,8 +65,11 @@ struct bt_gatt_server {
>>         unsigned int read_by_grp_type_id;
>>         unsigned int read_by_type_id;
>>         unsigned int find_info_id;
>> +       unsigned int write_id;
>> +       unsigned int write_cmd_id;
>>
>>         struct async_read_op *pending_read_op;
>> +       struct async_write_op *pending_write_op;
>>
>>         bt_gatt_server_debug_func_t debug_callback;
>>         bt_gatt_server_destroy_func_t debug_destroy;
>> @@ -77,10 +85,15 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
>>         bt_att_unregister(server->att, server->read_by_grp_type_id);
>>         bt_att_unregister(server->att, server->read_by_type_id);
>>         bt_att_unregister(server->att, server->find_info_id);
>> +       bt_att_unregister(server->att, server->write_id);
>> +       bt_att_unregister(server->att, server->write_cmd_id);
>>
>>         if (server->pending_read_op)
>>                 server->pending_read_op->server = NULL;
>>
>> +       if (server->pending_write_op)
>> +               server->pending_write_op->server = NULL;
>> +
>>         bt_att_unref(server->att);
>>         free(server);
>>  }
>> @@ -626,6 +639,125 @@ done:
>>                                                         NULL, NULL, NULL);
>>  }
>>
>> +static void async_write_op_destroy(struct async_write_op *op)
>> +{
>> +       if (op->server)
>> +               op->server->pending_write_op = NULL;
>> +
>> +       free(op);
>> +}
>> +
>> +static void write_complete_cb(struct gatt_db_attribute *attr, int err,
>> +                                                               void *user_data)
>> +{
>> +       struct async_write_op *op = user_data;
>> +       struct bt_gatt_server *server = op->server;
>> +       uint16_t handle;
>> +
>> +       if (!server) {
>> +               async_write_op_destroy(op);
>> +               return;
>> +       }
>> +
>> +       handle = gatt_db_attribute_get_handle(attr);
>> +
>> +       if (err) {
>> +               uint8_t rsp_pdu[4];
>> +               uint8_t att_ecode = att_ecode_from_error(err);
>> +
>> +               encode_error_rsp(op->opcode, handle, att_ecode, rsp_pdu);
>> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
>> +                                                       NULL, NULL, NULL);
>> +       } else {
>> +               /*
>> +                * TODO: Make this function work with Prepare Write request once
>> +                * it's supported.
>> +                */
>> +
>> +               bt_att_send(server->att, BT_ATT_OP_WRITE_RSP, NULL, 0,
>> +                                                       NULL, NULL, NULL);
>> +       }
>> +
>> +       async_write_op_destroy(op);
>> +}
>> +
>> +static void write_cb(uint8_t opcode, const void *pdu,
>> +                                       uint16_t length, void *user_data)
>> +{
>> +       struct bt_gatt_server *server = user_data;
>> +       struct gatt_db_attribute *attr;
>> +       uint16_t handle = 0;
>> +       uint8_t rsp_pdu[4];
>> +       gatt_db_attribute_write_t complete_func = NULL;
>> +       struct async_write_op *op = NULL;
>> +       uint8_t ecode;
>> +       uint32_t perm;
>> +
>> +       if (length < 2) {
>> +               ecode = BT_ATT_ERROR_INVALID_PDU;
>> +               goto error;
>> +       }
>> +
>> +       handle = get_le16(pdu);
>> +       attr = gatt_db_get_attribute(server->db, handle);
>> +       if (!attr) {
>> +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
>> +               goto error;
>> +       }
>> +
>> +       util_debug(server->debug_callback, server->debug_data,
>> +                               "Write %s - handle: 0x%04x",
>> +                               (opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
>> +                               handle);
>> +
>> +       if (!gatt_db_attribute_get_permissions(attr, &perm)) {
>> +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
>> +               goto error;
>> +       }
>> +
>> +       if (!(perm & BT_ATT_PERM_WRITE)) {
>> +               ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
>> +               goto error;
>> +       }
>> +
>> +       /* If this is not a command, set up the completion callback and data */
>> +       if (opcode == BT_ATT_OP_WRITE_REQ) {
>> +               if (server->pending_write_op) {
>> +                       ecode = BT_ATT_ERROR_UNLIKELY;
>> +                       goto error;
>> +               }
>> +
>> +               op = new0(struct async_write_op, 1);
>> +               if (!op) {
>> +                       ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>> +                       goto error;
>> +               }
>> +
>> +               op->server = server;
>> +               op->opcode = opcode;
>> +               server->pending_write_op = op;
>> +
>> +               complete_func = write_complete_cb;
>> +       }
>> +
>> +       if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
>> +                                               NULL, complete_func, op))
>> +               return;
>
> Currently gatt_db_attribute_write does not accept NULL callbacks so
> this would probably fail for BT_ATT_OP_WRITE_CMD, so either we do
> change it and allow unconfirmed writes or perhaps we can always set
> write_complete_cb and server->pending_write_op so the server can tell
> the write is still pending although for BT_ATT_OP_WRITE_CMD there is
> no response.
>

You're right, fixed for v2.

>> +       if (op)
>> +               async_write_op_destroy(op);
>> +
>> +       ecode = BT_ATT_ERROR_UNLIKELY;
>> +
>> +error:
>> +       if (opcode == BT_ATT_OP_WRITE_CMD)
>> +               return;
>> +
>> +       encode_error_rsp(opcode, handle, ecode, rsp_pdu);
>> +       bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
>> +                                                       NULL, NULL, NULL);
>> +}
>> +
>>  static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
>>                                         uint16_t length, void *user_data)
>>  {
>> @@ -690,6 +822,20 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
>>         if (!server->find_info_id)
>>                 return false;
>>
>> +       /* Write Request */
>> +       server->write_id = bt_att_register(server->att, BT_ATT_OP_WRITE_REQ,
>> +                                                               write_cb,
>> +                                                               server, NULL);
>> +       if (!server->write_id)
>> +               return false;
>> +
>> +       /* Write Command */
>> +       server->write_cmd_id = bt_att_register(server->att, BT_ATT_OP_WRITE_CMD,
>> +                                                               write_cb,
>> +                                                               server, NULL);
>> +       if (!server->write_cmd_id)
>> +               return false;
>> +
>>         return true;
>>  }
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

Cheers,
Arman

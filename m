Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RQ87QGAR+x7ZYh7paoM7PRGRE9rxW=cCa6-C7Z_3yopw@mail.gmail.com>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
	<1413838861-29956-7-git-send-email-armansito@chromium.org>
	<CABBYNZLkhzGgdZk2YSxbhdKHXeX2f_2OZi6sXvcbj75P8NgRtw@mail.gmail.com>
	<CAHrH25RQ87QGAR+x7ZYh7paoM7PRGRE9rxW=cCa6-C7Z_3yopw@mail.gmail.com>
Date: Sun, 26 Oct 2014 20:56:11 +0200
Message-ID: <CABBYNZKF=VYA6YHe_UftQDuvXOdHHqVxyRdJDc=8MAS_jrxHKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/8] shared/gatt-server: Implement "Read By Type" request.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Oct 24, 2014 at 8:12 PM, Arman Uguray <armansito@google.com> wrote:
> Hi Luiz,
>
>
> On Fri, Oct 24, 2014 at 2:25 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Tue, Oct 21, 2014 at 12:00 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> This patch implements the ATT protocol "Read By Type" request for
>>> shared/gatt-server. Logic is implemented that allows asynchronous
>>> reading of non-standard attribute values via the registered read and
>>> read completion callbacks.
>>> ---
>>>  src/shared/gatt-server.c | 273 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 270 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>>> index 3233b21..6c5ea2b 100644
>>> --- a/src/shared/gatt-server.c
>>> +++ b/src/shared/gatt-server.c
>>> @@ -38,6 +38,16 @@
>>>  #define MIN(a, b) ((a) < (b) ? (a) : (b))
>>>  #endif
>>>
>>> +struct async_read_op {
>>> +       struct bt_gatt_server *server;
>>> +       uint8_t opcode;
>>> +       bool done;
>>> +       uint8_t *pdu;
>>> +       size_t pdu_len;
>>> +       int value_len;
>>> +       struct queue *db_data;
>>> +};
>>> +
>>>  struct bt_gatt_server {
>>>         struct gatt_db *db;
>>>         struct bt_att *att;
>>> @@ -46,6 +56,9 @@ struct bt_gatt_server {
>>>
>>>         unsigned int mtu_id;
>>>         unsigned int read_by_grp_type_id;
>>> +       unsigned int read_by_type_id;
>>> +
>>> +       struct async_read_op *pending_read_op;
>>>
>>>         bt_gatt_server_debug_func_t debug_callback;
>>>         bt_gatt_server_destroy_func_t debug_destroy;
>>> @@ -59,8 +72,12 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
>>>
>>>         bt_att_unregister(server->att, server->mtu_id);
>>>         bt_att_unregister(server->att, server->read_by_grp_type_id);
>>> +       bt_att_unregister(server->att, server->read_by_type_id);
>>>         bt_att_unref(server->att);
>>>
>>> +       if (server->pending_read_op)
>>> +               server->pending_read_op->server = NULL;
>>> +
>>>         free(server);
>>>  }
>>>
>>> @@ -124,21 +141,21 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>>>                  * value is seen.
>>>                  */
>>>                 if (iter == 0) {
>>> -                       data_val_len = value_len;
>>> +                       data_val_len = MIN(MIN(mtu - 6, 251), value_len);
>>>                         pdu[0] = data_val_len + 4;
>>>                         iter++;
>>>                 } else if (value_len != data_val_len)
>>>                         break;
>>>
>>>                 /* Stop if this unit would surpass the MTU */
>>> -               if (iter + data_val_len + 4 > mtu)
>>> +               if (iter + data_val_len + 4 > mtu - 1)
>>>                         break;
>>>
>>>                 end_handle = gatt_db_get_end_handle(db, start_handle);
>>>
>>>                 put_le16(start_handle, pdu + iter);
>>>                 put_le16(end_handle, pdu + iter + 2);
>>> -               memcpy(pdu + iter + 4, value, value_len);
>>> +               memcpy(pdu + iter + 4, value, data_val_len);
>>>
>>>                 iter += data_val_len + 4;
>>>         }
>>> @@ -235,6 +252,248 @@ done:
>>>                                                         NULL, NULL, NULL);
>>>  }
>>>
>>> +static void async_read_op_destroy(struct async_read_op *op)
>>> +{
>>> +       if (op->server)
>>> +               op->server->pending_read_op = NULL;
>>> +
>>> +       queue_destroy(op->db_data, NULL);
>>> +       free(op->pdu);
>>> +       free(op);
>>> +}
>>> +
>>> +static void process_read_by_type(struct async_read_op *op);
>>> +
>>> +static void read_by_type_read_complete_cb(uint16_t handle, uint16_t att_ecode,
>>> +                                       const uint8_t *value, size_t len,
>>> +                                       void *complete_data)
>>> +{
>>> +       struct async_read_op *op = complete_data;
>>> +       struct bt_gatt_server *server = op->server;
>>> +       uint16_t mtu;
>>> +
>>> +       if (!server) {
>>> +               async_read_op_destroy(op);
>>> +               return;
>>> +       }
>>> +
>>> +       mtu = bt_att_get_mtu(server->att);
>>> +
>>> +       /* Terminate the operation if there was an error */
>>> +       if (att_ecode) {
>>> +               uint8_t pdu[4];
>>> +
>>> +               encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, handle, att_ecode,
>>> +                                                                       pdu);
>>> +               bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
>>> +                                                               NULL, NULL);
>>> +               async_read_op_destroy(op);
>>> +               return;
>>> +       }
>>> +
>>> +       if (op->pdu_len == 0) {
>>> +               op->value_len = MIN(MIN(mtu - 4, 253), len);
>>> +               op->pdu[0] = op->value_len + 2;
>>> +               op->pdu_len++;
>>> +       } else if (len != op->value_len) {
>>> +               op->done = true;
>>> +               goto done;
>>> +       }
>>> +
>>> +       /* Stop if this would surpass the MTU */
>>> +       if (op->pdu_len + op->value_len + 2 > mtu - 1) {
>>> +               op->done = true;
>>> +               goto done;
>>> +       }
>>> +
>>> +       /* Encode the current value */
>>> +       put_le16(handle, op->pdu + op->pdu_len);
>>> +       memcpy(op->pdu + op->pdu_len + 2, value, op->value_len);
>>> +
>>> +       op->pdu_len += op->value_len + 2;
>>> +
>>> +       if (op->pdu_len == mtu - 1)
>>> +               op->done = true;
>>
>> The code above is duplicated and it is actually causing some warnings
>> comparing unsigned with signed (usually cause by '-' operation) which
>> I started fixing myself but stop once I realize this was the result of
>> gatt_db_read having 2 modes to read, sync and async, which I don't
>> think is a good idea.
>>
>
> Yes, please see my response to your other comment in this patch set.
>
>
>>> +done:
>>> +       process_read_by_type(op);
>>> +}
>>> +
>>> +static void process_read_by_type(struct async_read_op *op)
>>> +{
>>> +       struct bt_gatt_server *server = op->server;
>>> +       uint16_t mtu = bt_att_get_mtu(server->att);
>>> +       uint8_t rsp_opcode;
>>> +       uint8_t rsp_len;
>>> +       uint8_t ecode;
>>> +       uint16_t ehandle;
>>> +       uint16_t start_handle;
>>> +       uint8_t *value;
>>> +       int value_len;
>>> +       uint32_t perm;
>>> +
>>> +       if (op->done) {
>>> +               rsp_opcode = BT_ATT_OP_READ_BY_TYPE_RSP;
>>> +               rsp_len = op->pdu_len;
>>> +               goto done;
>>> +       }
>>> +
>>> +       while (queue_peek_head(op->db_data)) {
>>> +               start_handle = PTR_TO_UINT(queue_pop_head(op->db_data));
>>> +               value = NULL;
>>> +               value_len = 0;
>>> +
>>> +               if (!gatt_db_get_attribute_permissions(server->db, start_handle,
>>> +                                                               &perm)) {
>>> +                       ecode = BT_ATT_ERROR_UNLIKELY;
>>> +                       goto error;
>>> +               }
>>> +
>>> +               /*
>>> +                * Check for the READ access permission. Encryption,
>>> +                * authentication, and authorization permissions need to be
>>> +                * checked by the read handler, since bt_att is agnostic to
>>> +                * connection type and doesn't have security information on it.
>>> +                */
>>> +               if (perm && !(perm & BT_ATT_PERM_READ)) {
>>> +                       ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
>>> +                       goto error;
>>> +               }
>>
>> I would suggest moving this check to gatt_db_read which should return
>> -EPERM or the actual code if it is too hard to have errno mapping for
>> each error code.
>>
>
> gatt_db currently has this nice property that the permissions field is
> just a uint32_t. This means that while shared/gatt-server can use the
> new permission macros I added to shared/att-types, the android code
> can still use the Android platform definitions. Of course, once
> android starts using shared/gatt-server it'll have to use the new
> macros but for now we can have gatt-db support both types by keeping
> the permission checks outside of gatt-db and this would make the whole
> transition easier. Makes sense?

Well I would like to harmonize the definitions with Android as soon as
possible since you are defining new ones, which Ive applied btw,
otherwise later when we start using it in Android it might break
things, btw Im fine if the server actually handling the permissions,
what I really want is a central place to handle them.

-- 
Luiz Augusto von Dentz

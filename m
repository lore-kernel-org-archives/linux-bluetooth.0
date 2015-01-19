Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAuDt+apnn5e+PO+3cGokoL9Hw_tc=KrEM5dBmXMDm4kig@mail.gmail.com>
References: <1421223444-9374-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKGuUa8AFo53QTs6Un=uGN0=jH63x4in=k+5uu55OqSAA@mail.gmail.com>
	<CAMudyAuDt+apnn5e+PO+3cGokoL9Hw_tc=KrEM5dBmXMDm4kig@mail.gmail.com>
Date: Mon, 19 Jan 2015 18:09:40 +0200
Message-ID: <CABBYNZ+K0D-ywU=fsJv4gwz6PV9LyZ79U++1hv=7zq5Z4j9T=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/gatt-client: Add write prepare and execute
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Jan 14, 2015 at 3:52 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Luiz,
>
> On 14 January 2015 at 13:56, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Wed, Jan 14, 2015 at 6:17 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> For Android we need explicit write prepare and execute commands in GATT
>>> client. This patch adds that.
>>>
>>> Note that till now prepare and execute has been used only in long write.
>>>
>>> This patch makes sure that long write is not proceeded when prepare write
>>> has been called. Instead long write commands will be queued and
>>> once write execute command is done, queued long write requests will be
>>> proceeded.
>>>
>>> It does not work in other way. Meaning, when long write is ongoing,
>>> prepare write will not be proceeded nor queued. This feature can be
>>> added later on if really needed.
>>>
>>> Conflicts:
>>>         src/shared/gatt-client.c
>>> ---
>>>  src/shared/gatt-client.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>  src/shared/gatt-client.h |  11 +++
>>>  2 files changed, 225 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>>> index 1acd34f..c7c29cf 100644
>>> --- a/src/shared/gatt-client.c
>>> +++ b/src/shared/gatt-client.c
>>> @@ -75,6 +75,8 @@ struct bt_gatt_client {
>>>         struct queue *long_write_queue;
>>>         bool in_long_write;
>>>
>>> +       bool in_prep_write;
>>> +
>>>         /* List of registered disconnect/notification/indication callbacks */
>>>         struct queue *notify_list;
>>>         struct queue *notify_chrcs;
>>> @@ -2172,6 +2174,7 @@ unsigned int bt_gatt_client_write_without_response(
>>>  }
>>>
>>>  struct write_op {
>>> +       struct bt_gatt_client *client;
>>>         bt_gatt_client_callback_t callback;
>>>         void *user_data;
>>>         bt_gatt_destroy_func_t destroy;
>>> @@ -2524,7 +2527,7 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>>>         req->destroy = long_write_op_free;
>>>         req->long_write = true;
>>>
>>> -       if (client->in_long_write) {
>>> +       if (client->in_long_write || client->in_prep_write) {
>>>                 queue_push_tail(client->long_write_queue, req);
>>>                 return req->id;
>>>         }
>>> @@ -2557,6 +2560,216 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>>>         return req->id;
>>>  }
>>>
>>> +struct prep_write_op {
>>> +       bt_gatt_client_write_long_callback_t callback;
>>> +       void *user_data;
>>> +       bt_gatt_destroy_func_t destroy;
>>> +       uint8_t *pdu;
>>> +       uint16_t pdu_len;
>>> +};
>>> +
>>> +static void destroy_prep_write_op(void *data)
>>> +{
>>> +       struct prep_write_op *op = data;
>>> +
>>> +       if (op->destroy)
>>> +               op->destroy(op->user_data);
>>> +
>>> +       free(op->pdu);
>>> +       free(op);
>>> +}
>>> +
>>> +static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>> +                                                               void *user_data)
>>> +{
>>> +       struct request *req = user_data;
>>> +       struct prep_write_op *op = req->data;
>>> +       bool success;
>>> +       uint8_t att_ecode;
>>> +       bool reliable_error;
>>> +
>>> +       if (opcode == BT_ATT_OP_ERROR_RSP) {
>>> +               success = false;
>>> +               reliable_error = false;
>>> +               att_ecode = process_error(pdu, length);
>>> +               goto done;
>>> +       }
>>> +
>>> +       if (opcode != BT_ATT_OP_PREP_WRITE_RSP) {
>>> +               success = false;
>>> +               reliable_error = false;
>>> +               att_ecode = 0;
>>> +               goto done;
>>> +       }
>>> +
>>> +       if (!pdu || length != op->pdu_len ||
>>> +                                       memcmp(pdu, op->pdu, op->pdu_len)) {
>>> +               success = false;
>>> +               reliable_error = true;
>>> +               att_ecode = 0;
>>> +               goto done;
>>> +       }
>>> +
>>> +       success = true;
>>> +       reliable_error = false;
>>> +       att_ecode = 0;
>>> +
>>> +done:
>>> +       if (op->callback)
>>> +               op->callback(success, reliable_error, att_ecode, op->user_data);
>>> +}
>>> +
>>> +unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
>>> +                               uint16_t value_handle, uint16_t offset,
>>> +                               uint8_t *value, uint16_t length,
>>> +                               bt_gatt_client_write_long_callback_t callback,
>>> +                               void *user_data,
>>> +                               bt_gatt_client_destroy_func_t destroy)
>>> +{
>>> +       struct request *req;
>>> +       struct prep_write_op *op;
>>> +       uint8_t pdu[4 + length];
>>> +
>>> +       if (!client)
>>> +               return 0;
>>> +
>>> +       if (client->in_long_write)
>>> +               return 0;
>>> +
>>> +       op = new0(struct prep_write_op, 1);
>>> +       if (!op)
>>> +               return 0;
>>> +
>>> +       req = request_create(client);
>>> +       if (!req) {
>>> +               free(op);
>>> +               return 0;
>>> +       }
>>> +
>>> +       op->callback = callback;
>>> +       op->user_data = user_data;
>>> +       op->destroy = destroy;
>>> +
>>> +       req->data = op;
>>> +       req->destroy = destroy_prep_write_op;
>>> +
>>> +       put_le16(value_handle, pdu);
>>> +       put_le16(offset, pdu + 2);
>>> +       memcpy(pdu + 4, value, length);
>>> +
>>> +       /*
>>> +        * Before sending command we need to remember pdu as we need to validate
>>> +        * it in the response. Store handle, offset and value. Therefore
>>> +        * increase length by 4 (handle + offset) as we need it in couple places
>>> +        * below
>>> +        */
>>> +       length += 4;
>>> +
>>> +       op->pdu = malloc(length);
>>> +       if (!op->pdu) {
>>> +               op->destroy = NULL;
>>> +               request_unref(req);
>>> +               return 0;
>>> +       }
>>> +
>>> +       memcpy(op->pdu, pdu, length);
>>> +       op->pdu_len = length;
>>> +
>>> +       /* Now we are ready to send command */
>>> +       req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ, pdu,
>>> +                                       sizeof(pdu), prep_write_cb, req,
>>> +                                       request_unref);
>>> +       if (!req->att_id) {
>>> +               op->destroy = NULL;
>>> +               request_unref(req);
>>> +               return 0;
>>> +       }
>>> +
>>> +       client->in_prep_write = true;
>>> +
>>> +       return req->id;
>>> +}
>>> +
>>> +static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>> +                                                               void *user_data)
>>> +{
>>> +       struct request *req = user_data;
>>> +       struct write_op *op = req->data;
>>> +       bool success;
>>> +       uint8_t att_ecode;
>>> +
>>> +       if (opcode == BT_ATT_OP_ERROR_RSP) {
>>> +               success = false;
>>> +               att_ecode = process_error(pdu, length);
>>> +               goto done;
>>> +       }
>>> +
>>> +       if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length) {
>>> +               success = false;
>>> +               att_ecode = 0;
>>> +               goto done;
>>> +       }
>>> +
>>> +       success = true;
>>> +       att_ecode = 0;
>>> +
>>> +done:
>>> +       if (op->callback)
>>> +               op->callback(success, att_ecode, op->user_data);
>>> +
>>> +       op->client->in_prep_write = false;
>>> +
>>> +       start_next_long_write(op->client);
>>> +}
>>> +
>>> +unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
>>> +                                       bool execute,
>>> +                                       bt_gatt_client_callback_t callback,
>>> +                                       void *user_data,
>>> +                                       bt_gatt_client_destroy_func_t destroy)
>>> +{
>>> +       struct request *req;
>>> +       struct write_op *op;
>>> +       uint8_t pdu;
>>> +
>>> +       if (!client)
>>> +               return false;
>>> +
>>> +       if (client->in_long_write || !client->in_prep_write)
>>> +               return false;
>>> +
>>> +       op = new0(struct write_op, 1);
>>> +       if (!op)
>>> +               return false;
>>> +
>>> +       req = request_create(client);
>>> +       if (!req) {
>>> +               free(op);
>>> +               return 0;
>>> +       }
>>> +
>>> +       op->client = client;
>>> +       op->callback = callback;
>>> +       op->user_data = user_data;
>>> +       op->destroy = destroy;
>>> +
>>> +       pdu = execute ? 0x01 : 0x00;
>>> +
>>> +       req->data = op;
>>> +       req->destroy = destroy_write_op;
>>> +
>>> +       req->att_id = bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
>>> +                                               sizeof(pdu), exec_write_cb,
>>> +                                               req, request_unref);
>>> +       if (!req->att_id) {
>>> +               op->destroy = NULL;
>>> +               request_unref(req);
>>> +               return 0;
>>> +       }
>>> +
>>> +       return req->att_id;
>>> +}
>>> +
>>>  static bool match_notify_chrc_value_handle(const void *a, const void *b)
>>>  {
>>>         const struct notify_chrc *chrc = a;
>>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>>> index 9a00feb..45c02c8 100644
>>> --- a/src/shared/gatt-client.h
>>> +++ b/src/shared/gatt-client.h
>>> @@ -109,6 +109,17 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>>>                                 bt_gatt_client_write_long_callback_t callback,
>>>                                 void *user_data,
>>>                                 bt_gatt_client_destroy_func_t destroy);
>>> +unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
>>> +                               uint16_t value_handle, uint16_t offset,
>>> +                               uint8_t *value, uint16_t length,
>>> +                               bt_gatt_client_write_long_callback_t callback,
>>> +                               void *user_data,
>>> +                               bt_gatt_client_destroy_func_t destroy);
>>> +unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
>>> +                                       bool execute,
>>> +                                       bt_gatt_client_callback_t callback,
>>> +                                       void *user_data,
>>> +                                       bt_gatt_client_destroy_func_t destroy);
>>
>> I think it is better to leave execute flag to be handled internally by
>> bt_gatt_client_cancel (which seems already handle that).
>
> Ah I see that bt_gatt_client_cancel send write execute 0x00 if there
> was ongoing long write.
> Maybe we could consider do same when does prepare write "manulay"

One thing Im not getting is what bt_gatt_client_prepare_write has to
be so different than bt_gatt_client_write_long_value, IMO it would
make sense to reuse code perhaps by calling
bt_gatt_client_prepare_write in bt_gatt_client_write_long_value as it
seems the only difference is that bt_gatt_client_write_long_value auto
execute while bt_gatt_client_prepare_write requires
bt_gatt_client_write_execute to be called manually.

> However I would keep write_execute with execute flag as it is now.
> Android has API for that and it just makes things easy. Otherwise,
> Android GATT part would have to keep track on the req_id of prepared
> writes in order to use it when application does write execute 0x00. Is
> that fine?

Don't you have to track it anyway, in case it is still outstanding in
the queue you would have to wait the prepare write to complete to send
the execute but if it still in the queue there is no reason even to
proceed with prepare.

> BTW. What happens in case we have really long write. Then in between
> prepare writes user sends regular write request and  then user cancel
> that regular write before long write is finished?

Well there is no cancel at ATT level, besides execute 0x00, so we can
only remove from the outgoing queue, but perhaps you had something
else in mind.

>
> BR
> \Lukasz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz

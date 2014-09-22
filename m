Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CD6FEB99-0D29-4AA7-8794-D5B5DFA28C37@holtmann.org>
References: <1410958395-7174-1-git-send-email-chao.jie.gu@intel.com>
	<12273172.GZIjs3WGW2@leonov>
	<3D02B219753AD44CBDDDE484323B17741130A080@SHSMSX104.ccr.corp.intel.com>
	<CD6FEB99-0D29-4AA7-8794-D5B5DFA28C37@holtmann.org>
Date: Mon, 22 Sep 2014 11:33:59 +0200
Message-ID: <CAN_7+YbX6OnBROiRAsm9Zp=4MVVF=MoTDYZQNdJ+9=nw7=AKdg@mail.gmail.com>
Subject: Re: [PATCH] Add signed write command
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"armansito@chromium.org" <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 22, 2014 at 11:06 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Chao Jie,
>
>>>> Add bt_att_set_csrk for btgatt-client tool. However this patch hook
>>>> into shared/mgmt, so btgatt-client now should be running by the root user.
>>>
>>> I guess this could be made optional.
>>
>> You said this could be made optional , what's you point ? I am not very clear about
>> That.
>
> just provide a command line option to btgatt-client to provide the CSRK to be used. There is no need to attach to mgmt since that is only seeing keys during pairing anyway.
>
>>
>>>> ---
>>>> src/shared/att-types.h   |    3 ++
>>>> src/shared/att.c         |   49 ++++++++++++++++--
>>>> src/shared/att.h         |    2 +
>>>> src/shared/gatt-client.c |   11 ++--
>>>> tools/btgatt-client.c    |  129
>>>> ++++++++++++++++++++++++++++++++++++++++++++++ 5 files changed, 186
>>>> insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/src/shared/att-types.h b/src/shared/att-types.h index
>>>> b85c969..da8b6ae 100644
>>>> --- a/src/shared/att-types.h
>>>> +++ b/src/shared/att-types.h
>>>> @@ -25,6 +25,9 @@
>>>>
>>>> #define BT_ATT_DEFAULT_LE_MTU 23
>>>>
>>>> +/* Length of signature in write signed packet */
>>>> +#define BT_ATT_SIGNATURE_LEN               12
>>>> +
>>>> /* ATT protocol opcodes */
>>>> #define BT_ATT_OP_ERROR_RSP                 0x01
>>>> #define BT_ATT_OP_MTU_REQ                   0x02
>>>> diff --git a/src/shared/att.c b/src/shared/att.c index
>>>> a5cab45..aadef9e 100644
>>>> --- a/src/shared/att.c
>>>> +++ b/src/shared/att.c
>>>> @@ -36,6 +36,7 @@
>>>> #include "lib/uuid.h"
>>>> #include "src/shared/att.h"
>>>> #include "src/shared/att-types.h"
>>>> +#include "src/shared/crypto.h"
>>>>
>>>> #define ATT_MIN_PDU_LEN                     1  /* At least 1 byte for the opcode. */
>>>> #define ATT_OP_CMD_MASK                     0x40
>>>> @@ -77,6 +78,11 @@ struct bt_att {
>>>>     bt_att_debug_func_t debug_callback;
>>>>     bt_att_destroy_func_t debug_destroy;
>>>>     void *debug_data;
>>>> +
>>>> +   struct bt_crypto *crypto;
>>>> +
>>>> +   uint8_t local_csrk[16];
>>>> +   uint32_t local_sign_cnt;
>>>> };
>>>>
>>>> enum att_op_type {
>>>> @@ -176,6 +182,8 @@ struct att_send_op {
>>>>     bt_att_response_func_t callback;
>>>>     bt_att_destroy_func_t destroy;
>>>>     void *user_data;
>>>> +
>>>> +   struct bt_att *att;
>>>> };
>>>>
>>>> static void destroy_att_send_op(void *data) @@ -277,6 +285,10 @@
>>>> static bool encode_pdu(struct att_send_op *op, const void *pdu,
>>>> uint16_t length, uint16_t mtu)  {
>>>>     uint16_t pdu_len = 1;
>>>> +   struct bt_att *att = op->att;
>>>> +
>>>> +   if (op->opcode & ATT_OP_SIGNED_MASK)
>>>> +           pdu_len += BT_ATT_SIGNATURE_LEN;
>>>>
>>>>     if (length && pdu)
>>>>             pdu_len += length;
>>>> @@ -293,17 +305,32 @@ static bool encode_pdu(struct att_send_op *op,
>>>> const void *pdu, if (pdu_len > 1)
>>>>             memcpy(op->pdu + 1, pdu, length);
>>>>
>>>> +   if (op->opcode & ATT_OP_SIGNED_MASK) {
>>>
>>> This should be used only if CSRK was provided. So we should have local_csrk_valid or
>>> similar flag (similar to what we currently have in android code). Check should be
>>> either here or we could also bail out sooner in
>>> bt_gatt_client_write_without_response().
>>
>> I think if we add loca_csrk_valid flag, it would be better to put in here. Since csrk
>> Information in the bt_att structure, it should be hidden the details from upper layer.
>>
>>>
>>>> +           if (bt_crypto_sign_att(att->crypto,
>>>> +                                   att->local_csrk,
>>>> +                                   op->pdu,
>>>> +                                   1 + length,
>>>> +                                   att->local_sign_cnt,
>>>> +                                   &((uint8_t *) op->pdu)[1 + length]))
>>>> +                   att->local_sign_cnt++;
>>>> +           else
>>>> +                   return false;
>>>> +   }
>>>> +
>>>>     return true;
>>>> }
>>>>
>>>> -static struct att_send_op *create_att_send_op(uint8_t opcode, const void
>>>> *pdu, -                                             uint16_t length, uint16_t mtu,
>>>> +static struct att_send_op *create_att_send_op(uint8_t opcode,
>>>> +                                           const void *pdu,
>>>> +                                           uint16_t length,
>>>> +                                           struct bt_att *att,
>>>>                                             bt_att_response_func_t callback,
>>>>                                             void *user_data,
>>>>                                             bt_att_destroy_func_t destroy)
>>>> {
>>>>     struct att_send_op *op;
>>>>     enum att_op_type op_type;
>>>> +   uint16_t mtu = att->mtu;
>>>>
>>>>     if (length && !pdu)
>>>>             return NULL;
>>>> @@ -334,6 +361,7 @@ static struct att_send_op
>>>> *create_att_send_op(uint8_t opcode, const void *pdu, op->callback = callback;
>>>>     op->destroy = destroy;
>>>>     op->user_data = user_data;
>>>> +   op->att = att;
>>>>
>>>>     if (!encode_pdu(op, pdu, length, mtu)) {
>>>>             free(op);
>>>> @@ -707,6 +735,10 @@ struct bt_att *bt_att_new(int fd)
>>>>     if (!att->io)
>>>>             goto fail;
>>>>
>>>> +   att->crypto = bt_crypto_new();
>>>> +   if (!att->crypto)
>>>> +           goto fail;
>>>> +
>>>>     att->req_queue = queue_new();
>>>>     if (!att->req_queue)
>>>>             goto fail;
>>>> @@ -741,6 +773,7 @@ fail:
>>>>     queue_destroy(att->write_queue, NULL);
>>>>     queue_destroy(att->notify_list, NULL);
>>>>     queue_destroy(att->disconn_list, NULL);
>>>> +   bt_crypto_unref(att->crypto);
>>>>     io_destroy(att->io);
>>>>     free(att->buf);
>>>>     free(att);
>>>> @@ -931,7 +964,7 @@ unsigned int bt_att_send(struct bt_att *att,
>>>> uint8_t opcode, if (!att || !att->io)
>>>>             return 0;
>>>>
>>>> -   op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
>>>> +   op = create_att_send_op(opcode, pdu, length, att, callback,
>>>>                                                     user_data, destroy);
>>>>     if (!op)
>>>>             return 0;
>>>> @@ -1116,3 +1149,13 @@ bool bt_att_unregister_all(struct bt_att *att)
>>>>
>>>>     return true;
>>>> }
>>>> +
>>>> +void bt_att_set_csrk(struct bt_att *att,
>>>> +                   const uint8_t *val,
>>>> +                   uint32_t local_sign_cnt)
>>>
>>> This should allow to set local and/or remote csrk. Either we have two functions or
>>> flag identifying which key is provided.
>>
>> This is good idea. But this patch for client side, there is no need to use remote_csrk,
>> So would it be better to add remote csrk part when we need this?
>
> I want to function. One to set the local CSRK and one for setting the remote CSRK. However I have no idea why we are bothering with the sign counter. Just reset it when creating bt_att.

Eventually we need signed counter to be stored. Spec 4.1 Part H, 2.4.5
Signing Algorithm  says:

" The SignCounter shall be initialized to zero when CSRK is generated and
incremented for every message that is signed with a given CSRK."

" The device performing verification should store the last verified
SignCounter in
the security database and compare it with a received SignCounter to prevent
replay attacks. If the received SignCounter is greater than the stored value
then the message has not been seen by the local device before and the security
database can be updated."

As far as I understand it is valid as long as given CSRK is used.

>
>>
>>> Also there should be a way to notify user of bt_att about incremented values of
>>> counters.
>>
>> This suggestion is also the same with previous one. I have thought about add
>> function like bt_att_get_csrk for user. However , for btgatt-client tool, there is no
>> need to use it right now, so I didn't add it.
>
> So unless it needs to be remember persistent across connects, then I would not bother with the sign counter at all. If it needs to be remembered, then yes, we something to tell the owner of bt_att that it got updated.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

\Lukasz

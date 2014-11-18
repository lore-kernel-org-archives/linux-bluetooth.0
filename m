Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-K5ZvNrWwDL4eEz4WFVrxBifeHfE83hqEFNvfmTquSnGg@mail.gmail.com>
References: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
	<1415878033-6766-2-git-send-email-marcin.kraglak@tieto.com>
	<CABBYNZJzrXYmqDGuJCy+NGaKj97Jq59TCibx8s43sT5Qq52VSg@mail.gmail.com>
	<CABD6X-JzJM71Z0NL+TTVat5JpnLYmb67p9C8DAFifHHpWLfwbA@mail.gmail.com>
	<CABBYNZLg1GStV359XDv0U2kdwNrbax_UmGsW0LQz-YcHwqnHcA@mail.gmail.com>
	<CAHrH25Qpgcvy0sLxuYprOnqDezS8Es-xiQTT9XF5AYtoXErBPg@mail.gmail.com>
	<CABD6X-KUh8qwnHW_9VswOL9_T-vc8Z8Qi+UFG55tOEkQppYrXQ@mail.gmail.com>
	<CABD6X-JOft8e4VHp_m9YFx=p=sAMuOtKgkOE12kxqrieP6fZ9g@mail.gmail.com>
	<CAHrH25Q-B5i8gGXBq--C8pFHZkFW24NwX9kAmU4wbtL_jCzArA@mail.gmail.com>
	<CABD6X-K5ZvNrWwDL4eEz4WFVrxBifeHfE83hqEFNvfmTquSnGg@mail.gmail.com>
Date: Tue, 18 Nov 2014 14:24:40 -0800
Message-ID: <CAHrH25TNRrH4RRAJQqJiNwLo_utPRrSP4sQ8QQ7osnsLWbrT7w@mail.gmail.com>
Subject: Re: [RFC 01/11] shared/gatt-client: Add read-by-uuid function
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> On Tue, Nov 18, 2014 at 1:03 PM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Hi Arman,
> 18 lis 2014 21:25 "Arman Uguray" <armansito@chromium.org> napisał(a):
>
>
>>
>> Hi Marcin,
>>
>> > On Tue, Nov 18, 2014 at 8:33 AM, Marcin Kraglak
>> > <marcin.kraglak@tieto.com> wrote:
>> > Hi Arman,
>> >
>> > On 18 November 2014 08:09, Marcin Kraglak <marcin.kraglak@tieto.com>
>> > wrote:
>> >> Hi Arman,
>> >>
>> >> On 18 November 2014 00:36, Arman Uguray <armansito@chromium.org> wrote:
>> >>> Hi Luiz,
>> >>>
>> >>>> On Fri, Nov 14, 2014 at 5:51 AM, Luiz Augusto von Dentz
>> >>>> <luiz.dentz@gmail.com> wrote:
>> >>>> Hi Marcin,
>> >>>>
>> >>>> On Fri, Nov 14, 2014 at 3:13 PM, Marcin Kraglak
>> >>>> <marcin.kraglak@tieto.com> wrote:
>> >>>>> Hi Luiz,
>> >>>>>
>> >>>>> On 14 November 2014 13:44, Luiz Augusto von Dentz
>> >>>>> <luiz.dentz@gmail.com> wrote:
>> >>>>>> Hi Marcin,
>> >>>>>>
>> >>>>>> On Thu, Nov 13, 2014 at 1:27 PM, Marcin Kraglak
>> >>>>>> <marcin.kraglak@tieto.com> wrote:
>> >>>>>>> This is exposed to allow client reading characteristic values
>> >>>>>>> with known uuid.
>> >>>>>>> ---
>> >>>>>>>  src/shared/gatt-client.c | 271
>> >>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>> >>>>>>>  src/shared/gatt-client.h |  18 ++++
>> >>>>>>>  2 files changed, 289 insertions(+)
>> >>>>>>>
>> >>>>>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> >>>>>>> index 30b271e..0493b05 100644
>> >>>>>>> --- a/src/shared/gatt-client.c
>> >>>>>>> +++ b/src/shared/gatt-client.c
>> >>>>>>> @@ -44,6 +44,11 @@
>> >>>>>>>  #define GATT_SVC_UUID  0x1801
>> >>>>>>>  #define SVC_CHNGD_UUID 0x2a05
>> >>>>>>>
>> >>>>>>> +static const uint8_t bt_base_uuid[16] = {
>> >>>>>>> +       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
>> >>>>>>> +       0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
>> >>>>>>> +};
>> >>>>>>> +
>> >>>>>>>  struct chrc_data {
>> >>>>>>>         /* The public characteristic entry. */
>> >>>>>>>         bt_gatt_characteristic_t chrc_external;
>> >>>>>>> @@ -122,6 +127,15 @@ struct bt_gatt_client {
>> >>>>>>>         bool in_svc_chngd;
>> >>>>>>>  };
>> >>>>>>>
>> >>>>>>> +static bool is_bluetooth_uuid(const uint8_t
>> >>>>>>> uuid[BT_GATT_UUID_SIZE])
>> >>>>>>> +{
>> >>>>>>> +       if (memcmp(uuid, bt_base_uuid, 2) ||
>> >>>>>>> +                                       memcmp(&uuid[4],
>> >>>>>>> &bt_base_uuid[4], 12))
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       return true;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>
>> >>>>>> Is this really different from uuid_cmp? Perhaps you use set uuid16
>> >>>>>> properly it should just do the same you are doing above.
>> >>>>> Ok, I'll use it.
>> >>>>>>
>> >>>>>>>  struct notify_data {
>> >>>>>>>         struct bt_gatt_client *client;
>> >>>>>>>         bool removed;
>> >>>>>>> @@ -2001,6 +2015,263 @@ bool bt_gatt_client_read_long_value(struct
>> >>>>>>> bt_gatt_client *client,
>> >>>>>>>         return true;
>> >>>>>>>  }
>> >>>>>>>
>> >>>>>>> +struct read_by_uuid_res {
>> >>>>>>> +       uint16_t handle;
>> >>>>>>> +       uint8_t length;
>> >>>>>>> +       uint8_t *data;
>> >>>>>>> +       struct read_by_uuid_res *next;
>> >>>>>>> +};
>> >>>>>>> +
>> >>>>>>> +bool read_by_uuid_res_get(struct read_by_uuid_res *result,
>> >>>>>>> uint16_t *handle,
>> >>>>>>> +                                       uint8_t *length, uint8_t
>> >>>>>>> **data)
>> >>>>>>> +{
>> >>>>>>> +       if (!result)
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       *length = result->length;
>> >>>>>>> +       *handle = result->handle;
>> >>>>>>> +       *data = result->data;
>> >>>>>>> +
>> >>>>>>> +       return true;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +struct read_by_uuid_res *read_by_uuid_res_next(struct
>> >>>>>>> read_by_uuid_res *result)
>> >>>>>>> +{
>> >>>>>>> +       if (!result)
>> >>>>>>> +               return NULL;
>> >>>>>>> +
>> >>>>>>> +       return result->next;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +struct read_by_uuid_op {
>> >>>>>>> +       struct bt_gatt_client *client;
>> >>>>>>> +       bt_gatt_client_read_by_uuid_callback_t callback;
>> >>>>>>> +       int ref_count;
>> >>>>>>> +       uint16_t start_handle;
>> >>>>>>> +       uint16_t end_handle;
>> >>>>>>> +       uint8_t uuid[BT_GATT_UUID_SIZE];
>> >>>>>>> +       struct read_by_uuid_res *result_head;
>> >>>>>>> +       struct read_by_uuid_res *result_tail;
>> >>>>>>> +       void *user_data;
>> >>>>>>> +       bt_gatt_client_destroy_func_t destroy;
>> >>>>>>> +};
>> >>>>>>
>> >>>>>> Im not really sure this lists are really helping us, perhaps this
>> >>>>>> is
>> >>>>>> the effect of using iterators in the API but that seems to create
>> >>>>>> duplicated code.
>> >>>>>>
>> >>>>>>> +static bool append_read_by_uuid_result(struct read_by_uuid_op
>> >>>>>>> *op,
>> >>>>>>> +                                       uint16_t handle, uint16_t
>> >>>>>>> length,
>> >>>>>>> +                                       const uint8_t *data)
>> >>>>>>> +{
>> >>>>>>> +       struct read_by_uuid_res *result;
>> >>>>>>> +
>> >>>>>>> +       result = new0(struct read_by_uuid_res, 1);
>> >>>>>>> +       if (!result)
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       result->data = malloc(length);
>> >>>>>>> +       if (!result->data) {
>> >>>>>>> +               free(result);
>> >>>>>>> +               return false;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       result->handle = handle;
>> >>>>>>> +       result->length = length;
>> >>>>>>> +       memcpy(result->data, data, length);
>> >>>>>>> +
>> >>>>>>> +       if (op->result_head) {
>> >>>>>>> +               op->result_tail->next = result;
>> >>>>>>> +               op->result_tail = result;
>> >>>>>>> +       } else {
>> >>>>>>> +               op->result_head = op->result_tail = result;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       return true;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +static void destroy_read_by_uuid_result(void *data)
>> >>>>>>> +{
>> >>>>>>> +       struct read_by_uuid_res *result = data;
>> >>>>>>> +
>> >>>>>>> +       free(result->data);
>> >>>>>>> +       free(result);
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +static struct read_by_uuid_op *read_by_uuid_op_ref(struct
>> >>>>>>> read_by_uuid_op *op)
>> >>>>>>> +{
>> >>>>>>> +       __sync_fetch_and_add(&op->ref_count, 1);
>> >>>>>>> +
>> >>>>>>> +       return op;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +static void read_by_uuid_op_unref(void *data)
>> >>>>>>> +{
>> >>>>>>> +       struct read_by_uuid_res *next, *temp;
>> >>>>>>> +       struct read_by_uuid_op *op = data;
>> >>>>>>> +
>> >>>>>>> +       if (__sync_sub_and_fetch(&op->ref_count, 1))
>> >>>>>>> +               return;
>> >>>>>>> +
>> >>>>>>> +       if (op->destroy)
>> >>>>>>> +               op->destroy(op->user_data);
>> >>>>>>> +
>> >>>>>>> +       for (temp = op->result_head; temp; temp = next) {
>> >>>>>>> +               next = temp->next;
>> >>>>>>> +               destroy_read_by_uuid_result(temp);
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       free(op);
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +static void read_by_uuid_cb(uint8_t opcode, const void *pdu,
>> >>>>>>> +                                       uint16_t length, void
>> >>>>>>> *user_data)
>> >>>>>>> +{
>> >>>>>>> +       struct read_by_uuid_op *op = user_data;
>> >>>>>>> +       size_t data_length;
>> >>>>>>> +       uint8_t att_ecode;
>> >>>>>>> +       uint16_t offset, last_handle;
>> >>>>>>> +       const uint8_t *data;
>> >>>>>>> +       bool success;
>> >>>>>>> +
>> >>>>>>> +       if (opcode == BT_ATT_OP_ERROR_RSP) {
>> >>>>>>> +               att_ecode = process_error(pdu, length);
>> >>>>>>> +               if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND)
>> >>>>>>> +                       success = true;
>> >>>>>>> +               else
>> >>>>>>> +                       success = false;
>> >>>>>>> +
>> >>>>>>> +               goto done;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || (!pdu &&
>> >>>>>>> length)) {
>> >>>>>>> +               success = false;
>> >>>>>>> +               att_ecode = 0;
>> >>>>>>> +               goto done;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       data_length = ((const uint8_t *) pdu)[0];
>> >>>>>>> +       if ((length - 1) % data_length) {
>> >>>>>>> +               success = false;
>> >>>>>>> +               att_ecode = 0;
>> >>>>>>> +               goto done;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       for (offset = 1; offset < length; offset += data_length) {
>> >>>>>>> +               data = pdu + offset;
>> >>>>>>> +               if (!append_read_by_uuid_result(op,
>> >>>>>>> get_le16(data),
>> >>>>>>> +                                               data_length - 2,
>> >>>>>>> data + 2)) {
>> >>>>>>> +                       success = false;
>> >>>>>>> +                       att_ecode = 0;
>> >>>>>>> +                       goto done;
>> >>>>>>> +               }
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       last_handle = get_le16(pdu + length - data_length);
>> >>>>>>> +       if (last_handle < op->end_handle) {
>> >>>>>>> +               uint8_t pdu[20];
>> >>>>>>> +
>> >>>>>>> +               put_le16(last_handle + 1, pdu);
>> >>>>>>> +               put_le16(op->end_handle, pdu + 2);
>> >>>>>>> +
>> >>>>>>> +               if (is_bluetooth_uuid(op->uuid)) {
>> >>>>>>> +                       put_le16((op->uuid[2] << 8) + op->uuid[3],
>> >>>>>>> pdu + 4);
>> >>>>>>> +                       /*
>> >>>>>>> +                        * 2 octets - start handle
>> >>>>>>> +                        * 2 octets - end handle
>> >>>>>>> +                        * 2 octets - 16-bit uuid
>> >>>>>>> +                        */
>> >>>>>>> +                       length = 6;
>> >>>>>>> +               } else {
>> >>>>>>> +                       bswap_128(&op->uuid, pdu + 4);
>> >>>>>>> +                       /*
>> >>>>>>> +                        * 2 octets - start handle
>> >>>>>>> +                        * 2 octets - end handle
>> >>>>>>> +                        * 16 octets - 128-bit uuid
>> >>>>>>> +                        */
>> >>>>>>> +                       length = 20;
>> >>>>>>> +               }
>> >>>>>>> +
>> >>>>>>> +               if (!bt_att_send(op->client->att,
>> >>>>>>> BT_ATT_OP_READ_BY_TYPE_REQ,
>> >>>>>>> +                                       pdu, length,
>> >>>>>>> read_by_uuid_cb,
>> >>>>>>> +                                       read_by_uuid_op_ref(op),
>> >>>>>>> +                                       read_by_uuid_op_unref)) {
>> >>>>>>> +                       read_by_uuid_op_unref(op);
>> >>>>>>> +                       success = false;
>> >>>>>>> +                       att_ecode = 0;
>> >>>>>>> +                       goto done;
>> >>>>>>> +               }
>> >>>>>>> +
>> >>>>>>> +               return;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       success = true;
>> >>>>>>> +       att_ecode = 0;
>> >>>>>>> +
>> >>>>>>> +done:
>> >>>>>>> +       if (op->callback)
>> >>>>>>> +               op->callback(success, att_ecode, op->result_head,
>> >>>>>>> +
>> >>>>>>> op->user_data);
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>> +bool bt_gatt_client_read_by_uuid(struct bt_gatt_client *client,
>> >>>>>>> +                               uint16_t start_handle, uint16_t
>> >>>>>>> end_handle,
>> >>>>>>> +                               const uint8_t
>> >>>>>>> uuid[BT_GATT_UUID_SIZE],
>> >>>>>>> +
>> >>>>>>> bt_gatt_client_read_by_uuid_callback_t callback,
>> >>>>>>> +                               void *user_data,
>> >>>>>>> +                               bt_gatt_client_destroy_func_t
>> >>>>>>> destroy)
>> >>>>>>> +{
>> >>>>>>> +       struct read_by_uuid_op *op;
>> >>>>>>> +       uint16_t length;
>> >>>>>>> +       uint8_t pdu[20];
>> >>>>>>> +
>> >>>>>>> +       if (!client)
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       if (start_handle > end_handle || start_handle == 0x0000)
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       op = new0(struct read_by_uuid_op, 1);
>> >>>>>>> +       if (!op)
>> >>>>>>> +               return false;
>> >>>>>>> +
>> >>>>>>> +       op->client = client;
>> >>>>>>> +       op->start_handle = start_handle;
>> >>>>>>> +       op->end_handle = end_handle;
>> >>>>>>> +       op->destroy = destroy;
>> >>>>>>> +       op->callback = callback;
>> >>>>>>> +       op->user_data = user_data;
>> >>>>>>> +       memcpy(&op->uuid, uuid, 16);
>> >>>>>>> +
>> >>>>>>> +       /* Convert to 16-bit if it is Bluetooth UUID */
>> >>>>>>> +       if (is_bluetooth_uuid(uuid)) {
>> >>>>>>> +               put_le16((uuid[2] << 8) + uuid[3], pdu + 4);
>> >>>>>>> +               /*
>> >>>>>>> +                * 2 octets - start handle
>> >>>>>>> +                * 2 octets - end handle
>> >>>>>>> +                * 2 octets - 16-bit uuid
>> >>>>>>> +                */
>> >>>>>>> +               length = 6;
>> >>>>>>> +       } else {
>> >>>>>>> +               bswap_128(uuid, pdu + 4);
>> >>>>>>> +               /*
>> >>>>>>> +                * 2 octets - start handle
>> >>>>>>> +                * 2 octets - end handle
>> >>>>>>> +                * 16 octets - 128-bit uuid
>> >>>>>>> +                */
>> >>>>>>> +               length = 20;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       put_le16(start_handle, pdu);
>> >>>>>>> +       put_le16(end_handle, pdu + 2);
>> >>>>>>> +
>> >>>>>>> +       if (!bt_att_send(client->att, BT_ATT_OP_READ_BY_TYPE_REQ,
>> >>>>>>> pdu,
>> >>>>>>> +                                               length,
>> >>>>>>> read_by_uuid_cb,
>> >>>>>>> +
>> >>>>>>> read_by_uuid_op_ref(op),
>> >>>>>>> +
>> >>>>>>> read_by_uuid_op_unref)) {
>> >>>>>>> +               free(op);
>> >>>>>>> +               return false;
>> >>>>>>> +       }
>> >>>>>>> +
>> >>>>>>> +       return true;
>> >>>>>>> +}
>> >>>>>>> +
>> >>>>>>>  bool bt_gatt_client_write_without_response(struct bt_gatt_client
>> >>>>>>> *client,
>> >>>>>>>                                         uint16_t value_handle,
>> >>>>>>>                                         bool signed_write,
>> >>>>>>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>> >>>>>>> index adccfc5..921ed75 100644
>> >>>>>>> --- a/src/shared/gatt-client.h
>> >>>>>>> +++ b/src/shared/gatt-client.h
>> >>>>>>> @@ -145,6 +145,24 @@ bool bt_gatt_client_read_long_value(struct
>> >>>>>>> bt_gatt_client *client,
>> >>>>>>>                                         void *user_data,
>> >>>>>>>
>> >>>>>>> bt_gatt_client_destroy_func_t destroy);
>> >>>>>>>
>> >>>>>>> +struct read_by_uuid_res;
>> >>>>>>> +
>> >>>>>>> +struct read_by_uuid_res *read_by_uuid_res_next(struct
>> >>>>>>> read_by_uuid_res *result);
>> >>>>>>> +bool read_by_uuid_res_get(struct read_by_uuid_res *result,
>> >>>>>>> uint16_t *handle,
>> >>>>>>> +                                       uint8_t *length, uint8_t
>> >>>>>>> **data);
>> >>>>>>> +
>> >>>>>>> +typedef void (*bt_gatt_client_read_by_uuid_callback_t)(bool
>> >>>>>>> success,
>> >>>>>>> +                                               uint8_t att_ecode,
>> >>>>>>> +                                               struct
>> >>>>>>> read_by_uuid_res *result,
>> >>>>>>> +                                               void *user_data);
>> >>>>>>> +
>> >>>>>>> +bool bt_gatt_client_read_by_uuid(struct bt_gatt_client *client,
>> >>>>>>> +                               uint16_t start_handle, uint16_t
>> >>>>>>> end_handle,
>> >>>>>>> +                               const uint8_t
>> >>>>>>> uuid[BT_GATT_UUID_SIZE],
>> >>>>>>> +
>> >>>>>>> bt_gatt_client_read_by_uuid_callback_t callback,
>> >>>>>>> +                               void *user_data,
>> >>>>>>> +                               bt_gatt_client_destroy_func_t
>> >>>>>>> destroy);
>> >>>>>>
>> >>>>>> Isn't this essentially duplicating
>> >>>>>> bt_gatt_service_iter_next_by_uuid?
>> >>>>>> I mean we should be reading everything already but this doesn't
>> >>>>>> seems
>> >>>>>> to using the cache and in case it is just to fulfill a test perhaps
>> >>>>>> it
>> >>>>>> is better to do it in gatt-helpers so we keep bt_gatt_client API
>> >>>>>> clean.
>> >>>>>
>> >>>>> It is functionality of GATT client described in chapter 4.8.2 "Read
>> >>>>> Using Characteristic UUID".
>> >>>>> Difference is that client can read attributes by passing UUID, and
>> >>>>> results can contain
>> >>>>> different valu lengths. And client interprets results instead of
>> >>>>> gatt-helpers.
>> >>>>> I implemented it here because all read/write operations on
>> >>>>> characteristics and descriptors
>> >>>>> are exposed in bt_gatt_client, and all discovery stuff is
>> >>>>> implemented
>> >>>>> in gatt_helpers. But if
>> >>>>> you don't agree I can change it.
>> >>>>
>> >>>> I see, it does actually end up reading, perhaps it is a good idea to
>> >>>> keep it here then. In the other hand this API seems to be going in
>> >>>> the
>> >>>> same direction that gatt-db had with access by handles, perhaps we
>> >>>> should do an API facelift to access by attribute such as we did with
>> >>>> gatt-db, also the iterator could be replaced with queues which I
>> >>>> guess
>> >>>> is not that different in the end.
>> >>>>
>> >>>
>> >>> The reason we have the iterators and not queues is because Marcel
>> >>> wanted to keep shared/queue as an internal utility of shared code
>> >>> (although shared/gatt-db exposes it to upper layers). In this case
>> >>> performing the read/write operations by handle isn't bad since the
>> >>> code simply constructs the request and sends it out and doesn't need
>> >>> to do an internal lookup for it.
>> >>>
>> >>> I commented on Marcin's new patch set that this code should go to
>> >>> gatt-helpers. I don't think it makes sense to put it in gatt-client,
>> >>> especially since the characteristic and include declaration discovery
>> >>
>> >> Include service discovery can't be based on that API, because it
>> >> performs read_by_type
>> >> and read requests during discovery. It can be shared by characteristic
>> >> discovery only.
>> >> Additionally in characteristic discovery gatt-client  interprets
>> >> results and cancel if length of
>> >> response is not valid. Also, you will be able to use include service
>> >> iterator and characteristic iterators
>> >> to read results of read-by-uuid (because it checks type of response
>> >> and length). I don't see benefit
>> >> having this in one place.
>> >>
>>
>> I guess you're right in that with what I'm proposing we can't do any
>> of the early cancellations in case of malformed PDUs and I guess you
>> have to perform the read requests in between read by type requests for
>> included discovery? Anyway, I'm fine with a standalone API for now
>> then, though I'd like to see us reduce duplicated code where we can.
> Agree,  let's create standalone Api in gatt helpers
>>
>> >
>> > One more thing: I moved it to gatt-helpers, and once I've added public
>> > API to read-by-type,
>> > I had to write iterator to handle results, and next iterator in
>> > gatt-client, to expose results there.
>> > And it would make sense if it will be used somewhere else (I mean
>> > read-by-uuid in gatt-helpers),
>> > but it will be used only in read-by-uuid() in gatt-client. Any thoughts?
>> >
>>
>> Actually what is the use case here?
> I think users of
>
> I can image user who found service and doesnt want to iterate through
> characteristics, just wants read specific characteristic with known uuid. We
> test it in BfA too. But we can keep it in gatt-helpers now, and use it in
> gatt client it needed.
>

Sounds good to me. Let's keep it in gatt-helpers for now then.

>> shared/gatt-client won't really need this API since gatt-client
>> already will have populated its cache of handles and UUIDs, so the
>> users can just iterate through that and send out a single read request
>> to read only one handle. So I'm assuming this is mainly for the unit
>> tests?
>>
>> Anyway, use your best judgement. I think it would be enough here to
>> just have a function in gatt-helpers and none in gatt-client. We would
>> then have a simple PDU iterator in gatt-helpers for getting the
>> handles and values out. If we figure later that this belongs in
>> gatt-client then we can move it over or wrap around it there.
>>
>> >>> procedures are already based on Read By Type and we can create a
>> >>> cleaner API by having this in gatt-helpers and basing the char/incl
>> >>> discovery functions on that instead.
>> >>>
>> >>>>>>
>> >>>>>>>  bool bt_gatt_client_write_without_response(struct bt_gatt_client
>> >>>>>>> *client,
>> >>>>>>>                                         uint16_t value_handle,
>> >>>>>>>                                         bool signed_write,
>> >>>>>>> --
>> >>>>>>> 1.9.3
>> >>>>>>>
>> >>>>>>> --
>> >>>>>>> To unsubscribe from this list: send the line "unsubscribe
>> >>>>>>> linux-bluetooth" in
>> >>>>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> --
>> >>>>>> Luiz Augusto von Dentz
>> >>>>>
>> >>>>> BR
>> >>>>> Marcin
>> >>>>
>> >>>>
>> >>>>
>> >>>> --
>> >>>> Luiz Augusto von Dentz
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe
>> >>>> linux-bluetooth" in
>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>
>> >>> Cheers,
>> >>> Arman
>> >>
>> >> BR
>> >> Marcin
>> >
>> > BR
>> > Marcin
>>
>> Cheers,
>> Arman
> BR
> Marcin

Cheers,
Arman

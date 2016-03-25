Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ=htc4KkmnzznUicBAtFxtXnnRgLMcMknZ6mtSqnvHMQ@mail.gmail.com>
References: <1458306498-28151-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1458306498-28151-7-git-send-email-lukasz.rymanowski@codecoup.pl>
	<CABBYNZJ=htc4KkmnzznUicBAtFxtXnnRgLMcMknZ6mtSqnvHMQ@mail.gmail.com>
Date: Fri, 25 Mar 2016 15:15:27 +0100
Message-ID: <CAExxLLCVsTvBuGf1WKPX=Rarsv7VBLY-AmeVb6eQokajzSs00A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] shared/gatt-server: Add support for long write
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 22 March 2016 at 16:03, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Mar 18, 2016 at 3:08 PM, Łukasz Rymanowski
> <lukasz.rymanowski@codecoup.pl> wrote:
>> With this patch long write and nested long write reliable is supported.
>> GATT server is responsible now to do aggregation of prep write data
>> for long write session.
>> Note: We consider long write as the consequtive prepare writes with
>> continues offsets.
>>
>> E.g. 1
>>
>> prep_write: handle 1, offset 0, value_len 10
>> prep_write: handle 2, offset 0, value_len 10
>> prep_write: handle 1, offset 10, value_len 10
>> prep_write: handle 2, offset 10, value_len 10
>>
>> Will result with following calles to app:
>>
>> exec_write: handle 1: offset 0, value_len 20
>> exec_write: handle 2: offset 0, value_len 20
>
> We should not alter the sequence if the remote is writing in that way
> we should honor it, so the aggregation shall only be done as long as
> the remote don't nest anything in between at that point you should
> stop aggregating and add a new item to the queue.

Fair enough

Perhaps you just
> detect if the prepare was for for the last handle and the offset start
> from the last point then just append otherwise create a new item.
>

Yes, we can peek tail on the prepare queue and check only that one.
Actually with this approach patch 07/09 is most likely not needed.

>>
>> E.g. 2
>>
>> prep_write: handle 1, offset 0, value_len 10
>> prep_write: handle 1, offset 2, value_len 5
>> prep_write: handle 2, offset 0, value_len 10
>> prep_write: handle 2, offset 4, value_len 5
>>
>> Will result with following calles to app:
>>
>> exec_write: handle 1: offset 0, value_len 10
>> exec_write: handle 1: offset 2, value_len 5
>> exec_write: handle 2: offset 0, value_len 10
>> exec_write: handle 2: offset 4, value_len 5
>> ---
>>  src/shared/gatt-server.c | 85 ++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 71 insertions(+), 14 deletions(-)
>>
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>> index c41273a..0904336 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -1088,6 +1088,63 @@ error:
>>         bt_att_send_error_rsp(server->att, opcode, 0, ecode);
>>  }
>>
>> +static bool match_attribute_handle(const void *data, const void *match_data)
>> +{
>> +       const struct prep_write_data *prep_data = data;
>> +
>> +       return prep_data->handle == PTR_TO_UINT(match_data);
>> +}
>> +
>> +static bool create_and_store_prep_data(struct bt_gatt_server *server,
>> +                                               uint16_t handle, uint16_t offset,
>> +                                               uint16_t length, uint8_t *value)
>> +{
>> +       struct prep_write_data *prep_data;
>> +
>> +       prep_data = new0(struct prep_write_data, 1);
>> +       prep_data->length = length;
>> +       if (prep_data->length) {
>> +               prep_data->value = malloc(prep_data->length);
>> +               if (!prep_data->value) {
>> +                       return false;
>> +               }
>> +
>> +               memcpy(prep_data->value, value, prep_data->length);
>> +       }
>> +
>> +       prep_data->server = server;
>> +       prep_data->handle = handle;
>> +       prep_data->offset = offset;
>> +
>> +       queue_push_tail(server->prep_queue, prep_data);
>> +
>> +       return true;
>> +}
>> +
>> +static bool make_aggregation_of_long_write_data(struct bt_gatt_server *server,
>> +                                       struct prep_write_data *prep_data,
>> +                                       uint16_t handle, uint16_t length,
>> +                                       uint8_t *value)
>> +{
>> +       uint8_t *buf;
>> +       uint16_t new_len;
>> +
>> +       new_len = prep_data->length + length;
>> +
>> +       buf = malloc(new_len);
>> +       if (!buf)
>> +               return false;
>> +
>> +       memcpy(buf, prep_data->value, prep_data->length);
>> +       memcpy(buf + prep_data->length, value, length);
>> +
>> +       free(prep_data->value);
>> +       prep_data->value = buf;
>> +       prep_data->length = new_len;
>> +
>> +       return true;
>> +}
>> +
>>  static void prep_write_cb(uint8_t opcode, const void *pdu,
>>                                         uint16_t length, void *user_data)
>>  {
>> @@ -1097,6 +1154,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
>>         uint16_t offset;
>>         struct gatt_db_attribute *attr;
>>         uint8_t ecode;
>> +       bool success;
>>
>>         if (length < 4) {
>>                 ecode = BT_ATT_ERROR_INVALID_PDU;
>> @@ -1126,22 +1184,21 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
>>         if (ecode)
>>                 goto error;
>>
>> -       prep_data = new0(struct prep_write_data, 1);
>> -       prep_data->length = length - 4;
>> -       if (prep_data->length) {
>> -               prep_data->value = malloc(prep_data->length);
>> -               if (!prep_data->value) {
>> -                       ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>> -                       goto error;
>> -               }
>> -       }
>> +       prep_data = queue_find(server->prep_queue, match_attribute_handle,
>> +                                                       UINT_TO_PTR(handle));
>>
>> -       prep_data->server = server;
>> -       prep_data->handle = handle;
>> -       prep_data->offset = offset;
>> -       memcpy(prep_data->value, pdu + 4, prep_data->length);
>> +       if (prep_data && offset == prep_data->length + prep_data->offset)
>> +               success = make_aggregation_of_long_write_data(server, prep_data,
>> +                                                       handle, length - 4,
>> +                                                       &((uint8_t *) pdu)[4]);
>> +       else
>> +               success = create_and_store_prep_data(server, handle, offset,
>> +                                       length - 4, &((uint8_t *) pdu)[4]);
>>
>> -       queue_push_tail(server->prep_queue, prep_data);
>> +       if (!success) {
>> +               ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>> +               goto error;
>> +       }
>>
>>         bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, NULL,
>>                                                                 NULL, NULL);
>> --
>> 2.5.0
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



-- 
BR / Pozdrawiam
Łukasz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAExxLLCckPU50wVK-nREf4wcqP4Gv8i9FAQ3qiQ_Ex9HA=XEsg@mail.gmail.com>
References: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1447708112-12695-4-git-send-email-lukasz.rymanowski@codecoup.pl>
	<CABD6X-LJtw7UxK-zGueB3+2gsN4f4Z6HDsKxwDWK9qbq8c8o4A@mail.gmail.com>
	<CABBYNZLyjzaGGCMV5Xh-cnr5AbGvjgLLxemJAzq=a=PitiSNxg@mail.gmail.com>
	<CAExxLLCckPU50wVK-nREf4wcqP4Gv8i9FAQ3qiQ_Ex9HA=XEsg@mail.gmail.com>
Date: Thu, 19 Nov 2015 01:01:50 +0200
Message-ID: <CABBYNZLh8p5kBebFbOGROjP_V7aJ3gXh1ZEQizZzdN7aoi8BTA@mail.gmail.com>
Subject: Re: [PATCH 3/4] shared/gatt-server: Improve long write session handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Nov 17, 2015 at 11:32 PM, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> Hi Luiz, Marcin,
>
> On Tue, Nov 17, 2015 at 1:49 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Marcin,
>>
>> On Tue, Nov 17, 2015 at 2:12 PM, Marcin Kraglak
>> <marcin.kraglak@tieto.com> wrote:
>>> Hi Lukasz,
>>>
>>> On 16 November 2015 at 22:08, Łukasz Rymanowski
>>> <lukasz.rymanowski@codecoup.pl> wrote:
>>>>
>>>> With current implementation application layer has no idea when
>>>> long write session ends as it gets write callback with execute
>>>> write for each prepare write data.
>>>> With this patch, after data are completly received by gatt-server it
>>>> starts to call write callback in proper order with opcode
>>>> BT_ATT_OP_PREP_WRITE_REQ. After that, each characteristic gets
>>>> BT_ATT_OP_EXEC_WRITE_REQ so it knows that complete characteristic value
>>>> has been received and data can be marked as valid.
>>>> ---
>>>>  src/shared/gatt-server.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----
>>>>  1 file changed, 73 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>>>> index 329f53f..931d619 100644
>>>> --- a/src/shared/gatt-server.c
>>>> +++ b/src/shared/gatt-server.c
>>>> @@ -104,6 +104,8 @@ struct bt_gatt_server {
>>>>         struct queue *prep_queue;
>>>>         unsigned int max_prep_queue_len;
>>>>
>>>> +       struct queue *exec_queue;
>>>> +
>>>>         struct async_read_op *pending_read_op;
>>>>         struct async_write_op *pending_write_op;
>>>>
>>>> @@ -137,6 +139,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
>>>>                 server->pending_write_op->server = NULL;
>>>>
>>>>         queue_destroy(server->prep_queue, prep_write_data_destroy);
>>>> +       queue_destroy(server->exec_queue, NULL);
>>>>
>>>>         gatt_db_unref(server->db);
>>>>         bt_att_unref(server->att);
>>>> @@ -1155,10 +1158,61 @@ error:
>>>>
>>>>  }
>>>>
>>>> +static void exec_next_write(struct bt_gatt_server *server);
>>>> +
>>>> +static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>>>> +                                                               void *user_data)
>>>> +{
>>>> +       struct bt_gatt_server *server = user_data;
>>>> +       uint16_t handle = gatt_db_attribute_get_handle(attr);
>>>> +
>>>> +       if (err) {
>>>> +               queue_remove_all(server->exec_queue, NULL, NULL, NULL);
>>>> +               bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
>>>> +                                                               handle, err);
>>>> +       }
>>>> +
>>>> +       exec_next_write(server);
>>>> +}
>>>> +
>>>> +static void exec_next_write(struct bt_gatt_server *server)
>>>> +{
>>>> +       uint16_t *handle;
>>>> +       struct gatt_db_attribute *attr;
>>>> +       bool status;
>>>> +       int err;
>>>> +
>>>> +       handle = queue_pop_head(server->exec_queue);
>>>> +       if (!handle) {
>>>> +               bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
>>>> +                                                       NULL, NULL, NULL);
>>>> +       }
>>>> +
>>>> +       attr = gatt_db_get_attribute(server->db, PTR_TO_UINT(handle));
>>>> +       if (!attr) {
>>>> +               err = BT_ATT_ERROR_UNLIKELY;
>>>> +               goto error;
>>>> +       }
>>>> +
>>>> +       status = gatt_db_attribute_write(attr, 0, NULL , 0,
>>>> +                                               BT_ATT_OP_EXEC_WRITE_REQ,
>>>> +                                               server->att,
>>>> +                                               exec_write_complete_cb, server);
>>>> +       if (status)
>>>> +               return;
>>>> +
>>>> +       err = BT_ATT_ERROR_UNLIKELY;
>>>> +
>>>> +error:
>>>> +       queue_remove_all(server->exec_queue, NULL, NULL, NULL);
>>>> +       bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
>>>> +                                               PTR_TO_UINT(handle), err);
>>>> +}
>>>> +
>>>>  static void exec_next_prep_write(struct bt_gatt_server *server,
>>>>                                                 uint16_t ehandle, int err);
>>>>
>>>> -static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>>>> +static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
>>>>                                                                 void *user_data)
>>>>  {
>>>>         struct bt_gatt_server *server = user_data;
>>>> @@ -1167,6 +1221,11 @@ static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
>>>>         exec_next_prep_write(server, handle, err);
>>>>  }
>>>>
>>>> +static bool match_attribute_handle(const void *data, const void *match_data)
>>>> +{
>>>> +       return PTR_TO_UINT(data) == PTR_TO_UINT(match_data);
>>>> +}
>>>> +
>>>>  static void exec_next_prep_write(struct bt_gatt_server *server,
>>>>                                                 uint16_t ehandle, int err)
>>>>  {
>>>> @@ -1177,10 +1236,17 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>>>>         if (err)
>>> Shouldn't you remove all elements of server->exec_queue here? Looking
>>> at the next patch, all attributes in exec_queue shall be notified that
>>> exec write is canceled too.
>>> And just open question: with introducing two types of write requests
>>> in reliable write procedure: BT_ATT_OP_EXEC_WRITE_REQ and
>>> BT_ATT_OP_PREP_WRITE_REQ, we could avoid using two queues and pass
>>> prepare writes immediatelly to specific service implementation instead
>>> of storing all values in prepare writes in server.
>>
>> Even if we have some flush logic trigger by execute we cannot really
>> dispatch writes immediately to the services because it can fail with
>> some errors that are not allowed by the testing spec, yes there is a
>> specific test checking the e.g. invalid offset is only receive as a
>> response to execute. It looks like this is because the value could be
>> changed in between prepare and execute, which IMO is something
>> horribly broken with prepare + execute since it is intended for
>> reliable writes but it can produce all sort of errors which is
>> impossible to guess without reading the value written after it has
>> been executed in case anything has change in between the commands.
>>
>
> I see Marcins point and agree. According to spec if handle is valid,
> permisions are ok and there
> is enought place in the queue, Prepare Write Response shall be sent
> back. No matter if application
> likes data or not. Error on value validation we will get during
> execute writes. So in teory we could indeed
> avoid prep_queue and send data directly to application when handle is
> ok and permisions are fine.

I thought the data reaching the application would mean it shall now
apply, but perhaps Android interface does not care what the
application will do with it, anyway this is something I would not like
to have in D-Bus since we don't expose prepare + execute write there.

> Actually this is how we do it now in Android part.
> But on the other side, that is not big deal, so if you Luiz saw any
> issues with that, we can stay with server
> handling queuing prep writes.

Im afraid Android got this wrong, if do dispatch to the application it
means they have to be queued there so you no longer can guarantee the
sequence of execute e.g.

prep handle1 -> app1
prep handle2 -> app2
prep handle2 -> app2
prep handle1 -> app1

exec -> app1, app2, app1 ? (opps, it already execute the first and the
second write)

It is no doubt a completely bogus scenario, but still I think it is
better be safe than sorry if some profile turns out to depend in a
strict sequence.

>>>>         next = queue_pop_head(server->prep_queue);
>>>>         if (!next) {
>>>> -               bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
>>>> -                                                       NULL, NULL, NULL);
>>>> +               exec_next_write(server);
>>>>                 return;
>>>>         }
>>>>
>>>> @@ -1192,9 +1258,9 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
>>>>
>>>>         status = gatt_db_attribute_write(attr, next->offset,
>>>>                                                 next->value, next->length,
>>>> -                                               BT_ATT_OP_EXEC_WRITE_REQ,
>>>> +                                               BT_ATT_OP_PREP_WRITE_REQ,
>>>>                                                 server->att,
>>>> -                                               exec_write_complete_cb, server);
>>>> +                                               prep_write_complete_cb, server);
>>>>
>>>>         prep_write_data_destroy(next);
>>>>
>>>> @@ -1396,6 +1462,8 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
>>>>         server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
>>>>         server->prep_queue = queue_new();
>>>>
>>>> +       server->exec_queue = queue_new();
>>>> +
>>>>         if (!gatt_server_register_att_handlers(server)) {
>>>>                 bt_gatt_server_free(server);
>>>>                 return NULL;
>>>> --
>>>> 2.5.0
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>> --
>>> BR
>>> Marcin Kraglak
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> BR / Pozdrawiam
> Łukasz



-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Dec 2014 22:55:59 +0100
Message-ID: <CAN_7+YaDAmt=LHy4Pj7KP--0-=ZYugBEiSdu7eTXmiJTNpo6hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] attrib/gattrib: Add track for internal request id
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 17, 2014 at 4:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> If user provides req_id to the g_attrib_send, he assume that req_id
>> should be used for transaction.
>> With this patch, gattrib  keeps track on user requested req_id and
>> actual pending req_id which allow to e.g. cancel correct transaction
>> when user request it.
>> ---
>> attrib/gattrib.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
>> index ab43f84..c75866b 100644
>> --- a/attrib/gattrib.c
>> +++ b/attrib/gattrib.c
>> @@ -51,10 +51,12 @@ struct _GAttrib {
>>       struct queue *callbacks;
>>       uint8_t *buf;
>>       int buflen;
>> +     struct queue *track_ids;
>> };
>>
>>
>> struct attrib_callbacks {
>> +     unsigned int id;
>>       GAttribResultFunc result_func;
>>       GAttribNotifyFunc notify_func;
>>       GDestroyNotify destroy_func;
>> @@ -63,6 +65,60 @@ struct attrib_callbacks {
>>       uint16_t notify_handle;
>> };
>>
>> +struct id_pair {
>> +     unsigned int org_id;
>> +     unsigned int pend_id;
>> +};
>> +
>> +
>> +static bool find_with_pend_id(const void *data, const void *user_data)
>> +{
>> +     const struct id_pair *p = data;
>> +     unsigned int pending = PTR_TO_INT(user_data);
>
> PTR_TO_UINT.
>
>> +
>> +     return (p->pend_id == pending);
>> +}
>> +
>> +static bool find_with_org_id(const void *data, const void *user_data)
>> +{
>> +     const struct id_pair *p = data;
>> +     unsigned int orig_id = PTR_TO_INT(user_data);
>
> PTR_TO_UINT.
>
>> +
>> +     return (p->org_id == orig_id);
>> +}
>> +
>> +static void remove_stored_ids(GAttrib *attrib, unsigned int pending_id)
>> +{
>> +     struct id_pair *p;
>> +
>> +     p = queue_remove_if(attrib->track_ids, find_with_pend_id,
>> +                                             INT_TO_PTR(pending_id));
>
> UINT_TO_PTR.
>
>> +
>> +     free(p);
>> +}
>> +
>> +static void store_id(GAttrib *attrib, unsigned int org_id,
>> +                                                     unsigned int pend_id)
>> +{
>> +     struct id_pair *t;
>> +
>> +     t = queue_find(attrib->track_ids, find_with_org_id, INT_TO_PTR(org_id));
>
> UINT_TO_PTR.
>
>> +     if (t) {
>> +             t->pend_id = pend_id;
>> +             return;
>> +     }
>> +
>> +     t = new0(struct id_pair, 1);
>> +     if (!t)
>> +             return;
>> +
>> +     t->org_id = org_id;
>> +     t->pend_id = pend_id;
>> +
>> +     if (!queue_push_tail(attrib->track_ids, t))
>> +             free(t);
>> +}
>> +
>> GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
>> {
>>       gint fd;
>> @@ -95,6 +151,10 @@ GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
>>       if (!attr->callbacks)
>>               goto fail;
>>
>> +     attr->track_ids = queue_new();
>> +     if (!attr->track_ids)
>> +             goto fail;
>> +
>>       return g_attrib_ref(attr);
>>
>> fail:
>> @@ -153,6 +213,7 @@ void g_attrib_unref(GAttrib *attrib)
>>       bt_att_unref(attrib->att);
>>
>>       queue_destroy(attrib->callbacks, attrib_callbacks_destroy);
>> +     queue_destroy(attrib->track_ids, free);
>>
>>       free(attrib->buf);
>>
>> @@ -229,6 +290,8 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
>>       if (cb->result_func)
>>               cb->result_func(status, buf, length + 1, cb->user_data);
>>
>> +     remove_stored_ids(cb->parent, cb->id);
>> +
>>       free(buf);
>> }
>>
>> @@ -282,18 +345,49 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
>>               queue_push_head(attrib->callbacks, cb);
>>               response_cb = attrib_callback_result;
>>               destroy_cb = attrib_callbacks_remove;
>> +
>>       }
>>
>> -     return bt_att_send(attrib->att, pdu[0], (void *)pdu + 1, len - 1,
>> +     cb->id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1, len - 1,
>>                                               response_cb, cb, destroy_cb);
>> +
>> +     if (id == 0)
>> +             return cb->id;
>> +
>> +     /*
>> +      * If user what us to use given id, lets keep track on that so we give
>> +      * user a possibility to cancel ongoing request
>> +      */
>> +     store_id(attrib, id, cb->id);
>> +     return id;
>> +}
>> +
>> +static unsigned int get_id(GAttrib *attrib, guint id)
>> +{
>> +     struct id_pair *p;
>> +     unsigned int result = id;
>> +
>> +     p = queue_remove_if(attrib->track_ids, find_with_org_id,
>> +                                                     INT_TO_PTR(id));
>
> UINT_TO_PTR.
>
>> +     if (!p)
>> +             return id;
>> +
>> +     result = p->pend_id;
>> +     free(p);
>> +
>> +     return result;
>> }
>>
>> gboolean g_attrib_cancel(GAttrib *attrib, guint id)
>> {
>> +     unsigned int pend_id;
>> +
>>       if (!attrib)
>>               return FALSE;
>>
>> -     return bt_att_cancel(attrib->att, id);
>> +     pend_id = get_id(attrib, id);
>
> If you only have a single her for get_id, why not just include it in g_attrib_cancel. It is not that the wrap is by any means complex.

Ok,

>
> Actually the get_id code is broken since it returns id and not error out if it is not found. Meaning you will try to cancel something else. And that might be a valid id from some user bt_att user.

One thing is that bt_att can be shared, second thing is that gattrib
in our case is shared. In this patch we solve only the issue of having
shared gattrib.
Idea is that it is gattrib user responsible for tracking its requests
id's and on profile disconnect cancel only the ones he holds. GAttrib
just needs to make sure that request id, which is given to user, is
valid during whole gattrib operation. Even if GAttrib does some
internal additional ATT request. Note that internal request comes form
helper attrib/gatt.c. Check second patch for more details.

When it comes to get_id(),  the only problem here is if e.g. there is
user calling g_attrib_send(id = 1) and in the same time some other
user don't care about id but gets id = 1. So when user cancel request
id = 1  we always cancel request for first user. I will put comment in
the code about this issue.
However, please note that request_id different than 0 is used only in
attrib/gatt.c and in the way that above is not possible.

Also, this fix is temporary as we are working on removing gattrib from
Android GATT/HOG, but it will just take longer then expected,
therefore we need this fix for smooth HOG operations on Android.

>
>> +
>> +     return bt_att_cancel(attrib->att, pend_id);
>> }
>>
>> gboolean g_attrib_cancel_all(GAttrib *attrib)
>> @@ -301,6 +395,8 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
>>       if (!attrib)
>>               return FALSE;
>>
>> +     queue_remove_all(attrib->track_ids, NULL, NULL, free);
>> +
>>       return bt_att_cancel_all(attrib->att);
>
> And I think you need to replace this bt_att_cancel_all with just canceling the ids in the queue. Since otherwise you have the same problem as before. It could be just luck that g_attrib_cancel_all has only been used in cases where it does not matter.

As wrote above, for now we track id;s only in case g_attrib_send( id
!=0 ). Actually I can easily extend it and keep all the ids. It would
look like this:

a) in case of g_attrib_send (id == 0) we keep pair (pend_id, pend_id)
b) in case of g_attrib_send (id != 0) we keep pair ( id, pend_id)

Then in g_attrib_cancel_all(), for each pair we do
bt_att_cancel(pend_id).  Anyway, still he might hit issue I described
above for get_id()

Should I go this way?

\Lukasz

>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

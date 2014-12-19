Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAseuJLW6xzE6nycnH7wOC9e1JfVd-TZ18OmwkgAbLrqZg@mail.gmail.com>
References: <1418910367-19792-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418910367-19792-4-git-send-email-lukasz.rymanowski@tieto.com>
	<CAJLTA8gL8jSRtaLkaiJBQK5kvtWBAA9eNJGUDotfE6qoh8JsXA@mail.gmail.com>
	<CAMudyAseuJLW6xzE6nycnH7wOC9e1JfVd-TZ18OmwkgAbLrqZg@mail.gmail.com>
Date: Thu, 18 Dec 2014 22:09:32 -0200
Message-ID: <CABBYNZLwM3Qz+=KzK6R4Hs4A6d=LGA4mhe6XhaG-8h6j6LaC_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] attrib/gattrib: Add tracking all the internal
 request id
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: Michael Janssen <jamuraa@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz, Michael,

On Thu, Dec 18, 2014 at 2:11 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Michael,
>
> On 18 December 2014 at 16:55, Michael Janssen <jamuraa@google.com> wrote:
>> Hi Lukasz:
>>
>> On Thu, Dec 18, 2014 at 5:46 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> With this patch gattrib track all the pending request id's to bt_att.
>>> When doing g_attrib_cancel_all, only those own by gattrib will be
>>> canceled.
>>> ---
>>>  attrib/gattrib.c | 95 ++++++++++++++++++++++++--------------------------------
>>>  1 file changed, 41 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
>>> index f986a77..5709d84 100644
>>> --- a/attrib/gattrib.c
>>> +++ b/attrib/gattrib.c
>>> @@ -54,9 +54,13 @@ struct _GAttrib {
>>>         struct queue *track_ids;
>>>  };
>>>
>>> +struct id_pair {
>>> +       unsigned int org_id;
>>> +       unsigned int pend_id;
>>> +};
>>>
>>>  struct attrib_callbacks {
>>> -       unsigned int id;
>>> +       struct id_pair *id;
>>>         GAttribResultFunc result_func;
>>>         GAttribNotifyFunc notify_func;
>>>         GDestroyNotify destroy_func;
>>> @@ -65,20 +69,6 @@ struct attrib_callbacks {
>>>         uint16_t notify_handle;
>>>  };
>>>
>>> -struct id_pair {
>>> -       unsigned int org_id;
>>> -       unsigned int pend_id;
>>> -};
>>> -
>>> -
>>> -static bool find_with_pend_id(const void *data, const void *user_data)
>>> -{
>>> -       const struct id_pair *p = data;
>>> -       unsigned int pending = PTR_TO_UINT(user_data);
>>> -
>>> -       return (p->pend_id == pending);
>>> -}
>>> -
>>>  static bool find_with_org_id(const void *data, const void *user_data)
>>>  {
>>>         const struct id_pair *p = data;
>>> @@ -87,37 +77,22 @@ static bool find_with_org_id(const void *data, const void *user_data)
>>>         return (p->org_id == orig_id);
>>>  }
>>>
>>> -static void remove_stored_ids(GAttrib *attrib, unsigned int pending_id)
>>> -{
>>> -       struct id_pair *p;
>>> -
>>> -       p = queue_remove_if(attrib->track_ids, find_with_pend_id,
>>> -                                               UINT_TO_PTR(pending_id));
>>> -
>>> -       free(p);
>>> -}
>>> -
>>> -static void store_id(GAttrib *attrib, unsigned int org_id,
>>> +static struct id_pair *store_id(GAttrib *attrib, unsigned int org_id,
>>>                                                         unsigned int pend_id)
>>>  {
>>>         struct id_pair *t;
>>>
>>> -       t = queue_find(attrib->track_ids, find_with_org_id,
>>> -                                                       UINT_TO_PTR(org_id));
>>> -       if (t) {
>>> -               t->pend_id = pend_id;
>>> -               return;
>>> -       }
>>> -
>>>         t = new0(struct id_pair, 1);
>>>         if (!t)
>>> -               return;
>>> +               return NULL;
>>>
>>>         t->org_id = org_id;
>>>         t->pend_id = pend_id;
>>>
>>> -       if (!queue_push_tail(attrib->track_ids, t))
>>> -               free(t);
>>> +       if (queue_push_tail(attrib->track_ids, t))
>>> +               return t;
>>> +
>>> +       return NULL;
>>>  }
>>>
>>>  GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
>>> @@ -185,6 +160,9 @@ static void attrib_callbacks_destroy(void *data)
>>>         if (cb->destroy_func)
>>>                 cb->destroy_func(cb->user_data);
>>>
>>> +       if (queue_remove(cb->parent->track_ids, cb->id))
>>> +               free(cb->id);
>>> +
>>>         free(data);
>>>  }
>>>
>>> @@ -291,8 +269,6 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
>>>         if (cb->result_func)
>>>                 cb->result_func(status, buf, length + 1, cb->user_data);
>>>
>>> -       remove_stored_ids(cb->parent, cb->id);
>>> -
>>>         free(buf);
>>>  }
>>>
>>> @@ -328,6 +304,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
>>>         struct attrib_callbacks *cb = NULL;
>>>         bt_att_response_func_t response_cb = NULL;
>>>         bt_att_destroy_func_t destroy_cb = NULL;
>>> +       unsigned int pend_id;
>>>
>>>         if (!attrib)
>>>                 return 0;
>>> @@ -349,32 +326,36 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
>>>
>>>         }
>>>
>>> -       cb->id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1, len - 1,
>>> +       pend_id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1, len - 1,
>>>                                                 response_cb, cb, destroy_cb);
>>>
>>> -       if (id == 0)
>>> -               return cb->id;
>>> +       /*
>>> +        * We store here pair as it is easier to handle it in response and in
>>> +        * case where user request us to use specific id request - see below.
>>> +        */
>>> +       if (id == 0) {
>>> +               cb->id = store_id(attrib, pend_id, pend_id);
>>> +               return pend_id;
>>> +       }
>>>
>>>         /*
>>>          * If user what us to use given id, lets keep track on that so we give
>>>          * user a possibility to cancel ongoing request.
>>>          */
>>> -       store_id(attrib, id, cb->id);
>>> +       cb->id = store_id(attrib, id, pend_id);
>>>         return id;
>>>  }
>>>
>>>  gboolean g_attrib_cancel(GAttrib *attrib, guint id)
>>>  {
>>>         struct id_pair *p;
>>> -       unsigned int pend_id;
>>>
>>>         if (!attrib)
>>>                 return FALSE;
>>>
>>>         /*
>>> -        * Let's try to find actual pending request id on the tracking id queue.
>>> -        * If there is no such it means it is not tracked id and we can cancel
>>> -        * it.
>>> +        * If request belongs to gattrib and is not yet done it has to be on
>>> +        * the tracking id queue
>>>          *
>>>          * FIXME: It can happen that on the queue there is id_pair with
>>>          * given id which was provided by the user. In the same time it might
>>> @@ -386,14 +367,18 @@ gboolean g_attrib_cancel(GAttrib *attrib, guint id)
>>>          */
>>>         p = queue_remove_if(attrib->track_ids, find_with_org_id,
>>>                                                         UINT_TO_PTR(id));
>>> -       if (p) {
>>> -               pend_id = p->pend_id;
>>> -               free(p);
>>> -       } else {
>>> -               pend_id = id;
>>> -       }
>>> +       if (!p)
>>> +               return FALSE;
>>>
>>> -       return bt_att_cancel(attrib->att, pend_id);
>>> +       return bt_att_cancel(attrib->att, p->pend_id);
>>> +}
>>> +
>>> +static void cancel_request(void *data, void *user_data)
>>> +{
>>> +       struct id_pair *p = data;
>>> +       GAttrib *attrib = user_data;
>>> +
>>> +       bt_att_cancel(attrib->att, p->pend_id);
>>>  }
>>>
>>>  gboolean g_attrib_cancel_all(GAttrib *attrib)
>>> @@ -401,9 +386,11 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
>>>         if (!attrib)
>>>                 return FALSE;
>>>
>>> +       /* Cancel only request which belongs to gattrib */
>>> +       queue_foreach(attrib->track_ids, cancel_request, attrib);
>>>         queue_remove_all(attrib->track_ids, NULL, NULL, free);
>>>
>>> -       return bt_att_cancel_all(attrib->att);
>>> +       return TRUE;
>>>  }
>>>
>>>  guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
>>> --
>>> 1.8.4
>>
>> I think you can eliminate a lot of memory management, the additional
>> queue and more by putting the pend_id and org_id both into
>> attrib_callbacks and then keeping all the pending requests, regardless
>> of whether they have a callback function, in the attrib->callbacks
>> queue.
>
> Yes, maybe I would, but in this shape it is more clear and I would
> stick to it if you agree.
> Especially when user call g_attrib_cancel or cancel all it makes more
> sens to look into id_tracks than callbacks->xx

Yep, lets start with this since it is a temporary fix I don't think we
should stay too long on this, Im currently fixing a couple of things
since this breaks make check and will push this in a moment.


-- 
Luiz Augusto von Dentz

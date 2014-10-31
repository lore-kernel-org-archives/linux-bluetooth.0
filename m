Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YbwZb9R1cMLr1-O4wn6yCvU0NxQg5DcPzS1MKWmVZ3unw@mail.gmail.com>
References: <1414758140-28892-1-git-send-email-luiz.dentz@gmail.com>
	<CAN_7+YbwZb9R1cMLr1-O4wn6yCvU0NxQg5DcPzS1MKWmVZ3unw@mail.gmail.com>
Date: Fri, 31 Oct 2014 15:20:00 +0200
Message-ID: <CABBYNZJxu7vszL-3G_rABZZEa3N=UH8sXFTKMm2Y35tqDDC2bg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/att: Simplify bt_att_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Oct 31, 2014 at 2:43 PM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Oct 31, 2014 at 1:22 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This split bt_att_unref into bt_att_free so it can be used within
>> bt_att_new when freeing the data.
>> ---
>>  src/shared/att.c | 68 +++++++++++++++++++++++---------------------------------
>>  1 file changed, 28 insertions(+), 40 deletions(-)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 6adde22..97f2541 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -743,6 +743,32 @@ static bool can_read_data(struct io *io, void *user_data)
>>         return true;
>>  }
>>
>> +static void bt_att_free(struct bt_att *att)
>> +{
>> +
>
> I think that  bt_ prefix we use only for api functions. For static
> function free_att or att_free is enought.

Yes but usually when it is a counterpart function I usually keep the
prefix for convenience in case it is made public later.

>>      if (att->pending_req)
>> +               destroy_att_send_op(att->pending_req);
>> +
>> +       if (att->pending_ind)
>> +               destroy_att_send_op(att->pending_ind);
>> +
>> +       io_destroy(att->io);
>> +
>> +       queue_destroy(att->req_queue, destroy_att_send_op);
>> +       queue_destroy(att->ind_queue, destroy_att_send_op);
>> +       queue_destroy(att->write_queue, destroy_att_send_op);
>> +       queue_destroy(att->notify_list, destroy_att_notify);
>> +       queue_destroy(att->disconn_list, destroy_att_disconn);
>> +
>> +       if (att->timeout_destroy)
>> +               att->timeout_destroy(att->timeout_data);
>> +
>> +       if (att->debug_destroy)
>> +               att->debug_destroy(att->debug_data);
>> +
>> +       free(att->buf);
>> +       free(att);
>> +}
>> +
>>  struct bt_att *bt_att_new(int fd)
>>  {
>>         struct bt_att *att;
>> @@ -794,14 +820,7 @@ struct bt_att *bt_att_new(int fd)
>>         return bt_att_ref(att);
>>
>>  fail:
>> -       queue_destroy(att->req_queue, NULL);
>> -       queue_destroy(att->ind_queue, NULL);
>> -       queue_destroy(att->write_queue, NULL);
>> -       queue_destroy(att->notify_list, NULL);
>> -       queue_destroy(att->disconn_list, NULL);
>> -       io_destroy(att->io);
>> -       free(att->buf);
>> -       free(att);
>> +       bt_att_free(att);
>>
>>         return NULL;
>>  }
>> @@ -824,38 +843,7 @@ void bt_att_unref(struct bt_att *att)
>>         if (__sync_sub_and_fetch(&att->ref_count, 1))
>>                 return;
>>
>> -       bt_att_unregister_all(att);
>> -       bt_att_cancel_all(att);
>> -
>> -       if (att->pending_req)
>> -               destroy_att_send_op(att->pending_req);
>> -
>> -       if (att->pending_ind)
>> -               destroy_att_send_op(att->pending_ind);
>> -
>> -       io_destroy(att->io);
>> -       att->io = NULL;
>> -
>> -       queue_destroy(att->req_queue, NULL);
>> -       queue_destroy(att->ind_queue, NULL);
>> -       queue_destroy(att->write_queue, NULL);
>> -       queue_destroy(att->notify_list, NULL);
>> -       queue_destroy(att->disconn_list, NULL);
>> -       att->req_queue = NULL;
>> -       att->ind_queue = NULL;
>> -       att->write_queue = NULL;
>> -       att->notify_list = NULL;
>> -
>> -       if (att->timeout_destroy)
>> -               att->timeout_destroy(att->timeout_data);
>> -
>> -       if (att->debug_destroy)
>> -               att->debug_destroy(att->debug_data);
>> -
>> -       free(att->buf);
>> -       att->buf = NULL;
>> -
>> -       free(att);
>> +       bt_att_free(att);
>>  }
>>
>>  bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
>> --
>> 1.9.3
>
>
> BR
> Lukasz
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

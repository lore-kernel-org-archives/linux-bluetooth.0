Return-Path: <cyrus@holtmann.org>
Message-id: <D2678C10D11A4905B04F48DD0DE37088@sisodomain.com>
From: Divya Yadav <divya.yadav@samsung.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1325756632-29335-1-git-send-email-divya.yadav@samsung.com>
 <CA+i+Aw1wpoPZxAHZeGEz3HZ0EPSqexLOkCYbPAx_-2WD_=8OXw@mail.gmail.com>
In-reply-to: <CA+i+Aw1wpoPZxAHZeGEz3HZ0EPSqexLOkCYbPAx_-2WD_=8OXw@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Add UpdateInbox Function
Date: Thu, 05 Jan 2012 17:10:54 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

--------------------------------------------------
From: "Slawomir Bochenski" <lkslawek@gmail.com>
Sent: Thursday, January 05, 2012 4:45 PM
To: "Divya Yadav" <divya.yadav@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] MAP: Add UpdateInbox Function

> Hi!
>
> On Thu, Jan 5, 2012 at 10:43 AM, Divya Yadav <divya.yadav@samsung.com> 
> wrote:
>> UpdateInbox function allows remote device to initiate an update of
>> the server's inbox, i.e. the Map server shall contact the network
>
> Maybe better to call it "MSE inbox".
>
>> to retrieve new messages if available. If the server does not allow
>> the network update it shall answer with a 'Not implemented'
>> error response.
>
> More like "does not support" than "does not allow".
>
>> ---
>>  plugins/mas.c              |   32 +++++++++++++++++++++++++++++++-
>>  plugins/messages-dummy.c   |    7 +++++++
>>  plugins/messages-tracker.c |   10 +++++++++-
>>  plugins/messages.h         |   14 ++++++++++++++
>>  4 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/plugins/mas.c b/plugins/mas.c
>> index 3c3104c..639d0b6 100644
>> --- a/plugins/mas.c
>> +++ b/plugins/mas.c
>> @@ -503,6 +503,36 @@ static void *message_open(const char *name, int 
>> oflag, mode_t mode,
>>                return mas;
>>  }
>>
>> +static void inbox_update_cb(void *session, int err, void *user_data)
>
> Callbacks added previously are all following each other, before the
> section with *_open functions, so I'd rather move this one up. Also
> I'd rather call it update_inbox_cb(), to be consistent with the
> typedef.
>
>> +{
>> +       struct mas_session *mas = user_data;
>> +
>> +       DBG("");
>> +
>> +       mas->finished = TRUE;
>> +
>> +       if (err < 0)
>> +               obex_object_set_io_flags(mas, G_IO_ERR, err);
>> +       else
>> +               obex_object_set_io_flags(mas, G_IO_OUT, 0);
>> +}
>> +
>> +static void *message_update_open(const char *name, int oflag, mode_t 
>> mode,
>> +                               void *driver_data, size_t *size, int 
>> *err)
>> +{
>> +       struct mas_session *mas = driver_data;
>> +
>> +       DBG("");
>> +
>> +       *err = messages_update_inbox(mas->backend_data, inbox_update_cb, 
>> mas);
>> +
>> +       if (*err < 0) {
>> +               mas->finished = TRUE;
>
> No need for this. If open returns NULL, no read/write is going to be 
> called.
>
>> +               return NULL;
>> +       } else
>> +               return mas;
>> +}
>
> This function is missing check for oflag value - this MIME type should
> return error on GET.
>
>> +
>>  static void *any_open(const char *name, int oflag, mode_t mode,
>>                                void *driver_data, size_t *size, int *err)
>>  {
>> @@ -628,7 +658,7 @@ static struct obex_mime_type_driver 
>> mime_message_update = {
>>        .target = MAS_TARGET,
>>        .target_size = TARGET_SIZE,
>>        .mimetype = "x-bt/MAP-messageUpdate",
>> -       .open = any_open,
>> +       .open = message_update_open,
>>        .close = any_close,
>>        .read = any_read,
>>        .write = any_write,
>> diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
>> index e96b13b..58f04f6 100644
>> --- a/plugins/messages-dummy.c
>> +++ b/plugins/messages-dummy.c
>> @@ -173,3 +173,10 @@ int messages_get_message(void *session,
>>  void messages_abort(void *session)
>>  {
>>  }
>> +
>> +int messages_update_inbox(void *session,
>> +               messages_update_inbox_cb callback,
>> +               void *user_data)
>> +{
>> +       return -EINVAL;
>> +}
>
> Put this before messages_abort().
>
>> diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
>> index 8f9b30a..6a68b5b 100644
>> --- a/plugins/messages-tracker.c
>> +++ b/plugins/messages-tracker.c
>> @@ -237,7 +237,8 @@ int messages_set_folder(void *s, const char *name, 
>> gboolean cdup)
>>        return 0;
>>  }
>>
>> -static gboolean async_get_folder_listing(void *s) {
>> +static gboolean async_get_folder_listing(void *s)
>> +{
>
> This belongs into a separate patch.
>
>>        struct session *session = s;
>>        gboolean count = FALSE;
>>        int folder_count = 0;
>> @@ -324,3 +325,10 @@ int messages_get_message(void *session,
>>  void messages_abort(void *session)
>>  {
>>  }
>> +
>> +int messages_update_inbox(void *session,
>> +               messages_update_inbox_cb callback,
>> +               void *user_data)
>> +{
>> +       return -EINVAL;
>> +}
>
> Same as for messages-dummy.c.
>
>> diff --git a/plugins/messages.h b/plugins/messages.h
>> index 6982edd..ea231a3 100644
>> --- a/plugins/messages.h
>> +++ b/plugins/messages.h
>> @@ -273,3 +273,17 @@ int messages_get_message(void *session,
>>  * session: Backend session.
>>  */
>>  void messages_abort(void *session);
>> +
>> +/*  Informs Message Server to Update Inbox via network
>
> One space after asterisk, dot at the end.
>
>> + *
>> + * session: Backend session.
>> + * user_data: User data if any to be sent
>
> Missing new line. Also missing dot at the end of second line.
>
>> + * Callback shall be called for every update inbox request, where if any 
>> error
>> + * should be reported to the remote end.
>
> "shall be called once" maybe. Second part not very understandable. I
> also guess you mean error during initiating inbox update, because the
> update procedure itself should take place after UpdateInbox MAP
> request returns.
>
>> + */
>> +typedef void (*messages_update_inbox_cb)(void *session, int err,
>> +               void *user_data);
>> +
>> +int messages_update_inbox(void *session,
>> +               messages_update_inbox_cb callback,
>> +               void *user_data);
>
> This I'd also like to be moved before messages_abort().
>
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> -- 
> Slawomir Bochenski

Thanks for your valuable comments. I will correct it and send it as multiple 
patches.

Divya
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 


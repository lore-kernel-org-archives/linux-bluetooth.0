Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <222dcd39-0ee0-2467-bb41-90d66e9a7715@jp.fujitsu.com>
References: <1499252831-29074-1-git-send-email-nsathish41@gmail.com> <222dcd39-0ee0-2467-bb41-90d66e9a7715@jp.fujitsu.com>
From: Sathish Narasimman <nsathish41@gmail.com>
Date: Thu, 6 Jul 2017 12:43:20 +0530
Message-ID: <CAOVXEJLp6qDJmknCW6PWk1rfgHz2NAXz=HVDMYmaPXeh6FqCXQ@mail.gmail.com>
Subject: Re: [PATCH] obexd/map: msg dummy implement MSE message viewing
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, Eramoto, Will update the patch.

--
Sathish
Thanks & Regards,
Sathish N


On Thu, Jul 6, 2017 at 10:45 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Sathish,
>
>> @@ -518,7 +545,26 @@ int messages_get_message(void *session, const char *handle,
>>                                       messages_get_message_cb callback,
>>                                       void *user_data)
>>  {
>> -     return -ENOSYS;
>> +     struct session *s =  session;
>> +     struct message_view_data *mvd;
>> +
>> +     mvd = g_new0(struct message_view_data, 1);
>> +     mvd->session = s;
>> +     mvd->handle = handle;
>> +     mvd->callback = callback;
>> +     mvd->user_data = user_data;
>> +
>> +     mvd->path = g_build_filename(s->cwd_absolute, handle, NULL);
>> +     mvd->fp = fopen(mvd->path, "r");
>> +     if (mvd->fp == NULL) {
>> +             int err = -errno;
>> +             DBG("fopen(): %d, %s", -err, strerror(-err));
>> +             g_free(mvd->path);
>> +             return -ENOENT;
>
> I think the memory of mvd leaks when fopen fails.
>
> Regards,
> Eramoto

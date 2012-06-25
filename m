Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6_k8NhT7NGN-6m44rX84-rm5W+LeXg5Mx11P0T7=J4hA@mail.gmail.com>
References: <1340460137-4279-1-git-send-email-lucas.demarchi@profusion.mobi>
	<CABBYNZJ9UAFcQ5qBMduZkufap+zLc_C2iB2kxsHJ3Qx6HaPEjg@mail.gmail.com>
	<CAMOw1v6_k8NhT7NGN-6m44rX84-rm5W+LeXg5Mx11P0T7=J4hA@mail.gmail.com>
Date: Mon, 25 Jun 2012 18:14:40 +0300
Message-ID: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix removal of filter after last filter_data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jun 25, 2012 at 4:26 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>
> Probably... this is the stock libdbus from Archlinux. I also found
> interest that all possible users of g_dbus_add_signal_watch() with a
> bus name were passing a NULL, which is clearly wrong. That made me
> think it was like this to workaround this bug.

Ive changed in a few places but I guess nobody really care when
g_dbus_add_signal_watch was introduced.

>
>>
>> Anyway I couldn't reproduce by changing ofono with stock libdbus from
>> FC 17, although I see the problem just by looking at the code, but
>> there other places where this need to be checked as well and the code
>> could be simplified:
>>
>> diff --git a/gdbus/watch.c b/gdbus/watch.c
>> index 9a716b0..d749176 100644
>> --- a/gdbus/watch.c
>> +++ b/gdbus/watch.c
>> @@ -376,15 +376,14 @@ static gboolean
>> filter_data_remove_callback(struct filter_data *data,
>>
>>        connection = dbus_connection_ref(data->connection);
>>        listeners = g_slist_remove(listeners, data);
>> -       filter_data_free(data);
>>
>>        /* Remove filter if there are no listeners left for the connection */
>> -       data = filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
>> -                                       NULL);
>> -       if (data == NULL)
>> +       if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
>> +                                                               NULL) == NULL)
>>                dbus_connection_remove_filter(connection, message_filter,
>>                                                NULL);
>>
>> +       filter_data_free(data);
>>        dbus_connection_unref(connection);
>>
>>        return TRUE;
>
> ahn... right. We already removed data from listeners list so we can
> call dbus_connection_remove_filter() before filter_data_free().

Please just send the patch with this changes, you probably have look
much more in details than I did.


-- 
Luiz Augusto von Dentz

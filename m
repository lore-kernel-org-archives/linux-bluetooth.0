Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120817075117.GC30060@x220>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
	<1345152524-13404-7-git-send-email-jprvita@openbossa.org>
	<20120817075117.GC30060@x220>
Date: Thu, 30 Aug 2012 19:08:28 -0300
Message-ID: <CAAngNMbTJ-YOg=fPAgeV7UQgG1VR7y4cZ-gPT0UBYgNUvMdfNw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 06/14] core: mutually exclude concurrent connections
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 17, 2012 at 4:51 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, Aug 16, 2012, João Paulo Rechi Vita wrote:
>> @@ -133,8 +133,10 @@ struct btd_adapter {
>> +     GSList *connecting_list;        /* Pending connects */
>> +     gboolean connecting;            /* Connect active */
>
> What's the relationship with the above two? Isn't connecting always true
> when g_slist_length(connecting_list) > 0 and false when the list is
> empty?
>

The connecting_list keeps track of devices that have been found but
for which a connect has not been issued yet. This was mainly used for
1) not trying to connect twice to the same device (on two subsequent
device_found events), and 2) to know if there are still any device
waiting for a connect when one connect finishes, to device if we
should restart scanning or not.

Reviewing this logic I've been able to simplify it a little bit, using
a counter (adapter->waiting_to_connect) to address problem #2, and #1
could be handled only using the adapter->connect_list.

>>  static gboolean connect_pending_cb(gpointer user_data)
>>  {
>>       struct btd_device *device = user_data;
>>       struct btd_adapter *adapter = device_get_adapter(device);
>> +     GIOChannel *io;
>>
>>       /* in the future we may want to check here if the controller supports
>>        * scanning and connecting at the same time */
>>       if (adapter->discovering)
>>               return TRUE;
>>
>> -     device_att_connect(device);
>> +     if (adapter->connecting)
>> +             return TRUE;
>> +
>> +     adapter->connecting = TRUE;
>> +     io = device_att_connect(device);
>> +     g_io_add_watch(io, G_IO_OUT | G_IO_ERR, clean_connecting_state,
>> +                                             btd_device_ref(device));
>>
>>       return FALSE;
>>  }
>
> Since you're not storing "io" after the function returns you should be
> doing a g_io_channel_unref() after calling g_io_add_watch(). Looking at
> device_att_connect it seems like it's missing a g_io_channel_ref (either
> when assigning to device->att_io or when returning from the function).
>
>> +             adapter->connecting_list = g_slist_append(
>> +                                     adapter->connecting_list, device);
>>
>
> Missing btd_device_unref()?
>

The whole ref counting has been reviewed as well, with the new logic
modifications mentioned above.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT

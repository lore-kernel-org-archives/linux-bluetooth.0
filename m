Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLHzxY01_ESgP3ra6xByNAcN_GO9B146W=v+nL4pk7jhw@mail.gmail.com>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
	<1415392919-17572-9-git-send-email-armansito@chromium.org>
	<CABBYNZJL5mHR8OGK5sLi81aeDHBs-UxZj5oJ6b3VKG-C_mD4GA@mail.gmail.com>
	<CAHrH25T5FhZZ=rsMAYjZpX8RenKFCpxv=hdNmAfQuVg7e9exAw@mail.gmail.com>
	<CABBYNZLHzxY01_ESgP3ra6xByNAcN_GO9B146W=v+nL4pk7jhw@mail.gmail.com>
Date: Tue, 11 Nov 2014 13:35:28 -0800
Message-ID: <CAHrH25Q6NzxAdBng6Pm9SQeVqz2PbHx7pRRDEczLHrsgpzNCgQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 08/11] shared/gatt-server: Implement "Prepare
 Write" request.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Nov 11, 2014 at 3:42 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Mon, Nov 10, 2014 at 6:26 PM, Arman Uguray <armansito@chromium.org> wrote:
>>>> diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
>>>> index 0e480e1..a95613c 100644
>>>> --- a/src/shared/gatt-server.h
>>>> +++ b/src/shared/gatt-server.h
>>>> @@ -40,6 +40,9 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
>>>>                                         void *user_data,
>>>>                                         bt_gatt_server_destroy_func_t destroy);
>>>>
>>>> +bool bt_gatt_server_set_max_prep_queue_length(struct bt_gatt_server *server,
>>>> +                                                       unsigned int length);
>>>
>>> Perhaps we should leave this API for later, Im not really sure if this
>>> will be ever used except perhaps for the TS in that case perhaps we
>>> should find a shorter name.
>>>
>>
>> In our case would it even make sense to have a maximum queue length? I
>> only added because there is an error for it and an application with
>> memory constraints may want to limit the size perhaps? Anyway, for now
>> I can set this to something arbitrary for v2.
>
> Perhaps having some arbitrary limit is good enough, not exactly
> because of memory constraints since each entry should consume just a
> few bytes but we don't want to timeout so I suggest we queue based on
> how long we should wait the result to be called.
>

OK, that makes a lot of sense. For now we can keep the arbitrary limit
and see how well it works.

> --
> Luiz Augusto von Dentz


Cheers,
Arman

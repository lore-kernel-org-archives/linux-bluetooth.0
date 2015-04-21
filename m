Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JHJ5p81ScZbhXo1JN9eSqovbzykWmTM2XMi=NZ7w09LWA@mail.gmail.com>
References: <20150417220040.A379A220209@puck.mtv.corp.google.com>
	<CABBYNZKHUbsLjzZrxNqUKe8Qp8L+F=COftCZfed1C+2JwydDOA@mail.gmail.com>
	<CAGXr9JH3PdfGsNreQF_CxeAESuJG6t_=CD=m6KW9DenT9pSxUg@mail.gmail.com>
	<CABBYNZKZCQ-g+VCDQcZQnrwskPaShUsgXwkqHysQ-6CffPGF3g@mail.gmail.com>
	<CAGXr9JEbTY9J+iVoMWaL=Vujcd5VWW=53775q9eL0kkMb3C4-A@mail.gmail.com>
	<CAGXr9JFvvLRUWFcRiwVFw4v7ABb=t9sAYrwg5B9xX4ZSP8rbSg@mail.gmail.com>
	<CABBYNZ+hYUYOu_CMZ+dvRN_ZdUbqy79btAreDk4m-Qn5QkoepQ@mail.gmail.com>
	<CAGXr9JHJ5p81ScZbhXo1JN9eSqovbzykWmTM2XMi=NZ7w09LWA@mail.gmail.com>
Date: Tue, 21 Apr 2015 23:49:09 +0300
Message-ID: <CABBYNZJutjCQEKA+w4EBKEAK17LLW=AQZKvPCqX3hN9RPhTaUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hog: re-enable HoG report notifications on HoG device reconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Tue, Apr 21, 2015 at 11:27 PM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Mon, Apr 20, 2015 at 11:08 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Tue, Apr 21, 2015 at 2:17 AM, Petri Gynther <pgynther@google.com> wrote:
>>> Hi Luiz,
>>>
>>> On Mon, Apr 20, 2015 at 2:54 PM, Petri Gynther <pgynther@google.com> wrote:
>>>> Hi Luiz,
>>>>
>>>> On Mon, Apr 20, 2015 at 1:12 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Petri,
>>>>>
>>>>> On Mon, Apr 20, 2015 at 7:34 PM, Petri Gynther <pgynther@google.com> wrote:
>>>>>> Hi Luiz,
>>>>>>
>>>>>> On Mon, Apr 20, 2015 at 7:50 AM, Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>> Hi Petri,
>>>>>>>
>>>>>>> On Sat, Apr 18, 2015 at 1:00 AM, Petri Gynther <pgynther@google.com> wrote:
>>>>>>>> On HoG device reconnect, re-enable HoG report notifications every
>>>>>>>> time by writing the client characteristic configuration attribute
>>>>>>>> of each HoG report.
>>>>>>>>
>>>>>>>> Doing this on every reconnect:
>>>>>>>> 1. ensures that HoG report notifications are always enabled
>>>>>>>>    (e.g. lost report notification state in battery swap).
>>>>>>>> 2. signals to HoG device that it can start sending HoG reports
>>>>>>>>    (e.g. buffered keypresses while the reconnect is still pending).
>>>>>>>
>>>>>>> Is that happening for a specific device? For 1 I suppose it would
>>>>>>> loose the paring keys as well which means we would not be able to
>>>>>>> connect at all as HoG mandates pairing, or does it loose only the CCC
>>>>>>> configuration? Reason 2 is not necessary the behavior every device
>>>>>>> would have, for example I don't expect a mouse to buffer anything and
>>>>>>> even a keyboard may buffer only the last key pressed since it might
>>>>>>> have very little memory to spend in buffering, anyway I suppose reason
>>>>>>> 1 is what you should really concentrate to tell us what is going on.
>>>>>>>
>>>>>>
>>>>>> On the device that I'm working on, pairing info is stored in
>>>>>> persistent storage, so it survives battery swap. However, I'm not sure
>>>>>> yet about HoG report notification enable/disable state. Waiting for
>>>>>> confirmation from vendor.
>>>>>
>>>>> I would expect it to store the CCC state as well in the persistent
>>>>> storage if one exists.
>>>>>
>>>>>> Anyways, we are seeing (2). The first keypress from HoG device is
>>>>>> getting lost on reconnect, leading to bad user experience. The device
>>>>>> is sending the keypress immediately when the connection is good, but
>>>>>> too early before BlueZ has managed to re-register the handler with
>>>>>> g_attrib_register(). During the reconnect, the HoG device has no way
>>>>>> of knowing when BlueZ is ready and has registered the handler. So, to
>>>>>> provide this indication, I propose to re-enable the HoG report
>>>>>> notification every time.
>>>>>
>>>>> But I already fixed this problem not long ago:
>>>>>
>>>>> commit 14569a33418a4c1dc07cca090b9336373d63a085
>>>>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>> Date:   Wed Mar 11 21:23:55 2015 +0200
>>>>>
>>>>>     core/device: Fix not handling notification
>>>>>
>>>>>     attio callbacks needs to be triggered as soon as possible once connected
>>>>>     otherwise profiles such as HoG may miss notification that are sent while
>>>>>     bt_gatt_client is doing MTU exchange.
>>>>>
>>>>> Perhaps you don't have this patch?
>>>>>
>>>>
>>>> Thanks for pointing this out. We are still using BlueZ 5.28, so don't
>>>> have this. I'll patch this in and see how HoG reconnect works then.
>>>>
>>>
>>> I reverted my 3 patches and applied your "core/device: Fix not
>>> handling notification" patch on top of our BlueZ 5.28 stack.
>>> Unfortunately, your patch breaks our HoG device completely. Our
>>> device's report map ends up being read incorrectly, and as a result,
>>> not a single keypress works any more.
>>>
>>> Applying your patch causes attio_connected_cb() getting called very
>>> early, before the MTU exchange has been negotiated. Somehow, this
>>> doesn't work for our device.
>>
>> You might need to following as well:
>>
>>     attrib: Fix not honoring MTU
>>
>>     If MTU has changed, by bt_gatt_client for example, the code should be
>>     able to figure it out without waiting g_attrib_set_mtu to be called.
>>
>> --
>> Luiz Augusto von Dentz
>
> I merged 5.30 into our codebase. Our HoG device is now operational
> (report map is OK), but the first keypress is still lost on reconnect.
>
> I'll have to dig deeper with btmon, once I get it compiling.
> Unfortunately, 5.30 has a dependency on #include <wordexp.h>, which
> our uClibc doesn't support.

Maybe try with your own box? We actually have this problem of missing
keys before so I would surprised if it is still happening since we
should be registering the notification handler within
device_attach_att on gatt_client_init and the notification should only
be triggering on att.c:can_read_data.

-- 
Luiz Augusto von Dentz

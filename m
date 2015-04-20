Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JEbTY9J+iVoMWaL=Vujcd5VWW=53775q9eL0kkMb3C4-A@mail.gmail.com>
References: <20150417220040.A379A220209@puck.mtv.corp.google.com>
	<CABBYNZKHUbsLjzZrxNqUKe8Qp8L+F=COftCZfed1C+2JwydDOA@mail.gmail.com>
	<CAGXr9JH3PdfGsNreQF_CxeAESuJG6t_=CD=m6KW9DenT9pSxUg@mail.gmail.com>
	<CABBYNZKZCQ-g+VCDQcZQnrwskPaShUsgXwkqHysQ-6CffPGF3g@mail.gmail.com>
	<CAGXr9JEbTY9J+iVoMWaL=Vujcd5VWW=53775q9eL0kkMb3C4-A@mail.gmail.com>
Date: Mon, 20 Apr 2015 16:17:17 -0700
Message-ID: <CAGXr9JFvvLRUWFcRiwVFw4v7ABb=t9sAYrwg5B9xX4ZSP8rbSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hog: re-enable HoG report notifications on HoG device reconnect
From: Petri Gynther <pgynther@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Apr 20, 2015 at 2:54 PM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Mon, Apr 20, 2015 at 1:12 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Mon, Apr 20, 2015 at 7:34 PM, Petri Gynther <pgynther@google.com> wrote:
>>> Hi Luiz,
>>>
>>> On Mon, Apr 20, 2015 at 7:50 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Petri,
>>>>
>>>> On Sat, Apr 18, 2015 at 1:00 AM, Petri Gynther <pgynther@google.com> wrote:
>>>>> On HoG device reconnect, re-enable HoG report notifications every
>>>>> time by writing the client characteristic configuration attribute
>>>>> of each HoG report.
>>>>>
>>>>> Doing this on every reconnect:
>>>>> 1. ensures that HoG report notifications are always enabled
>>>>>    (e.g. lost report notification state in battery swap).
>>>>> 2. signals to HoG device that it can start sending HoG reports
>>>>>    (e.g. buffered keypresses while the reconnect is still pending).
>>>>
>>>> Is that happening for a specific device? For 1 I suppose it would
>>>> loose the paring keys as well which means we would not be able to
>>>> connect at all as HoG mandates pairing, or does it loose only the CCC
>>>> configuration? Reason 2 is not necessary the behavior every device
>>>> would have, for example I don't expect a mouse to buffer anything and
>>>> even a keyboard may buffer only the last key pressed since it might
>>>> have very little memory to spend in buffering, anyway I suppose reason
>>>> 1 is what you should really concentrate to tell us what is going on.
>>>>
>>>
>>> On the device that I'm working on, pairing info is stored in
>>> persistent storage, so it survives battery swap. However, I'm not sure
>>> yet about HoG report notification enable/disable state. Waiting for
>>> confirmation from vendor.
>>
>> I would expect it to store the CCC state as well in the persistent
>> storage if one exists.
>>
>>> Anyways, we are seeing (2). The first keypress from HoG device is
>>> getting lost on reconnect, leading to bad user experience. The device
>>> is sending the keypress immediately when the connection is good, but
>>> too early before BlueZ has managed to re-register the handler with
>>> g_attrib_register(). During the reconnect, the HoG device has no way
>>> of knowing when BlueZ is ready and has registered the handler. So, to
>>> provide this indication, I propose to re-enable the HoG report
>>> notification every time.
>>
>> But I already fixed this problem not long ago:
>>
>> commit 14569a33418a4c1dc07cca090b9336373d63a085
>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Date:   Wed Mar 11 21:23:55 2015 +0200
>>
>>     core/device: Fix not handling notification
>>
>>     attio callbacks needs to be triggered as soon as possible once connected
>>     otherwise profiles such as HoG may miss notification that are sent while
>>     bt_gatt_client is doing MTU exchange.
>>
>> Perhaps you don't have this patch?
>>
>
> Thanks for pointing this out. We are still using BlueZ 5.28, so don't
> have this. I'll patch this in and see how HoG reconnect works then.
>

I reverted my 3 patches and applied your "core/device: Fix not
handling notification" patch on top of our BlueZ 5.28 stack.
Unfortunately, your patch breaks our HoG device completely. Our
device's report map ends up being read incorrectly, and as a result,
not a single keypress works any more.

Applying your patch causes attio_connected_cb() getting called very
early, before the MTU exchange has been negotiated. Somehow, this
doesn't work for our device.

>>>>> ---
>>>>>  profiles/input/hog.c | 5 +----
>>>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>>>>> index c55443c..690fd43 100644
>>>>> --- a/profiles/input/hog.c
>>>>> +++ b/profiles/input/hog.c
>>>>> @@ -842,10 +842,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>>>>         for (l = hogdev->reports; l; l = l->next) {
>>>>>                 struct report *r = l->data;
>>>>>
>>>>> -               r->notifyid = g_attrib_register(hogdev->attrib,
>>>>> -                                       ATT_OP_HANDLE_NOTIFY,
>>>>> -                                       r->decl->value_handle,
>>>>> -                                       report_value_cb, r, NULL);
>>>>> +               enable_report_notification(r);
>>>>>         }
>>>>>  }
>>>>>
>>>>> --
>>>>> 2.2.0.rc0.207.ga3a616c
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz

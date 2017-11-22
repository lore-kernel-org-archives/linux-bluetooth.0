Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLy-ei67BuDApNvK4KWhtKPWM__4ynM9F8REgCWFgO7WA@mail.gmail.com>
References: <20171121200436.17576-1-luiz.dentz@gmail.com> <1511301906.16347.42.camel@hadess.net>
 <CABBYNZLy-ei67BuDApNvK4KWhtKPWM__4ynM9F8REgCWFgO7WA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Nov 2017 15:38:54 +0200
Message-ID: <CABBYNZJbXm9Wy1b3L1pv_0YLyM5sDOrcAwRcpvGsi=PhOSVk6g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix not emiting PropertiesChanged
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 22, 2017 at 11:14 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bastien,
>
> On Wed, Nov 22, 2017 at 12:05 AM, Bastien Nocera <hadess@hadess.net> wrote:
>>> Re: [PATCH BlueZ] gdbus: Fix not emiting PropertiesChanged
>>
>> emitting.
>>
>> On Tue, 2017-11-21 at 22:04 +0200, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> If and interface is removed while properties are pending it would cause
>>
>> "an interface".
>>
>>> process_properties_from_interface to clear data->pending_prop when it
>>> should only clear the iface->pending_prop.
>>
>> I prefer my version, which allows the pending properties to be cleared
>> out if the pending ones were for that interface. I also prefer the
>> subject line I used, describing the actual problem it fixes, and the
>> commit message going more into details.
>
> I guess this one is simpler to maintain, also notice that iterating in
> the data->interfaces to check if there are no other pending_prop has
> almost the same effect as process_property_changes, what would make a
> difference would be to prevent process_changes but that has to run
> anyway to propagate the interfaces added/removed. Also notice that
> data->pending_prop is clear earlier than the original fix for
> duplicated signals, the one that introduced this problem, that way we
> don't reintroduce the original problem.
>
> Regarding the commit message, we usually avoid BlueZ specific
> description there as gdbus is shared with other projects.
>
>>
>> But up to you.
>>
>> Cheers
>>
>>> ---
>>>  gdbus/object.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/gdbus/object.c b/gdbus/object.c
>>> index afb458764..5c8ad7a55 100644
>>> --- a/gdbus/object.c
>>> +++ b/gdbus/object.c
>>> @@ -1659,8 +1659,6 @@ static void
>>> process_properties_from_interface(struct generic_data *data,
>>>       DBusMessageIter iter, dict, array;
>>>       GSList *invalidated;
>>>
>>> -     data->pending_prop = FALSE;
>>> -
>>>       if (iface->pending_prop == NULL)
>>>               return;
>>>
>>> @@ -1722,6 +1720,8 @@ static void process_property_changes(struct
>>> generic_data *data)
>>>  {
>>>       GSList *l;
>>>
>>> +     data->pending_prop = FALSE;
>>> +
>>>       for (l = data->interfaces; l != NULL; l = l->next) {
>>>               struct interface_data *iface = l->data;
>>>

Applied.

-- 
Luiz Augusto von Dentz

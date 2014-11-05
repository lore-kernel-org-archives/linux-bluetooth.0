Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <545A5CA3.1000807@LilandIT.com>
References: <5457A17D.9060404@LilandIT.com>
	<CAHrH25RfMAiNTHYBR=vT+KuBtVwEKPuLRFfEiMGF9Ya__9Y5nA@mail.gmail.com>
	<5458C0CD.9010907@LilandIT.com>
	<CAHrH25SBzCoJ+nvUbS2a8MfxbSG4nBhJ447qz7VKGSdGgMXM-A@mail.gmail.com>
	<545A5CA3.1000807@LilandIT.com>
Date: Wed, 5 Nov 2014 09:47:01 -0800
Message-ID: <CAHrH25TZgUU85PLOnQZQzxypwbQVa4Rto85H6vwbGg7F4G3QcQ@mail.gmail.com>
Subject: Re: How to get started on a GATT Server ?
From: Arman Uguray <armansito@chromium.org>
To: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edmund,

> On Wed, Nov 5, 2014 at 9:21 AM, Urbani, Edmund <edmund.urbani@lilandit.com> wrote:
> On 11/04/2014 08:11 PM, Arman Uguray wrote:
>>
>> Hi Edmund,
>>
>> On Tue, Nov 4, 2014 at 4:04 AM, Urbani, Edmund
>> <edmund.urbani@lilandit.com> wrote:
>>>
>>> On 11/03/2014 08:32 PM, Arman Uguray wrote:
>>>>
>>>> Hi Edmund,
>>>>
>>>>> On Mon, Nov 3, 2014 at 7:38 AM, Urbani, Edmund
>>>>> <edmund.urbani@lilandit.com> wrote:
>>>>> Hello all,
>>>>>
>>>>> I am trying to write a simple GATT-based service of my own. Right now I
>>>>> don't really know which docs I should be looking at. I have skimmed
>>>>> through
>>>>> bluez sources (5.23) and found gatt-service.h and gatt.h, as well as
>>>>> the
>>>>> gatt-example plugin.
>>>>>
>>>>> So far I am still trying to figure out whether I should be going the C
>>>>> API
>>>>> route or maybe use the D-Bus interface. Also gatt-service.c seems to
>>>>> suggest
>>>>> that there is a way to register a GATT service over D-Bus but running
>>>>> it
>>>>> gives me this:
>>>>> RegisterService: Method "RegisterService" with signature "oa{sv}" on
>>>>> interface "org.bluez.GattManager1" doesn't exist"
>>>>
>>>> The reason you're not seeing GattManager1 is because it's hidden
>>>> behind the "experimental" flag. So you need to configure and run bluez
>>>> with the --enable-experimental and the --experimental flags
>>>> respectively.
>>>>
>>>> That said, that API implementation isn't complete and isn't in fact
>>>> even wired up with the internal attrib-server. We're working towards
>>>> rewriting all of the C API and finally implementing the proposed D-Bus
>>>> API but until then, I would ignore doc/gatt-api.txt (it's only a
>>>> proposal at the moment and isn't even included in release tarballs).
>>>> So for now you have to use the C API route. There will probably be an
>>>> announcement once that D-Bus API is finally supported.
>>>
>>>
>>>>> Any pointers to help me get started would be appreciated. Thanks!
>>>>>
>>>>> Kind regards,
>>>>>     Edmund
>>>>
>>>> Cheers,
>>>> Arman
>>>
>>>
>>> Thanks, I won't bother with the D-Bus interface then. But if the C API is
>>> being rewritten now, that sounds like there is currently no stable API
>>> available at all. :/ Or is it just the internals being rewritten?
>>>
>> The C API for GATT interactions is being rewritten, i.e. the code in
>> attrib/* is being deprecated in favor of code in src/shared/gatt*. You
>> can still keep using the existing APIs though at some point we will
>> rip out the existing attrib-server to be a combination of
>> shared/gatt-db and shared/gatt-server. So, make sure you keep track of
>> the patches going in.
>>
>> Keep in mind that if you're developing your code on top of the master
>> branch then things are meant to be in flight and unstable there, so
>> you should follow releases anyway. I think we'll figure out a way so
>> that the C based GATT server/client won't be entirely broken for
>> people in between official BlueZ releases.
>>
>>> So I assume, the fastest route the get a prototype that does something,
>>> would be to get gatt-example.c to run and then modify that, right?
>>>
>> Yes, that is the easiest way right now. When the new C APIs are mature
>> enough we will convert gatt-example to use the new code but that's
>> still a few months down the line.
>>
>>> Kind regards,
>>>   Edmund
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Cheers,
>> Arman
>
>
> Thanks, Arman. I now have a basic service with one characteristic and a
> read-only value up and running (I can see and read its value from another
> system using gatttool... though my iOS app still fails to discover the
> service :/ ).
>
> What I actually need however is a read/write attribute and a way to react to
> write requests. The examples in gatt-service.c all seem to be read-only. How
> would I get a call-back for an incoming write request?
>

It's not obvious from reading the existing code but the
"gatt_service_add" function defined attrib/gatt-service.h allows you
to specify read/write handlers using options passed via its variable
length argument list. You can look at profiles/proximity/linkloss.c
for an example of this. Looking at the link_loss_register function, I
see the profile register both a read and a write callback for the
Alert Level characteristic (the functions link_loss_alert_lvl_read and
link_loss_alert_lvl_write). I think this is what you're looking for.

That said, the new API will hopefully make this more readable by doing
away with the variable argument list and having explicit functions and
arguments for inserting characteristics into the database with
read/write handlers.

>
> Kind regards,
>  Edmund
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

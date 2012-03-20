Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTh+qs=dPFmJGq=MeG8qLarkcUu6UWrXb-a1sbAqMt3Dkw@mail.gmail.com>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
	<20120319230436.GA27304@x220>
	<20120320173546.GA6307@samus>
	<CAB7rCTgRzuBS49XNLfLN03POO3W0hZm3QjGwBCNkOXN2wKZ7Ag@mail.gmail.com>
	<CAB7rCTh+qs=dPFmJGq=MeG8qLarkcUu6UWrXb-a1sbAqMt3Dkw@mail.gmail.com>
Date: Tue, 20 Mar 2012 14:21:49 -0500
Message-ID: <CAB7rCThoXBiXAs=fmC829khQ+62GSwAsJPvzj6tTMg+iiKLydg@mail.gmail.com>
Subject: Re: reverse SDP issue
From: Mike <puffy.taco@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2012 at 1:39 PM, Mike <puffy.taco@gmail.com> wrote:
> On Tue, Mar 20, 2012 at 1:27 PM, Mike <puffy.taco@gmail.com> wrote:
>> On Tue, Mar 20, 2012 at 12:35 PM, Vinicius Costa Gomes
>> <vinicius.gomes@openbossa.org> wrote:
>>> Hi,
>>>
>>> On 20:04 Mon 19 Mar, Johan Hedberg wrote:
>>>> Hi Mike,
>>>>
>>>> On Mon, Mar 19, 2012, Mike wrote:
>>>> > I notice a change in commit d2920be715974795b51f9cc3279947104da3647b
>>>> > [1] that changes the "reverse" variable for an SDP query:
>>>> >
>>>> >  -       device_browse_sdp(device, NULL, NULL, NULL, TRUE);
>>>> > +       if (device_is_bredr(device))
>>>> > +               device_browse_sdp(device, NULL, NULL, NULL, FALSE);
>>>> > +       else
>>>> > +               device_browse_primary(device, NULL, NULL, FALSE);
>>>> >
>>>> > You can see the original had reverse as TRUE, but the patch may have
>>>> > inadvertently changed it to FALSE..kernel.org/majordomo-info.html
>>>>
>>>> That looks like a definitive bug. Good that you caught it. Vinicius
>>>> (author of the commit) care to comment?
>>>
>>> It was changed to false by mistake, a patch to fix it should be arriving
>>> on the mailing list in a few moments.
>>>
>>> The comment on src/device.c around line 1683 gives some hints on what
>>> my mistake may have caused: it could be that the device while connected
>>> "hides" some items from its service record. So with reverse set to
>>> false, some records that are present are being removed by mistake.
>>
>> I'm not sure that's the case here.  I added some code to print out the
>> contents of "device->uuids" at the beginning of update_services
>> (src/device.c), and here is what I got:
>>
>> UUID 0000110d-0000-1000-8000-00805f9b34fb
>> UUID 0000111f-0000-1000-8000-00805f9b34fb
>> UUID 0000110d-0000-1000-8000-00805f9b34fb
>> UUID 0000111f-0000-1000-8000-00805f9b34fb
>>
>> A little curious why the UUIDs are duplicated, but besides that, we
>> can see that my phone already attempted to connect _before_ it was
>> paired, because it thought it was paired already (pairing deleted on
>> the BlueZ side only).  The UUIDs were added then before SDP could be
>> done.
>>
>> This has me suspecting these lines of code in update_services:
>>
>>                l = g_slist_find_custom(device->uuids, profile_uuid,
>>                                                        (GCompareFunc) strcmp);
>>                if (!l)
>>                        req->profiles_added =
>>                                        g_slist_append(req->profiles_added,
>>                                                        profile_uuid);
>>                else {
>>                        req->profiles_removed =
>>                                        g_slist_remove(req->profiles_removed,
>>                                                        l->data);
>>                        g_free(profile_uuid);
>>                }
>>
>> It appears that if a UUID already existed when you did the SDP browse,
>> it is removed?  Why would that be?
>
> Ah, I read that wrong.  The UUID is removed from the list of profiles
> to be removed!  So that's sane, but I guess the problem is that
> somehow we have the UUIDs in there twice, which makes this code fail.

Argh.  I guess update_services was being called twice, so the UUIDS
aren't duplicated.  I'm still tracing what the real issue is then.

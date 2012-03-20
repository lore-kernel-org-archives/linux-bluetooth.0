Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCThoXBiXAs=fmC829khQ+62GSwAsJPvzj6tTMg+iiKLydg@mail.gmail.com>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
	<20120319230436.GA27304@x220>
	<20120320173546.GA6307@samus>
	<CAB7rCTgRzuBS49XNLfLN03POO3W0hZm3QjGwBCNkOXN2wKZ7Ag@mail.gmail.com>
	<CAB7rCTh+qs=dPFmJGq=MeG8qLarkcUu6UWrXb-a1sbAqMt3Dkw@mail.gmail.com>
	<CAB7rCThoXBiXAs=fmC829khQ+62GSwAsJPvzj6tTMg+iiKLydg@mail.gmail.com>
Date: Tue, 20 Mar 2012 15:18:35 -0500
Message-ID: <CAB7rCTic1TFRM7YgoQnQf6PS-Yp7G9RbdX+Y+griMwteMipYtA@mail.gmail.com>
Subject: Re: reverse SDP issue
From: Mike <puffy.taco@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2012 at 2:21 PM, Mike <puffy.taco@gmail.com> wrote:
> On Tue, Mar 20, 2012 at 1:39 PM, Mike <puffy.taco@gmail.com> wrote:
>> On Tue, Mar 20, 2012 at 1:27 PM, Mike <puffy.taco@gmail.com> wrote:
>>> On Tue, Mar 20, 2012 at 12:35 PM, Vinicius Costa Gomes
>>> <vinicius.gomes@openbossa.org> wrote:
>>>> Hi,
>>>>
>>>> On 20:04 Mon 19 Mar, Johan Hedberg wrote:
>>>>> Hi Mike,
>>>>>
>>>>> On Mon, Mar 19, 2012, Mike wrote:
>>>>> > I notice a change in commit d2920be715974795b51f9cc3279947104da3647b
>>>>> > [1] that changes the "reverse" variable for an SDP query:
>>>>> >
>>>>> >  -       device_browse_sdp(device, NULL, NULL, NULL, TRUE);
>>>>> > +       if (device_is_bredr(device))
>>>>> > +               device_browse_sdp(device, NULL, NULL, NULL, FALSE);
>>>>> > +       else
>>>>> > +               device_browse_primary(device, NULL, NULL, FALSE);
>>>>> >
>>>>> > You can see the original had reverse as TRUE, but the patch may have
>>>>> > inadvertently changed it to FALSE..kernel.org/majordomo-info.html
>>>>>
>>>>> That looks like a definitive bug. Good that you caught it. Vinicius
>>>>> (author of the commit) care to comment?
>>>>
>>>> It was changed to false by mistake, a patch to fix it should be arriving
>>>> on the mailing list in a few moments.
>>>>
>>>> The comment on src/device.c around line 1683 gives some hints on what
>>>> my mistake may have caused: it could be that the device while connected
>>>> "hides" some items from its service record. So with reverse set to
>>>> false, some records that are present are being removed by mistake.
>>>
>>> I'm not sure that's the case here.  I added some code to print out the
>>> contents of "device->uuids" at the beginning of update_services
>>> (src/device.c), and here is what I got:
>>>
>>> UUID 0000110d-0000-1000-8000-00805f9b34fb
>>> UUID 0000111f-0000-1000-8000-00805f9b34fb
>>> UUID 0000110d-0000-1000-8000-00805f9b34fb
>>> UUID 0000111f-0000-1000-8000-00805f9b34fb
>>>
>>> A little curious why the UUIDs are duplicated, but besides that, we
>>> can see that my phone already attempted to connect _before_ it was
>>> paired, because it thought it was paired already (pairing deleted on
>>> the BlueZ side only).  The UUIDs were added then before SDP could be
>>> done.
>>>
>>> This has me suspecting these lines of code in update_services:
>>>
>>>                l = g_slist_find_custom(device->uuids, profile_uuid,
>>>                                                        (GCompareFunc) strcmp);
>>>                if (!l)
>>>                        req->profiles_added =
>>>                                        g_slist_append(req->profiles_added,
>>>                                                        profile_uuid);
>>>                else {
>>>                        req->profiles_removed =
>>>                                        g_slist_remove(req->profiles_removed,
>>>                                                        l->data);
>>>                        g_free(profile_uuid);
>>>                }
>>>
>>> It appears that if a UUID already existed when you did the SDP browse,
>>> it is removed?  Why would that be?
>>
>> Ah, I read that wrong.  The UUID is removed from the list of profiles
>> to be removed!  So that's sane, but I guess the problem is that
>> somehow we have the UUIDs in there twice, which makes this code fail.
>
> Argh.  I guess update_services was being called twice, so the UUIDS
> aren't duplicated.  I'm still tracing what the real issue is then.

Alright, now I think I understand what's going on.  The avdtp.c code
adds ADVANCED_AUDIO_UUID to the UUID list if the device does not
exist.  The problem is that ADVANCED_AUDIO_UUID, according to the
assigned numbers document, is only allowed as a profile class.  The
code in update_services is checking for service classes, and finds
0x110a (audio source) rather than 0x110d (advanced audio).  So, the
real problem in my case is that ADVANCED_AUDIO_UUID is being used as a
service class when it should not.  Below is the SDP record from my
phone for the Audio Source:

Service Name: Audio Source
Service Description: Audio Source
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x1000d
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

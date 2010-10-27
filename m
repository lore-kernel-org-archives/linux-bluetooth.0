Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=g+8UDsSQBnqBWk=Ly=xCmfvwX_ZCMsn_kU9Fb@mail.gmail.com>
References: <201010191147.34241.sander@outrightsolutions.nl>
	<AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com>
	<AANLkTi=ThA2ojhj8PBHK_VybmFcHO91K0g=y7nhfTBAO@mail.gmail.com>
	<AANLkTimGO9-_odEX-=8Lttw1D3M=X+DWJH0w45W8nMtT@mail.gmail.com>
	<AANLkTi=g+8UDsSQBnqBWk=Ly=xCmfvwX_ZCMsn_kU9Fb@mail.gmail.com>
Date: Wed, 27 Oct 2010 12:27:54 +0530
Message-ID: <AANLkTinodSvkAffPKrHT_Yd9nwXwAdQoqacD9vJt-F96@mail.gmail.com>
Subject: Re: AVRCP 1.4 : Future on Target Role
From: "shivendra.agrawal@stericsson.com" <ag.shivendra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

ST-Ericsson plans to implement the commands to support target role of
AVRCP 1.4 Profile, and we would like to contribute it to BlueZ.
With our initial discussion, I would be aligning with BlueZ
contributors and would propose for the ideas that has not been
touched/developed so far, in order to have a design/implementation
that can be accepted.

As a very first, and very rough, design proposal for the BlueZ parts:
- A new SDP record for AVRCP 1.4 would be added to inform CT of the
version and features supported by target.
- A new callback to accept browsing channel establishment.
- Enhancing similar to bt_io_listen for browsing PSM.
- A new browsing command handler
- Incremental addition to AVRCP 1.4 commands.

Any feedback is very much appreciated!

Regards,
Shivendra


2010/10/25 João Paulo Rechi Vita <jprvita@gmail.com>:
> 2010/10/25 Shivendra Agrawal <ag.shivendra@gmail.com>:
>> 2010/10/23 João Paulo Rechi Vita <jprvita@gmail.com>:
>>> Hello all,
>>>
>>> I've seen some discuss regarding how to add support for AVRCP 1.3 and
>>> 1.4 versions on the ML lately, and some expectations over the related
>>> work I've done in BlueZ. Sorry for the long delay on replying, I've
>>> been pretty busy lately and just didn't got the time. I'm planing to
>>> put some effort again on this work on the coming weeks.
>>>
>>> On Tue, Oct 19, 2010 at 14:14, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> On Tue, Oct 19, 2010 at 12:47 PM, Sander van Grieken
>>>> <sander@outrightsolutions.nl> wrote:
>>>>> I am very much in favor of not directly depending on MPRIS, but instead letting
>>>>> applications registering themselves as a target. For two reasons:
>>>>>
>>>>> - AVRCP seems to be a superset of MPRIS (which is very limited IMO), and might have
>>>>> different semantics, especially w.r.t. event notifications. So we would limit ourselves to
>>>>> the intersecting subset of both technologies.
>>>>> - A separate AVRCP/TG <-> MPRIS bridge agent would still allow controlling all MPRIS-
>>>>> enabled players, so we can have both full implementation of the AVRCP spec, AND generic
>>>>> MPRIS support.
>>>>
>>>> Sounds good to me, we can use Media API to register players as well.
>>>>
>>>
>>> I agree with Sander's opinion that MPRIS seems a bit limited for 1.4.
>>> OTOH it's an already defined and under-adoption standard. If we have
>>> applications registering themselves directly with us, we'll have to
>>> define a new interface for that and push this to the player
>>> applications. Do you guys already have a draft of these interfaces
>>> (for the applications and extensions to the Media API)? I guess we
>>> should try to define exactly what we need first, and them see what's
>>> missing from MPRIS.
>>>
>>>>>> > I am keen to receive your feedback with some ideas and thoughts to put
>>>>>> > my effort in right direction.
>>>>>> >
>>>>>> > Question:
>>>>>> > Is anyone working on AVRCP 1.4 Target role profile development?
>>>>>>
>>>>>> Joao Paulo (http://jprvita.wordpress.com/2010/07/22/avrcp-metadata/)
>>>>>
>>>>> Actually, the metadata work is not part of v1.4 of the spec, but 1.3
>>>>>
>>>>> Second, I have already added some boilerplate stuff (like a DBUS Connect method for RCP and
>>>>> some fixes for CT commands), but I've based on Joao's branch, so I have to wait until his
>>>>> stuff gets merged. Alternatively, I could rebase that stuff on HEAD, but that would overlap
>>>>> and conflict with Joao's stuff, so I'm hesitant to go there.
>>>>
>>>
>>> Have you published this code somewhere?
>>>
>>>> I hope to see this code being push upstream soon, I will try to
>>>> contact Joao Paulo to get an idea if the code is ready to be
>>>> reviewed/pushed so we get the things rolling.
>>>>
>>>
>>> I'm finally here :) I've focused mostly in the 1.3 version of the spec
>>> and having pulseaudio as a middle-man in my work, and have written
>>> most of the code in pulseaudio to handle these new functionality. Even
>>> if we take the approach described above for 1.4, IMO it makes sense to
>>> upstream this so we can have earlier support for 1.3 and also to
>>> support Sander's work. Luiz, Johan, what do you think?
>>>
>>> I'll review the code once more, since I've written it a few months
>>> ago, but my main concern about pushing it upstream right now is that
>>> it hasn't been tested yet. I have no device to test against and PTS
>>> can't give us no guarantee whether the code really works in practice
>>> or not (but it's still better than nothing). Sander, David, have you
>>> tested my code against any real device?
>>
>> You are right, PTS does not guarantee, but I guess, PTS viewer can support
>> checking the frame that is sent is as per protocol.
>> This could give a safe hands of the implementation. Does that assumption helps?
>
> Yes, you can view what is passing by the bluetooth radio, but it's
> still the same as testing against the PTS only. The best would be to
> have device which someone could test against.
>
> --
> João Paulo Rechi Vita
> http://jprvita.wordpress.com/
>

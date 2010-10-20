Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com>
References: <201010191147.34241.sander@outrightsolutions.nl>
	<AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com>
Date: Wed, 20 Oct 2010 09:57:52 +0530
Message-ID: <AANLkTim9ypGcMEJ4+HqSZT_uxH4x9chHUW3mU0uDbfrR@mail.gmail.com>
Subject: Re: AVRCP 1.4 : Future on Target Role
From: Shivendra Agrawal <ag.shivendra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Thanks a lot for nice feedback. I will do some study on the MPRIS and
suggestions for TG<->Media API, and would come back soon.
I would certainly sync with all to avoid any duplicate effort.

Meanwhile, I also found a need to enhance the sdp record for Browsing
PSM and feature set. This would be needed by CT to establish Browsing
Channel with TG.

Question:
Is anyone working on this or I could put some proposal for discussion?

David,
If you are going to resume AVRCP 1.3 implementation, can we sync
together as I have done some study on this part as well.
So far I don't have any device and guess PTS can be taken as start point.

Regards,
Shivendra

On Tue, Oct 19, 2010 at 9:44 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Oct 19, 2010 at 12:47 PM, Sander van Grieken
> <sander@outrightsolutions.nl> wrote:
>> I am very much in favor of not directly depending on MPRIS, but instead letting
>> applications registering themselves as a target. For two reasons:
>>
>> - AVRCP seems to be a superset of MPRIS (which is very limited IMO), and might have
>> different semantics, especially w.r.t. event notifications. So we would limit ourselves to
>> the intersecting subset of both technologies.
>> - A separate AVRCP/TG <-> MPRIS bridge agent would still allow controlling all MPRIS-
>> enabled players, so we can have both full implementation of the AVRCP spec, AND generic
>> MPRIS support.
>
> Sounds good to me, we can use Media API to register players as well.
>
>>> > I am keen to receive your feedback with some ideas and thoughts to put
>>> > my effort in right direction.
>>> >
>>> > Question:
>>> > Is anyone working on AVRCP 1.4 Target role profile development?
>>>
>>> Joao Paulo (http://jprvita.wordpress.com/2010/07/22/avrcp-metadata/)
>>
>> Actually, the metadata work is not part of v1.4 of the spec, but 1.3
>>
>> Second, I have already added some boilerplate stuff (like a DBUS Connect method for RCP and
>> some fixes for CT commands), but I've based on Joao's branch, so I have to wait until his
>> stuff gets merged. Alternatively, I could rebase that stuff on HEAD, but that would overlap
>> and conflict with Joao's stuff, so I'm hesitant to go there.
>
> I hope to see this code being push upstream soon, I will try to
> contact Joao Paulo to get an idea if the code is ready to be
> reviewed/pushed so we get the things rolling.
>
>> Shivendra, before you start, let's sync so we don't duplicate efforts
>>
>> grtz,
>> Sander
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

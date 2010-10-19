Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201010191147.34241.sander@outrightsolutions.nl>
References: <201010191147.34241.sander@outrightsolutions.nl>
Date: Tue, 19 Oct 2010 19:14:14 +0300
Message-ID: <AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com>
Subject: Re: AVRCP 1.4 : Future on Target Role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 19, 2010 at 12:47 PM, Sander van Grieken
<sander@outrightsolutions.nl> wrote:
> I am very much in favor of not directly depending on MPRIS, but instead letting
> applications registering themselves as a target. For two reasons:
>
> - AVRCP seems to be a superset of MPRIS (which is very limited IMO), and might have
> different semantics, especially w.r.t. event notifications. So we would limit ourselves to
> the intersecting subset of both technologies.
> - A separate AVRCP/TG <-> MPRIS bridge agent would still allow controlling all MPRIS-
> enabled players, so we can have both full implementation of the AVRCP spec, AND generic
> MPRIS support.

Sounds good to me, we can use Media API to register players as well.

>> > I am keen to receive your feedback with some ideas and thoughts to put
>> > my effort in right direction.
>> >
>> > Question:
>> > Is anyone working on AVRCP 1.4 Target role profile development?
>>
>> Joao Paulo (http://jprvita.wordpress.com/2010/07/22/avrcp-metadata/)
>
> Actually, the metadata work is not part of v1.4 of the spec, but 1.3
>
> Second, I have already added some boilerplate stuff (like a DBUS Connect method for RCP and
> some fixes for CT commands), but I've based on Joao's branch, so I have to wait until his
> stuff gets merged. Alternatively, I could rebase that stuff on HEAD, but that would overlap
> and conflict with Joao's stuff, so I'm hesitant to go there.

I hope to see this code being push upstream soon, I will try to
contact Joao Paulo to get an idea if the code is ready to be
reviewed/pushed so we get the things rolling.

> Shivendra, before you start, let's sync so we don't duplicate efforts
>
> grtz,
> Sander
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer

Return-Path: <cyrus@holtmann.org>
Message-ID: <a8e1da0807212202o342fea25w3bf650f05986f65@mail.gmail.com>
Date: Tue, 22 Jul 2008 13:02:33 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Odysseus Flappington" <deriziotis@gmail.com>
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <5eee8c670807211353u49afeb71gc7aa02ce15b684a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	 <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	 <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	 <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	 <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	 <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
	 <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
	 <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
	 <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
	 <5eee8c670807211353u49afeb71gc7aa02ce15b684a@mail.gmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, Jul 22, 2008 at 4:53 AM, Odysseus Flappington
<deriziotis@gmail.com> wrote:
> Hi Marcel,
>
> I keep reading kernel developers saying that we should be persistent, so I'm
> following up on this, has any progress been made regarding the following
> issue?

Hi, I ever tried to implement it, but I'm occupied by other projects.

The key problem is that bluetooth drivers can only set the flags
during the probe now, but we need to send bluetooth commands to get
the revision.

>
> This one's a bit of an old one, regarding bluetooth adapters after a certain
> build number to require a reset command every boot before they'll work
> properly, I've attached a previous discussion as a reminder to the issue.
>
> If there's anything I can do (non-code writing though), please let me know,
> I'll be glad to help get this sorted.
>
> Alexander Deriziotis
>
> On 26/03/2008, Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>> Hi Dave,
>>
>>>> I've been looking around to see if I could figure out the build id where
>>>> the
>>>> dongles started shipping with the correct HCI_Reset. I think I may have
>>>> found something.
>>>
>>> Thanks a lot.
>>>
>>> Marcel, I think it's what you want.  I would like to file a patch.
>>
>> yes, but I already got it via CSR internals. They have always been helpful
>> when it comes to BlueZ. CSR is an open source friendly company. I didn't
>> have time to actually produce that patch since we have to turn the whole
>> logic around.
>>
>> Regards
>>
>> Marcel
>>
>
>



-- 
Regards
dave

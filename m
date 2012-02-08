Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Feb 2012 14:33:19 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Getting L2CAP ERTM support into better upstream state
In-Reply-To: <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1202081221280.25089@mathewm-linux>
References: <1328678855.28848.6.camel@aeonflux> <20120208090945.GB5917@aemeltch-MOBL1> <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com> <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 8 Feb 2012, Ulisses Furquim wrote:

> Hi everybody,
>
> On Wed, Feb 8, 2012 at 7:32 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Andrei,
>>
>> On Wed, Feb 8, 2012 at 11:09 AM, Andrei Emeltchenko
>> <andrei.emeltchenko.news@gmail.com> wrote:
>>>
>>> I think this would be good to send as patch series so that people can
>>> comment. What comes to my mind is that the patch might be reduced if it
>>> does not change order of functions and defines like:
>>>

... <snip> ...

>>> those magic number does not look nice IMO and the code is not looking any
>>> better.
>>
>> In this aspect perhaps, but we don't need to take the code as it is,
>> but the point here is following the states defined by the spec and
>> that is IMO much better.

Right - the code as it stands now was ported quickly, and does not 
take in to account many of Andrei's upstream improvements.  I don't 
want to move backwards in terms of magic numbers, and there is some 
extra noise in there due to symbol names.  I need to address these 
issues before merging.

I'm also looking for ideas on how to do this as a patch series.  Since 
it takes a very different approach from the original code, it's hard 
to make meaningful, small patches that don't break functionality.  At 
some point there has to be a major switchover but there is a lot of 
room to split this up.

One approach is to add inactive code until everything is there, then 
have one commit that calls in to the new code instead of the old code. 
Then the old code can be removed.  I talked to Gustavo about that a 
while ago, and he preferred finding a different way.  Maybe an 
intermediate step is to put the state machine code in there, but call 
the existing frame handling functions in every state.


> I've taken a quick look last week at their code and indeed it looks
> better regarding following the states. In particular they track
> rx_state and tx_state and then decide what to do based on that and
> what happened. I like it because it's explicit about that instead of
> demanding us to reason a lot on what state we are and what we should
> do. I'm all for changing our ERTM to that so it'll be more
> maintainable.

That was the goal of the design.  It has worked well during in-house 
testing, and has been through several UPFs.


> Marcel mentioned the separation of L2CAP channel and socket. That is a
> work in progress by Andrei and judging by what you said, Marcel, you
> want that merged before we change ERTM, is that it?

Andrei and Marcel, let's figure out this order now.  It doesn't make 
sense for one of us to have a bunch of changes staged, only to have 
major merge/rebase conflicts when another far-reaching patch set gets 
merged.


> Mat, thanks a lot for doing this. I have just a few questions. Have
> you tested the stack with this patch? How was it? Quickly looking
> through the code I feel it's almost there. I agree with Andrei
> regarding constants and control field handling but apart from that it
> looks good, in general.

It's only lightly tested right now.  I can do incoming and outgoing 
connections, and send/receive.  It is unstable when disconnecting.  I 
have not tested with dropped frames yet.


> Regarding delayed work handling, are you sure about usage of
> __cancel_delayed_work()? I do think it's safer to use
> cancel_delayed_work() instead as it'll just spin on a lock if the
> timer to queue the work is running on another CPU.

This code is coming from a kernel that still had code running in 
tasklet context that couldn't block, and the delayed work handlers 
were written such that it was ok if the functions were called after 
cancel.  I will update to the safer cancel_delayed_work().


> I saw a comment about channel ref counting and kind of audit that
> would be great. It'd be good to see a patch for that after transition
> to new state handling.

The "do channel ref counting" comment is there because I saw that the 
existing ack/monitor/retrans timers do that.  I will fix this up 
before submitting.


Thanks for the feedback, everyone.  Please let me know if you have 
preferences for how to structure this patch set.  I'll work on the 
issues mentioned in this thread and start splitting up the changes.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

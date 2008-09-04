Return-Path: <cyrus@holtmann.org>
Message-ID: <48BFBBED.5010504@free.fr>
Date: Thu, 04 Sep 2008 12:43:57 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding Sony Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr> <1220471377.6714.52.camel@californication>
In-Reply-To: <1220471377.6714.52.camel@californication>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> 
> retest with 2.6.27-rc5 since that has full Simple Pairing support and is
> the kernel version that counts.

I'm gonna rebase on this one then.

> 
> Also this is not BlueZ screwing anything up. Where is written that we
> have to get out of sniff mode before we can disconnect a link. What kind
> of hardware are you using? Does BlueZ always have to cleanup after
> broken hardware and f*cked up stacks?

Lol :-)
I never said that Bluez was screwing up anything.
But as usual, there are compromises to make between sticking close to 
the standard and having good interoperability, which usually involves 
some level of workaround :-)

> 
>> Conclusion: to have those bloody Sony Erisson headsets working we have 
>> to change two things in the kernel:
>>   1) Provide a way for a L2CAP socket user to alter sniff mode exit 
>> behaviour
>>   2) Make sure we exit sniff mode before to disconnect
>>
>> Question 1: Are you interested in reviewing then merging my patches if i 
>> try to fix thoses issues ?
>> Question 2: I have the gut feeling that we should change default 
>> behaviour to the behaviour required by those headsets, and provide a 
>> socket option for the bluetooth HID, rather than the other way round. 
>> What do you think ?
>>
>> If we can come on an agreement on the proper way to fix this issue then 
>> i should come with a patch in a 3-4 days timeframe.
> 
> Make it two separate patches. We can send the exit sniff mode command
> that is not a problem. I still don't like it, because it is the job of
> the Link Manager to do this.

Will do.

You didn't answer to question 2: what's your choice ? (btw to question 1 
neither, but i guess that means a 'yes' :-)

> 
> For the sniff mode setting you have to use SOL_BLUETOOTH since I will
> remove all the other SOL_* and consolidate them.

hmmm... not sure i really see what you mean. :-(

Fabien

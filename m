Return-Path: <cyrus@holtmann.org>
Message-ID: <48BFFAE5.9040801@free.fr>
Date: Thu, 04 Sep 2008 17:12:37 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding Sony	Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr>	 <1220471377.6714.52.camel@californication>  <48BFBBED.5010504@free.fr> <1220536177.6714.68.camel@californication>
In-Reply-To: <1220536177.6714.68.camel@californication>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

>> I never said that Bluez was screwing up anything.
>> But as usual, there are compromises to make between sticking close to 
>> the standard and having good interoperability, which usually involves 
>> some level of workaround :-)
> 
> I am seriously sick of this f*cked up hardware. What is it? My guess
> would be a TI chip.

...and you won !!

> 
>>> Make it two separate patches. We can send the exit sniff mode command
>>> that is not a problem. I still don't like it, because it is the job of
>>> the Link Manager to do this.
>> Will do.
>>
>> You didn't answer to question 2: what's your choice ? (btw to question 1 
>> neither, but i guess that means a 'yes' :-)
> 
> I would first have to know which host controller it is, before I
> actually think about adding something like this.


I dug deeper in this second problem.
In fact it has not been solved by the 2.6.17-rc5 kernel.

I misinterpreted the result as i inadvertedly changed bluetooth dongle 
at the same time.
So issue with wrong pin code only arise whith Sony Erisson(TI) + ST + bluez.
Sony Erisson(TI) + BCM + bluez works.

As you said issue is clearly seems to come from the hardware (LMP).



> 
>>> For the sniff mode setting you have to use SOL_BLUETOOTH since I will
>>> remove all the other SOL_* and consolidate them.
>> hmmm... not sure i really see what you mean. :-(
> 
> Don't use SOL_L2CAP or SOL_RFCOMM anymore. They will be all
> SOL_BLUETOOTH since there are no different between the socket options
> itself.

Yeah sure but from the kernel point of view there is a a level parameter 
passed to setsockopt/getsockopt which is already ignored... or maybe you 
were just speeking about user space ?

Regards,

Fabien

Return-Path: <rene@soft.uni-linz.ac.at>
Message-ID: <3F952EC9.9000909@soft.uni-linz.ac.at>
Date: Tue, 21 Oct 2003 15:04:09 +0200
From: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
References: <3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r				ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.	1	73.camel@pegasus>			<3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>		 <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus>		<3F950E33.3070303@soft.uni-linz.ac.at> <1066735933.1005.114.camel@pegasus>	 <3F9521E4.8010900@soft.uni-linz.ac.at> <1066738444.13788.124.camel@pegasus>
In-Reply-To: <1066738444.13788.124.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
> it is ok that devices with active connections don't answer inquiry scans
I was expecting something like that, and it shouldn't be a problem since 
I have the pings anyway.

> and you need to use --flush with hcitool to disable the kernel side
> inquiry cache.
I didn't know the --flush, but I always executed hcitool scan multiple 
times until it really did a new scan (judging from the response time). 
--flush doesn't change the results.
I still find it a bit disturbing that I am unable to reproduce your 
results (two l2ping runs and an inquriy which returns results), maybe 
there is something wrong with my setup. I just loaded the appropriate 
modules, started hcid and did nothing to tweak it. If two l2ping 
invocations run and I start "hcitool scan --flush", then I get nothing back.
Update: On one invocation, I indeed got a third MAC address back (which 
is detected reliably when no l2ping is running), but only this one time....
The second l2ping also can not be started reliably when inquiries are 
continuously running (while true; do hcitool scan --flush; done). 
Sometimes (I've not found a way to reproduce it reliably), it fails with 
device or ressource busy.

>>PS: Is libbluetooth thread-safe ? Maybe that could be part of my problem 
>>with two l2ping sessions from two different threads in the same process ?
> 
> 
> I don't see any problems here, because you only use socket programming.
Me neither, just wanted to ask :)

best regards,
Rene


-- 
------------------------------------------------
Pervasive 2004:            www.pervasive2004.org
------------------------------------------------

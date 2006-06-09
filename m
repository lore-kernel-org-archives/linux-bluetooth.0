Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4489AA6C.7010300@free.fr>
Date: Fri, 09 Jun 2006 19:05:48 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447B4F98.8020501@free.fr>	<1148934839.31689.116.camel@localhost>
	<447C4862.5050205@free.fr>	<1149189300.28511.61.camel@localhost>
	<448733E2.7090602@free.fr> <1149712246.22472.56.camel@localhost>
In-Reply-To: <1149712246.22472.56.camel@localhost>
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

>>> Another question is if we really should queue the data in sk_write_queue
>>> and not directly in the core. I would prefer to send the data to the
>>> core and then stream it from there.
>> That's an interesting question... :-)
>> I asked it myself when i started to design this feature.
>> In fact having outgoing packets stored in a socket queue has some 
>> advantages:
>>    * it makes use of the BSD socket send queue, and thus can reuse some 
>> generic socket queue management related functions, which rely on some 
>> well known sk_buff variable (sk_sndbuff, sk_wmem_alloc, sk_rcvbuff, 
>> sk_rmem_alloc ...)
>>    * it makes the thing symetrical, both uplink and downlink path make 
>> use socket queues to buffer data.
>>
>> As such I thought there were not any valid reason to put in the core... 
>> however if you have suggestions i would be very happy to hear them. :-)
> 
> Actually I never thought about SCO as socket is the best interface. So
> we might wanna move away from it sometime in the future. And in this
> case it would be great if it uses simple SKB queues or maybe kfifo for
> it. Even if this sounds like more work right now, I might be worth it.

It might make sense: however we must take into account the following 
constraints:
   - we must be aple to setup fifo lengths from userspace, so that to 
simulate a variable size ring buffer as found on sound card hardware.
   - we must be able to put the sending task to sleep, and wake it up 
later, when the fifo gets 'full'.

I'm not against this, even if it means more work...
However i don't have any precise idea on which communication mechanism 
to use between userspace/kernelspace. Any ideas ??

> 
> Let's have another patch on top of 2.6.16-mh1 and maybe you also wanna
> adapt scotest for testing it.
> 
Ok, i'm gonna work on that then...

Cheers,

Fabien


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44CDD529.6030001@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
	<1153758912.25058.3.camel@localhost>
	<20060724203433.7184d301@localhost.localdomain>
	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
	<1153775541.25058.6.camel@localhost> <44C881B5.7060809@infitsrl.com>
	<1154085261.2298.34.camel@localhost>  <44CDD529.6030001@infitsrl.com>
Date: Mon, 31 Jul 2006 16:14:21 +0200
Message-Id: <1154355262.4982.2.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About l2cap patch to handle
	multiple	connections....
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

Hi Fabrizio,

> Hi I'm trying to play with the patch to make it work (as Marcel said it 
> hangs my machine).
> 
> First I'm trying a simple debug by printing to find where it hangs...
> 
> There is a first question about this: various BT_DBG statements that 
> print bluetooth address
> in string format (using batostr) print them in reverse 
> order(00:01:02.... is printed 02:01:00).
> My test machine is a powerpc based mac, I've used in user-space the 
> ba2str  without problems in same architecture
> so I'm confused about this.

this is normal. We don't bother to swap the address for the debug
messages. In Bluetooth the address is always used in the reversed order,
but for the human eyes it is swapped.

> An other dubt is about following log :
> 
> Jul 31 10:36:39 localhost kernel: [  596.604617] Bluetooth: 
> 00:00:00:00:00:00 -> 44:53:25:E3:01:00 psm 0x300
> Jul 31 10:36:39 localhost kernel: [  596.606752] Bluetooth: 
> 00:00:00:00:00:00 -> 20:68:2A:2D:09:00 psm 0x300
> (address are in reverse order as I said above)
> 
> Why psm is 0x300? May be also the psm in reverse order and really it's 
> 0x003 (RFCOMM) as I would have expected ?

This looks like a big endian bug. The PSM value is in little endian
order.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

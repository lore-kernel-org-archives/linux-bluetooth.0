Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Dec 2007 15:53:13 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000e01c843de$cabd8d80$0200a8c0@jester>
Message-ID: <Pine.LNX.4.63.0712211538040.8893@redbean.intranet.gw-instruments.de>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
	<Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
	<000801c84343$f6efce40$0200a8c0@jester>
	<003101c843ba$5d611280$0200a8c0@jester>
	<1198244391.8050.285.camel@aeonflux>
	<Pine.LNX.4.63.0712211442560.8893@redbean.intranet.gw-instruments.de>
	<000e01c843de$cabd8d80$0200a8c0@jester>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Olivier, 

> Thanks a lot for your explanations guys everything is clearer now.
> However, I can't understand the following behaviour : instead of starting 4 
> connections from the same hci device, I put 4 dongles and start 4 
> connections at the same time one per dongle.
> Here is what I get -dump below- (basically 2 "quick" connections, and 2 page 
> timeout). It can vary depending on attempts, but at least 1 page timeout.
That's probably because the "air" interface is also a shared resource. 
When multiple devices are paging at the same time you'll get collisons and 
corrupted data packages which may cause random page timeouts. 


> Do you think running the inquiry on hci0 (for example) would "save" the 
> clock offsets for connections on other dongles ? (I mean inquiry on hci0 
> then "connect" to the found device on hci1 to N) ?
No. The clock offset is only valid between any two devices.
A third device will allways run on its own internal clock. May be if you 
know the clock offset between, lets say HCI0 and HCI1 than it may be 
possible to calculate the clock offset between HCI1 and a third device if 
you know the clock offest between HCI0 and the third device. Never tried 
that. 

> Do you thing there is there another way to speed this up (e.g. doing a 
> request name to the remote device on the dongle where the connection will be 
> done) ?
No, all this stuff is handled in the baseband and not a BlueZ issue. 
A name request is more or less the same as a connection setup, that won't 
help. 

Ciao,

Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

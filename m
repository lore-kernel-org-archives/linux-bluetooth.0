Return-Path: <cyrus@holtmann.org>
Message-ID: <000d01c84408$7277a550$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
	<Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
	<000801c84343$f6efce40$0200a8c0@jester>
	<003101c843ba$5d611280$0200a8c0@jester>
	<1198244391.8050.285.camel@aeonflux>
	<Pine.LNX.4.63.0712211442560.8893@redbean.intranet.gw-instruments.de>
	<000e01c843de$cabd8d80$0200a8c0@jester>
	<Pine.LNX.4.63.0712211538040.8893@redbean.intranet.gw-instruments.de>
Date: Fri, 21 Dec 2007 20:34:04 +0100
MIME-Version: 1.0
Cc: Peter Wippich <pewi@gw-instruments.de>
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Peter,

> That's probably because the "air" interface is also a shared resource.
> When multiple devices are paging at the same time you'll get collisons and
> corrupted data packages which may cause random page timeouts.

Indeed, maybe will I try to put my dongles in a hub allowing a bit of 
distance between each other. Having them too close is maybe not a good idea. 
Using class 2 ones instead of class 1 may not be bad as well, I suppose the 
more powerful the more "air" problems. What's your opinion about all of this 
? Another point : have you ever had USB / power issues when using several 
dongles ? I was wondering if a lack of responsiveness of power supplying 
when more power is required for some operations could not cause troubles (I 
mean the delay between "I need more power" and "I get it"). If I'm talking 
nonsense don't hesitate to flame me.

Thanks a lot for your help, I think things start to be clearer to me !

Best regards,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

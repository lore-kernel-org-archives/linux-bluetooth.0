Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 4 Dec 2006 08:55:29 -0500
References: <200612011448.32667.akohlsmith-bluez@benshaw.com>
	<1165152757.19590.7.camel@localhost>
In-Reply-To: <1165152757.19590.7.camel@localhost>
MIME-Version: 1.0
Message-Id: <200612040855.29496.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-devel] "promiscuous mode" for hci devices?
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

On Sunday 03 December 2006 08:32, Marcel Holtmann wrote:
> a Bluetooth chip doesn't receive any packets that are not meant for it.
> You must understand that Bluetooth works totally different than for
> example Ethernet or Wireless LAN.

With all due respect, that simply cannot be true.  Any device in a shared 
medium would by its very nature have to receive all messages in order to 
determine whether a message was intended for it.

Ethernet compares the received frame's recipient MAC address to its own.  
Wifi's similar.  CAN and I2C do the same.  Hell, plain old ModBus does this 
over RS485, albeit in software.  If BT doesn't have a standard command to do 
this that's fine, and actually may have been intentionally removed as some 
kind of security measure.  It seems unlikely that it's impossible, though, 
and much like cellular phones, the method probably exists, but needs to be 
reverse-engineered.

That's a shame, since it'd make monitoring BT communications so much 
easier.  :-)

Has anyone experimented with a box with two BT devices in it in order to 
perform the equivalent man-in-the-middle type of monitoring?

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

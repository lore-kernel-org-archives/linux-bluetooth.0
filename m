Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E8B28499-36A8-493E-A680-2AA6126617BB@holtmann.org>
References: <1208950651.6611.167.camel@pancake>
	<1208956070.6611.173.camel@pancake>
	<E8B28499-36A8-493E-A680-2AA6126617BB@holtmann.org>
Date: Thu, 24 Apr 2008 14:03:54 +0200
Message-Id: <1209038634.6611.209.camel@pancake>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Question about hci_create_connection
	and	clock	offset
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

> > However, what I'm trying to do - repeating inquiries in one thread,
> > checking RSSI in another one (even for devices that haven't been  
> > seen by
> > the last inquiries) - doesn't seem possible in the D-Bus API, as there
> > is no function to create a low-level ACL connection to a device
> > address..?
> what do you expect from the RSSI value that you get from an active ACL  
> link. It is different from the RSSI value you get via inquiry anyway.
Well, that wouldn't matter, as I'm going to put all that into a wrapper
class anyway.

Maybe a word about what I'm trying to do - as you may have guessed
already, it's about proximity sensing. I've put a minimal Dbus interface
into my wrapper class and it's actually working quite nicely. However,
some of the devices which I'm working with - e.g., Motorola mobile
phones - have a hardcoded discoverable timeout of 3 minutes.

This makes things a bit more difficult for me, as these phones suddenly
vanish from the list which the Dbus interface is providing, even if they
are still in range. With the hci_* interface, I can simply try to open
an ACL connection and get the RSSI value to see if they are just
invisible. How do I do this with Dbus?

Thanks for your help,
Yours, Florian
-- 
0666 - Filemode of the Beast


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't understand
From: Marcel Holtmann <marcel@holtmann.org>
To: Hedin <andrewthegreat@mail.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405122046.02992.andrewthegreat@mail.ru>
References: <200405121820.59166.andrewthegreat@mail.ru>
	 <1084367829.25099.16.camel@pegasus>
	 <200405122046.02992.andrewthegreat@mail.ru>
Content-Type: text/plain
Message-Id: <1084382011.25099.69.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 19:13:31 +0200

Hi Hedin,

is it too hard to press the "Reply to All" button?

> > the bluez-bluefw was never ported to work on 2.6 systems. You can use
> > the bcm203x firmware loader driver instead. For some more information
> > take a look here http://www.bluez.org/drivers.html
> 
> Hm, I tried the bcm203x kernel module. Nothing changed at all. Any ideas?
> My dongle is not supported ?

My idea is that you start looking at the logfiles and dmesg for example
and see what it tells you. Saying that nothing changed isn't helpful. If
you think your dongle is not supported then show us the content of
/proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with kernel-2.6.5
From: Marcel Holtmann <marcel@holtmann.org>
To: tim@birdsnest.maths.tcd.ie
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
References: <200404210427.29406.tim@birdsnest.maths.tcd.ie>
Content-Type: text/plain
Message-Id: <1082550752.23959.34.camel@pegasus>
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
Date: Wed, 21 Apr 2004 14:32:32 +0200

Hi Timothy,

> I wonder if anyone has had a problem with Bluetooth in linux-2.6.5?
> I have a Sony C1VFK Picturebook with built-in bluetooth.
> Everything works fine in 2.6.3,
> buit when I go to 2.6.5 I get the oops below.
> I should say that this occurs after "service bluetooth restart" 
> and "spicctrl -l1" 
> (the latter being required to activate bluetooth on this machine).
> 
> It is possible that this has nothing to do with bluetooth,
> and is a USB problem.

give 2.6.6-rc2 a shot, because it includes the outstanding Bluetooth and
USB updates. If it still oopses report it on the USB mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

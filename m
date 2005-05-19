Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: William Pettersson <enigma@strudel-hound.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1116475358.32473.9.camel@delta>
Mime-Version: 1.0
Subject: [Bluez-users] Lost API? / Creating serial port connection
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 19 May 2005 14:02:38 +1000

Ok, I'm working on some Linux drivers to communicate to a Bar Code
scanner.  It works fine over a regular serial port.  Next task, use
Bluetooth.  I've just added a Bluetooth module to the bar code scanner,
and I can communicate with it perfectly fine by using 'hcitool scan' and
then 'rfcomm connect'.  I then note the serial port, and use that for
the bar code comms.  However, I wanted to add a GUI type interface to do
the discovery/connecting part.  Now I can do some simple system calls,
parsing input and output, but that's dodgy.

So what I wanted to do was basically, run a discovery/inquiry.  Find
some devices, their names, and possibly classes as well.  And then
establish a SPP connection to a device.

But I can't seem to find any sort of programming API for Bluez.  Am I
just being silly and looking in the wrong places?  I've checked the
header files, and they're very rudimentary.  I've done the same thing,
for the same bar code scanner, under PalmOS, and that was, whilst not
overty simple, not too convoluted.

So is there an API out there?
And is there a simple way to do what I want?

William



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

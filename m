Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Scott Gilliland <Scott.Gilliland@gatech.edu>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1141191114.22408.31.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] sound skips on i.tech a2dp headset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 01 Mar 2006 00:31:53 -0500

Hi all,

I've got the i.tech A2DP stereo headset clip-y thing. I've gotten a2play
working, but the sound skips every several seconds while playing. I
tried the -p flag, and that helped a whole lot, bringing the
time-between-skips up to over a minute, but it still happens, and it's
still annoying.

Looking at how things work, I get the idea that the sender just blasts
out data with no way to check on the buffer of the receiver. Could it
just be that the i.tech headset doesn't handle something right? Or is
this likely a timing issue on the computer? Should I just start tossing
in other numbers, like 43995 or 44005? Any other clues?

Further, if anyone is interested, an i.tech clip can be modified into
having a low-level output to something like an amp (in my case, my car
radio) with just a little bit of soldering. Further, since it uses
standard nokia chargers, you can hook it up to run off of 12v with a
nokia car charger (available at any quality computer show).


Thanks for any help,
Scott Gilliland
Scott Gilliland at gatech dot edu



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

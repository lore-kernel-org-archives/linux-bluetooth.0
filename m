Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <200405101325.18922.tim@birdsnest.maths.tcd.ie>
Content-Type: text/plain;
  charset="us-ascii"
Subject: [Bluez-users] Can only start Bluetooth once on my Sony Picturebook
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
Date: Mon, 10 May 2004 13:25:18 +0100

A little query which does not really matter,
but which leaves me slightly puzzled.

I'm running linux-2.6.6-rc2 under Fedora-1
on my Sony C1VFK Picturebook.
This has in-built Bluetooth.
To start this running, I say "spicctrl -l1"
(when the blue Bluetooth light on my laptop comes on)
followed by "service bluetooth restart".

All this works perfectly.
But if I give the command "spicctrl -l0"
to stop the inbuilt Bluetooth
I am never able to restart it,
except by re-booting.

I couldn't see from a very brief (and ignorant) look at the source
why the sonypi_ioctl() call couldn't be reversed.

Perhaps there is some command I could give
to restart Bluetooth, short of re-booting?

[IIRC, I could start and stop Bluetooth like this
in older kernels.]



-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45C7C6DF.20106@killesreiter.de>
Date: Tue, 06 Feb 2007 01:07:59 +0100
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] headset /SCO / plugz
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi there!

Since I never got to work my headset with the old btsco method I decided 
to try the new plugz method. However that method isn't well documented 
and everything I found through google referred to the old method.

What I have:

1) usb bluetooth dongle (CSR chip):
Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)

2) bluetooth headset:         00:0D:44:2F:CC:A3       Logitech HS02-V07

3) I've found the install instructions! 
http://bluetooth-alsa.sourceforge.net/build.html

4) I've built and installed sbc and plugz.

5) I am running Kernel 2.6.19.2 with the patch from plugz applied (also 
suspend2) on Debian etch.

6) now what? a2dpd doesn't show up in my output choices in xmms, 
"headset" shows up as a choice for the mixer device, but not the general 
output device.

I am pretty sure I am missing something obvious, but what?

Cheers,
	Gerhard

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

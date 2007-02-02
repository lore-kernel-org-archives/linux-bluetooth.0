Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45C387D6.5040603@felton.felton.ca.us>
Date: Fri, 02 Feb 2007 10:49:58 -0800
From: Robert Lewis <rll@felton.felton.ca.us>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Blue tooth headset
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

I have a bluetooth headset with microphone.
It works fine on XP.  I have bluetooth turned
on the YaST hardware control panel.

lsusb shows:
Bus 004 Device 002: ID 0b7a:0100 Zeevo, Inc.

I am on SUSE 10.2  with kernel 2.6.18.2-34-default

Previous releases of SUSE did not recognize the
above USB bluetooth dongle.  However, I now  see
Bluetooth Audio Dongle   show up in both Skype
devices and in Kmix via ALSA.

However, even though the headset sync's up with
the dongle I don't get any audio.  Skype reports:
Problem with sound device.

hcitool scan        (reports)
Device is not available: No such device

Any suggestions on how to get this working?

Cheers,
Bob



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

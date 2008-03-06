Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: TD <topper.doggle@googlemail.com>
Date: Thu, 6 Mar 2008 00:59:00 +0000 (UTC)
Message-ID: <fqnfkk$9np$1@ger.gmane.org>
Subject: [Bluez-users] Can't get headset to pair
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Trying to get a bluetooth headset (http://www.ebuyer.com/product/123000) to
work with bluez, so that I can access it from alsa.  Running Debian lenny
(2.6.22 kernel), bluez 3.24.

With the headset in pairing mode:
laptop:~# hcitool scan
Scanning ...
	00:02:5B:02:64:9D	VBH-006
laptop:~# hcitool cc 00:02:5B:02:64:9D
laptop:~#

System log reports:
Mar  6 00:44:19 laptop NetworkManager: <debug> [1204764259.628237]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_25b02649d'). 
Mar  6 00:44:22 laptop NetworkManager: <debug> [1204764262.493448]
nm_hal_device_removed(): Device removed (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_25b02649d').

The light on the hands-free doesn't start to flash, indicating that pairing
didn't take place.  My /etc/bluetooth/hcid.conf contains:
pin_helper /etc/bluetooth/feed-pin.sh;

and /etc/bluetooth/feed-pin.sh contains:
#!/bin/sh
echo "PIN:0000"

which runs fine as a shell script.

My normal user .asoundrc contains:
pcm.bluetooth {
   type bluetooth
   device 00:02:5B:02:64:9D
}

Have I missed something?  Do I need to pair the device before it will work?

TD


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

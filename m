Return-Path: <cyrus@holtmann.org>
References: <courier.479F910B.00002E18@softhome.net>
	<20080129210226.GV5671@cathedrallabs.org>
	<courier.479FA02D.0000617F@softhome.net>
	<20080129221236.GW5671@cathedrallabs.org>
In-Reply-To: <20080129221236.GW5671@cathedrallabs.org> 
From: iemai@softhome.net
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 29 Jan 2008 16:17:27 -0700
Mime-Version: 1.0
Message-ID: <courier.479FB407.0000262B@softhome.net>
Subject: Re: [Bluez-devel] PS3Remote patches
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

Aristeu Rozanski writes: 

> check if bluetoothd-service-input/hcid are running, they may be the old copy.
> also, by default it'll be installed in /usr/local/...
> Is uinput module loaded? is there anything on logs perhaps? 
> 
> -- 
> Aristeu
let's see:
# ps ax|grep hcid
4704 ?        Ss     0:00 /usr/sbin/hcid -x -s
5323 pts/1    R+     0:00 grep hcid
it seems is running.
Right after I compiled the utils I restarted bluetooth service and had no 
errors.
But now I tried to first stop it:
# /etc/init.d/bluetooth stop
Stopping bluetooth: rfcomm hid_devicesSwitching device 0a12:0001 to HID mode 
failed (Broken pipe)
hidd hcid.
then tried to start:
# /etc/init.d/bluetooth start
Starting bluetooth: hcid hidd hid_devicesNo devices in HCI mode found
rfcomm. 

I think I broke something...
Here is some syslog
 -This is when I attach the usb dongle:
Jan 30 00:04:03 soulmate kernel: usb 3-1: new full speed USB device using 
uhci_hcd and address 3
Jan 30 00:04:03 soulmate kernel: usb 3-1: configuration #1 chosen from 1 
choice
Jan 30 00:04:03 soulmate hcid[3291]: HCI dev 0 registered
Jan 30 00:04:03 soulmate hcid[3291]: HCI dev 0 up
Jan 30 00:04:03 soulmate hcid[3291]: Device hci0 has been added
Jan 30 00:04:03 soulmate hcid[3291]: Starting security manager 0
Jan 30 00:04:03 soulmate hcid[3291]: Device hci0 has been activated
 -press a button on the remote:
Jan 30 00:07:40 soulmate hidd[3295]: New HID device XX:XX:XX:XX:XX:XX (Sony 
Computer Entertainment Inc BD Remote Control)
Jan 30 00:07:40 soulmate kernel: input: Sony Computer Entertainment Inc BD 
Remote Control as /class/input/input6
 -tried to stop the service:
an 30 00:10:06 soulmate hidd[3295]: Exit
Jan 30 00:10:06 soulmate hcid[3291]: Stopping SDP server
Jan 30 00:10:06 soulmate hcid[3291]: Unregister path: /org/bluez/hci0
Jan 30 00:10:06 soulmate hcid[3291]: Unregister path: /org/bluez
Jan 30 00:10:06 soulmate hcid[3291]: Shutting down local server
Jan 30 00:10:06 soulmate hcid[3291]: Exit
 -tried to start the service:
Jan 30 00:12:04 soulmate hcid[3856]: Bluetooth HCI daemon
Jan 30 00:12:04 soulmate hcid[3856]: HCI dev 0 registered
Jan 30 00:12:04 soulmate hcid[3856]: HCI dev 0 already up
Jan 30 00:12:04 soulmate hcid[3856]: Device hci0 has been added
Jan 30 00:12:04 soulmate hidd[3860]: Bluetooth HID daemon
Jan 30 00:12:04 soulmate hcid[3856]: Starting security manager 0
Jan 30 00:12:04 soulmate hcid[3856]: Device hci0 has been activated
Jan 30 00:12:04 soulmate hcid[3856]: Starting SDP server
Jan 30 00:12:04 soulmate hcid[3856]: Created local server at 
unix:abstract=/var/run/dbus-DmTOlqsMvO,guid=fd5b47e83850bf415914b64e479fb2c4 

-- 
Ciao, Emiliano. 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

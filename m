Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez+2.6+Logitech bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Di Pietro Nicolas <potens@swing.be>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084826611.10503.23.camel@darthvader.linuxkot.kap>
References: <20040515163903.CB06543F94@rekin8.go2.pl>
	 <20040516081059.46f1904b@bluez.bueche.ch> <1084708456.4184.0.camel@pegasus>
	 <1084826611.10503.23.camel@darthvader.linuxkot.kap>
Content-Type: text/plain
Message-Id: <1084835041.5833.40.camel@pegasus>
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
Date: Tue, 18 May 2004 01:04:01 +0200

Hi Nicolas,

> Just to say to you that, I've tried the new hidd and hidp modules
> (from a patched against patch-2.6.6-mh1 2.6.6 kernel)
> but it change a few (the only thing that has changed is when I halt
> or reboot the computer after have done hid2hci, there is no more
> Ooops when stopping usb
> 
> darthvader root # hidd
> Can't open HIDP control socket: Address family not supported by protocol

this shouldn't happen, because the kernel knows which module it has to
load.

> darthvader root # hidd --server
> darthvader root # May 17 22:33:48 darthvader hidd[14177]: Bluetooth HID
> daemon
> darthvader root #
> darthvader root # lsmod
> 
> hidp                   24000  0
> l2cap                  20676  1 hidp
> bluetooth              41124  2 hidp,l2cap

This is problematic, because after the start of hidd, the hidp must hold
a reference count of 2. Check the syslog for any errors.

> darthvader root # hid2hci
> Switching device 046d:c704 to HCI mode was successful
> darthvader root # May 17 22:26:22 darthvader usb 2-2.2: new full speed
> USB device using address 5

At this point hciconfig should report your device.

> darthvader bluetooth # lsusb
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 005: ID 046d:c707 Logitech, Inc.
> Bus 002 Device 004: ID 046d:c704 Logitech, Inc.
> Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
> Bus 002 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000

The Bluetooth dongle hasn't changed from HID mode to HCI mode.

> PS:Thank a lot for the bluez stack under Linux...
>   :Is it something right tha when I switch to hci the blue button on   
>    the bt hub doesn't work anymore ??? Until I disconnect the hub and 
>    reboot the computer

How should it work if you are in HCI mode ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez+2.6+Logitech bluetooth
From: Di Pietro Nicolas <potens@swing.be>
To: bluez <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084708456.4184.0.camel@pegasus>
References: <20040515163903.CB06543F94@rekin8.go2.pl>
	 <20040516081059.46f1904b@bluez.bueche.ch> <1084708456.4184.0.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1084826611.10503.23.camel@darthvader.linuxkot.kap>
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
Date: Mon, 17 May 2004 22:43:31 +0200

Le dim 16/05/2004 =E0 13:54, Marcel Holtmann a =E9crit :=20
> Hi Charles,
>=20
> > you may want to try my cookbook at
> > http://www.bueche.ch/comp/mx900/mx900.html
>=20
> maybe you wanna play with the new hidd from bluez-utils-2.7 and the hidp
> kernel module from patch-2.6.6-mh1 ;)
>=20
> Regards
>=20
> Marcel

Hi all,
Just to say to you that, I've tried the new hidd and hidp modules
(from a patched against patch-2.6.6-mh1 2.6.6 kernel)
but it change a few (the only thing that has changed is when I halt
or reboot the computer after have done hid2hci, there is no more
Ooops when stopping usb

darthvader root # hidd
Can't open HIDP control socket: Address family not supported by protocol
darthvader root # modprobe hidp
darthvader root # May 17 22:19:41 darthvader Bluetooth: Core ver 2.4
May 17 22:19:41 darthvader NET: Registered protocol family 31
May 17 22:19:41 darthvader Bluetooth: HCI device and connection manager
initialized
May 17 22:19:41 darthvader Bluetooth: HCI socket layer initialized
May 17 22:19:41 darthvader Bluetooth: L2CAP ver 2.1
May 17 22:19:41 darthvader Bluetooth: L2CAP socket layer initialized
May 17 22:19:41 darthvader Bluetooth: HIDP (Human Interface Emulation)
ver 0.1
=20
darthvader root # hidd --server
darthvader root # May 17 22:33:48 darthvader hidd[14177]: Bluetooth HID
daemon
darthvader root #
darthvader root # lsmod

hidp                   24000  0
l2cap                  20676  1 hidp
bluetooth              41124  2 hidp,l2cap
nvidia               2074376  12
(...) net modules
usbhid                 29952  0
ohci1394               30532  0
ieee1394              293688  2 eth1394,ohci1394
snd_intel8x0           29060  0
snd_mpu401_uart         6144  1 snd_intel8x0
ehci_hcd               24324  0
ohci_hcd               16644  0
evdev                   7360  0
(...) sound modules
usbcore                91932  5 usbhid,ehci_hcd,ohci_hcd
processor              13872  0
fan                     2828  0
button                  4760  0

darthvader root # hid2hci
Switching device 046d:c704 to HCI mode was successful
darthvader root # May 17 22:26:22 darthvader usb 2-2.2: new full speed
USB device using address 5

<I switch to another keyboard>
darthvader root # lsmod
Module                  Size  Used by
hci_usb                11456  0
hidp                   24000  0
l2cap                  20676  1 hidp
bluetooth              41124  2 hidp,l2cap
nvidia               2074376  12

usbhid                 29952  0
ohci1394               30532  0
ieee1394              293688  2 eth1394,ohci1394
snd_intel8x0           29060  0
snd_mpu401_uart         6144  1 snd_intel8x0
ehci_hcd               24324  0
ohci_hcd               16644  0
evdev                   7360  0
(...)
soundcore               7456  3 snd
usbcore                91932  5 usbhid,ehci_hcd,ohci_hcd
processor              13872  0
fan                     2828  0
button                  4760  0

darthvader bluetooth # lsusb
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 005: ID 046d:c707 Logitech, Inc.
Bus 002 Device 004: ID 046d:c704 Logitech, Inc.
Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
Bus 002 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


darthvader bluetooth # hcitool hci0 up
darthvader bluetooth # hidd -i hci0
darthvader bluetooth # hidd --search
Searching ...
darthvader bluetooth #
darthvader bluetooth # hidd --show
darthvader bluetooth # hcitool dev
Devices:
darthvader bluetooth # hcitool scan
Device is not available: Success
darthvader bluetooth #

Don't know what to do now... :'(
Any idea ??? Suggestions ?
It seems that the new hidp is not used...
Thanks in advance
Nicolas

PS:Thank a lot for the bluez stack under Linux...
  :Is it something right tha when I switch to hci the blue button on  =20
   the bt hub doesn't work anymore ??? Until I disconnect the hub and=20
   reboot the computer












-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

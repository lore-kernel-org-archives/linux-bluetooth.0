Return-Path: <potens@swing.be>
Subject: Re: [Bluez-users] Bluez+2.6+Logitech bluetooth
From: Di Pietro Nicolas <potens@swing.be>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084835041.5833.40.camel@pegasus>
References: <20040515163903.CB06543F94@rekin8.go2.pl>
	 <20040516081059.46f1904b@bluez.bueche.ch> <1084708456.4184.0.camel@pegasus>
	 <1084826611.10503.23.camel@darthvader.linuxkot.kap>
	 <1084835041.5833.40.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1084899186.10618.16.camel@darthvader.linuxkot.kap>
Mime-Version: 1.0
Date: Tue, 18 May 2004 18:53:06 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Le mar 18/05/2004 =E0 01:04, Marcel Holtmann a =E9crit :
> Hi Nicolas,
>=20
> > Just to say to you that, I've tried the new hidd and hidp modules
> > (from a patched against patch-2.6.6-mh1 2.6.6 kernel)
> > but it change a few (the only thing that has changed is when I halt
> > or reboot the computer after have done hid2hci, there is no more
> > Ooops when stopping usb
> >=20
> > darthvader root # hidd
> > Can't open HIDP control socket: Address family not supported by protoco=
l
>=20
> this shouldn't happen, because the kernel knows which module it has to
> load.

huuu ? What have I to do with the kernel then ?

> > darthvader root # hidd --server
> > darthvader root # May 17 22:33:48 darthvader hidd[14177]: Bluetooth HID
> > daemon
> > darthvader root #
> > darthvader root # lsmod
> >=20
> > hidp                   24000  0
> > l2cap                  20676  1 hidp
> > bluetooth              41124  2 hidp,l2cap
>=20
> This is problematic, because after the start of hidd, the hidp must hold
> a reference count of 2. Check the syslog for any errors.

It was what I tougth, it's the reason why I've put the output of my
lsmod.
I've included all the output of my kernel messages (I've done a=20
"tail -f /var/log/messages &" before begining)

> > darthvader root # hid2hci
> > Switching device 046d:c704 to HCI mode was successful
> > darthvader root # May 17 22:26:22 darthvader usb 2-2.2: new full speed
> > USB device using address 5
>=20
> At this point hciconfig should report your device.
>=20
> > darthvader bluetooth # lsusb
> > Bus 003 Device 001: ID 0000:0000
> > Bus 002 Device 005: ID 046d:c707 Logitech, Inc.
> > Bus 002 Device 004: ID 046d:c704 Logitech, Inc.
> > Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
> > Bus 002 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
> > Bus 002 Device 001: ID 0000:0000
> > Bus 001 Device 001: ID 0000:0000
>=20
> The Bluetooth dongle hasn't changed from HID mode to HCI mode.
>=20
What's this "Bus 002 Device 005: ID 046d:c707 Logitech, Inc." mean ?=20
I tought that is I got a new usb device, it was good
nic@darthvader nic $ /usr/sbin/lsusb
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 003: ID 046d:c704 Logitech, Inc.
Bus 002 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

> > PS:Thank a lot for the bluez stack under Linux...
> >   :Is it something right tha when I switch to hci the blue button on  =20
> >    the bt hub doesn't work anymore ??? Until I disconnect the hub and=20
> >    reboot the computer
>=20
> How should it work if you are in HCI mode ;)
I'm trying to get it :-D

Cheers and thank you for your answer
Nicolas

Return-Path: <cyrus@holtmann.org>
Message-ID: <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
Date: Sat, 22 Mar 2008 08:29:43 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Odysseus Flappington" <deriziotis@gmail.com>
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Cc: marcel@holtmann.org, "BlueZ users" <bluez-users@lists.sourceforge.net>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	 <a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com>
	 <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	 <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	 <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	 <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	 <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
	 <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 21, 2008 at 1:19 AM, Odysseus Flappington
<deriziotis@gmail.com> wrote:
> Hi Marcel, Dave,
>
> I've been looking around to see if I could figure out the build id where the
> dongles started shipping with the correct HCI_Reset. I think I may have
> found something.

Thanks a lot.

Marcel, I think it's what you want.  I would like to file a patch.

>
> http://www.csr.com/ contains the docs regarding the release of the CSR
> firmware and the specs that each adhere's to. Looking at the following HCI
> overall Implementation doc, I think we can find the relevant build id:
>
> https://www.csrsupport.com/document.php?did=141
>
> Firstly, i found confirmation that the problem has been solved in
> HCIStack1.1v12.x:
>
> "In builds before HCIStack1.1v12.x, the HCI Reset command rebooted the
> BlueCore device. This implied the host
>  transport was reset. This was a consequence of the way the firmware team
> understood an early version of the
> Bluetooth specification (probably 0.7).
>
> Rebooting the BlueCore device is incorrect behaviour. Version 1.1 [BT] now
> makes it clear that the Reset
>  command must reinitialise radio, LC, LM and HCI state, but leave the host
> transport in place. Builds since
> HCIStack1.1v12.x obey [BT]."
>
> So this should be fixed in HCIStack1.1v12.x, the doc outlines the build ids
> for each version of of the stack, here is the build id for HCIStack1.1v12.1:
>
> BuildID (hex)   BuildID (decimal)    Build Name
> 0x0077               119             HCIStack1.1v12.1
>
> So, if I'm reading this correctly, you should issue the reset for all
> CSR-based dongles with build id > 118.
>
> Am I on the right track here? Does this information look accurate to you
> guys?
>
> If there's anything else I can to do re this issue, please let feel free to
> ask me.
>
> Many thanks,
> Alex (Jackflap)
>
>
>
>
>
> On 18/03/2008, Dave Young <hidave.darkstar@gmail.com> wrote:
> > On Mon, Mar 17, 2008 at 8:28 PM, Odysseus Flappington
> >
> > <deriziotis@gmail.com> wrote:
> > > Hi Dave,
> > >
> >
> > > So I got around to recompiling my kernel this weekend, and ran off a
> test on
> > > the patch attached and it worked like a charm.
> > >
> > > I have to wonder though why the line was commented out in the first
> place.
> > > Could it be because internal adapters don't need the line?
> > >
> > > Anyway, I'd love to see this fixed in future kernels. If there's
> anything
> > > else I can do to help test, let me know. Now that I've got my head
> around
> > > recompiling kernels again, I can probably turn around tests a lot
> faster.
> >
> >
> > Hi thanks
> >
> > About the reset issue, I get some response from marcel about reset csr
> dongles
> > -------- Marcel said :
> > this is a clear NAK since you gonna break all old CSR based dongles.
> > Within the Bluetooth 1.0b and 1.1 specification there was an issues
> > with if HCI_Reset should only reset the Bluetooth internals or also
> > the transport. So issuing HCI_Reset on an old dongle will cause an USB
> > reset.
> >
> > The solution is to find the build id when CSR produced correct
> > firmware and set the HCI_RESET quirk based on that. I meant to do this
> > for a long time, but so far never got around to inquiry the correct
> > build id where this got fixed.
> > --------
> >
> > But I think it's hard to find that build id, so ...
> >
> > Regards
> >
> > dave
> >
> >
> > >
> > > Many thanks,
> > >
> > >
> > > Alex
> > >
> > > On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> > > > Ok,
> > > >
> > > > I passed reset=1 to hci_usb by adding the following line to
> > > > /etc/modprobe.d/options:
> > > >
> > > > options hci_usb reset=1
> > > >
> > > > and that's fixed the problem!
> > > >
> > > > Wasn't sure about my lsusb output, didn't seem to show very much, so
> > > > here's my lsusb -v output for my bluetooth device:
> > > >
> > > > Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> > > > Bluetooth Dongle (HCI mode)
> > > > Device Descriptor:
> > > >   bLength                18
> > > >   bDescriptorType         1
> > > >   bcdUSB               2.00
> > > >   bDeviceClass          224 Wireless
> > > >   bDeviceSubClass         1 Radio Frequency
> > > >   bDeviceProtocol         1 Bluetooth
> > > >   bMaxPacketSize0        64
> > > >   idVendor           0x0a12 Cambridge Silicon Radio, Ltd
> > > >   idProduct          0x0001 Bluetooth Dongle (HCI mode)
> > > >   bcdDevice           31.64
> > > >   iManufacturer           0
> > > >   iProduct                0
> > > >   iSerial                 0
> > > >   bNumConfigurations      1
> > > >   Configuration Descriptor:
> > > >     bLength                 9
> > > >     bDescriptorType         2
> > > >     wTotalLength          177
> > > >     bNumInterfaces          2
> > > >     bConfigurationValue     1
> > > >     iConfiguration          0
> > > >     bmAttributes         0xc0
> > > >       Self Powered
> > > >     MaxPower                0mA
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        0
> > > >       bAlternateSetting       0
> > > >       bNumEndpoints           3
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x81  EP 1 IN
> > > >         bmAttributes            3
> > > >           Transfer Type            Interrupt
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0010  1x 16 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x02  EP 2 OUT
> > > >         bmAttributes            2
> > > >           Transfer Type            Bulk
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0040  1x 64 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x82  EP 2 IN
> > > >         bmAttributes            2
> > > >           Transfer Type            Bulk
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0040  1x 64 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       0
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0000  1x 0 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0000  1x 0 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       1
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0009  1x 9 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0009  1x 9 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       2
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0011  1x 17 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0011  1x 17 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       3
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0019  1x 25 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0019  1x 25 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       4
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0021  1x 33 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0021  1x 33 bytes
> > > >         bInterval               1
> > > >     Interface Descriptor:
> > > >       bLength                 9
> > > >       bDescriptorType         4
> > > >       bInterfaceNumber        1
> > > >       bAlternateSetting       5
> > > >       bNumEndpoints           2
> > > >       bInterfaceClass       224 Wireless
> > > >       bInterfaceSubClass      1 Radio Frequency
> > > >       bInterfaceProtocol      1 Bluetooth
> > > >       iInterface              0
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x03  EP 3 OUT
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0031  1x 49 bytes
> > > >         bInterval               1
> > > >       Endpoint Descriptor:
> > > >         bLength                 7
> > > >         bDescriptorType         5
> > > >         bEndpointAddress     0x83  EP 3 IN
> > > >         bmAttributes            1
> > > >           Transfer Type            Isochronous
> > > >           Synch Type               None
> > > >           Usage Type               Data
> > > >         wMaxPacketSize     0x0031  1x 49 bytes
> > > >         bInterval               1
> > > > Device Status:     0x0001
> > > >   Self Powered
> > > >
> > > > Thanks,
> > > > Alex
> > > >
> > > >
> > > >
> > > >
> > > > On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> > > > > Hi Dave,
> > > > >
> > > > >  Thanks for the help. I can probably get a recompile of my kernel
> done
> > > > >  by the end of the weekend, maybe end of week, if it'll help.
> > > > >
> > > > >  In the meantime, I'll try loading the bluetooth module with reset=1
> > > > >  and get the lsusb output to you tonight when I get home from work.
> > > > >
> > > > >  Thanks,
> > > > >  Alex (Jackflap)
> > > > >
> > > > >
> > > > >  On 03/03/2008, Dave Young <hidave.darkstar@gmail.com> wrote:
> > > > >  > On Mon, Mar 3, 2008 at 9:21 AM, Dave Young
> > > <hidave.darkstar@gmail.com> wrote:
> > > > >  >  > On Fri, Feb 29, 2008 at 6:51 AM, Odysseus Flappington
> > > > >  >  >  <deriziotis@gmail.com> wrote:
> > > > >  >  >
> > > > >  >  >
> > > > >  >  > > So, it turns out that in order for any external usb
> bluetooth
> > > adapters
> > > > >  >  >  >  to re-connect to paired input devices on reboot, you need
> to
> > > issue an
> > > > >  >  >  >  'hciconfig hci0 reset' command after rebooting in order to
> > > reconnect.
> > > > >  >  >  >
> > > > >  >  >  >  More info can be found in bug #133690 on Launchpad
> > > > >  >  >  >
> > > (https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690).
> > > > >  >  >  >
> > > > >  >  >  >  This bug isn't Ubuntu-specific since I have reproduced in
> > > Fedora 8, so
> > > > >  >  >  >  I'm posting here.
> > > > >  >  >  >
> > > > >  >  >  >  Simply adding 'hciconfig hci0 reset' in
> /etc/default/bluetooth
> > > in
> > > > >  >  >  >  source would solve this bug. Is this a reasonable
> solution?
> > > > >  >  >  >
> > > > >  >  >  >  What is required in order to get a fix implemented?
> > > > >  >
> > > > >  >
> > > > >  > Sorry for previous blank reply.
> > > > >  >
> > > > >  >  For your problem, if you don't want to patch kernel you can also
> try
> > > > >  >  load the bluetooth module with parameter "reset=1"
> > > > >  >
> > > > >  >  Could you send the lsusb output?
> > > > >  >
> > > > >  >  Regards
> > > > >  >
> > > > >  > dave
> > > > >  >
> > > > >  >
> > > > >  >
> > >
> -------------------------------------------------------------------------
> > > > >  >  This SF.net email is sponsored by: Microsoft
> > > > >  >  Defy all challenges. Microsoft(R) Visual Studio 2008.
> > > > >  >  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > > > >  >  _______________________________________________
> > > > >  >  Bluez-users mailing list
> > > > >  >  Bluez-users@lists.sourceforge.net
> > > > >  >  https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > > >  >
> > > > >
> > > >
> > >
> > >
> >
>
>

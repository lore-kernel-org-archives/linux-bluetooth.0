Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
Date: Thu, 20 Mar 2008 17:19:22 +0000
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: marcel@holtmann.org
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Cc: "Dave Young" <hidave.darkstar@gmail.com>,
	"BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1911_350025.1206033563022"
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	 <a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com>
	 <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	 <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	 <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	 <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	 <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

------=_Part_1911_350025.1206033563022
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel, Dave,

I've been looking around to see if I could figure out the build id where the
dongles started shipping with the correct HCI_Reset. I think I may have
found something.

http://www.csr.com/ contains the docs regarding the release of the CSR
firmware and the specs that each adhere's to. Looking at the following HCI
overall Implementation doc, I think we can find the relevant build id:

https://www.csrsupport.com/document.php?did=141

Firstly, i found confirmation that the problem has been solved in
HCIStack1.1v12.x:

"In builds before HCIStack1.1v12.x, the HCI Reset command rebooted the
BlueCore device. This implied the host
transport was reset. This was a consequence of the way the firmware team
understood an early version of the
Bluetooth specification (probably 0.7).

Rebooting the BlueCore device is incorrect behaviour. Version 1.1 [BT] now
makes it clear that the Reset
command must reinitialise radio, LC, LM and HCI state, but leave the host
transport in place. Builds since
HCIStack1.1v12.x obey [BT]."

So this should be fixed in HCIStack1.1v12.x, the doc outlines the build ids
for each version of of the stack, here is the build id for HCIStack1.1v12.1:

BuildID (hex)   BuildID (decimal)    Build Name
0x0077               119             HCIStack1.1v12.1

So, if I'm reading this correctly, you should issue the reset for all
CSR-based dongles with build id > 118.

Am I on the right track here? Does this information look accurate to you
guys?

If there's anything else I can to do re this issue, please let feel free to
ask me.

Many thanks,
Alex (Jackflap)



On 18/03/2008, Dave Young <hidave.darkstar@gmail.com> wrote:
>
> On Mon, Mar 17, 2008 at 8:28 PM, Odysseus Flappington
>
> <deriziotis@gmail.com> wrote:
> > Hi Dave,
> >
>
> > So I got around to recompiling my kernel this weekend, and ran off a
> test on
> > the patch attached and it worked like a charm.
> >
> > I have to wonder though why the line was commented out in the first
> place.
> > Could it be because internal adapters don't need the line?
> >
> > Anyway, I'd love to see this fixed in future kernels. If there's
> anything
> > else I can do to help test, let me know. Now that I've got my head
> around
> > recompiling kernels again, I can probably turn around tests a lot
> faster.
>
>
> Hi thanks
>
> About the reset issue, I get some response from marcel about reset csr
> dongles
> -------- Marcel said :
> this is a clear NAK since you gonna break all old CSR based dongles.
> Within the Bluetooth 1.0b and 1.1 specification there was an issues
> with if HCI_Reset should only reset the Bluetooth internals or also
> the transport. So issuing HCI_Reset on an old dongle will cause an USB
> reset.
>
> The solution is to find the build id when CSR produced correct
> firmware and set the HCI_RESET quirk based on that. I meant to do this
> for a long time, but so far never got around to inquiry the correct
> build id where this got fixed.
> --------
>
> But I think it's hard to find that build id, so ...
>
> Regards
>
> dave
>
>
> >
> > Many thanks,
> >
> >
> > Alex
> >
> > On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> > > Ok,
> > >
> > > I passed reset=1 to hci_usb by adding the following line to
> > > /etc/modprobe.d/options:
> > >
> > > options hci_usb reset=1
> > >
> > > and that's fixed the problem!
> > >
> > > Wasn't sure about my lsusb output, didn't seem to show very much, so
> > > here's my lsusb -v output for my bluetooth device:
> > >
> > > Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> > > Bluetooth Dongle (HCI mode)
> > > Device Descriptor:
> > >   bLength                18
> > >   bDescriptorType         1
> > >   bcdUSB               2.00
> > >   bDeviceClass          224 Wireless
> > >   bDeviceSubClass         1 Radio Frequency
> > >   bDeviceProtocol         1 Bluetooth
> > >   bMaxPacketSize0        64
> > >   idVendor           0x0a12 Cambridge Silicon Radio, Ltd
> > >   idProduct          0x0001 Bluetooth Dongle (HCI mode)
> > >   bcdDevice           31.64
> > >   iManufacturer           0
> > >   iProduct                0
> > >   iSerial                 0
> > >   bNumConfigurations      1
> > >   Configuration Descriptor:
> > >     bLength                 9
> > >     bDescriptorType         2
> > >     wTotalLength          177
> > >     bNumInterfaces          2
> > >     bConfigurationValue     1
> > >     iConfiguration          0
> > >     bmAttributes         0xc0
> > >       Self Powered
> > >     MaxPower                0mA
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        0
> > >       bAlternateSetting       0
> > >       bNumEndpoints           3
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x81  EP 1 IN
> > >         bmAttributes            3
> > >           Transfer Type            Interrupt
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0010  1x 16 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x02  EP 2 OUT
> > >         bmAttributes            2
> > >           Transfer Type            Bulk
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0040  1x 64 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x82  EP 2 IN
> > >         bmAttributes            2
> > >           Transfer Type            Bulk
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0040  1x 64 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       0
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0000  1x 0 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0000  1x 0 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       1
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0009  1x 9 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0009  1x 9 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       2
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0011  1x 17 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0011  1x 17 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       3
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0019  1x 25 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0019  1x 25 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       4
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0021  1x 33 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0021  1x 33 bytes
> > >         bInterval               1
> > >     Interface Descriptor:
> > >       bLength                 9
> > >       bDescriptorType         4
> > >       bInterfaceNumber        1
> > >       bAlternateSetting       5
> > >       bNumEndpoints           2
> > >       bInterfaceClass       224 Wireless
> > >       bInterfaceSubClass      1 Radio Frequency
> > >       bInterfaceProtocol      1 Bluetooth
> > >       iInterface              0
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x03  EP 3 OUT
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0031  1x 49 bytes
> > >         bInterval               1
> > >       Endpoint Descriptor:
> > >         bLength                 7
> > >         bDescriptorType         5
> > >         bEndpointAddress     0x83  EP 3 IN
> > >         bmAttributes            1
> > >           Transfer Type            Isochronous
> > >           Synch Type               None
> > >           Usage Type               Data
> > >         wMaxPacketSize     0x0031  1x 49 bytes
> > >         bInterval               1
> > > Device Status:     0x0001
> > >   Self Powered
> > >
> > > Thanks,
> > > Alex
> > >
> > >
> > >
> > >
> > > On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> > > > Hi Dave,
> > > >
> > > >  Thanks for the help. I can probably get a recompile of my kernel
> done
> > > >  by the end of the weekend, maybe end of week, if it'll help.
> > > >
> > > >  In the meantime, I'll try loading the bluetooth module with reset=1
> > > >  and get the lsusb output to you tonight when I get home from work.
> > > >
> > > >  Thanks,
> > > >  Alex (Jackflap)
> > > >
> > > >
> > > >  On 03/03/2008, Dave Young <hidave.darkstar@gmail.com> wrote:
> > > >  > On Mon, Mar 3, 2008 at 9:21 AM, Dave Young
> > <hidave.darkstar@gmail.com> wrote:
> > > >  >  > On Fri, Feb 29, 2008 at 6:51 AM, Odysseus Flappington
> > > >  >  >  <deriziotis@gmail.com> wrote:
> > > >  >  >
> > > >  >  >
> > > >  >  > > So, it turns out that in order for any external usb
> bluetooth
> > adapters
> > > >  >  >  >  to re-connect to paired input devices on reboot, you need
> to
> > issue an
> > > >  >  >  >  'hciconfig hci0 reset' command after rebooting in order to
> > reconnect.
> > > >  >  >  >
> > > >  >  >  >  More info can be found in bug #133690 on Launchpad
> > > >  >  >  >
> > (https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690).
> > > >  >  >  >
> > > >  >  >  >  This bug isn't Ubuntu-specific since I have reproduced in
> > Fedora 8, so
> > > >  >  >  >  I'm posting here.
> > > >  >  >  >
> > > >  >  >  >  Simply adding 'hciconfig hci0 reset' in
> /etc/default/bluetooth
> > in
> > > >  >  >  >  source would solve this bug. Is this a reasonable
> solution?
> > > >  >  >  >
> > > >  >  >  >  What is required in order to get a fix implemented?
> > > >  >
> > > >  >
> > > >  > Sorry for previous blank reply.
> > > >  >
> > > >  >  For your problem, if you don't want to patch kernel you can also
> try
> > > >  >  load the bluetooth module with parameter "reset=1"
> > > >  >
> > > >  >  Could you send the lsusb output?
> > > >  >
> > > >  >  Regards
> > > >  >
> > > >  > dave
> > > >  >
> > > >  >
> > > >  >
> >
> -------------------------------------------------------------------------
> > > >  >  This SF.net email is sponsored by: Microsoft
> > > >  >  Defy all challenges. Microsoft(R) Visual Studio 2008.
> > > >  >  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > > >  >  _______________________________________________
> > > >  >  Bluez-users mailing list
> > > >  >  Bluez-users@lists.sourceforge.net
> > > >  >  https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > >  >
> > > >
> > >
> >
> >
>

------=_Part_1911_350025.1206033563022
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel, Dave,<br><br>I&#39;ve been looking around to see if I could figure out the build id where the dongles started shipping with the correct HCI_Reset. I think I may have found something.<br><br><a href="http://www.csr.com/">http://www.csr.com/</a> contains the docs regarding the release of the CSR firmware and the specs that each adhere&#39;s to. Looking at the following HCI overall Implementation doc, I think we can find the relevant build id:<br>
<br><a href="https://www.csrsupport.com/document.php?did=141">https://www.csrsupport.com/document.php?did=141</a><br><br>Firstly, i found confirmation that the problem has been solved in HCIStack1.1v12.x:<br><br>&quot;In builds before HCIStack1.1v12.x, the HCI Reset command rebooted the BlueCore device. This implied the host<br>
transport was reset. This was a consequence of the way the firmware team understood an early version of the<br>Bluetooth specification (probably 0.7).<br><br>Rebooting the BlueCore device is incorrect behaviour. Version 1.1 [BT] now makes it clear that the Reset<br>
command must reinitialise radio, LC, LM and HCI state, but leave the host transport in place. Builds since<br>HCIStack1.1v12.x obey [BT].&quot;<br><br>So this should be fixed in HCIStack1.1v12.x, the doc outlines the build ids for each version of of the stack, here is the build id for <span style="font-family: courier new,monospace;">HCIStack1.1v12.1</span>:<br>
<br><span style="font-family: courier new,monospace;">BuildID (hex)&nbsp;&nbsp; BuildID (decimal)&nbsp;&nbsp;&nbsp; Build Name</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">0x0077&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 119&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCIStack1.1v12.1</span><br>
<br>So, if I&#39;m reading this correctly, you should issue the reset for all CSR-based dongles with build id &gt; 118.<br><br>Am I on the right track here? Does this information look accurate to you guys?<br><br>If there&#39;s anything else I can to do re this issue, please let feel free to ask me.<br>
<br>Many thanks,<br>Alex (Jackflap)<br><br><br><br><div><span class="gmail_quote">On 18/03/2008, <b class="gmail_sendername">Dave Young</b> &lt;<a href="mailto:hidave.darkstar@gmail.com">hidave.darkstar@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, Mar 17, 2008 at 8:28 PM, Odysseus Flappington<br> <br>&lt;<a href="mailto:deriziotis@gmail.com">deriziotis@gmail.com</a>&gt; wrote:<br> &gt; Hi Dave,<br> &gt;<br> <br>&gt; So I got around to recompiling my kernel this weekend, and ran off a test on<br>
 &gt; the patch attached and it worked like a charm.<br> &gt;<br> &gt; I have to wonder though why the line was commented out in the first place.<br> &gt; Could it be because internal adapters don&#39;t need the line?<br>
 &gt;<br> &gt; Anyway, I&#39;d love to see this fixed in future kernels. If there&#39;s anything<br> &gt; else I can do to help test, let me know. Now that I&#39;ve got my head around<br> &gt; recompiling kernels again, I can probably turn around tests a lot faster.<br>
 <br> <br>Hi thanks<br> <br> About the reset issue, I get some response from marcel about reset csr dongles<br> -------- Marcel said :<br> this is a clear NAK since you gonna break all old CSR based dongles.<br> Within the Bluetooth 1.0b and 1.1 specification there was an issues<br>
 with if HCI_Reset should only reset the Bluetooth internals or also<br> the transport. So issuing HCI_Reset on an old dongle will cause an USB<br> reset.<br> <br> The solution is to find the build id when CSR produced correct<br>
 firmware and set the HCI_RESET quirk based on that. I meant to do this<br> for a long time, but so far never got around to inquiry the correct<br> build id where this got fixed.<br> --------<br> <br> But I think it&#39;s hard to find that build id, so ...<br>
 <br> Regards<br> <br>dave<br> <br><br> &gt;<br> &gt; Many thanks,<br> &gt;<br> &gt;<br> &gt; Alex<br> &gt;<br> &gt; On 03/03/2008, Odysseus Flappington &lt;<a href="mailto:deriziotis@gmail.com">deriziotis@gmail.com</a>&gt; wrote:<br>
 &gt; &gt; Ok,<br> &gt; &gt;<br> &gt; &gt; I passed reset=1 to hci_usb by adding the following line to<br> &gt; &gt; /etc/modprobe.d/options:<br> &gt; &gt;<br> &gt; &gt; options hci_usb reset=1<br> &gt; &gt;<br> &gt; &gt; and that&#39;s fixed the problem!<br>
 &gt; &gt;<br> &gt; &gt; Wasn&#39;t sure about my lsusb output, didn&#39;t seem to show very much, so<br> &gt; &gt; here&#39;s my lsusb -v output for my bluetooth device:<br> &gt; &gt;<br> &gt; &gt; Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd<br>
 &gt; &gt; Bluetooth Dongle (HCI mode)<br> &gt; &gt; Device Descriptor:<br> &gt; &gt;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18<br> &gt; &gt;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp; bcdUSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00<br> &gt; &gt;&nbsp;&nbsp; bDeviceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;224 Wireless<br>
 &gt; &gt;&nbsp;&nbsp; bDeviceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp; bDeviceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp; bMaxPacketSize0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;64<br> &gt; &gt;&nbsp;&nbsp; idVendor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0a12 Cambridge Silicon Radio, Ltd<br>
 &gt; &gt;&nbsp;&nbsp; idProduct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0001 Bluetooth Dongle (HCI mode)<br> &gt; &gt;&nbsp;&nbsp; bcdDevice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31.64<br> &gt; &gt;&nbsp;&nbsp; iManufacturer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br> &gt; &gt;&nbsp;&nbsp; iProduct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp; iSerial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
 &gt; &gt;&nbsp;&nbsp; bNumConfigurations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp; Configuration Descriptor:<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; wTotalLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;177<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bNumInterfaces&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bConfigurationValue&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; iConfiguration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Self Powered<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; MaxPower&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0mA<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x81&nbsp;&nbsp;EP 1 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interrupt<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0010&nbsp;&nbsp;1x 16 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x02&nbsp;&nbsp;EP 2 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bulk<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0040&nbsp;&nbsp;1x 64 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x82&nbsp;&nbsp;EP 2 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bulk<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0040&nbsp;&nbsp;1x 64 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0000&nbsp;&nbsp;1x 0 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0000&nbsp;&nbsp;1x 0 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0009&nbsp;&nbsp;1x 9 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0009&nbsp;&nbsp;1x 9 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0011&nbsp;&nbsp;1x 17 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0011&nbsp;&nbsp;1x 17 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0019&nbsp;&nbsp;1x 25 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0019&nbsp;&nbsp;1x 25 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0021&nbsp;&nbsp;1x 33 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0021&nbsp;&nbsp;1x 33 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Interface Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceNumber&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bAlternateSetting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bNumEndpoints&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Radio Frequency<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterfaceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 Bluetooth<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iInterface&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x03&nbsp;&nbsp;EP 3 OUT<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0031&nbsp;&nbsp;1x 49 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Endpoint Descriptor:<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bEndpointAddress&nbsp;&nbsp;&nbsp;&nbsp; 0x83&nbsp;&nbsp;EP 3 IN<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bmAttributes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transfer Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Isochronous<br>
 &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synch Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usage Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wMaxPacketSize&nbsp;&nbsp;&nbsp;&nbsp; 0x0031&nbsp;&nbsp;1x 49 bytes<br> &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br> &gt; &gt; Device Status:&nbsp;&nbsp;&nbsp;&nbsp; 0x0001<br>
 &gt; &gt;&nbsp;&nbsp; Self Powered<br> &gt; &gt;<br> &gt; &gt; Thanks,<br> &gt; &gt; Alex<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; On 03/03/2008, Odysseus Flappington &lt;<a href="mailto:deriziotis@gmail.com">deriziotis@gmail.com</a>&gt; wrote:<br>
 &gt; &gt; &gt; Hi Dave,<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;Thanks for the help. I can probably get a recompile of my kernel done<br> &gt; &gt; &gt;&nbsp;&nbsp;by the end of the weekend, maybe end of week, if it&#39;ll help.<br>
 &gt; &gt; &gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;In the meantime, I&#39;ll try loading the bluetooth module with reset=1<br> &gt; &gt; &gt;&nbsp;&nbsp;and get the lsusb output to you tonight when I get home from work.<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;Thanks,<br>
 &gt; &gt; &gt;&nbsp;&nbsp;Alex (Jackflap)<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;On 03/03/2008, Dave Young &lt;<a href="mailto:hidave.darkstar@gmail.com">hidave.darkstar@gmail.com</a>&gt; wrote:<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt; On Mon, Mar 3, 2008 at 9:21 AM, Dave Young<br>
 &gt; &lt;<a href="mailto:hidave.darkstar@gmail.com">hidave.darkstar@gmail.com</a>&gt; wrote:<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt; On Fri, Feb 29, 2008 at 6:51 AM, Odysseus Flappington<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&lt;<a href="mailto:deriziotis@gmail.com">deriziotis@gmail.com</a>&gt; wrote:<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt; &gt; So, it turns out that in order for any external usb bluetooth<br> &gt; adapters<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;to re-connect to paired input devices on reboot, you need to<br>
 &gt; issue an<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&#39;hciconfig hci0 reset&#39; command after rebooting in order to<br> &gt; reconnect.<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;More info can be found in bug #133690 on Launchpad<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; (<a href="https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690">https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690</a>).<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;This bug isn&#39;t Ubuntu-specific since I have reproduced in<br> &gt; Fedora 8, so<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;I&#39;m posting here.<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;Simply adding &#39;hciconfig hci0 reset&#39; in /etc/default/bluetooth<br>
 &gt; in<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;source would solve this bug. Is this a reasonable solution?<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;What is required in order to get a fix implemented?<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt; Sorry for previous blank reply.<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;For your problem, if you don&#39;t want to patch kernel you can also try<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;load the bluetooth module with parameter &quot;reset=1&quot;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;Could you send the lsusb output?<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;Regards<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt; dave<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; -------------------------------------------------------------------------<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;This SF.net email is sponsored by: Microsoft<br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;Defy all challenges. Microsoft(R) Visual Studio 2008.<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;_______________________________________________<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;Bluez-users mailing list<br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
 &gt; &gt; &gt;&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br> &gt; &gt; &gt;&nbsp;&nbsp;&gt;<br> &gt; &gt; &gt;<br> &gt; &gt;<br> &gt;<br>
 &gt;<br> </blockquote></div><br>

------=_Part_1911_350025.1206033563022--

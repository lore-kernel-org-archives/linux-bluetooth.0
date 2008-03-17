Return-Path: <cyrus@holtmann.org>
From: Javi F Gorostiza <ingestado@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.81929.1205756903.15220.bluez-users@lists.sourceforge.net>
References: <mailman.81929.1205756903.15220.bluez-users@lists.sourceforge.net>
Date: Mon, 17 Mar 2008 17:05:00 +0100
Message-Id: <1205769900.6369.15.camel@goya.uc3m.es>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 23, Issue 7
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Have you tried 
$ aplay -D plughw:bluetooth /tmp1/16000.wav
that is, "plug:bluetooth" instead "bluetooth" alone or "plughw:sco"
instead "sco" alone?
It seems an alsa problem. 
Is it also posible to use a updated kernel?
I spect it helps.
J


> Hi All:
>       Im using an ARM9 embeded system running linux2.6.18 and
> bluez3.28.Im using a bluetooth module named "STLC2500" with UART
> interface.Since the STLC2500 supports only sco over pcm, i connect the
> pcm interface of stlc2500 to the CPU's pcm pins.But...so far , i wasnt
> able to establish any SCO connections when testing HFP/HSP profile.
> Here's some details and questions:
>       1.How many ways do we have testing hsp/hfp using bluez?
>          I tried "hstest","hsplay", they all resulted in a "sco
> connection timed out" error.
>          I also tried modifying the asound.conf:
> pcm.bluetooth {
>   type bluetooth
>   device 00:0D:3C:EB:53:F0
>      profile hfp
> }
> Then use "aplay -D bluetooth /*.wav" to play the music. Then it shows:
> / $ aplay -D bluetooth /tmp1/16000.wav
> audio[198]: Accepted new client connection on unix socket (fd=7)
> audio[198]: Audio API: received BT_GETCAPABILITIES_REQ
> audio[198]: Audio API: sending BT_GETCAPABILITIES_RSP
> ALSA lib pcm_bluetooth.c:1574:(bluetooth_init) BT_GETCAPABILITIES failed :
> Input/output error(5)
> aplay: main:564: audio open error: Input/output error
> audio[198]: Unix client disconnected (fd=7)
> 
>       Anyway, these methods didnt work out. Is there any other way of
> testing the hfp/hsp profiles?
>       2.My stlc2500 bluetooth chip does not support sco over hci. So i
> connected it with my cpu using pcm. My cpu has to play a pcm slave
> role, so stlc2500 has to be pcm master(the master generates pcm
> clk/sync). The problem is , the stlc2500 should be programmed to be
> master or slave , and the value of pcm clk/sync should also be
> programmed. According to its spec , it can be programmed through
> various HCI commands.....but i dont know which hci command is it?
>       Its also loaded with 2 patch files when it started, which the
> spec says can also set the value of pcm clk/sync values. The 2 files
> are from bluez-firmware-1.2.  Like this:
>        STLC2500 R4.2 12102005 12:40:14 ZAV100012
>        HW Id= V440BAA
> Loading file /lib/firmware/STLC2500_R4_02_04.ptc
> Loading file /lib/firmware/STLC2500_R4_02_02_WLAN.ssf
>       Is there anyway of modifying those patches so that i can change
> the pcm clk/sync(if i can)?
> 
> Thanks in advance.
> 
> Best Regards
> 
> 
> semiyd
> 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Mon, 17 Mar 2008 14:35:51 +0530
> From: Paul <chemvell@gmail.com>
> Subject: [Bluez-users] Test suite for Bluez
> To: "BlueZ users" <bluez-users@lists.sourceforge.net>
> Message-ID:
> 	<8f5c4ad0803170205n2d83d3d8of2a0e1a4e7ad12ea@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Hi,
> 
>                     Are there any test suites available for testting the
> APIs provided by bluez-libs other than the test programs that comes with
> bluez-utils?
> 
> Thank you for your time and consideration,
> Regards,
> Paul.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> 
> ------------------------------
> 
> Message: 4
> Date: Mon, 17 Mar 2008 10:52:12 +0100
> From: Wolfgang Buesser <wolfgang.buesser@web.de>
> Subject: [Bluez-users] problems with permissions for sdp local
> To: bluez-users@lists.sourceforge.net
> Message-ID: <1205747533.8285.10.camel@linuxpc9.mylocaldomain.com>
> Content-Type: text/plain
> 
> I am using a USB-bluetooth dongle to my mobile phone.
> 
> Everything seems to work fine when I am logged in as root.
> As normal user kbluetoothd complains
> 
> >Failed to connect to the SDP server.
> >Please make sure that sdpd is running
> >without it, other devices will not be able to find out
> >which services your computer offers.
> 
> When I run 'sdptool browse local' as normal user I get:
> >Failed to connect to SDP server on FF:FF:FF:00:00:00: Permission denied
> 
> When I run it as root I get:
> >Browsing FF:FF:FF:00:00:00 ...
> >Service Name: OBEX Object Push
> >Service RecHandle: 0x10000
> >Service Class ID List:
> >  "OBEX Object Push" (0x1105)
> >Protocol Descriptor List:
> >  "L2CAP" (0x0100)
> >  "RFCOMM" (0x0003)
> >    Channel: 10
> >  "OBEX" (0x0008)
> >Profile Descriptor List:
> >  "OBEX Object Push" (0x1105)
> >    Version: 0x0100
> 
> Browsing for the remote device works for both, root an normal user.
> 
> So here is my question:
> What controls the permissions to access the local interface with sdp?
> Is this am matter of udev?
> How can I change these permissions?
> 
> Thanks
> 	Wolfgang
> 
> 
> 
> 
> 
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Mon, 17 Mar 2008 12:28:28 +0000
> From: "Odysseus Flappington" <deriziotis@gmail.com>
> Subject: Re: [Bluez-users] hciconfig hci0 reset bug
> To: "Dave Young" <hidave.darkstar@gmail.com>
> Cc: BlueZ users <bluez-users@lists.sourceforge.net>
> Message-ID:
> 	<5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Hi Dave,
> 
> So I got around to recompiling my kernel this weekend, and ran off a test on
> the patch attached and it worked like a charm.
> 
> I have to wonder though why the line was commented out in the first place.
> Could it be because internal adapters don't need the line?
> 
> Anyway, I'd love to see this fixed in future kernels. If there's anything
> else I can do to help test, let me know. Now that I've got my head around
> recompiling kernels again, I can probably turn around tests a lot faster.
> 
> Many thanks,
> Alex
> 
> On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> >
> > Ok,
> >
> > I passed reset=1 to hci_usb by adding the following line to
> > /etc/modprobe.d/options:
> >
> > options hci_usb reset=1
> >
> > and that's fixed the problem!
> >
> > Wasn't sure about my lsusb output, didn't seem to show very much, so
> > here's my lsusb -v output for my bluetooth device:
> >
> > Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> > Bluetooth Dongle (HCI mode)
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          224 Wireless
> >   bDeviceSubClass         1 Radio Frequency
> >   bDeviceProtocol         1 Bluetooth
> >   bMaxPacketSize0        64
> >   idVendor           0x0a12 Cambridge Silicon Radio, Ltd
> >   idProduct          0x0001 Bluetooth Dongle (HCI mode)
> >   bcdDevice           31.64
> >   iManufacturer           0
> >   iProduct                0
> >   iSerial                 0
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength          177
> >     bNumInterfaces          2
> >     bConfigurationValue     1
> >     iConfiguration          0
> >     bmAttributes         0xc0
> >       Self Powered
> >     MaxPower                0mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           3
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0010  1x 16 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x02  EP 2 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x82  EP 2 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       0
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0000  1x 0 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0000  1x 0 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       1
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0009  1x 9 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0009  1x 9 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       2
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0011  1x 17 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0011  1x 17 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       3
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0019  1x 25 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0019  1x 25 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       4
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0021  1x 33 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0021  1x 33 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       5
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0031  1x 49 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0031  1x 49 bytes
> >         bInterval               1
> > Device Status:     0x0001
> >   Self Powered
> >
> > Thanks,
> > Alex
> >
> >
> >
> >
> > On 03/03/2008, Odysseus Flappington <deriziotis@gmail.com> wrote:
> > > Hi Dave,
> > >
> > >  Thanks for the help. I can probably get a recompile of my kernel done
> > >  by the end of the weekend, maybe end of week, if it'll help.
> > >
> > >  In the meantime, I'll try loading the bluetooth module with reset=1
> > >  and get the lsusb output to you tonight when I get home from work.
> > >
> > >  Thanks,
> > >  Alex (Jackflap)
> > >
> > >
> > >  On 03/03/2008, Dave Young <hidave.darkstar@gmail.com> wrote:
> > >  > On Mon, Mar 3, 2008 at 9:21 AM, Dave Young <hidave.darkstar@gmail.com>
> > wrote:
> > >  >  > On Fri, Feb 29, 2008 at 6:51 AM, Odysseus Flappington
> > >  >  >  <deriziotis@gmail.com> wrote:
> > >  >  >
> > >  >  >
> > >  >  > > So, it turns out that in order for any external usb bluetooth
> > adapters
> > >  >  >  >  to re-connect to paired input devices on reboot, you need to
> > issue an
> > >  >  >  >  'hciconfig hci0 reset' command after rebooting in order to
> > reconnect.
> > >  >  >  >
> > >  >  >  >  More info can be found in bug #133690 on Launchpad
> > >  >  >  >  (
> > https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/133690).
> > >  >  >  >
> > >  >  >  >  This bug isn't Ubuntu-specific since I have reproduced in
> > Fedora 8, so
> > >  >  >  >  I'm posting here.
> > >  >  >  >
> > >  >  >  >  Simply adding 'hciconfig hci0 reset' in /etc/default/bluetooth
> > in
> > >  >  >  >  source would solve this bug. Is this a reasonable solution?
> > >  >  >  >
> > >  >  >  >  What is required in order to get a fix implemented?
> > >  >
> > >  >
> > >  > Sorry for previous blank reply.
> > >  >
> > >  >  For your problem, if you don't want to patch kernel you can also try
> > >  >  load the bluetooth module with parameter "reset=1"
> > >  >
> > >  >  Could you send the lsusb output?
> > >  >
> > >  >  Regards
> > >  >
> > >  > dave
> > >  >
> > >  >
> >
> > >  >  -------------------------------------------------------------------------
> > >  >  This SF.net email is sponsored by: Microsoft
> > >  >  Defy all challenges. Microsoft(R) Visual Studio 2008.
> > >  >  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > >  >  _______________________________________________
> > >  >  Bluez-users mailing list
> > >  >  Bluez-users@lists.sourceforge.net
> > >  >  https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >  >
> > >
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: diff.hci_reset
> Type: application/octet-stream
> Size: 608 bytes
> Desc: not available
> 
> ------------------------------
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> 
> ------------------------------
> 
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> End of Bluez-users Digest, Vol 23, Issue 7
> ******************************************


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

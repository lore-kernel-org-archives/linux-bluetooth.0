Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d86405022806312ab4142a@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Bluetooth PC Headset - SCO connection failed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Feb 2005 20:01:50 +0530

Hi Marcel,
Thanks for your clarifications for my mail. 

I am not able to establish SCO connection from PC to headset.

My linux kernel version is 2.4.29. I have downloaded the required
files from bluetooth-alsa.sf.net and followed the instructions as per
the Readme files.

To send audio over bluetooth:
i) I am using alsa-driver-0.9.6, snd-bluez-sco-2003-09-15 drivers.
ii) For alsa driver and library I patched
alsa-driver-0.9.6-bluezsco.patch,alsa-lib-0.9.6-bluezsco.patch
respectively.
iii) I am using bluetooth mono headset and on the linux PC I use a
standard USB bluetooth dongle.
iv) I have installed on a linux PC the alsa's snd-bluez-sco driver and
its dependencies.

I am getting the following results:

[root@localhost BT-Test]# hciconfig hci0 up
[root@localhost BT-Test]# hciconfig hci0 voice 0x0040
[root@localhost BT-Test]# hciconfig -a
hci0:   Type: USB
        BD Address: 01:5A:4B:20:07:DB ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:10132 acl:198 sco:0 events:421 errors:0
        TX bytes:5332 acl:192 sco:0 commands:142 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver:
0x110
        Manufacturer: Cambridge Silicon Radio (10)

[root@localhost BT-Test]# hcitool scan
Scanning ...
        AE:2D:00:44:01:00       HDS_MONO100

[root@localhostBT-Test]# sdptool search --bdaddr AE:2D:00:44:01:00
0x1108
Class 0x1108
Searching for 0x1108 on AE:2D:00:44:01:00 ...
Service Name: HSU
Service RecHandle: 0x90001
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100
 
[root@localhost BT-Test]# bluezsco AE:2D:00:44:01:00 1
Device is 0:0
Voice setting: 0x0040
RFCOMM channel connected
Can't connect SCO audio channel: No such file or directory

Please advice.

Thanks & Regards,
Benny


On Mon, 28 Feb 2005 09:12:23 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Benny,
> 
> > We are planning for a single bluetooth device(microcontroller based)
> > featuring a headset and our custom hardware device which sends status
> > to the PC and gets control information over bluetooth. We plan to use
> > a Bluetooth SoC with Headset Profile interfaced to the microcontroller
> > over UART which fetches the status/control data from our custom
> > hardware.
> >
> > On the PC side(linux) we are going to use a standard USB Bluetooth
> > dongle. We are using the Bluez on the Linux PC side.
> >
> > i) We need to send audio information(playing song using some MP3
> > player) from PC to the bluetooth device headset and also send data
> > from Mic to the PC for voice recording.
> >
> > What setup we need to make for audio configuration in Linux PC to
> > route the audio information to the headset and a voice recording
> > setup?
> 
> look at the information at bluetooth-alsa.sf.net
> 
> > ii) Parallely we want to recieve the status info from the bluetooth
> > device and need to send the appropriate control information from PC.
> > We have tested data transfer between 2 PCs using BT USB dongles at
> > L2CAP level. But our final target is we need to implement in firware
> > on our Microcontroller.
> >
> > Is there a firmware level implementation of Bluez available?
> 
> No and we don't have any plans for it, until the firmware of your
> Microcontroller is Linux based.
> 
> Regards
> 
> Marcel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

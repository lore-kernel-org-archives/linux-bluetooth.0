Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40C0A761.2010504@libero.it>
From: Paolo Arcagni <paolo.arcagni@libero.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Linux audio gateway and headset feature
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
Date: Fri, 04 Jun 2004 18:46:25 +0200

Hi gentlemen.

I am setting up my Linux box to use an USB Bluetooth interface in order 
to talk to my nokia 6310. I can browse the internet using GPRS from the 
laptop enabling the rfcomm0 interface with the command

rfcomm conn 0 xx:xx:xx:xx:xx:xx 1

pointing pppd to /dev/rfcomm0.

The question is: which is the right procedure to use the laptop 
multimedia subsystem as an headset for the phone ? On windows2000 this 
kind of setup worked fine....

I can obtain a connection with the command

rfcomm conn 0 xx:xx:xx:xx:xx:xx 12

and accepting the connection on the cell phone the output is

Conmected /dev/rfcomm0 to xx:xx:xx:xx:xx:xx on channel 12
Press CTRL-C for hungup

On the phone display I can see the symbol for the connected headset, I 
cannot hear the sound on the phone, but I have no sound on the Laptop.

My Laptop is using ALSA with a ESS ES1978 audio board and the sound in 
gnome works fine.

Where is the mistake ?!?

Thanks for your help

===============================
Gentoo Linux with kernel 2.6.6
ALSA Drivers for the ESS ES1978
Gnome 2.6

sdptool browse outpout is:

[CUT]

Service Name: Audio Gateway
Service RecHandle: 0x10002
Service Class ID List:
   "Headset Audio Gateway" (0x1112)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 12
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Headset" (0x1108)
     Version: 0x0100

Service Name: Voice Gateway
Service RecHandle: 0x10004
Service Class ID List:
   "" (0x111f)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 13
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "" (0x111e)
     Version: 0x0100

[CUT]





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

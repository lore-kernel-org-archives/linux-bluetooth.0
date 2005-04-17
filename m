Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?UTF-8?B?SmVzw7pz?= Cano Navarro <jesuscanonavarro@yahoo.es>
To: Bluez <bluez-users@lists.sourceforge.net>
Message-Id: <20050417205450.653f7567.jesuscanonavarro@yahoo.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9"
Subject: [Bluez-users] Can't connect to a keyboard
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
Date: Sun, 17 Apr 2005 20:54:50 +0200

This is a multi-part message in MIME format.

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everybody,

First of all, thank you very much for reading the message and spending a little of your time helping me. I'm new in this "blue field", hope i can help people with this some day.

Ok. I had an Apple Wireless Keyboard for xmas, since then, i haven't been able to use it on my GNU/Linux, a minimalistic Debian testing (in Compaq Deskpro EN series old workstation, P2 350Mhz, 256MB, 8GB; it runs so fine ;).

I read Marcel's pages about bluez and bluetooth in GNU/Linux (great job man!) to get a right dongle (a 3com USB Bluetooth adapter) and get the first contact to bluetooth in GNU/Linux. I couldn't understand that pages very well since i don't know much more about the bluetooth hw, protocol, stack... Perhaps, the answer is right in front of my nose but i cann't see it. Actually, someone seemed to have the same problem in the list archives time ago, but i can't imagine what do i have to do.

So, i installed "bluez-utils" pakage. And i've been trying things; the info i know i can give you by now, is:

-I need to restart /etc/init.d/bluez-utils, after booting to make it work.
-I have no problem to detect the dongle on boot or with hotplug.
-I have tried some steps to connect with the keyboard i found in the documentation i difficultly read:

http://www.hpl.hp.com/personal/Jean_Tourrilhes/bt/Brainboxes.html
http://pinsa.escomposlinux.org/sromero/linux/bluetooth_ht.php
http://www.linuca.org/body.phtml?nIdNoticia=299
http://www.holtmann.org/linux/bluetooth/
http://www.holtmann.org/linux/bluetooth/usb.html
http://dmnet.bitacoras.com/index.php?id=2997
http://tuxmobil.org/bluetooth_linux.html
http://usefulinc.com/edd/blog/contents/2004/05/26-bluez/read
http://www.holtmann.org/linux/kernel/debian.html
http://www.asturlinux.org/~alvaro/noticias/docs/bthowto/adjuntos/bluetooth.howto.htm

I'm attaching all the outputs i could collect for you.

I have no idea. All you are wellcome.

Thank you very much!.

-- 
Por favor, NUNCA reveles esta dirrección de correo electrónico a ninguna persona o entidad.
Te estaría muy agradecido si respetases que sólo quiero recibir aquí, correo exclusivamente dirigido a mi persona (nada de mensajes cadena, o "de reenviar" o como quieras llamarlos).
Muchísimas gracias.

Please, NEVER give my e-mail address to anyone.
I would be very thankful if you respect that I only want to receive here totally directed to my person post (no chain messages, or "to foward messages" or whatever you want to call them).
Thank you very much.

Jesús Cano Navarro <jesuscanonavarro@yahoo.es>

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hciconfig-a.txt"
Content-Disposition: attachment;
 filename="hciconfig-a.txt"
Content-Transfer-Encoding: 7bit

hci0:	Type: USB
	BD Address: 00:0B:AC:EB:C8:9F ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:393 acl:0 sco:0 events:19 errors:0
	TX bytes:317 acl:0 sco:0 commands:17 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'herzeleid-0'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver: 0x20e
	Manufacturer: Cambridge Silicon Radio (10)


--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hcid.conf.txt"
Content-Disposition: attachment;
 filename="hcid.conf.txt"
Content-Transfer-Encoding: 7bit

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# PIN helper
	pin_helper /usr/bin/bluez-pin;

	# D-Bus PIN helper
	#dbus_pin_helper;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "%h-%d";

	# Local device class
	class 0x100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	#
	#lm accept,master;
	#
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hcitool-dev.txt"
Content-Disposition: attachment;
 filename="hcitool-dev.txt"
Content-Transfer-Encoding: 7bit

Devices:
	hci0	00:0B:AC:EB:C8:9F

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hcitool-info.txt"
Content-Disposition: attachment;
 filename="hcitool-info.txt"
Content-Transfer-Encoding: 7bit

Requesting information ...

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hcitool-inq.txt"
Content-Disposition: attachment;
 filename="hcitool-inq.txt"
Content-Transfer-Encoding: 7bit

Inquiring ...
	00:0A:95:3D:EB:EC	clock offset: 0x7474	class: 0x002540

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="hcitool-scan.txt"
Content-Disposition: attachment;
 filename="hcitool-scan.txt"
Content-Transfer-Encoding: 7bit

Scanning ...
	00:0A:95:3D:EB:EC	n/a

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9
Content-Type: text/plain;
 name="lsmod.txt"
Content-Disposition: attachment;
 filename="lsmod.txt"
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
hidp                   15488  2 
rfcomm                 39420  0 
l2cap                  25796  8 hidp,rfcomm
ipv6                  264644  8 
pcspkr                  3592  0 
floppy                 61200  0 
parport_pc             36900  0 
parport                41800  1 parport_pc
pci_hotplug            34640  0 
intel_agp              22816  1 
hci_usb                13888  0 
bluetooth              49604  4 hidp,rfcomm,l2cap,hci_usb
tsdev                   7392  0 
mousedev               10476  1 
joydev                  9984  0 
evdev                   9600  0 
usbhid                 32224  0 
uhci_hcd               33136  0 
usbcore               119012  5 hci_usb,usbhid,uhci_hcd
3c59x                  39368  0 
agpgart                34664  1 intel_agp
capability              4520  0 
commoncap               7232  1 capability
psmouse                20360  0 
ide_cd                 42656  0 
cdrom                  40732  1 ide_cd
genrtc                  9588  0 
jfs                   185576  2 
ide_generic             1408  0 
piix                   13440  1 
ide_disk               19296  4 
ide_core              139940  4 ide_cd,ide_generic,piix,ide_disk
sd_mod                 21728  0 
ata_piix                8132  0 
libata                 41700  1 ata_piix
scsi_mod              125228  2 sd_mod,libata
unix                   28756  76 
font                    8320  0 
vesafb                  6656  0 
cfbcopyarea             3872  1 vesafb
cfbimgblt               3040  1 vesafb
cfbfillrect             3776  1 vesafb

--Multipart=_Sun__17_Apr_2005_20_54_50_+0200_IQs6IePignmyGbj9--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

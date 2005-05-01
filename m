Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <RJenster@web.de>
To: bluez-devel@lists.sourceforge.net
References: <Pine.LNX.4.30.0505011025590.18702-100000@stealth.kirenet.com> <1114959364.21785.18.camel@pegasus>
In-Reply-To: <1114959364.21785.18.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TfTdCnKFSFBBLos"
Message-Id: <200505012210.59716.RJenster@web.de>
Subject: [Bluez-devel] authentication problem - link_key prevents from pairing
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 1 May 2005 22:10:59 +0200

--Boundary-00=_TfTdCnKFSFBBLos
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I've a really enerving problem.

On my desktop I'm not able to pair my headset without 
deleting /etc/bluetooth/link_key. After deleting the link_key
the pinhelper pops up and asks for the pin. I insert them and 
I'm able to connect.

My bluetooth dongle is from allnet and is attached to the usb port of a 
nforce2 mobo.

I allready submitted a bug report at the kde bugtracker cause I thought 
this is a kdebluetooth problem. Please look at   
http://bugs.kde.org/show_bug.cgi?id=104876 which could also be usefull 
information.

I tried all versions of bluez-utils and bluez-libs from 2.7 till 2.16 
and kdebluetooth from 20041107 till 0.99_beta1 in nearly every combination but 
everytime the same problem.

Curious is that on my thinkpad (T41p) evertime I pair my headset with the 
buildtin bluetooth module I'm asked for the PIN.

I'm really stumped. Please help me.

Regards 

Ruben

--Boundary-00=_TfTdCnKFSFBBLos
Content-Type: text/plain;
  charset="iso-8859-15";
  name="hciconfig.info"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hciconfig.info"

Bluetooth Dongle Allnet 1575

hci0:	Type: USB
	BD Address: 00:0C:55:FD:8E:6B ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:708 acl:0 sco:0 events:25 errors:0
	TX bytes:335 acl:0 sco:0 commands:23 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'Thinkpad (0)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
	Manufacturer: Cambridge Silicon Radio (10)


Thinkpad T41p internal bluetooth

hci0:	Type: USB
	BD Address: 00:20:E0:7D:21:C7 ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:384 acl:0 sco:0 events:17 errors:0
	TX bytes:309 acl:0 sco:0 commands:16 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'Thinkpad (1)'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
	Manufacturer: Cambridge Silicon Radio (10)


--Boundary-00=_TfTdCnKFSFBBLos--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

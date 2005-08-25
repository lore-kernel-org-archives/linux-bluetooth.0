Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <430E0AF9.4050502@gmx.de>
From: Johannes Bauer <dfnsonfsduifb@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] rfcomm: Connection Refused
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
Date: Thu, 25 Aug 2005 20:16:25 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi list,

I'm having trouble with Bluez. I think I'm almost there, however. Here's
the description:

I have successfully set up the hci0 device:

# hciconfig -a hci0
hci0:   Type: USB
        BD Address: 00:11:F6:03:E7:9A ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:35535 acl:527 sco:0 events:1263 errors:0
        TX bytes:20799 acl:524 sco:0 commands:442 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Joeserver'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)
#

And I have paired my PC with my Sony Ericsson K700i Cellular Phone:

# hcitool scan
Scanning ...
        00:0E:07:A7:7E:D2       K700i
# hcitool cc 00:0E:07:A7:7E:D2
# hcitool auth 00:0E:07:A7:7E:D2
# hcitool dc 00:0E:07:A7:7E:D2

The cell phone asks upon the "auth" command if it shall connect to
"Joeserver" and asks for the PIN. When I enter the correct pin (stored
in /etc/bluetooth/pin) the devices are paired.

Everything looks fine so far. Then comes the rfcomm:

# rfcomm bind 0 00:0E:07:A7:7E:D2 1

Now when I try, for example:

# cat > /dev/bluetooth/rfcomm/0
- -bash: /dev/bluetooth/rfcomm/0: Connection refused
#

I also tried changing channels from 1 to 12. On 6 it just blocked, but
the cellphone didn't display anything. All other channels said
"connection refused".

Then I read the mailing list and some message there said to use sdptool:

# sdptool browse 00:0E:07:A7:7E:D2
Browsing 00:0E:07:A7:7E:D2 ...
Service Name: Dial-up Networking
Service RecHandle: 0x10000
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: HS Voice Gateway
Service RecHandle: 0x10002
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Serial Port
Service RecHandle: 0x10003
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2

Service Name: Serial Port 2
Service RecHandle: 0x10004
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3

Service Name: OBEX Object Push
Service RecHandle: 0x10005
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX IrMC Sync Server
Service RecHandle: 0x10006
Service Class ID List:
  "IrMC Sync" (0x1104)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
  "OBEX" (0x0008)
Profile Descriptor List:
  "IrMC Sync" (0x1104)
    Version: 0x0100

Service Name: OBEX Basic Imaging
Service RecHandle: 0x1000a
Service Class ID List:
  "Imaging Responder" (0x111b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Profile Descriptor List:
  "Imaging" (0x111a)
    Version: 0x0100

Service Name: OBEX File Transfer
Service RecHandle: 0x1000d
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: HF Voice Gateway
Service RecHandle: 0x1000e
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Service Name: OBEX SyncML Client
Service RecHandle: 0x10018
Service Class ID List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 15
  "OBEX" (0x0008)

Service Description: K700 series
Service RecHandle: 0x1001b
Service Class ID List:
  "PnP Information" (0x1200)

Service Name: Mouse & Keyboard
Service Description: K700
Service Provider: Sony Ericsson
Service RecHandle: 0x1001c
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

#

Channels appear to be 1, 2 and 3 (which I tried, as mentioned above).

Here's my /etc/bluetooth/hcid.conf (all comments removed)
options {
        autoinit yes;
        security user;
        pairing multi;
        pin_helper /etc/bluetooth/pin-helper;
}

device {
        name "Joeserver";
        class 0x3e0100;
        iscan enable;
        pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
}

And this is my /etc/bluetooth/rfcomm.conf:
rfcomm0 {
        bind yes;
        device 00:0E:07:A7:7E:D2;
        channel 1;
        comment "Handy";
}

(it only gets read on startup, I have set up the bindings to channel
1-12 manually).

Would a dump of hcidump be helpful? What exactly should I dump?

I would really appreciate if somebody could help, Bluez is already a
really impressive piece of work. It worked (until now) so smoothly, I
was really impressed  :-)

Greetings,
Johannes
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDDgr5CseFG8xyfi4RAquTAJ9y+DeGvnzoMNtW0lCogjzr2i8aYwCeKM8R
AoHvp/5dCpt9xtlGP7sTCqI=
=cbBD
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

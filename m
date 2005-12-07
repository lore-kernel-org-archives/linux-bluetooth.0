Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOOEGECAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1133952508.3752.1.camel@blade>
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
Date: Wed, 7 Dec 2005 10:54:29 -0000

Hi Marcel

> > Can someone tell me how to set the bluetooth voice settings
> when using sco
> > and what to set it to?
> > My hcidump shows voice setting as (0x03|0x0025) - what does
> this mean? Also,
> > the hcidump shows that a connection is created for DM* and DH*
> packet types:
> > for sco, should this not be HV* packet types?
>
> you don't need to worry about it. The packet types and the voice setting
> are not related (from the HCI viewpoint). If you wanna know details
> about it, look at the HCI part of the Bluetooth specification. The value
> is a bitmask and it is explained in detail there.
>

I was curious because I am not getting any sound through my machine
(configured as a headset - 0x200404 device class).
Also there are no service classes defined when I do hciconfig -a (as shown
below).
Although a headset icon appears on my 6310i and I get no sound at the actual
mobile phone (because the headset is connected), I still cannot hear or say
anything that can be heard from my computer.
Therefore, I am trying to study the hcidump output but its almost impossible
to interpret.

I have hcidump output, which I can send should you wish to view it.

hciconfig -a:

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:45230 acl:1413 sco:0 events:2002 errors:0
        TX bytes:27314 acl:1440 sco:0 commands:243 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x200404
        Service Classes:
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
0x175
        Manufacturer: Cambridge Silicon Radio (10)

hci0:   Type: USB
        BD Address: 00:09:DD:10:29:78 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 14.7
        Chip version: BlueCore02-External (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI

sdptool browse local:

Browsing FF:FF:FF:00:00:00 ...
Service Name: Voice Gateway
Service RecHandle: 0x10000
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Handfree Audio Gateway" (0x111f)
    Version: 0x0100

Service Name: Voice Gateway
Service RecHandle: 0x10001
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

sdptool search --bdaddr 00:0E:6D:34:BD:B1 0x111f:

Class 0x111F
Searching for 0x111f on 00:0E:6D:34:BD:B1 ...
Service Name: Voice Gateway
Service RecHandle: 0x10005
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
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
  "Handsfree" (0x111e)
    Version: 0x0100

I have set the channel to be used as channel 13 given the above search
result; this connects the phone to the headset.

Kind Regards.

Khaled



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ian Bobbitt <bobbitti@bloomington.in.us>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0507151820470.15627@kirkwood.hoosier.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] trouble connecting to device
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
Date: Fri, 15 Jul 2005 18:30:49 -0500 (EST)

I'm using a USB dongle with a CSR chip to connect to a device from 
blueradios.com.  The manual for this device says the PIN code is 
"default", and is required.

I have tried running the following commands:
-----------------------------8<------------------------
papasmurf ~ # hcitool inq
Inquiring ...
         00:A0:96:0E:4C:8A       clock offset: 0x1108    class: 0x000000
papasmurf ~ # hcitool cc 00:A0:96:0E:4C:8A

papasmurf ~ # hcitool con
Connections:
         < ACL 00:A0:96:0E:4C:8A handle 42 state 1 lm MASTER
papasmurf ~ # hcitool auth 00:A0:96:0E:4C:8A
HCI authentication request failed: Input/output error
papasmurf ~ # hcitool dc 00:A0:96:0E:4C:8A
-----------------------------8<------------------------


The output of hcidump is:
-----------------------------8<------------------------
papasmurf ~ # hcidump -XV --psm=3

HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
     bdaddr 00:A0:96:0E:4C:8A mode 1 clkoffset 0x1108 class 0x000000
> HCI Event: Inquiry Complete (0x01) plen 1
     status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:A0:96:0E:4C:8A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 42 bdaddr 00:A0:96:0E:4C:8A type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 42 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:A0:96:0E:4C:8A mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 42 slots 5
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
     handle 42
> HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:A0:96:0E:4C:8A
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:A0:96:0E:4C:8A key 888A933AE77F43813AEFAB8B8FCBA9BA
> HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:A0:96:0E:4C:8A
> HCI Event: Auth Complete (0x06) plen 3
     status 0x05 handle 42
     Error: Authentication Failure
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 42 reason 0x13
     Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x16
     Reason: Connection Terminated by Local Host
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:A0:96:0E:4C:8A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 42 bdaddr 00:A0:96:0E:4C:8A type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 42 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:A0:96:0E:4C:8A mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 42 slots 5
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:A0:96:0E:4C:8A mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:A0:96:0E:4C:8A name 'Goofy Giggles'
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
     handle 42
> HCI Event: Command Status (0x0f) plen 4
     Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
     status 0x00 handle 42
     LMP Version: 1.2 (0x2) LMP Subversion: 0x5df
     Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 42
> HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 42
     Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 42 page 0
> HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 42 page 0 max 0
     Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 42 reason 0x13
     Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x16
     Reason: Connection Terminated by Local Host
-----------------------------8<------------------------


-----------------------------8<------------------------
papasmurf ~ # hcitool info 00:A0:96:0E:4C:8A
Requesting information ...
         BD Address:  00:A0:96:0E:4C:8A
         Device Name: Goofy Giggles
         LMP Version: 1.2 (0x2) LMP Subversion: 0x5df
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging 
scheme>
                 <power control> <transparent SCO> <broadcast encrypt>
                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                 <AFH cap. master> <AFH class. master> <extended features>
-----------------------------8<------------------------


hcid.conf is:
-----------------------------8<------------------------
options {
         autoinit yes;
         security user;
         pairing multi;
         pin_helper /etc/bluetooth/pin-helper
}
device {
         name "BlueZ (%d)";
         class 0x3e0100;
         iscan enable; pscan enable;
         lm accept;
         lp rswitch,hold,sniff,park;
}
-----------------------------8<------------------------

pin-helper is:
-----------------------------8<------------------------
#!/bin/sh
echo -n "PIN:"
cat /etc/bluetooth/pin
-----------------------------8<------------------------

and pin is:
-----------------------------8<------------------------
default
-----------------------------8<------------------------


What am I doing wrong with connecting to this device?  Will I eventually 
need to use rfcomm when I can authenticate with the device?


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

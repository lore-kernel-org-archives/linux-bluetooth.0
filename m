Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1281.216.47.50.125.1154111937.squirrel@webmail.feline-soul.net>
Date: Fri, 28 Jul 2006 12:38:57 -0600 (MDT)
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: "Ulisses Furquim" <ulissesf@gmail.com>
MIME-Version: 1.0
References: <44C8FB2F.9070403@kernelconcepts.de>    
	<44C9DB62.1000103@kernelconcepts.de>    
	<1154079988.2298.23.camel@localhost>    
	<200607281048.07126.Bearcat@feline-soul.com>   
	<d23110170607281121s3dbf5c6brde2156d3f1c01b73@mail.gmail.com>
In-Reply-To: <d23110170607281121s3dbf5c6brde2156d3f1c01b73@mail.gmail.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Sorry about that. I meant to say files/bluetooth on all those.

They are here: http://www.feline-soul.com/files/bluetooth/

Here the are inline:
http://www.feline-soul.net/files/bluetooth/hcid.conf:
#
# HCI daemon configuration file.
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
	security user;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# Default PIN code for incoming connections
	passkey "BlueZ";

	# PIN helper
     #pin_helper /usr/bin/bluepin;
     #pin_helper /etc/bluetooth/cbpinscript;
     pin_helper /usr/lib/kdebluetooth/kbluepin;
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	name "BlueZ (%d)";

	# Local device class
	class 0x100000;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;
}
-------------------------------------------------------------------
http://www.feline-soul.net/files/bluetooth/hcidev_-a_output:
hci0:	Type: USB
	BD Address: 00:07:61:1C:9F:D3 ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:8886937 acl:584808 sco:0 events:79865 errors:0
	TX bytes:392377 acl:192 sco:0 commands:77281 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'BlueZ (0)'
	Class: 0x000000
	Service Classes: Unspecified
	Device Class: Miscellaneous,
	HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver: 0x34e
Manufacturer: Cambridge Silicon Radio (10)
--------------------------------------------------------------------
http://www.feline-soul.net/files/bluetooth/hcidump:
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x02 interval 126
    Mode: Sniff
-----------------------------------------------------------------
http://www.feline-soul.net/files/bluetooth/hcidump_hcitool_connect HCI
sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:61:1B:50:9B ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:07:61:1B:50:9B type ACL encrypt 0x00
Error: Page Timeout
--------------------------------------------------------------------
http://www.feline-soul.net/files/bluetooth/hcidump_hidd_connect
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x02 interval 126
    Mode: Sniff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:61:1B:50:9B ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:07:61:1B:50:9B type ACL encrypt 0x00
Error: Page Timeout
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:61:1B:50:9B ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:07:61:1B:50:9B type ACL encrypt 0x00
Error: Page Timeout
-----------------------------------------------------------
http://www.feline-soul.net/files/bluetooth/rfcomm.conf
#
# RFCOMM configuration file.
#

rfcomm0 {
	# Automatically bind the device at startup
	bind no;

	# Bluetooth address of the device
	device 11:22:33:44:55:66;

	# RFCOMM channel for the connection
	channel	1;

	# Description of the connection
	comment "Example Bluetooth device";
---------------------------------------------

That's it. The commands i used to get these sets of output are in the
previous email.

Thanks all,

Bearcat


> Hi Bearcat,
>
> On 7/28/06, Bearcat M. Sandor <Bearcat@feline-soul.com> wrote:
>> Thank you again for the help so far. I have placed a bunch of output
files on
>> my server for your viewing pleasure, instead of giving you large
outputs
>> in
>> an email body.
>
> Sorry, but I couldn't see any of those files (all links end up with "404
Not found" error). Can you send those files inline so we can see what's
happening, please?
>
> Regards,
>
> -- Ulisses
>
>





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

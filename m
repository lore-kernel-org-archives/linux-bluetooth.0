Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems establishing connection to Cellular
	phone
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1110795678.8158.46.camel@pegasus>
References: <1110766661.9456.4.camel@tux> <1110795678.8158.46.camel@pegasus>
Content-Type: text/plain
Message-Id: <1110802026.9167.11.camel@tux>
Mime-Version: 1.0
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
Date: Mon, 14 Mar 2005 13:07:06 +0100

Dear Marcell, 
Thank you very much for the quick answer. I appreciate your help very
much for solving my problem (specially because I am such a newbie).
About the dbus, I installed it and get the bluez-pin package installed
successfully. 

1st) I run up the Bluetooth-stick with the command: 
hciconfig auth noscan nosecmgr noencrypt

and tried to connect to the mobile phone with the result (after entering
on the phone a PIN): 
Can't create connection: Input/output error

Before creating a connection I run the sniffer command: 
hcidump -X -V

program and received this result during the test: 

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:E0:03:65:64:94 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:E0:03:65:64:94
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:E0:03:65:64:94
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:E0:03:65:64:94
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:E0:03:65:64:94
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:E0:03:65:64:94 len 4 pin '1234'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:E0:03:65:64:94
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:E0:03:65:64:94 type ACL encrypt 0x00
    Error: Authentication Failure

2nd) About the mobilephone itself I can give you informations i
requested with the tool hcitool info 00:E0:03:65:64:94:

hcitool info 00:E0:03:65:64:94 
Requesting information ...
        BD Address:  00:E0:03:65:64:94
        Device Name: Yo-Tamer
        LMP Version: 1.1 (0x1) LMP Subversion: 0x382
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xfe 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <paging scheme> <power
control>
                <transparent SCO>

On Mon, 2005-03-14 at 11:21 +0100, Marcel Holtmann wrote:
> Hi Tamer,
> 
> > How do I make a stable connection to my cellular phone via bluetooth
> > without that the connection is dying. 
> > 
> > 
> > I make: 
> > hcitool cc MAC-ADDRESS 
> > hcitool auth MAC-ADDRESS 
> > 
> > then I enter the pin on the mobile phone and I receive the answer: 
> > 
> > HCI authentication request failed: Input/output error
> > 
> > 
> > Can somebody help me? 
> > 
> > However I get this bluez-pin installed. In which relation does it belong
> > to my problem? And if yes, how do I use it? 
> 
> you will never get a stable connection with "hcitool cc". In the case of
> a mobile phone establish a RFCOMM connection. If you see problems then
> check with "hcidump -X -V" as root what really happens on the device.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

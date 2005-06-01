Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429DF908.80808@eridani.co.uk>
From: Michael McConnell <soruk@eridani.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BNEP session hangs, can't work out why.
References: <4299F069.3080703@eridani.co.uk> <1117454226.7072.135.camel@pegasus>
In-Reply-To: <1117454226.7072.135.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 01 Jun 2005 19:06:00 +0100

Marcel Holtmann wrote:
> Hi Michael,
> 
>>At machine A I have:
>>hci0:   Type: USB
>>         BD Address: 00:05:16:58:9D:C1 ACL MTU: 192:8 SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:269283 acl:1781 sco:0 events:869 errors:0
>>         TX bytes:58266 acl:815 sco:0 commands:42 errors:0
>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (0)'
>>         Class: 0x3e0100
>>         Service Classes: Networking, Rendering, Capturing
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>>         Manufacturer: Cambridge Silicon Radio (10)
>>
>>Machine B has:
>>hci0:   Type: USB
>>         BD Address: 00:0A:94:13:26:7D ACL MTU: 120:20 SCO MTU: 64:0
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:72835 acl:1541 sco:0 events:1813 errors:0
>>         TX bytes:266197 acl:2713 sco:0 commands:24 errors:0
>>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (0)'
>>         Class: 0x3e0100
>>         Service Classes: Networking, Rendering, Capturing
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757
>>         Manufacturer: Silicon Wave (11)
>>
>>Everything starts fine, I can get packets flowing.
>>
>>Then, without warning, the connection stalls.
>>
>>hcidump on A finishes off with:
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 41
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>>     L2CAP(d): cid 0x0040 len 71 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       44.000000 > HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 41 reason 0x13
>>     Reason: Remote User Terminated Connection
>>
>>Machine B reports:
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>>     L2CAP(d): cid 0x0040 len 63 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 59
>>     L2CAP(d): cid 0x0040 len 55 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>>     L2CAP(d): cid 0x0040 len 63 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 59
>>     L2CAP(d): cid 0x0040 len 55 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 24
>>     L2CAP(d): cid 0x0040 len 260 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 9
>>     L2CAP(d): cid 0x0040 len 365 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>>     L2CAP(d): cid 0x0040 len 63 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 38
>>     L2CAP(d): cid 0x0040 len 274 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 2
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 94
>>     L2CAP(d): cid 0x0040 len 570 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 73
>>     L2CAP(d): cid 0x0040 len 789 [psm 15]
>>       BNEP: Compressed(0x02|0)
>>         [proto 0x0800]
>>       20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>>       20.000000 < HCI Command: Disconnect (0x01|0x0006) plen 3
>>     handle 2 reason 0x13
>>     Reason: Remote User Terminated Connection
>>       20.000000 > HCI Event: Command Status (0x0f) plen 4
>>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>>       20.000000 > HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 2 reason 0x16
>>     Reason: Connection Terminated by Local Host
>>
>>(Aside: The timestamps in hcidump don't appear to be working right.)
> 
> 
> they are working for me. Use "hcidump -X -V" and in case of your mailer
> it is better you attach it.

OK.

>>After this, trying 'hcitool info' on each querying the other just results in 
>>"Connection timed out".
> 
> Show the hcidump for this, too.

When querying A from B, I get:
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:05:16:58:9D:C1 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1

(after a delay)

 > HCI Event: Connect Complete (0x03) plen 11
     status 0x24 handle 4 bdaddr 00:05:16:58:9D:C1 type ACL encrypt 0x00
     Error: LMP PDU Not Allowed

with hcitool reporting:
Requesting information ...
Can't create connection: Connection timed out

This error is reported before the LMP PDU Not Allowed error.

When querying B from A, I get:
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0A:94:13:26:7D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1

(after a delay)

 > HCI Event: Connect Complete (0x03) plen 11
     status 0x22 handle 41 bdaddr 00:0A:94:13:26:7D type ACL encrypt 0x00
     Error: LMP Response Timeout

with hcitool also reporting:
Requesting information ...
Can't create connection: Connection timed out

Again, this error is reported before hcidump reports the timeout.


>>I can't work out which end is at fault.
> 
> Check dmesg for any error messages.

Machine B reports:
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection C1:9D:58:16:05:00

Machine A has no error messages.

I also paired both machines to my mobile phone.

Machine A reports with "hcitool info 00:0A:28:F8:76:C2
Requesting information ...
         BD Address:  00:0A:28:F8:76:C2
         Device Name: Motorola V500
         LMP Version: 1.1 (0x1) LMP Subversion: 0x700
         Manufacturer: Broadcom Corporation (15)
         Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power 
control>
                 <transparent SCO>

Machine B, however just gives:
Requesting information ...
Can't create connection: Connection timed out

The hcidump is:
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0A:28:F8:76:C2 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x24 handle 6 bdaddr 00:0A:28:F8:76:C2 type ACL encrypt 0x00
     Error: LMP PDU Not Allowed


Before running BNEP and getting the link to stall, machine B gives the 
same "hcitool info" output as Machine A above.

When getting my phone to scan for devices, both machines are found; 
machine A is identified by name, but machine B is only identified after 
some delay and then only by a string generated from the MAC address. 
hcidump on both machines didn't show anything from doing this scan. 
When I try to send a phonebook item, machine A refuses the connection 
straight away (as I'd expect), but machine B just times out.

After I reset the bluetooth layer on machine B, it can see the phone 
just as machine A can.

>>Machine A is running an unpatched 2.4.30, machine B 2.4.28. (2.4.29 had USB 
>>issues with my DVD burner.) Both are running bluez-libs and bluez-utils 2.17, 
>>and bluz-hcidump 1.21.
> 
> What about using a 2.6.12-rc5 kernel?

That's to come, but they're both production systems so it's something 
I'm wary about. However, I've since upgraded machine B to 2.4.30.

-- 
-- Michael "Soruk" McConnell
    Eridani Star System

    MailStripper - "The easy spam filter."
    http://mailstripper.eridani.co.uk/


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

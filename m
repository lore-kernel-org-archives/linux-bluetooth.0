Return-Path: <bluez-users-admin@lists.sourceforge.net>
Date: Thu, 10 Feb 2005 15:01:12 -0500 (EST)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0502101500220.13274@gaia3.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Re: Trouble pairing with new phone...
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

hciconfig -a says:
hci0:   Type: UART
        BD Address: 00:10:60:AA:FB:C9 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:357 acl:0 sco:0 events:18 errors:0
        TX bytes:849 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)


This is a standard PCMCIA Zoom bluetooth card, worked with a Sony T610
phone before, still works with the palm T.

When I do hcitool info 00:0A:D9:1D:E6:B2 I get the following error:
Requesting information ...
Can't create connection: Input/output error

The hcidump -x output of the above is:
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  B2 E6 1D D9 0A 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Link Key Request (0x17) plen 6
  B2 E6 1D D9 0A 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  B2 E6 1D D9 0A 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 B2 E6 1D D9 0A 00
> HCI Event: PIN Code Request (0x16) plen 6
  B2 E6 1D D9 0A 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  B2 E6 1D D9 0A 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 B2 E6 1D D9 0A 00
> HCI Event: Connect Complete (0x03) plen 11
  06 29 00 B2 E6 1D D9 0A 00 01 00

So it looks like because the phone isn't paired with BlueZ, it won't
give the information hictool is requesting...

As to the "role switch". I'm not doing anything explicitly. hcid.conf has the
following entry which may be involved:
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


(If I use lm accept,master instead of the lm accept that is in the file,
the phone still does not pair...I have also tried using lp hold,snif
instead of the lp rswitch,hold,sniff,park same result, phone does not
pair.)



Jay


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

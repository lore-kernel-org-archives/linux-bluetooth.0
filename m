Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for security
 reasons"
In-Reply-To: <1084868892.5833.45.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BQ0K1-0000wa-00@intern.SerNet.DE>
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
Date: Tue, 18 May 2004 10:51:37 +0200 (CEST)

Hi Marcel and all,
On Tue, 18 May 2004, Marcel Holtmann wrote:
>
> > In contrast to Nokia 6310i, I'm not able to pair my Nokia 6230 (firmware
> > 3.15) and bluez (two 2.4 systems tried, one beeing SuSE 9.0 with
> > kernel 2.5.21-251 and bluez-utils-2.3-57, bluez-libs-2.4-31).
>
> please run "hcitool info <bdaddr-6230>" for me, so I can put this phone
> on my list.
>
Requesting information ...
        BD Address:  00:E0:03:39:C9:AB
        Device Name: Nokia 6230 LP
        LMP Version: 1.1 (0x1) LMP Subversion: 0x380
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x00 0x09
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log>

> > After entering the correct pin (giving the wrong one yields other error)
> > in the phone's pairing dialogue, the 6230 only aborts with
> > "pairing and conn. rejected for security reasons".
>
> Run "hcidump -x" as root and show us the part of connection creation and
> the request for the link key.
HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
  AB C9 39 03 E0 00 04 02 52 01
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
  AB C9 39 03 E0 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 09 04
> HCI Event: PIN Code Request(0x16) plen 6
  AB C9 39 03 E0 00
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
  AB C9 39 03 E0 00 05 38 34 37 37 31 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete(0x0e) plen 10
  01 0D 04 00 AB C9 39 03 E0 00
> HCI Event: Link Key Notification(0x18) plen 23
  AB C9 39 03 E0 00 0F B5 F9 09 4B CC 34 47 B7 91 18 71 5F 0B
  D8 A3 01
> HCI Event: Connect Complete(0x03) plen 11
  00 00 00 AB C9 39 03 E0 00 01 00
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  00 00 0F 00
> HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 00 00
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
  00 00 18 CC
> HCI Event: Command Status(0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
  00 00 00 18 CC
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00
> HCI Event: Disconn Complete(0x05) plen 4
  00 00 00 29

>
> > hcid.conf is more or less default, works with 6310i and can be sent on
> > request.
>
> If it is not default then show it to us.
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
        # if you want a interactiv query of your pin use /bin/bluepin
        # /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
        # pin_helper /bin/bluepin;
        pin_helper /bin/bluepincat;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        # name "BlueZ (%d)";
        name "tux";

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
        lp hold,sniff,park,rswitch;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;
}


>
> > Acer USB adapter (vend/prod 0xb7a/0x7d0).
>
> What is the output of "hciconfig -a". What version of the Acer dongle is
> this?
hci0:   Type: USB
        BD Address: 00:04:3E:C0:6D:93 ACL MTU: 1356:5  SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:7294 acl:0 sco:0 events:342 errors:0
        TX bytes:2754 acl:0 sco:0 commands:143 errors:0
        Features: 0xff 0x07 0x04 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'tux'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver: 0x86
        Manufacturer: Telencomm Inc. (18)


Acer "BT-510".


Thanks,
  Lutz


-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

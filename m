Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Detecting RSSI without connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
	 <1099960170.29330.43.camel@pegasus>
	 <qszu0rfnfil.fsf@mspacman.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1101413321.6465.6.camel@pegasus>
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
Date: Thu, 25 Nov 2004 21:08:41 +0100

Hi Scott,

> >> For a project I'm working on, I'd like to determine which of several
> >> (possibly many) Bluetooth devices is closest.  "Best RSSI" is a good
> >> enough approximation of "closest" for my purposes, and since there may
> >> be many devices and I don't have any other interest in them, I'd like
> >> to get the RSSI without establishing a connection with each device.
> >> 
> >> It appears that "hcitool rssi <bdaddr>" requires that a connection is
> >> established.  Do any cards provide a way of getting RSSI that doesn't
> >> require establishing a connection?
> >
> > starting with the Bluetooth 1.2 specification it is possible to get the
> > RSSI value from the inquiry results. Check the mailing list archives for
> > more details.
> 
> I bought a Bluetooth 1.2 adapter (an IOGear GBU211), but it still
> doesn't seem to work.  From what I found in the archives and the
> source code, it looks like I should set the inquiry mode to 1, then
> just use "hcitool scan".  But it looks like the inquiry mode doesn't
> get set properly:
> 
>   [root@gifford tools]# /usr/local/sbin/hcidump -X &
>     [1] 10382
>     HCIDump - HCI packet analyzer ver 1.12
>     device: hci0 snap_len: 1028 filter: 0xffffffff
>   [root@gifford tools]# /usr/local/sbin/hciconfig hci0 inqmode
>     < HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0
>     > HCI Event: Command Complete (0x0e) plen 4
>       0000: 01 44 0c 11                                       .D..
>     Read inquiry mode on hci0 returned status 17
>   [root@gifford tools]# /usr/local/sbin/hciconfig hci0 inqmode 1
>     < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
>       0000: 01                                                .
>     > HCI Event: Command Complete (0x0e) plen 4
>       0000: 01 45 0c 11                                       .E..

this command returns with error code 0x11 which means unsupported
feature or parameter value. Actually I think this should return unknown
HCI command with error code 0x01.

> It looks like read and write are both returning 17 (hex 0x11), which
> seems to mean unsupported.  hciconfig -a says:
> 
>     hci0:   Type: USB
>         BD Address: 00:02:72:C0:08:CB ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:3340 acl:0 sco:0 events:135 errors:0
>         TX bytes:728 acl:0 sco:0 commands:87 errors:0
>         Features: 0xff 0xff 0x0d 0x38 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x69 LMP Ver: 1.2 (0x2) LMP
>         Subver: 0x694a
>         Manufacturer: Broadcom Corporation (15)

Check with "hciconfig hci0 features" if the inquiry with RSSI feature
bit is set.

> Am I doing this wrong, or is it possible that a Bluetooth 1.2 device
> doesn't support RSSI on inquiry?  If this device doesn't support it,
> can anybody recommend a device available in the US that does support
> RSSI on inquiry?  Does the feature need to be supported on both the
> inquiring device and the inquired device to get RSSI information, or
> is support on the inquiring device enough?

It can be that Broadcom didn't implemented this, which is actually
somekind of stupid. Maybe they only added AFH.

If you buy a CSR based Bluetooth 1.2 device it will support inquiry with
RSSI. Also the 1.2 Silicon Wave based and the AVM BlueFRITZ! USB v2.0
have this support. However both have a bug, but you can work around it.
Maybe the easiest way is a D-Link DBT-120 Rev. B3 and then put the Apple
firmware update on it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

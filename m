Return-Path: <Lutz.Pressler@SerNet.DE>
Date: Wed, 19 May 2004 10:29:06 +0200 (CEST)
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Peter Stephenson <pws@csr.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for security
 reasons"
In-Reply-To: <1084875342.5833.89.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BQMRm-0001ot-00@intern.SerNet.DE>
List-ID: <bluez-users.lists.sourceforge.net>

Hi,
On Tue, 18 May 2004, Marcel Holtmann wrote:
> looks like something is really screwed up here. Please check this with
> another USB dongle to make sure that your phone is not broken.
>
I borrowed a CSR based Allnet 1575.

hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:FF:DE:7F ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:99 acl:0 sco:0 events:13 errors:0
        TX bytes:296 acl:0 sco:0 commands:12 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'tux'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

Pairing and RFCOM usage of the Nokia 6230 (PPP via GPRS) does work with
that one.

hcitool info 00:E0:03:39:C9:AB   now looks different:

Requesting information ...
        BD Address:  00:E0:03:39:C9:AB
        Device Name: Nokia 6230 LP
        LMP Version: 1.1 (0x1) LMP Subversion: 0x380
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x0f 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO>

Any further tests/dums to (re)do with that phone?

Thanks!
  Lutz

-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/

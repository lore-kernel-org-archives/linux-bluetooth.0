Return-Path: <cyrus@holtmann.org>
From: kjonca@o2.pl (Kamil =?iso-8859-2?Q?Jo=F1ca?=)
To: linux-bluetooth@vger.kernel.org
Subject: Re: How to pair device from CLI?
References: <871uebt47d.fsf@alfa.kjonca>
	<20121228080842.GA28814@x220.P-661HNU-F1>
Date: Fri, 28 Dec 2012 14:30:57 +0100
In-Reply-To: <20121228080842.GA28814@x220.P-661HNU-F1> (Johan Hedberg's
	message of "Fri, 28 Dec 2012 10:08:42 +0200")
Message-ID: <87wqw2s3qm.fsf@alfa.kjonca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
writes:

> Hi Kamil,
>
> On Fri, Dec 28, 2012, Kamil Jo=F1ca wrote:

[....]
>
> It's quite odd that you should get RequestPasskey. That's something that
> should only happen if you're pretending to be a keyboard in which case
> you should enter the passkey displayed on the remote device (your phone
> in this case).
Nothing shows on my phone.
>
>> What do I should check? (s)trace?
>>=20
>> Distribution is pretty fresh debian sid.
>
> The most useful too would be hcidump (bluez-hcidump package). The output
> of hcidump -X for the full pairing process would be interesting.

Two tries in attachment.
--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=hcidump.txt
Content-Description: Log 

Sorry, try again.
HCI sniffer - Bluetooth packet analyzer ver 2.4
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr D4:E8:B2:AA:15:FA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr D4:E8:B2:AA:15:FA role 0x01
    Role: Slave
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr D4:E8:B2:AA:15:FA type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr D4:E8:B2:AA:15:FA mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Link Supervision Timeout Change (0x38) plen 4
    handle 12 timeout 8000
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr D4:E8:B2:AA:15:FA name 'theta'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr D4:E8:B2:AA:15:FA
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr D4:E8:B2:AA:15:FA capability 0x04 oob 0x00 auth 0x03
    Capability: Reserved (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr D4:E8:B2:AA:15:FA capability 0x01 oob 0x00 auth 0x03
    Capability: DisplayYesNo (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: User Passkey Request (0x34) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: User Passkey Request Reply (0x01|0x002e) plen 10
    bdaddr D4:E8:B2:AA:15:FA passkey 0
> HCI Event: Command Complete (0x0e) plen 10
    User Passkey Request Reply (0x01|0x002e) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x05 bdaddr D4:E8:B2:AA:15:FA
    Error: Authentication Failure
> HCI Event: Auth Complete (0x06) plen 3
    status 0x05 handle 12
    Error: Authentication Failure
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x05
    Reason: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr D4:E8:B2:AA:15:FA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr D4:E8:B2:AA:15:FA type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr D4:E8:B2:AA:15:FA mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr D4:E8:B2:AA:15:FA name 'theta'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr D4:E8:B2:AA:15:FA
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr D4:E8:B2:AA:15:FA capability 0x04 oob 0x00 auth 0x03
    Capability: Reserved (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr D4:E8:B2:AA:15:FA capability 0x01 oob 0x00 auth 0x03
    Capability: DisplayYesNo (OOB data not present)
    Authentication: Dedicated Bonding (MITM Protection)
> HCI Event: User Passkey Request (0x34) plen 6
    bdaddr D4:E8:B2:AA:15:FA
< HCI Command: User Passkey Request Reply (0x01|0x002e) plen 10
    bdaddr D4:E8:B2:AA:15:FA passkey 0
> HCI Event: Command Complete (0x0e) plen 10
    User Passkey Request Reply (0x01|0x002e) ncmd 1
    status 0x00 bdaddr D4:E8:B2:AA:15:FA
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x05 bdaddr D4:E8:B2:AA:15:FA
    Error: Authentication Failure
> HCI Event: Auth Complete (0x06) plen 3
    status 0x05 handle 12
    Error: Authentication Failure
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x05
    Reason: Authentication Failure

--=-=-=
Content-Type: text/plain



-- 
http://modnebzdury.wordpress.com/2009/10/01/niewiarygodny-list-prof-majewskiej-wprowadzenie/
I want to reach your mind -- where is it currently located?

--=-=-=--

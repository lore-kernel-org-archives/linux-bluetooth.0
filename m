Return-Path: <steve.drew@empics.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4BC42.9204FF99"
Subject: RE: [Bluez-users] Problems connecting to multiple rfcomm sockets
Date: Wed, 27 Oct 2004 17:32:37 +0100
Message-ID: <0DD4EA5DCF754A409C4E182C758C37F38205@tigris.i.empics.co.uk>
From: "Steve Drew" <steve.drew@empics.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4BC42.9204FF99
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: 27 October 2004 16:49
To: Steve Drew
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Problems connecting to multiple rfcomm
sockets

Hi Steve,

> I've been experiencing some problems when trying to open multiple
rfcomm
> ports, with pppd using the rfcomm ports.
>=20
> I have three bluetooth serial ports setup in rfcomm.conf, but it
appears
> that I can open connections to two of them at once.=20
>=20
> While the first two serial ports are connected, and the third is
trying
> to connect, running rfcomm gives;
>=20
> rfcomm0: 00:0E:6D:1A:9A:3F channel 1 connected [tty-attached]
> rfcomm1: 00:02:EE:82:D9:29 channel 2 connected [tty-attached]
> rfcomm2: 00:60:57:70:CD:E1 channel 3 config [tty-attached]
>=20
> Then the terminal with the third connection reports;
>=20
> "Failed to open /dev/rfcomm2: Host is down"
>=20
> At which point running #rfcomm gives;
>=20
> rfcomm0: 00:0E:6D:1A:9A:3F channel 1 connected [tty-attached]
> rfcomm1: 00:02:EE:82:D9:29 channel 2 connected [tty-attached]
> rfcomm2: 00:60:57:70:CD:E1 channel 3 closed.

what does "hcitool con" tell you at this point? Run "hcidump -x" and see
with what error code the third connection fails.


FromSteve-->
At This point running hcitool con shows the following connections=20

Connections:
        < ACL 00:02:EE:82:D9:29 handle 44 state 1 lm MASTER ENCRYPT
        < ACL 00:0E:6D:1A:9A:3F handle 41 state 1 lm MASTER ENCRYPT

Running hcidump -x gives the output attached in hcidump.txt (hcidump is
running from just before the 3rd connection is called, and until after
the error (Host is down) is reported).=20

---->FromSteve

> If I now close the connection to rfcomm1 or rfcomm0, I can connect to
> rfcomm2 (so I can always have a max of 2 active connections).
>=20
> However, If before I start the pppd connections to the serial ports, I
> start 3 copies of l2ping (one to each of the MAC addresses listed
> above), and keep these running, I can establish pppd connections on
> rfcomm0+1+2 at the same time.
>=20
> With this scenario, if one of the pppd sessions terminates, the l2ping
> to the corresponding rfcomm device's MAC will stop giving:
>  "Send failed: Connection reset by peer", and once again I can only
use
> two of the rfcomm ports.=20
>=20
> Using bluez-utils-2.10-2 and bluez-libs-2.10-2 under a 2.4.22-1 kernel
>=20
> Any idea/subjections/requests for more information greatly
appreciated!

What devices did you use (hciconfig -a) and to what devices are you
connecting?

Regards

Marcel

<---FromSteve

The adapter is a USB Dlink DBT-120, and running hciconfig -a gives;

hci0:   Type: USB
        BD Address: 00:0F:3D:5F:1F:C1 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:25060 acl:524 sco:0 events:591 errors:0
        TX bytes:20405 acl:518 sco:0 commands:38 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'slb2-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

The three devices I am connecting to are Nokia6310's.=20

Thanks

steve


------_=_NextPart_001_01C4BC42.9204FF99
Content-Type: text/plain;
	name="hcidump0.txt"
Content-Transfer-Encoding: base64
Content-Description: hcidump0.txt
Content-Disposition: attachment;
	filename="hcidump0.txt"

PCBIQ0kgQ29tbWFuZDogQ3JlYXRlIENvbm5lY3Rpb24gKDB4MDF8MHgwMDA1KSBwbGVuIDEzDQog
IEUxIENEIDcwIDU3IDYwIDAwIDE4IENDIDAxIDAwIDAwIDAwIDAxDQo+IEhDSSBFdmVudDogQ29t
bWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNA0KICAwMCAwMSAwNSAwNA0KPiBBQ0wgZGF0YTogaGFu
ZGxlIDB4MDAyYyBmbGFncyAweDAyIGRsZW4gMzgNCiAgICBMMkNBUChkKTogY2lkIDB4MDA0MCBs
ZW4gMzQgW3BzbSAwXQ0KICAgICAgMDkgRkYgM0IgMDEgN0UgRkYgN0QgMjMgQzAgMjEgN0QgMjkg
NEEgN0QgMjAgN0QgMkMgN0QgMjAgN0QNCiAgICAgIDIwIDdEIDIwIDdEIDIwIEZGIDdEIDIxIDMz
IDRBIEYzIDQzIDdFIDVDDQo8IEFDTCBkYXRhOiBoYW5kbGUgMHgwMDJjIGZsYWdzIDB4MDIgZGxl
biAzOA0KICAgIEwyQ0FQKGQpOiBjaWQgMHgwMDQwIGxlbiAzNCBbcHNtIDBdDQogICAgICAwQiBF
RiAzRCA3RSBGRiA3RCAyMyBDMCAyMSA3RCAyQSA0QSA3RCAyMCA3RCAyQyA3RCAyMCA3RCAyMA0K
ICAgICAgN0QgMjAgN0QgMjAgRkYgN0QgMjEgMzMgNEEgN0QgM0QgQzQgN0UgOUENCj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNQ0KICAwMSAyQyAw
MCAwMSAwMA0KPiBBQ0wgZGF0YTogaGFuZGxlIDB4MDAyOSBmbGFncyAweDAyIGRsZW4gNDANCiAg
ICBMMkNBUChkKTogY2lkIDB4MDA0MCBsZW4gMzYgW3BzbSAwXQ0KICAgICAgMDkgRkYgM0YgMDEg
N0UgRkYgN0QgMjMgQzAgMjEgN0QgMjkgNTEgN0QgMjAgN0QgMkMgN0QgMjAgN0QNCiAgICAgIDIw
IDdEIDIwIDdEIDIwIDdEIDIwIDYxIDdEIDIwIDdEIDIwIEE0IEMxIDdFIDVDDQo8IEFDTCBkYXRh
OiBoYW5kbGUgMHgwMDI5IGZsYWdzIDB4MDIgZGxlbiAzOQ0KICAgIEwyQ0FQKGQpOiBjaWQgMHgw
MDQwIGxlbiAzNSBbcHNtIDBdDQogICAgICAwQiBFRiAzRiA3RSBGRiA3RCAyMyBDMCAyMSA3RCAy
QSA1MSA3RCAyMCA3RCAyQyA3RCAyMCA3RCAyMA0KICAgICAgN0QgMjAgN0QgMjAgN0QgMjAgNjEg
N0QgMjAgN0QgMjAgNEEgNDYgN0UgOUENCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVk
IFBhY2tldHMgKDB4MTMpIHBsZW4gNQ0KICAwMSAyOSAwMCAwMSAwMA0KPiBBQ0wgZGF0YTogaGFu
ZGxlIDB4MDAyYyBmbGFncyAweDAyIGRsZW4gMzkNCiAgICBMMkNBUChkKTogY2lkIDB4MDA0MCBs
ZW4gMzUgW3BzbSAwXQ0KICAgICAgMDkgRkYgM0QgMDEgN0UgRkYgN0QgMjMgQzAgMjEgN0QgMjkg
NEIgN0QgMjAgN0QgMkMgN0QgMjAgN0QNCiAgICAgIDIwIDdEIDIwIDdEIDIwIDdEIDIxIDU5IDMw
IEQ4IEQ5IDdEIDM3IDdFIDVDDQo8IEFDTCBkYXRhOiBoYW5kbGUgMHgwMDJjIGZsYWdzIDB4MDIg
ZGxlbiAzNw0KICAgIEwyQ0FQKGQpOiBjaWQgMHgwMDQwIGxlbiAzMyBbcHNtIDBdDQogICAgICAw
QiBFRiAzQiA3RSBGRiA3RCAyMyBDMCAyMSA3RCAyQSA0QiA3RCAyMCA3RCAyQyA3RCAyMCA3RCAy
MA0KICAgICAgN0QgMjAgN0QgMjAgN0QgMjEgNTkgMzAgRDggMzcgOTAgN0UgOUENCj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNQ0KICAwMSAyQyAw
MCAwMSAwMA0KPiBBQ0wgZGF0YTogaGFuZGxlIDB4MDAyOSBmbGFncyAweDAyIGRsZW4gMzkNCiAg
ICBMMkNBUChkKTogY2lkIDB4MDA0MCBsZW4gMzUgW3BzbSAwXQ0KICAgICAgMDkgRkYgM0QgMDEg
N0UgRkYgN0QgMjMgQzAgMjEgN0QgMjkgNTIgN0QgMjAgN0QgMkMgN0QgMjAgN0QNCiAgICAgIDIw
IDdEIDIwIDdEIDIwIEZGIDdEIDIzIEMwIDIxIDdEIDMxIEIwIDdFIDVDDQo8IEFDTCBkYXRhOiBo
YW5kbGUgMHgwMDI5IGZsYWdzIDB4MDIgZGxlbiAzNw0KICAgIEwyQ0FQKGQpOiBjaWQgMHgwMDQw
IGxlbiAzMyBbcHNtIDBdDQogICAgICAwQiBFRiAzQiA3RSBGRiA3RCAyMyBDMCAyMSA3RCAyQSA1
MiA3RCAyMCA3RCAyQyA3RCAyMCA3RCAyMA0KICAgICAgN0QgMjAgN0QgMjAgRkYgN0QgMjMgQzAg
MjEgRkYgMzcgN0UgOUENCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMg
KDB4MTMpIHBsZW4gNQ0KICAwMSAyOSAwMCAwMSAwMA0KPiBIQ0kgRXZlbnQ6IENvbm5lY3QgQ29t
cGxldGUgKDB4MDMpIHBsZW4gMTENCiAgMDQgMDAgMDAgRTEgQ0QgNzAgNTcgNjAgMDAgMDEgMDAN
Cg==

------_=_NextPart_001_01C4BC42.9204FF99--

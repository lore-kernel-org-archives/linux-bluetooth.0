Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <001c01c4b223$9875c130$752cb8ac@monika>
Reply-To: "Monika Hubrich" <monikahubrich@aol.com>
From: "Monika Hubrich" <monikahubrich@aol.com>
To: <bluez-users@lists.sourceforge.net>
References: <E1CHrun-0004K5-67@sc8-sf-list2.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] PICO Bluetooth Modem and PCMCIA Card
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
Date: Thu, 14 Oct 2004 21:24:20 +0200

> Hello Monika,
> hcidump is a tool used to show the raw
> hci layer during bluetooth activity.
>
> It is used also to understand if bluez has some bugs.
>
> What is needed is to launch hcicump -x
> and, while it is running, on another terminal
> try to reproduce the bluetooth problem.
>
> After doing so, hcidump will show a dump of
> all the hci packet though which gurus like Marcel
> will try to solve your problem.
>
> Regards,
> Diego.
>
>
> On Wed, 2004-10-13 at 19:36, Monika Hubrich wrote:
> > This is the output of hcidump -x:
> > HCIDump - HCI packet analyzer ver 1.12
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > Greetings
> >
> > Moni
> >
> > Hi Monika,
> >
> > > -run "hcidump -x" as root and show us the output.
> > >
> > > When I type in the command hcicump -x,
> > > the output is: Command not found.
> >
> > you have to install the bluez-hcidump package.
> >
> > Regards
> >
> > Marcel
>
>

I've only created bluepin in ./bin/
Can this be a problem, or have I to install bluez-pin.0.24 (how can I do
that?)
===================================================
Here are the Results:
==========================================================
linux:~ # hciconfig

hci0: Type: PCCARD

BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10 SCO MTU: 64:0

UP RUNNING PSCAN ISCAN

RX bytes:392 acl:0 sco:0 events:16 errors:0

TX bytes:325 acl:0 sco:0 commands:16 errors:0

linux:~ # hciconfig -a

hci0: Type: PCCARD

BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10 SCO MTU: 64:0

UP RUNNING PSCAN ISCAN

RX bytes:392 acl:0 sco:0 events:16 errors:0

TX bytes:325 acl:0 sco:0 commands:16 errors:0

Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3

Link policy: RSWITCH HOLD SNIFF PARK

Link mode: SLAVE ACCEPT

Name: 'BlueZ (0)'

Class: 0x000100

Service Classes: Unspecified

Device Class: Computer, Uncategorized

HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver: 0x300

Manufacturer: Ericsson Technology Licensing (0)

linux:~ # hcitool scan

Scanning ...

00:02:C7:09:9B:FA PICO MODEM

linux:~ # sdptool browse 00:02:C7:09:9B:FA

Browsing 00:02:C7:09:9B:FA ...

linux:~ # rfcom connect 0 00:02:C7:09:9B:FA 1

bash: rfcom: command not found

linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 1

Can't connect RFCOMM socket: Connection refused

====> Here I changed the PIN in bluepin from "12345" (so it is in the
description of my modem) to "1234" (like I've seen it in the Internet) and
tried it again.

linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 1

Can't connect RFCOMM socket: Connection refused

linux:~ #

============================================================================
====================

hcidump:

linux:~ # hcidump -x

HCIDump - HCI packet analyzer ver 1.12

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Read Local Name (0x03|0x0014) plen 0

> HCI Event: Command Complete (0x0e) plen 252

01 14 0C 00 42 6C 75 65 5A 20 28 30 29 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00

< HCI Command: Read Class of Device (0x03|0x0023) plen 0

> HCI Event: Command Complete (0x0e) plen 7

01 23 0C 00 00 01 00

< HCI Command: Read Local Version Information (0x04|0x0001) plen 0

> HCI Event: Command Complete (0x0e) plen 12

01 01 10 00 01 0B 00 01 00 00 00 03

< HCI Command: Inquiry (0x01|0x0001) plen 5

33 8B 9E 08 64

> HCI Event: Command Status (0x0f) plen 4

00 01 01 04

> HCI Event: Inquiry Result (0x02) plen 15

01 FA 9B 09 C7 02 00 01 00 00 10 02 40 FF 4E

> HCI Event: Inquiry Complete (0x01) plen 1

00

< HCI Command: Remote Name Request (0x01|0x0019) plen 10

FA 9B 09 C7 02 00 02 00 00 00

> HCI Event: Command Status (0x0f) plen 4

00 01 19 04

> HCI Event: Remote Name Req Complete (0x07) plen 255

00 FA 9B 09 C7 02 00 50 49 43 4F 20 4D 4F 44 45 4D 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

< HCI Command: Create Connection (0x01|0x0005) plen 13

FA 9B 09 C7 02 00 18 CC 01 00 FF CE 00

> HCI Event: Command Status (0x0f) plen 4

00 01 05 04

> HCI Event: Connect Complete (0x03) plen 11

00 01 00 FA 9B 09 C7 02 00 01 00

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 1 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

01 00 0F 00

> HCI Event: Max Slots Change (0x1b) plen 3

01 00 05

> HCI Event: Command Complete (0x0e) plen 6

01 0D 08 01 01 00

> ACL data: handle 0x0001 flags 0x02 dlen 24

L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

> ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 24

L2CAP(d): cid 0x0040 len 20 [psm 1]

SDP SSA Req: tid 0x0 len 0xf

pat uuid-16 0x1002 (PubBrwsGrp)

max 0xffff

aid(s) 0x0000 - 0xffff

cont 00

> ACL data: handle 0x0001 flags 0x02 dlen 15

L2CAP(d): cid 0x0040 len 11 [psm 1]

SDP SSA Rsp: tid 0x0 len 0x6

cnt 0x3

cont 00

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

01 01 00 05 00

> ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3

01 00 13

> HCI Event: Command Status (0x0f) plen 4

00 00 06 04

> HCI Event: Disconn Complete (0x05) plen 4

00 01 00 16

> HCI Event: Command Complete (0x0e) plen 4

01 00 00 00

< HCI Command: Create Connection (0x01|0x0005) plen 13

FA 9B 09 C7 02 00 18 CC 00 00 00 00 00

> HCI Event: Command Status (0x0f) plen 4

00 01 05 04

> HCI Event: Connect Complete (0x03) plen 11

00 01 00 FA 9B 09 C7 02 00 01 00

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

01 00 0F 00

> HCI Event: Max Slots Change (0x1b) plen 3

01 00 05

> HCI Event: Command Complete (0x0e) plen 6

01 0D 08 01 01 00

> ACL data: handle 0x0001 flags 0x02 dlen 24

L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 16

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4

MTU 1024

< ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

> ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

< ACL data: handle 0x0001 flags 0x02 dlen 18

L2CAP(d): cid 0x0040 len 14 [psm 3]

RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8

dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0

frame_size 667 max_retrans 0 credits 7

> HCI Event: Number of Completed Packets (0x13) plen 5

01 01 00 05 00

> ACL data: handle 0x0001 flags 0x02 dlen 18

L2CAP(d): cid 0x0040 len 14 [psm 3]

RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8

dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0

frame_size 667 max_retrans 0 credits 4

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59

> HCI Event: Link Key Request (0x17) plen 6

FA 9B 09 C7 02 00

< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6

FA 9B 09 C7 02 00

> HCI Event: Command Complete (0x0e) plen 10

01 0C 04 00 FA 9B 09 C7 02 00

> HCI Event: PIN Code Request (0x16) plen 6

FA 9B 09 C7 02 00

< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6

FA 9B 09 C7 02 00

> HCI Event: Command Complete (0x0e) plen 10

01 0E 04 00 FA 9B 09 C7 02 00

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

> ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3

01 00 13

> HCI Event: Command Status (0x0f) plen 4

00 00 06 04

> HCI Event: Disconn Complete (0x05) plen 4

00 01 00 16

> HCI Event: Command Complete (0x0e) plen 4

01 00 00 00

< HCI Command: Create Connection (0x01|0x0005) plen 13

FA 9B 09 C7 02 00 18 CC 00 00 00 00 00

> HCI Event: Command Status (0x0f) plen 4

00 01 05 04

> HCI Event: Connect Complete (0x03) plen 11

00 01 00 FA 9B 09 C7 02 00 01 00

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

01 00 0F 00

> HCI Event: Max Slots Change (0x1b) plen 3

01 00 05

> HCI Event: Command Complete (0x0e) plen 6

01 0D 08 01 01 00

> ACL data: handle 0x0001 flags 0x02 dlen 24

L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 16

L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4

MTU 1024

< ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

> ACL data: handle 0x0001 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

< ACL data: handle 0x0001 flags 0x02 dlen 18

L2CAP(d): cid 0x0040 len 14 [psm 3]

RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8

dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0

frame_size 667 max_retrans 0 credits 7

> HCI Event: Number of Completed Packets (0x13) plen 5

01 01 00 05 00

> ACL data: handle 0x0001 flags 0x02 dlen 18

L2CAP(d): cid 0x0040 len 14 [psm 3]

RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8

dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0

frame_size 667 max_retrans 0 credits 4

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59

> HCI Event: Link Key Request (0x17) plen 6

FA 9B 09 C7 02 00

< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6

FA 9B 09 C7 02 00

> HCI Event: Command Complete (0x0e) plen 10

01 0C 04 00 FA 9B 09 C7 02 00

> HCI Event: PIN Code Request (0x16) plen 6

FA 9B 09 C7 02 00

< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6

FA 9B 09 C7 02 00

> HCI Event: Command Complete (0x0e) plen 10

01 0E 04 00 FA 9B 09 C7 02 00

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73

< ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd

< ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> ACL data: handle 0x0001 flags 0x02 dlen 8

L2CAP(d): cid 0x0040 len 4 [psm 3]

RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

> ACL data: handle 0x0001 flags 0x02 dlen 12

L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3

01 00 13

> HCI Event: Command Status (0x0f) plen 4

00 00 06 04

> HCI Event: Disconn Complete (0x05) plen 4

00 01 00 16

> HCI Event: Command Complete (0x0e) plen 4

01 00 00 00



----- Original Message -----
From: "Diego Liziero" <liziero.diego@unimore.it>
To: "Monika Hubrich" <monikahubrich@aol.com>
Sent: Thursday, October 14, 2004 9:48 AM
Subject: Re: [Bluez-users] PICO Bluetooth Modem and PCMCIA Card


> Hello Monika,
> hcidump is a tool used to show the raw
> hci layer during bluetooth activity.
>
> It is used also to understand if bluez has some bugs.
>
> What is needed is to launch hcicump -x
> and, while it is running, on another terminal
> try to reproduce the bluetooth problem.
>
> After doing so, hcidump will show a dump of
> all the hci packet though which gurus like Marcel
> will try to solve your problem.
>
> Regards,
> Diego.
>
>
> On Wed, 2004-10-13 at 19:36, Monika Hubrich wrote:
> > This is the output of hcidump -x:
> > HCIDump - HCI packet analyzer ver 1.12
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > Greetings
> >
> > Moni
> >
> > Hi Monika,
> >
> > > -run "hcidump -x" as root and show us the output.
> > >
> > > When I type in the command hcicump -x,
> > > the output is: Command not found.
> >
> > you have to install the bluez-hcidump package.
> >
> > Regards
> >
> > Marcel
>
>



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

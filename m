Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] SCO. Some ideas.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <A1F0D47583A2D711919F00600819B3A4028B8E@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 1 Mar 2004 15:25:23 -0500

James,

I currently have two systems:=20
- my development host machine - an x86 PC, 2.4.20-6 Red Hat. There is
no patch available for this kernel, so I'm doing my work on the =
following:
- my target machine, an xScale single board computer, 2.4.19,=20
with several hardware specific patches. I did apply the 2.4.19.mh14 =
patch to this.

For both machines. I use an Anycomm USB BT dongle. I don't know what =
chipset is inside.

So I've got rfcomm, hci, SDP and sco.c on the target xScale machine.=20
The modules are loaded OK. I can "hcitool scan" and see the headset.

I've been running the following commands:
hcid
hciconfig hci0 voice 0x0040
sdpd
sdptool add --channel=3D7 HSET
hstest play file 00:02:72:41:2E:2F 7
<<< nothing seems to happen>>>>

Before I can connect, the headset must be paired. I put the headset=20
into pairing mode, then how do I get linux to initiate pairing with=20
the headset ?

I'm not sure what to do next. Any advice is appreciated.

Thanks,

Rich


-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
Sent: Monday, March 01, 2004 2:47 PM
To: Williams, Richard
Cc: BlueZ Mailing List
Subject: Re: [Bluez-devel] SCO. Some ideas.


Williams, Richard wrote:
> James,
>=20
> Thanks for the reply. But I am having trouble getting SCO to work on =
my
> platform. Can you point me to any documentation that explains how
> to get this to work ? I want to have a Sony-Ericsson BT headset to=20
> send/receive audio to/from my Linux box - 2.4.19.=20
>=20
> I do have BT working: rfcomm, SDP, Obex, but SCO is giving me more=20
> trouble.
>=20
> Thanks very much,
>=20
> Rich
>=20

Which type of bluetooth interface do you have on the PC?
I currently use a USB CSR based bluetooth device and a Sony-Ericsson=20
HBH-30 headset.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jun 2008 11:32:40 +0200
From: "Martin Kupf" <mulata@gmx.de>
In-Reply-To: <20080610074231.39470@gmx.net>
Message-ID: <20080610093240.17970@gmx.net>
MIME-Version: 1.0
References: <20080609163110.282100@gmx.net> <20080610074231.39470@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Well I try to start the Input Service but the binary bluetoothd-input-servi=
ce is missing.
If I compile (with --enable-input-service) the binary doesn't get created e=
ither.
But anyway what exaclty is the task of the Input Service?
I might not have to need it since I have to use bthid.
Anyway I did some further tests in order to be able to use the keyboard aft=
er an initial pairing without the need of entering a pin again.


A link key is present in /var/lib/bluettoth/my_host_device/xx.xx.xx.xx.xx/
created by the initial pairing.

If I press a key the keyboard tries to reconnect, at the same time bthid is=
 running with -a, -e option (enables encryption and auth. support). =


hcid outputs:  : link_key_request (sba=3D00:04:0E:8B:AE:92, dba=3D00:18:00:=
00:61:45)

Hcidump says the following:

 HCI Event: Connect Request (0x04) plen 10
  45 61 00 00 18 00 40 25 00 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  45 61 00 00 18 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  00 05 00 45 61 00 00 18 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  05 00 0F 00
> HCI Event: Max Slots Change (0x1b) plen 3
  05 00 05
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 05 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  05 00 18 CC
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 05 00 18 CC
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
      Connection pending - Authentication pending
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  05 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 11 04
> HCI Event: Link Key Request (0x17) plen 6
  45 61 00 00 18 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  45 61 00 00 18 00 02 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  45 61 00 00 18 00 64 0B D8 84 94 21 CB AD 4E 68 2C C8 8B C3
  C7 88
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 45 61 00 00 18 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 45 61 00 00 18 00 42 54 4B 42 2D 36 31 34 35 00 00 00 00
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
> HCI Event: Auth Complete (0x06) plen 3
  00 05 00
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  05 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 13 04
> HCI Event: Encrypt Change (0x08) plen 4
  00 05 00 01
< ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Encrypt Change (0x08) plen 4
  00 05 00 00
> HCI Event: Role Change (0x12) plen 8
  00 45 61 00 00 18 00 00
> HCI Event: Max Slots Change (0x1b) plen 3
  05 00 05
> HCI Event: Encrypt Change (0x08) plen 4
  00 05 00 01
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
< ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0042
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 05 00 01 00
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0042
> ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

What do you think about the outputs?
The problem is, bthid crashes with segment fault...

bye
mulata



-------- Original-Nachricht --------
> Datum: Tue, 10 Jun 2008 09:42:31 +0200
> Von: "Martin Kupf" <mulata@gmx.de>
> An: BlueZ users <bluez-users@lists.sourceforge.net>
> Betreff: Re: [Bluez-users] pairing problems

> I did some more research and I figured out that I will have to use the
> InputService of bluez.
> So with the dbus Interface of bluez I think have to do the following
> steps, right?:
> ActiveService (input)
> CreateDevice (bdaddr of keyboard)
> Connect()
> CreateDevice looks for a link key and if it finds one, an authorized
> connection can be established with Connect() I guess.
> =

> >>From the point that an auhorized connection is established (this can be
> recognized if hcitool con returns a connection with AUTH at the end of the
> line) I can start bthid and use the keyboard.
> =

> =

> Thanks for any hints
> -mulata
> =

> PS: Sorry that I have published a similar thread (email) with my google
> account, but I have at the moment huge roubel with my google mail account=
..
> =

> =

> =

> =

> -------- Original-Nachricht --------
> > Datum: Mon, 09 Jun 2008 18:31:10 +0200
> > Von: mulata@gmx.de
> > An: bluez-users@lists.sourceforge.net
> > Betreff: [Bluez-users] pairing problems
> =

> > Hi!
> > After an initial I always have to go through the complete pairing
> process,
> > there is no reconnect.
> > =

> > I want to use a Bluetooth keyboard and it works fine so far, but there
> are
> > some problems after the initial pairing.
> > =

> > To get the keyboard wokring I do the following steps:
> > =

> > hcid and passkey-agent are running.
> > =

> > hcitool scan
> > hcitool cc <bdaddr>
> > After this step hcitool con lists a established connection to the
> keyboard
> > auth <bdaddr>
> > Enter PIN on keyboard
> > =

> > Now the entry in hcitool con changes to AUTH
> > So the connection is authorized and established and the keyboard works
> (I
> > use bthid, anyway the process of authorization and pairing is done by
> hcid,
> > and hcitools)
> > =

> > Usually from now this initial pairing process shouldnt be necessary for
> > further sessions, but unfortunately it is.
> > In oder to use the keyboard again (after disabling it) I have to go
> > through the whole process again, but befor I have to
> /var/lib/bluetooth/*
> > =

> > So how can I establish further connections without the whole pairing
> > process?
> > =

> > thanks
> > -- =

> > Martin Kupf
> > =

> > Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
> > Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
> > =

> >
> -------------------------------------------------------------------------
> > Check out the new SourceForge.net Marketplace.
> > It's the best place to buy or sell services for
> > just about anything Open Source.
> > http://sourceforge.net/services/buy/index.php
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> =

> -- =

> Martin Kupf
> =

> Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

> Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
> =

> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- =

Martin Kupf

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

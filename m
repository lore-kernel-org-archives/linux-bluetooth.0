Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FE5D06.8080304@cloutier-vilhuber.net>
From: Lars Vilhuber <lars.vilhuber@cloutier-vilhuber.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] experience with TDK PCMCIA Bluetooth Card, (goBlue)?
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
Date: Mon, 31 Jan 2005 11:29:58 -0500

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| Hi Lars,
|
|>> Symptoms are a collection of
|>>
|>> bcsp_recv: Short BCSP packet
|>> bcsp_recv: Out-of-order packet arrive
|>> bcsp_recv: Error in BCSP hdr checksum
|>>
|>> which I have seen reported for some cards before, but for which I
|>> haven't a solution reported.
|
| so in general your card gets detected as serial port and normal stuff

... after some filling up of /etc/pcmcia/ config files... yes. The lists
helped on that:

config.opts AND bluetooth.conf (one may be redundant):
card "TDK goBlue PCMCIA Bluetooth Adapter"
~  manfid 0x0105,0x4254
~  version "TDK","Bluetooth PC Card II","",""
~  bind "serial_cs" class "bluetooth"

and adding an elif condition in /etc/pcmcia/bluetooth conditional on MANFID.

| like "hciconfig -a" is working?

that yields:

hci0:   Type: UART
~        BD Address: 00:80:98:64:B4:D1 ACL MTU: 192:8  SCO MTU: 64:8
~        UP RUNNING PSCAN ISCAN AUTH
~        RX bytes:240 acl:0 sco:0 events:12 errors:0
~        TX bytes:492 acl:0 sco:0 commands:12 errors:0
~        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
~        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
~        Link policy: RSWITCH HOLD SNIFF PARK
~        Link mode: SLAVE ACCEPT
~        Name: 'Laptop iveshall (0)'
~        Class: 0x14010c
~        Service Classes: Rendering
~        Device Class: Computer, Laptop
~        HCI Ver: 1.1 (0x1) HCI Rev: 0x33d LMP Ver: 1.1 (0x1) LMP Subver:
0x33d
~        Manufacturer: Cambridge Silicon Radio (10)


I should note that most everything works in principle:
	- I can browse services of other devices using this card
~        - I can receive browse requests from other devices
~          (T610, Palm T3)
~        - I can receive/send *small* data chunks (vcard, etc.)
	- I can *not* receive/send larger data chunks (jpeg)
~          or streams of data (PPP connection)

It all breaks apart at the short packet/bcsp/etc.

|

- --
Lars Vilhuber           Private:  lars.vilhuber@cloutier-vilhuber.net
~                        Business: lars.vilhuber@cornell.edu
~                        http://www.cloutier-vilhuber.net/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/l0F/QE38DNic0YRAo4gAJ4msDfKWixpIuJiqN7GfoEvoqLxFwCg+i0w
tzeIZ+dZJACoNOmfUGuaF1A=
=VSrB
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

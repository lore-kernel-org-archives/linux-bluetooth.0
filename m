Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000b01c3f98e$697f79a0$494db850@ULLA>
From: "Zbigniew Diaczyszyn \(gmx\)" <z.dia@gmx.de>
To: <bluez-users@lists.sourceforge.net>
References: <000d01c3f343$d89f1ad0$e04db850@ULLA> <1076855680.14758.55.camel@pegasus>  <000b01c3f599$04aaf520$de4bb850@ULLA> <1077058491.2665.131.camel@pegasus>  <003b01c3f65e$371ef400$dc4db850@ULLA> <1077147114.2685.11.camel@pegasus>  <000601c3f8c9$98e2c820$3d4bb850@ULLA> <1077415764.2716.21.camel@pegasus>
Subject: Re: [Bluez-users] rfcomm socket message: function not implemented
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sun, 22 Feb 2004 22:54:12 +0100

Hi Marcel,

> > Feb 19 22:30:13 linux hcid[1307]: link_key_request =
(sba=3D8C:97:A6:60:10:00, dba=3D2C:AC:29:60:10:00)
>=20
> if you see this, there is something on the HCI layer.

Indeed. I'm now able proudly to present the hcidump-activity. Meanwhile =
I have updated to Suse 9.0 and recompiled hcidump. The error message has =
changed :-)

< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
> HCI Event: Connect Complete(0x03) plen 11

And here is the protocol from kinternet:
------------------------------
SuSE Meta pppd (smpppd-ifcfg), Version 1.06 on linux.
...
Status is: connecting
pppd[0]: Plugin passwordfd.so loaded.
pppd[0]: Failed to open /dev/rfcomm0: Function not implemented
Status is: disconnected
pppd[0] died: Serial port open failed (exit code 7)
---------------------------------------


=20





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

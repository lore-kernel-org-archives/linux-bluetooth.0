Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 02 Dec 2006 17:48:46 +0100
From: "Glen Rolle" <g.len@gmx.de>
Message-ID: <20061202164846.252080@gmx.net>
MIME-Version: 1.0
To: kristoffer.lunden@gamemaker.nu
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DiNovo + Ubuntu edgy, hid2hci is not working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I found your mail on the bluez mailing list that you have trouble switching=
 your DiNovo to bluetooth mode. The problem is, that Logitech has changed I=
Ds when releasing the Laser-version.

The following patch will solve your problem. (At least I hope so :-) )

I have posted this patch to the devel list but got no reaction from the res=
ponsible persons. So I do not know whether this patch will be integrated in=
 bluez some day.

Good luck,

G.len

--- hid2hci.c.dinovo.diff       2006-10-01 22:39:55.000000000 +0200
+++ tools/hid2hci.c     2006-10-01 22:45:50.000000000 +0200
@@ -223,7 +223,9 @@
         { HCI, 0x046d, 0xc703, switch_logitech },
         { HCI, 0x046d, 0xc704, switch_logitech },
         { HCI, 0x046d, 0xc705, switch_logitech },
         { HCI, 0x046d, 0xc70a, switch_logitech },       /* Logitech diNovo=
 mouse */
 +       { HCI, 0x046d, 0xc70b, switch_logitech },       /* Logitech diNovo=
 Laser keyboard */
 +       { HCI, 0x046d, 0xc70c, switch_logitech },       /* Logitech diNovo=
 Laser mouse */
         { HCI, 0x046d, 0xc70e, switch_logitech },       /* logitech diNovo=
 keyboard */
         { -1 }
  };
-- =

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

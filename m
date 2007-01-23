Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Lauri Lubi" <lauri@lubi.se>
To: <bluez-devel@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 12:03:38 +0100
Message-ID: <000001c73ede$232d4660$0409a8c0@LUBI>
MIME-Version: 1.0
Subject: [Bluez-devel] HCI version
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

Does anybody know the meaning of HCI version in hciconfig =96a ?
I have a dongle
(http://www.globalsat.com.tw/eng/product_detail_00000057.htm) which should
be Bluetooth 2.0 + EDR. This is what is says on Globalsats homepage and in
Bluetooth Qualified Product Listing Notice from SGS.

BUT:
# hciconfig hci0 version
hci0:=A0=A0 Type: USB
=A0=A0=A0=A0=A0=A0=A0 BD Address: 00:0D:B5:21:02:54 ACL MTU: 384:8 SCO MTU:=
 64:8
=A0=A0=A0=A0=A0=A0=A0 HCI Ver: 1.2 (0x2) HCI Rev: 0x7a6 LMP Ver: 1.2 (0x2) =
LMP Subver:
0x7a6
=A0=A0=A0=A0=A0=A0=A0 Manufacturer: Cambridge Silicon Radio (10)

Is HCI Ver the same as supported Bluetooth version?



Mvh
Lauri Lubi
Lubi Datakonsult
Tel +46 (0) 174 40416
Mob +46 (0) 730 39 31 00
lauri@lubi.se



-- =

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.432 / Virus Database: 268.17.4/644 - Release Date: 2007-01-22
07:30
 =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: ben4fun <ben_4_fun@freenet.de>
Cc: bluez-users mailing list <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408170949.50588.cijoml@volny.cz>
References: <1091742606.6143.17.camel@localhost>
	 <1092727197.12606.1.camel@localhost> <1092728177.31651.6.camel@pegasus>
	 <200408170949.50588.cijoml@volny.cz>
Content-Type: multipart/alternative; boundary="=-0GEVL8BM25uYTdFafdNM"
Message-Id: <1092776029.3475.27.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 17 Aug 2004 22:53:50 +0200


--=-0GEVL8BM25uYTdFafdNM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le mar 17/08/2004 =E0 09:49, Bc. Michal Semler a =E9crit :

> Hi Marcel,
>=20
> better way is to buy a better dongle  (CSR based) ;-)
>=20
> M.
>=20

But the cheapest way was to follow the advice of Marcel. It's almost
done.
With the new kernel from kernel.org, i can now send data from my mobile
phone to my pc.
But it doesn't work in the other way. It seems I have some problems to
pair the mobile phone with the pc.

But I am happy that it works in one way.
=20
this is the results of my new hciconfig -a=20
=20
hci0:   Type: USB
        BD Address: 00:02:72:B3:43:18 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:102019 acl:4770 sco:0 events:292 errors:0
        TX bytes:5159 acl:258 sco:0 commands:48 errors:0
        Features: 0xff 0xff 0x0d 0x38 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver:
0x800
        Manufacturer: Broadcom Corporation (15)

Big thanks to you Marcel ans Michal

Regards

Ben


--=-0GEVL8BM25uYTdFafdNM
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Le mar 17/08/2004 &#224; 09:49, Bc. Michal Semler a &#233;crit&nbsp;:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hi Marcel,

better way is to buy a better dongle  (CSR based) ;-)

M.
</I></FONT></PRE>
</BLOCKQUOTE>
But the cheapest way was to follow the advice of Marcel. It's almost done.<BR>
With the new kernel from kernel.org, i can now send data from my mobile phone to my pc.<BR>
But it doesn't work in the other way. It seems I have some problems to pair the mobile phone with the pc.<BR>
<BR>
But I am happy that it works in one way.<BR>
 <BR>
this is the results of my new hciconfig -a <BR>
 <BR>
hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:B3:43:18 ACL MTU: 377:10&nbsp; SCO MTU: 16:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:102019 acl:4770 sco:0 events:292 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:5159 acl:258 sco:0 commands:48 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0d 0x38 0x00 0x00 0x00 0x00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: HOLD SNIFF PARK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver: 0x800<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporation (15)<BR>
<BR>
Big thanks to you Marcel ans Michal<BR>
<BR>
Regards<BR>
<BR>
Ben<BR>
<BR>
</BODY>
</HTML>

--=-0GEVL8BM25uYTdFafdNM--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

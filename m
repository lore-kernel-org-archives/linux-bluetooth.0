Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY107-W1580ABAE4B060A2CC0ADECD8340@phx.gbl>
From: Adolfo Bulfoni <iaquintovski@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Mon, 28 Jan 2008 18:20:57 +0100
MIME-Version: 1.0
Subject: [Bluez-devel] inquiry with RSSI (not via d-bus & python)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1071446074=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1071446074==
Content-Type: multipart/alternative;
	boundary="_40ae776c-3589-4375-baa9-154c8cf18731_"

--_40ae776c-3589-4375-baa9-154c8cf18731_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi guys, I'm trying to setup an inquiry with RSSI. So far in hci.c there is=
 no hci_inquiry_with_RSSI function, infact the *inquiry_info returned is a =
normal inquiry_info struct (without the rssi value). How can I perform an i=
nquiry with rssi operation??
I don't want to use python and d-bus because i have already a C native libr=
ary linked to my java program via JNI, and i don't want to mix-up things fu=
rthermore. Do you know some code snippet performing similar operations? (un=
fortunately i'm not very good in C programming :( )

best regards,

adolfo bulfoni

_________________________________________________________________
Scarica GRATIS la versione personalizzata MSN di Internet Explorer 7!
http://optimizedie7.msn.com/default.aspx?mkt=3Dit-it=

--_40ae776c-3589-4375-baa9-154c8cf18731_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Hi guys, I'm trying to setup an inquiry with RSSI. So far in hci.c there is=
 no hci_inquiry_with_RSSI function, infact the *inquiry_info returned is a =
normal inquiry_info struct (without the rssi value). How can I perform an i=
nquiry with rssi operation??<br>I don't want to use python and d-bus becaus=
e i have already a C native library linked to my java program via JNI, and =
i don't want to mix-up things furthermore. Do you know some code snippet pe=
rforming similar operations? (unfortunately i'm not very good in C programm=
ing :( )<br><br>best regards,<br><br>adolfo bulfoni<br><br /><hr />Windows =
Live Messenger <a href=3D'http://www.messenger.it' target=3D'_new'>Prova il=
 nuovo Messenger 2008, =E8 GRATIS!</a></body>
</html>=

--_40ae776c-3589-4375-baa9-154c8cf18731_--


--===============1071446074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1071446074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1071446074==--

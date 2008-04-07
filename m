Return-Path: <cyrus@holtmann.org>
Message-ID: <00bd01c89901$26af9f80$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Mon, 7 Apr 2008 17:45:56 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0934731240=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0934731240==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00BA_01C898D7.3BA48F10"

This is a multi-part message in MIME format.

------=_NextPart_000_00BA_01C898D7.3BA48F10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

After installing *-3.30, when calling DiscoverDevices, with path =
"/hci0", RemoteDeviceFound and RemoteNameUpdated are STILL returned =
against path "/org/bluez/hci0", and not the originating path, "/hci0".

DS

----- Original Message -----=20
From: David Stockwell=20
To: BlueZ development=20
Sent: Friday, March 28, 2008 6:31 PM
Subject: Experimental Mode: org.bluez.Adapter Methods/Signals



I ask because when I tried calling DiscoverDevices, it would fail when I =
called with path "/org/bluez/hci0", but would run when I called it with =
path "/hci0".  But, the funny thing is that because the =
RemoteDeviceFound signal is registered to both the old path and the new =
path, the signals come back on "/org/bluez/hci0".

------=_NextPart_000_00BA_01C898D7.3BA48F10
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>After installing *-3.30, when calling=20
DiscoverDevices, with path "/hci0", RemoteDeviceFound and =
RemoteNameUpdated are=20
STILL returned against path "/org/bluez/hci0", and not the originating =
path,=20
"/hci0".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV style=3D"FONT: 10pt arial">----- Original Message -----=20
<DIV style=3D"BACKGROUND: #e4e4e4; font-color: black"><B>From:</B> <A=20
title=3Ddstockwell@frequency-one.com=20
href=3D"mailto:dstockwell@frequency-one.com">David Stockwell</A> </DIV>
<DIV><B>To:</B> <A title=3Dbluez-devel@lists.sourceforge.net=20
href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ development</A> =
</DIV>
<DIV><B>Sent:</B> Friday, March 28, 2008 6:31 PM</DIV>
<DIV><B>Subject:</B> Experimental Mode: org.bluez.Adapter=20
Methods/Signals</DIV></DIV>
<DIV><BR></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I ask because when I tried calling =
DiscoverDevices,=20
it would fail when I called with path "/org/bluez/hci0", but would run =
when I=20
called it with path "/hci0".&nbsp; But, the funny thing is that because =
the=20
RemoteDeviceFound signal is registered to both the old path and the new =
path,=20
the signals come back on "/org/bluez/hci0".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------=_NextPart_000_00BA_01C898D7.3BA48F10--



--===============0934731240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0934731240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0934731240==--

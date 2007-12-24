Return-Path: <cyrus@holtmann.org>
Message-ID: <001501c84660$6b520040$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <951351190712240702x7b84c38j135735888bbd40d0@mail.gmail.com>
Date: Mon, 24 Dec 2007 20:08:50 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] passkey-agent
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1864845923=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1864845923==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0012_01C84668.CCD3B9F0"

This is a multi-part message in MIME format.

------=_NextPart_000_0012_01C84668.CCD3B9F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

> Currently, I am implementing a passkey-agent for my own application. =
The principle is similar with the /daemon/passkey-agent.c. However, when =
> I run it, the system gives me some errors: "Can't regiter passeky =
agent, passkey agnet already exists".=20

Before launching your own (or the default) passkey-agent, what does a =
"ps eax | grep passkey" output ?
Just in case the default passkey agent is not launched somewhere in your =
startup scripts and you haven't realized

Regards,
Oli

------=_NextPart_000_0012_01C84668.CCD3B9F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi Jason,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>&gt; Currently,=20
I am implementing a passkey-agent for my own application. The principle =
is=20
similar with the /daemon/passkey-agent.c. However, when &gt; I run it, =
the=20
system gives me some errors: "Can't regiter passeky agent, passkey agnet =
already=20
exists". </FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Before launching your own (or the =
default)=20
passkey-agent, what does a "ps eax | grep passkey" output ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Just in case the default passkey agent =
is not=20
launched somewhere in your startup scripts and you haven't =
realized</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Oli</DIV>
<DIV></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0012_01C84668.CCD3B9F0--



--===============1864845923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1864845923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1864845923==--

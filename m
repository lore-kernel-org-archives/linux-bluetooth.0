Return-Path: <cyrus@holtmann.org>
Message-ID: <025201c8d891$75c10260$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 27 Jun 2008 15:07:41 -0500
MIME-Version: 1.0
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [Bluez-devel] org.bluez.Agent interface vs. org.bluez.PasskeyAgent
	and org.bluez.AuthorizationAgent
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1190739894=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1190739894==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_024F_01C8D867.8BB9CD60"

This is a multi-part message in MIME format.

------=_NextPart_000_024F_01C8D867.8BB9CD60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I would like to test BT 2.1 and SSP, and have installed the updated =
kernel with patches onto my system.  To make the connection, I have to =
install or create an Agent that interacts with the BT daemon (currently, =
hcid), to deal with the pairing issues introduced by the SSSP (Secure =
"Supposedly Simple" Pairing).  However, it also appears that the DBus =
interfaces are in flux.

So, what is the future of these; is it the org.bluez.Agent, as described =
in bluez-utils-3.34/doc/agent-api.txt?  Or is it the old PasskeyAgent =
and AuthorizationAgent described in hcid/dbus-api.txt?

Also, the daemon/ directory used to contain sample code for a passkey =
agent and an authorization agent.  If as I assume these need to move =
over to the .Agent interface, are there plans to provide a design =
example for these (or a combined agent daemon)?

Has the gnome agent been modified to the "experimental" interface?

When starting the sample passkey agent, it is possible to provide a path =
that the agent uses as its object path (in function register_agent, with =
the call to dbus_connection_register_object_path).  I assume that this =
path is what we would pass to "Adapter.CreatePairedDevice" as the object =
path of the agent, with the capabilities string.  Am I correct?

Any constraints on what this object path contains (for example: =
"/com/frequency-one")?  I assume it must be unique and must not clash =
with the other paths under org.bluez.

Thanks in advance...

David Stockwell
------=_NextPart_000_024F_01C8D867.8BB9CD60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I would like to test BT 2.1 and SSP, =
and have=20
installed the updated kernel with patches onto my system.&nbsp; To make =
the=20
connection, I have to install or create an Agent that interacts with the =
BT=20
daemon (currently, hcid), to deal with the pairing issues introduced by =
the SSSP=20
(Secure "Supposedly Simple" Pairing).&nbsp; However, it also appears =
that the=20
DBus interfaces are in flux.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So, what is the future of these; is it =
the=20
org.bluez.Agent, as described in =
bluez-utils-3.34/doc/agent-api.txt?&nbsp; Or is=20
it the old PasskeyAgent and AuthorizationAgent described in=20
hcid/dbus-api.txt?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Also, the daemon/ directory used to =
contain sample=20
code for a passkey agent and an authorization agent.&nbsp; If as I =
assume these=20
need to move over to the .Agent interface, are there plans to provide a =
design=20
example for these (or a combined agent daemon)?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Has the gnome agent been modified to =
the=20
"experimental" interface?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When starting the sample passkey agent, =
it is=20
possible to provide a path that the agent uses as its object path (in =
function=20
register_agent, with the call to=20
dbus_connection_register_object_path).&nbsp;&nbsp;I assume that this =
path is=20
what we would pass to "Adapter.CreatePairedDevice" as the object path of =
the=20
agent, with the capabilities string.&nbsp; Am I correct?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any constraints on what this object =
path contains=20
(for example: "/com/frequency-one")?&nbsp; I assume it must be unique =
and must=20
not clash with the other paths under org.bluez.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in advance...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David =
Stockwell</FONT></DIV></BODY></HTML>

------=_NextPart_000_024F_01C8D867.8BB9CD60--



--===============1190739894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1190739894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1190739894==--

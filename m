Return-Path: <cyrus@holtmann.org>
Message-ID: <037601c8c78f$c71a00c0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 5 Jun 2008 23:42:48 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Retrieving an Array of Strings,
	that is attached to a G_HASH_TABLE variant
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2035804604=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============2035804604==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0373_01C8C765.DC51C5B0"

This is a multi-part message in MIME format.

------=_NextPart_000_0373_01C8C765.DC51C5B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In Bluez, certain messages return a GHashTable of type (G_TYPE_STRING, =
G_TYPE_VALUE), so the key is a String, and the value is a Variant.  Many =
of the values returned are boolean, integer, and other simple types; =
others are a boxed Object Path.  These I can handle.

However, in a couple of cases, the value returned is an array of =
pointers to strings (G_TYPE_STRV).

To retrieve the strings, I am trying something like the following:

(GStrv) gPropValue =3D (GStrv) g_hash_table_lookup(propTable, =
"Strings"); // Assume that the "key" is "Strings"
if (gPropValue) {
  while (*gPropValue) {
    cout << *gPropValue << endl;
    ++gPropValue;
  }
}

I do get a properly terminated list of pointers, but each pointer points =
to a null string. ('\0')

I have not yet added debug statements to syslog (my next step) into the =
system level code, but why are the strings not filled in?  What else am =
I missing?  Any suggestions?

David Stockwell
------=_NextPart_000_0373_01C8C765.DC51C5B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>In Bluez, certain messages return a =
GHashTable of=20
type (G_TYPE_STRING, G_TYPE_VALUE), so the key is a String, and the =
value is a=20
Variant.&nbsp; Many of the values returned are boolean, integer, and =
other=20
simple types; others are a boxed Object Path.&nbsp; These I can=20
handle.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>However, in a couple of cases, the =
value returned=20
is an array of pointers to strings (G_TYPE_STRV).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>To retrieve the strings, I am trying =
something like=20
the following:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>(GStrv) gPropValue =3D (GStrv)=20
g_hash_table_lookup(propTable, "Strings"); // Assume that the "key" is=20
"Strings"</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>if (gPropValue) {</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; while (*gPropValue) =
{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; cout &lt;&lt; =
*gPropValue=20
&lt;&lt; endl;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; =
++gPropValue;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; }</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I do get a properly terminated list of =
pointers,=20
but each pointer points to a null string. ('\0')</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have not yet added debug statements =
to syslog (my=20
next step) into the system level code, but why are the strings not =
filled=20
in?&nbsp; What else am I missing?&nbsp; Any suggestions?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David =
Stockwell</FONT></DIV></BODY></HTML>

------=_NextPart_000_0373_01C8C765.DC51C5B0--



--===============2035804604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============2035804604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2035804604==--

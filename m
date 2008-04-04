Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2008 13:54:42 -0500
Message-ID: <1207335282.19116.5.camel@mlimonciello>
From: <Mario_Limonciello@Dell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] Add HID->HCI switching support for newer Dell
	BT cards
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2097626798=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============2097626798==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="=-L9QVnqVtI+kjp+YFDUBm"
Content-class: urn:content-classes:message


--=-L9QVnqVtI+kjp+YFDUBm
Content-Type: multipart/mixed; boundary="=-K9TRzP5X10arYqAg1RMu"


--=-K9TRzP5X10arYqAg1RMu
Content-Type: multipart/alternative; boundary="=-ki0OmxpHPEY9SorVuQI1"


--=-ki0OmxpHPEY9SorVuQI1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

As I've recently discovered, the more recent (Dell Wireless 370+) BT
adapters with the latest firmware don't come up in Bluetooth Radio mode.
They come up in a HID/UHE dongle like mode before the OS loads and
expect the OS to transition the device to HCI mode.  Unfortunately, the
transition to HCI mode isn't done in the same fashion as the existing
switch_hidproxy function available in hid2hci.  I'm attaching a patch to
hid2hci that adds a function for the expected behavior on these newer
adapters.=20

The device that needs to have the report sent to it is claimed by usbhid
at OS load time, so there are some calls in there to release it from
usbhid.

I tested this against a Dell 370 BT adapter.  =EF=BB=BFThis should be the s=
ame
for the newer adapters (after the 370), but I haven't verified them yet,
so there may be an additional patch needed for it.

Thanks,
=20
---
Mario Limonciello
Dell | Linux Engineering
mario_limonciello@dell.com



--=-ki0OmxpHPEY9SorVuQI1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.18.0">
</HEAD>
<BODY>
Hello,<BR>
<BR>
As I've recently discovered, the more recent (Dell Wireless 370+) BT adapte=
rs with the latest firmware don't come up in Bluetooth Radio mode.&nbsp; Th=
ey come up in a HID/UHE dongle like mode before the OS loads and expect the=
 OS to transition the device to HCI mode.&nbsp; Unfortunately, the transiti=
on to HCI mode isn't done in the same fashion as the existing switch_hidpro=
xy function available in hid2hci.&nbsp; I'm attaching a patch to hid2hci th=
at adds a function for the expected behavior on these newer adapters. <BR>
<BR>
The device that needs to have the report sent to it is claimed by usbhid at=
 OS load time, so there are some calls in there to release it from usbhid.<=
BR>
<BR>
I tested this against a Dell 370 BT adapter.&nbsp; &#65279;This should be t=
he same for the newer adapters (after the 370), but I haven't verified them=
 yet, so there may be an additional patch needed for it.<BR>
<BR>
Thanks,<BR>
 <BR>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
<FONT SIZE=3D"2"><FONT COLOR=3D"#808080">---</FONT></FONT><BR>
<FONT SIZE=3D"2"><FONT COLOR=3D"#808080">Mario Limonciello</FONT></FONT><BR=
>
<B><FONT SIZE=3D"1"><FONT COLOR=3D"#ff0000">Dell</FONT></FONT></B><B> </B><=
B><FONT SIZE=3D"1"><FONT COLOR=3D"#000000">|</FONT></FONT></B><B><FONT SIZE=
=3D"1"><FONT COLOR=3D"#808080"> Linux Engineering</FONT></FONT></B><BR>
<FONT SIZE=3D"1"><FONT COLOR=3D"#808080">mario_limonciello@dell.com</FONT><=
/FONT><BR>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-ki0OmxpHPEY9SorVuQI1--

--=-K9TRzP5X10arYqAg1RMu
Content-Disposition: attachment; filename=007_dell_bluetooth.patch
Content-Type: text/x-patch; name=007_dell_bluetooth.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtTnVyIC14ICcqLm9yaWcnIC14ICcqficgYmx1ZXotdXRpbHMtMy4yNi90b29scy9oaWQy
aGNpLmMgYmx1ZXotdXRpbHMtMy4yNi5uZXcvdG9vbHMvaGlkMmhjaS5jDQotLS0gYmx1ZXotdXRp
bHMtMy4yNi90b29scy9oaWQyaGNpLmMJMjAwOC0wMi0wMSAxNzoxNjozNC4wMDAwMDAwMDAgLTA2
MDANCisrKyBibHVlei11dGlscy0zLjI2Lm5ldy90b29scy9oaWQyaGNpLmMJMjAwOC0wNC0wNCAx
MzozNDoxMy4wMDAwMDAwMDAgLTA1MDANCkBAIC0yMTEsNiArMjExLDQyIEBADQogCXJldHVybiBl
cnI7DQogfQ0KIA0KK3N0YXRpYyBpbnQgc3dpdGNoX2RlbGwoc3RydWN0IGRldmljZV9pbmZvICpk
ZXZpbmZvKQ0KK3sNCisJY2hhciByZXBvcnRbXSA9IHsgMHg3RiwgMHgxMywgMHgwMCwgMHgwMH07
DQorDQorCXN0cnVjdCB1c2JfZGV2X2hhbmRsZSAqaGFuZGxlOw0KKwlpbnQgZXJyOw0KKw0KKwkv
L3JlbGVhc2UgYW55IGxvY2tzIHRoYXQgdGhlIGtlcm5lbCBtYXkgaGF2ZSBvbiB0aGlzIGRldmlj
ZQ0KKwloYW5kbGUgPSB1c2Jfb3BlbihkZXZpbmZvLT5kZXYpOw0KKwlpZiAoaGFuZGxlKQ0KKwl7
DQorCQl1c2JfY2xhaW1faW50ZXJmYWNlKGhhbmRsZSwgMCk7DQorCQl1c2JfZGV0YWNoX2tlcm5l
bF9kcml2ZXJfbnAoaGFuZGxlLDApOw0KKwl9DQorDQorCS8vc3dpdGNoIGRldmljZSBtb2Rlcw0K
KwllcnIgPSB1c2JfY29udHJvbF9tc2coaGFuZGxlLA0KKwkJVVNCX0VORFBPSU5UX09VVCArIFVT
Ql9UWVBFX0NMQVNTICsgVVNCX1JFQ0lQX0lOVEVSRkFDRSwNCisJCTB4MDksDQorCQkweDdmICsg
KDB4MDMgPDwgOCksDQorCQkwLA0KKwkJKGNoYXIqKXJlcG9ydCwgNCwgMTAwMDApOw0KKw0KKwlp
ZiAoZXJyID09IDApIHsNCisJCWVyciA9IC0xOw0KKwkJZXJybm8gPSBFQUxSRUFEWTsNCisJfSBl
bHNlIHsNCisJCWlmIChlcnJubyA9PSBFVElNRURPVVQpDQorCQkJZXJyID0gMDsNCisJfQ0KKw0K
Kwl1c2JfY2xvc2UoaGFuZGxlKTsNCisNCisJcmV0dXJuIGVycjsNCit9DQorDQogc3RhdGljIHN0
cnVjdCBkZXZpY2VfaWQgZGV2aWNlX2xpc3RbXSA9IHsNCiAJeyBIQ0ksIDB4MGExMiwgMHgxMDAw
LCBzd2l0Y2hfaGlkcHJveHkgfSwNCiAJeyBISUQsIDB4MGExMiwgMHgwMDAxLCBzd2l0Y2hfaGlk
cHJveHkgfSwNCkBAIC0yMjksNiArMjY1LDcgQEANCiAJeyBIQ0ksIDB4MDQ2ZCwgMHhjNzBlLCBz
d2l0Y2hfbG9naXRlY2ggfSwJLyogTG9naXRlY2ggZGlOb3ZvIGtleWJvYXJkICovDQogCXsgSENJ
LCAweDA0NmQsIDB4YzcxMywgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExvZ2l0ZWNoIGRpTm92byBF
ZGdlICovDQogCXsgSENJLCAweDA0NmQsIDB4YzcxNCwgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExv
Z2l0ZWNoIGRpTm92byBFZGdlICovDQorCXsgSENJLCAweDQxM2MsIDB4ODE1OCwgc3dpdGNoX2Rl
bGwgfSwJCS8qIERlbGwgV2lyZWxlc3MgMzcwICovDQogCXsgLTEgfQ0KIH07DQogDQo=


--=-K9TRzP5X10arYqAg1RMu--

--=-L9QVnqVtI+kjp+YFDUBm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH9nly2CrZjkA73YsRAo0nAJ9atS7yXv0s4LahBP1LohMPYKjjLgCgmIbt
tpb/CdPz/c362Dj2dM2cUz0=
=deVU
-----END PGP SIGNATURE-----

--=-L9QVnqVtI+kjp+YFDUBm--


--===============2097626798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============2097626798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2097626798==--

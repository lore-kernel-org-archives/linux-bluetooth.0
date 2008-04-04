Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2008 15:46:38 -0500
Message-ID: <1207341998.32219.1.camel@mlimonciello>
In-Reply-To: <1207335282.19116.5.camel@mlimonciello>
References: <1207335282.19116.5.camel@mlimonciello>
From: <Mario_Limonciello@Dell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching support for newer
	Dell BT cards
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1882830584=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1882830584==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="=-SU51+OGfCCZS1vIwRTcn"
Content-class: urn:content-classes:message


--=-SU51+OGfCCZS1vIwRTcn
Content-Type: multipart/mixed; boundary="=-BT0GrVcUNUvyHdWR79gm"


--=-BT0GrVcUNUvyHdWR79gm
Content-Type: multipart/alternative; boundary="=-YruBwgc5nFVVpJPzF7s3"


--=-YruBwgc5nFVVpJPzF7s3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

As it turns out, this also works for the Dell 410 series cards.
Attached is an updated patch to include them.

Regards,

On Fri, 2008-04-04 at 13:54 -0500, Mario Limonciello wrote:

> Hello,
>=20
> As I've recently discovered, the more recent (Dell Wireless 370+) BT
> adapters with the latest firmware don't come up in Bluetooth Radio
> mode.  They come up in a HID/UHE dongle like mode before the OS loads
> and expect the OS to transition the device to HCI mode.
> Unfortunately, the transition to HCI mode isn't done in the same
> fashion as the existing switch_hidproxy function available in hid2hci.
> I'm attaching a patch to hid2hci that adds a function for the expected
> behavior on these newer adapters.=20
>=20
> The device that needs to have the report sent to it is claimed by
> usbhid at OS load time, so there are some calls in there to release it
> from usbhid.
>=20
> I tested this against a Dell 370 BT adapter.  =EF=BB=BFThis should be the=
 same
> for the newer adapters (after the 370), but I haven't verified them
> yet, so there may be an additional patch needed for it.
>=20
> Thanks,
>=20
> ---
> Mario Limonciello
> Dell | Linux Engineering
> mario_limonciello@dell.com
>=20
>=20
>=20

---
Mario Limonciello
Dell | Linux Engineering
Desk : (512) 723-0582
mario_limonciello@dell.com



--=-YruBwgc5nFVVpJPzF7s3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.18.0">
</HEAD>
<BODY>
Hi,<BR>
<BR>
As it turns out, this also works for the Dell 410 series cards.&nbsp; Attac=
hed is an updated patch to include them.<BR>
<BR>
Regards,<BR>
<BR>
On Fri, 2008-04-04 at 13:54 -0500, Mario Limonciello wrote:<BR>
<BLOCKQUOTE TYPE=3DCITE>
    Hello,<BR>
    <BR>
    As I've recently discovered, the more recent (Dell Wireless 370+) BT ad=
apters with the latest firmware don't come up in Bluetooth Radio mode.&nbsp=
; They come up in a HID/UHE dongle like mode before the OS loads and expect=
 the OS to transition the device to HCI mode.&nbsp; Unfortunately, the tran=
sition to HCI mode isn't done in the same fashion as the existing switch_hi=
dproxy function available in hid2hci.&nbsp; I'm attaching a patch to hid2hc=
i that adds a function for the expected behavior on these newer adapters. <=
BR>
    <BR>
    The device that needs to have the report sent to it is claimed by usbhi=
d at OS load time, so there are some calls in there to release it from usbh=
id.<BR>
    <BR>
    I tested this against a Dell 370 BT adapter.&nbsp; &#65279;This should =
be the same for the newer adapters (after the 370), but I haven't verified =
them yet, so there may be an additional patch needed for it.<BR>
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
<BR>
</TD>
</TR>
</TABLE>
</BLOCKQUOTE>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
<FONT SIZE=3D"2"><FONT COLOR=3D"#808080">---</FONT></FONT><BR>
<FONT SIZE=3D"2"><FONT COLOR=3D"#808080">Mario Limonciello</FONT></FONT><BR=
>
<B><FONT SIZE=3D"1"><FONT COLOR=3D"#ff0000">Dell</FONT></FONT></B><B> </B><=
B><FONT SIZE=3D"1"><FONT COLOR=3D"#000000">|</FONT></FONT></B><B><FONT SIZE=
=3D"1"><FONT COLOR=3D"#808080"> Linux Engineering</FONT></FONT></B><BR>
<FONT SIZE=3D"1"><FONT COLOR=3D"#808080">Desk : (512) 723-0582</FONT></FONT=
><BR>
<FONT SIZE=3D"1"><FONT COLOR=3D"#808080">mario_limonciello@dell.com</FONT><=
/FONT><BR>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-YruBwgc5nFVVpJPzF7s3--

--=-BT0GrVcUNUvyHdWR79gm
Content-Disposition: attachment; filename=007_dell_bluetooth.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=007_dell_bluetooth.patch; charset=utf-8

ZGlmZiAtTnVyIC14ICcqLm9yaWcnIC14ICcqficgYmx1ZXotdXRpbHMtMy4yNi90b29scy9oaWQy
aGNpLmMgYmx1ZXotdXRpbHMtMy4yNi5uZXcvdG9vbHMvaGlkMmhjaS5jDQotLS0gYmx1ZXotdXRp
bHMtMy4yNi90b29scy9oaWQyaGNpLmMJMjAwOC0wMi0wMSAxNzoxNjozNC4wMDAwMDAwMDAgLTA2
MDANCisrKyBibHVlei11dGlscy0zLjI2Lm5ldy90b29scy9oaWQyaGNpLmMJMjAwOC0wNC0wNCAx
NTozOTo0MC4wMDAwMDAwMDAgLTA1MDANCkBAIC0yMTEsNiArMjExLDQyIEBADQogCXJldHVybiBl
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
cHJveHkgfSwNCkBAIC0yMjksNiArMjY1LDggQEANCiAJeyBIQ0ksIDB4MDQ2ZCwgMHhjNzBlLCBz
d2l0Y2hfbG9naXRlY2ggfSwJLyogTG9naXRlY2ggZGlOb3ZvIGtleWJvYXJkICovDQogCXsgSENJ
LCAweDA0NmQsIDB4YzcxMywgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExvZ2l0ZWNoIGRpTm92byBF
ZGdlICovDQogCXsgSENJLCAweDA0NmQsIDB4YzcxNCwgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExv
Z2l0ZWNoIGRpTm92byBFZGdlICovDQorCXsgSENJLCAweDQxM2MsIDB4ODE1OCwgc3dpdGNoX2Rl
bGwgfSwJCS8qIERlbGwgV2lyZWxlc3MgMzcwICovDQorCXsgSENJLCAweDQxM2MsIDB4ODE1NCwg
c3dpdGNoX2RlbGwgfSwJCS8qIERlbGwgV2lyZWxlc3MgNDEwICovDQogCXsgLTEgfQ0KIH07DQog
DQo=


--=-BT0GrVcUNUvyHdWR79gm--

--=-SU51+OGfCCZS1vIwRTcn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH9pOu2CrZjkA73YsRAlVfAJ9K5I0kQmy5VUfCnWRFTfeXzIc9UgCeNj5D
E+wp8HFbvzV2suH3R3k6RQU=
=Se0L
-----END PGP SIGNATURE-----

--=-SU51+OGfCCZS1vIwRTcn--


--===============1882830584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1882830584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1882830584==--

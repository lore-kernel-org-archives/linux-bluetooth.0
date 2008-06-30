Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@canonical.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214830640.11537.39.camel@violet.holtmann.net>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214830311.6764.2.camel@bongo>
	<1214830640.11537.39.camel@violet.holtmann.net>
Date: Mon, 30 Jun 2008 09:20:22 -0400
Message-Id: <1214832022.6764.10.camel@bongo>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0826626542=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0826626542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-g4Da5s9Iv9ENE2W4p8fQ"


--=-g4Da5s9Iv9ENE2W4p8fQ
Content-Type: multipart/mixed; boundary="=-FUOcn3zF5aADIHBezsfW"


--=-FUOcn3zF5aADIHBezsfW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-06-30 at 14:57 +0200, Marcel Holtmann wrote:
> please use the coding style that is present in the file you are
> working
> on. This includes whitespaces and indentation.

Sure.  I thought I did, but I missed a tab, which is what I assume you
were referring to?

Tab-complete patch attached.

-mt

--=-FUOcn3zF5aADIHBezsfW
Content-Disposition: attachment; filename=selector2.diff
Content-Type: text/x-patch; name=selector2.diff; charset=utf-8
Content-Transfer-Encoding: base64

SW5kZXg6IGNvbW1vbi9ibHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXovZ25vbWUvY29tbW9uL2JsdWV0b290aC1kZXZpY2Utc2Vs
ZWN0aW9uLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjIzDQpkaWZmIC11IC1wIC1yMS4yMyBi
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQotLS0gY29tbW9uL2JsdWV0b290aC1kZXZpY2Ut
c2VsZWN0aW9uLmMJMzAgSnVuIDIwMDggMDc6NTk6MjkgLTAwMDAJMS4yMw0KKysrIGNvbW1vbi9i
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jCTMwIEp1biAyMDA4IDEzOjE3OjQzIC0wMDAwDQpA
QCAtOTEsNiArOTEsMTUgQEAgYmx1ZXRvb3RoX2RldmljZV9jYXRlZ29yeV90b19zdHJpbmcgKGlu
dA0KIAl9DQogfQ0KIA0KK3N0YXRpYyBpbnQNCitpbnRfbG9nMihpbnQgdikNCit7DQorCWludCBy
diA9IDA7DQorCXdoaWxlICh2ID4+PSAxKQ0KKwkJcnYrKzsNCisJcmV0dXJuIHJ2Ow0KK30NCisN
CiBzdGF0aWMgdm9pZA0KIG5hbWVfdG9fdGV4dCAoR3RrVHJlZVZpZXdDb2x1bW4gKmNvbHVtbiwg
R3RrQ2VsbFJlbmRlcmVyICpjZWxsLA0KIAkgICAgICBHdGtUcmVlTW9kZWwgKm1vZGVsLCBHdGtU
cmVlSXRlciAqaXRlciwgZ3BvaW50ZXIgZGF0YSkNCkBAIC02MDksNyArNjE4LDcgQEAgYmx1ZXRv
b3RoX2RldmljZV9zZWxlY3Rpb25faW5pdChCbHVldG9vdA0KIAl9DQogCWdfc2lnbmFsX2Nvbm5l
Y3QgKEdfT0JKRUNUIChwcml2LT5kZXZpY2VfdHlwZSksICJjaGFuZ2VkIiwNCiAJCQkgIEdfQ0FM
TEJBQ0soZmlsdGVyX3R5cGVfY2hhbmdlZF9jYiksIHNlbGYpOw0KLQlndGtfY29tYm9fYm94X3Nl
dF9hY3RpdmUgKEdUS19DT01CT19CT1gocHJpdi0+ZGV2aWNlX3R5cGUpLCBwcml2LT5kZXZpY2Vf
dHlwZV9maWx0ZXIpOw0KKwlndGtfY29tYm9fYm94X3NldF9hY3RpdmUgKEdUS19DT01CT19CT1go
cHJpdi0+ZGV2aWNlX3R5cGUpLCBpbnRfbG9nMihwcml2LT5kZXZpY2VfdHlwZV9maWx0ZXIpKTsN
CiAJaWYgKHByaXYtPnNob3dfZGV2aWNlX3R5cGUpIHsNCiAJCWd0a193aWRnZXRfc2hvdyAocHJp
di0+ZGV2aWNlX3R5cGVfbGFiZWwpOw0KIAkJZ3RrX3dpZGdldF9zaG93IChwcml2LT5kZXZpY2Vf
dHlwZSk7DQpAQCAtNjk2LDcgKzcwNSw3IEBAIGJsdWV0b290aF9kZXZpY2Vfc2VsZWN0aW9uX3Nl
dF9wcm9wZXJ0eSANCiAJCWJyZWFrOw0KIAljYXNlIFBST1BfREVWSUNFX1RZUEVfRklMVEVSOg0K
IAkJcHJpdi0+ZGV2aWNlX3R5cGVfZmlsdGVyID0gZ192YWx1ZV9nZXRfaW50ICh2YWx1ZSk7DQot
CQlndGtfY29tYm9fYm94X3NldF9hY3RpdmUgKEdUS19DT01CT19CT1gocHJpdi0+ZGV2aWNlX3R5
cGUpLCBwcml2LT5kZXZpY2VfdHlwZV9maWx0ZXIgPj4gMSk7DQorCQlndGtfY29tYm9fYm94X3Nl
dF9hY3RpdmUgKEdUS19DT01CT19CT1gocHJpdi0+ZGV2aWNlX3R5cGUpLCBpbnRfbG9nMihwcml2
LT5kZXZpY2VfdHlwZV9maWx0ZXIpKTsNCiAJCWJyZWFrOw0KIAljYXNlIFBST1BfREVWSUNFX0NB
VEVHT1JZX0ZJTFRFUjoNCiAJCXByaXYtPmRldmljZV9jYXRlZ29yeV9maWx0ZXIgPSBnX3ZhbHVl
X2dldF9pbnQgKHZhbHVlKTsNCkBAIC03ODgsNyArNzk3LDcgQEAgYmx1ZXRvb3RoX2RldmljZV9z
ZWxlY3Rpb25fY2xhc3NfaW5pdCAoQg0KIAkJCQkJCQkJCQkJICBOVUxMLCBOVUxMLCBUUlVFLCBH
X1BBUkFNX1JFQURXUklURSkpOw0KIAlnX29iamVjdF9jbGFzc19pbnN0YWxsX3Byb3BlcnR5IChH
X09CSkVDVF9DTEFTUyhrbGFzcyksDQogCQkJCQkgUFJPUF9ERVZJQ0VfVFlQRV9GSUxURVIsIGdf
cGFyYW1fc3BlY19pbnQgKCJkZXZpY2UtdHlwZS1maWx0ZXIiLCBOVUxMLCBOVUxMLA0KLQkJCQkJ
CQkJCQkgICAgMCwgQkxVRVRPT1RIX1RZUEVfTlVNX1RZUEVTLCAwLCBHX1BBUkFNX1JFQURXUklU
RSkpOw0KKwkJCQkJCQkJCQkgICAgMSwgMSA8PCAoQkxVRVRPT1RIX1RZUEVfTlVNX1RZUEVTLTEp
LCAxLCBHX1BBUkFNX1JFQURXUklURSkpOw0KIAlnX29iamVjdF9jbGFzc19pbnN0YWxsX3Byb3Bl
cnR5IChHX09CSkVDVF9DTEFTUyhrbGFzcyksDQogCQkJCQkgUFJPUF9ERVZJQ0VfQ0FURUdPUllf
RklMVEVSLCBnX3BhcmFtX3NwZWNfaW50ICgiZGV2aWNlLWNhdGVnb3J5LWZpbHRlciIsIE5VTEws
IE5VTEwsDQogCQkJCQkgCQkJCQkJMCwgQkxVRVRPT1RIX0NBVEVHT1JZX05VTV9DQVRFR09SSUVT
LCAwLCBHX1BBUkFNX1JFQURXUklURSkpOw0K


--=-FUOcn3zF5aADIHBezsfW--

--=-g4Da5s9Iv9ENE2W4p8fQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIaN2W53i2YxNrdi0RAtVEAJ0SiBsFbrDr8BR11Zx4l4Y/ID74YgCfT05J
DsoIuf5WfIhmWzs7n/ksqSA=
=sHFw
-----END PGP SIGNATURE-----

--=-g4Da5s9Iv9ENE2W4p8fQ--



--===============0826626542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0826626542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0826626542==--

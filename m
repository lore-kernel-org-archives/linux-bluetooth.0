Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@canonical.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214605438.11537.0.camel@violet.holtmann.net>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
Date: Mon, 30 Jun 2008 08:51:51 -0400
Message-Id: <1214830311.6764.2.camel@bongo>
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
Content-Type: multipart/mixed; boundary="===============1763010851=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1763010851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Rclc8EFxFAaqdgthqwgy"


--=-Rclc8EFxFAaqdgthqwgy
Content-Type: multipart/mixed; boundary="=-+SsUD0q6wmTzUk7itxHG"


--=-+SsUD0q6wmTzUk7itxHG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, Marcel!

On Sat, 2008-06-28 at 00:23 +0200, Marcel Holtmann wrote:
> looks nice. However you have to break this up into pieces for. Sent
> small patches and I can quickly review and commit them.

Here's one such piece of my wizard patch.  It simply fixes the "device-type=
-filter" property to do something reasonable when set (namely, you give it =
a BLUETOOTH_TYPE and it sets the right index in the combo).

More patches coming.

-mt

--=-+SsUD0q6wmTzUk7itxHG
Content-Disposition: attachment; filename=selector.diff
Content-Type: text/x-patch; name=selector.diff; charset=utf-8
Content-Transfer-Encoding: base64

ZGlmZiAtcnVwTiBibHVlei1nbm9tZS0wLjI3Lm9yaWcvY29tbW9uL2JsdWV0b290aC1kZXZpY2Ut
c2VsZWN0aW9uLmMgYmx1ZXotZ25vbWUtMC4yNy9jb21tb24vYmx1ZXRvb3RoLWRldmljZS1zZWxl
Y3Rpb24uYw0KLS0tIGJsdWV6LWdub21lLTAuMjcub3JpZy9jb21tb24vYmx1ZXRvb3RoLWRldmlj
ZS1zZWxlY3Rpb24uYwkyMDA4LTA2LTI3IDE0OjEyOjQ5LjAwMDAwMDAwMCAtMDQwMA0KKysrIGJs
dWV6LWdub21lLTAuMjcvY29tbW9uL2JsdWV0b290aC1kZXZpY2Utc2VsZWN0aW9uLmMJMjAwOC0w
Ni0yNyAxNDoxMzowNS4wMDAwMDAwMDAgLTA0MDANCkBAIC05MCw2ICs5MCwxNSBAQCBibHVldG9v
dGhfZGV2aWNlX2NhdGVnb3J5X3RvX3N0cmluZyAoaW50DQogCX0NCiB9DQogDQorc3RhdGljIGlu
dA0KK2ludF9sb2cyKGludCB2KQ0KK3sNCisJdW5zaWduZWQgcnYgPSAwOw0KKwl3aGlsZSAodiA+
Pj0gMSkNCisJICBydisrOw0KKwlyZXR1cm4gcnY7DQorfQ0KKw0KIHN0YXRpYyB2b2lkDQogbmFt
ZV90b190ZXh0IChHdGtUcmVlVmlld0NvbHVtbiAqY29sdW1uLCBHdGtDZWxsUmVuZGVyZXIgKmNl
bGwsDQogCSAgICAgIEd0a1RyZWVNb2RlbCAqbW9kZWwsIEd0a1RyZWVJdGVyICppdGVyLCBncG9p
bnRlciBkYXRhKQ0KQEAgLTU5MSw3ICs2MDAsNyBAQCBibHVldG9vdGhfZGV2aWNlX3NlbGVjdGlv
bl9pbml0KEJsdWV0b290DQogCX0NCiAJZ19zaWduYWxfY29ubmVjdCAoR19PQkpFQ1QgKHByaXYt
PmRldmljZV90eXBlKSwgImNoYW5nZWQiLA0KIAkJCSAgR19DQUxMQkFDSyhmaWx0ZXJfdHlwZV9j
aGFuZ2VkX2NiKSwgc2VsZik7DQotCWd0a19jb21ib19ib3hfc2V0X2FjdGl2ZSAoR1RLX0NPTUJP
X0JPWChwcml2LT5kZXZpY2VfdHlwZSksIHByaXYtPmRldmljZV90eXBlX2ZpbHRlcik7DQorCWd0
a19jb21ib19ib3hfc2V0X2FjdGl2ZSAoR1RLX0NPTUJPX0JPWChwcml2LT5kZXZpY2VfdHlwZSks
IGludF9sb2cyKHByaXYtPmRldmljZV90eXBlX2ZpbHRlcikpOw0KIAlpZiAocHJpdi0+c2hvd19k
ZXZpY2VfdHlwZSkgew0KIAkJZ3RrX3dpZGdldF9zaG93IChwcml2LT5kZXZpY2VfdHlwZV9sYWJl
bCk7DQogCQlndGtfd2lkZ2V0X3Nob3cgKHByaXYtPmRldmljZV90eXBlKTsNCkBAIC02NjUsNyAr
Njc0LDcgQEAgYmx1ZXRvb3RoX2RldmljZV9zZWxlY3Rpb25fc2V0X3Byb3BlcnR5IA0KIAkJYnJl
YWs7DQogCWNhc2UgUFJPUF9ERVZJQ0VfVFlQRV9GSUxURVI6DQogCQlwcml2LT5kZXZpY2VfdHlw
ZV9maWx0ZXIgPSBnX3ZhbHVlX2dldF9pbnQgKHZhbHVlKTsNCi0JCWd0a19jb21ib19ib3hfc2V0
X2FjdGl2ZSAoR1RLX0NPTUJPX0JPWChwcml2LT5kZXZpY2VfdHlwZSksIHByaXYtPmRldmljZV90
eXBlX2ZpbHRlciA+PiAxKTsNCisJCWd0a19jb21ib19ib3hfc2V0X2FjdGl2ZSAoR1RLX0NPTUJP
X0JPWChwcml2LT5kZXZpY2VfdHlwZSksIGludF9sb2cyKHByaXYtPmRldmljZV90eXBlX2ZpbHRl
cikpOw0KIAkJYnJlYWs7DQogCWNhc2UgUFJPUF9ERVZJQ0VfQ0FURUdPUllfRklMVEVSOg0KIAkJ
cHJpdi0+ZGV2aWNlX2NhdGVnb3J5X2ZpbHRlciA9IGdfdmFsdWVfZ2V0X2ludCAodmFsdWUpOw0K
QEAgLTc1MSw3ICs3NjAsNyBAQCBibHVldG9vdGhfZGV2aWNlX3NlbGVjdGlvbl9jbGFzc19pbml0
IChCDQogCQkJCQkJCQkJCQkgIE5VTEwsIE5VTEwsIFRSVUUsIEdfUEFSQU1fUkVBRFdSSVRFKSk7
DQogCWdfb2JqZWN0X2NsYXNzX2luc3RhbGxfcHJvcGVydHkgKEdfT0JKRUNUX0NMQVNTKGtsYXNz
KSwNCiAJCQkJCSBQUk9QX0RFVklDRV9UWVBFX0ZJTFRFUiwgZ19wYXJhbV9zcGVjX2ludCAoImRl
dmljZS10eXBlLWZpbHRlciIsIE5VTEwsIE5VTEwsDQotCQkJCQkJCQkJCSAgICAwLCBCTFVFVE9P
VEhfVFlQRV9OVU1fVFlQRVMsIDAsIEdfUEFSQU1fUkVBRFdSSVRFKSk7DQorCQkJCQkJCQkJCSAg
ICAxLCAxIDw8IChCTFVFVE9PVEhfVFlQRV9OVU1fVFlQRVMtMSksIDEsIEdfUEFSQU1fUkVBRFdS
SVRFKSk7DQogCWdfb2JqZWN0X2NsYXNzX2luc3RhbGxfcHJvcGVydHkgKEdfT0JKRUNUX0NMQVNT
KGtsYXNzKSwNCiAJCQkJCSBQUk9QX0RFVklDRV9DQVRFR09SWV9GSUxURVIsIGdfcGFyYW1fc3Bl
Y19pbnQgKCJkZXZpY2UtY2F0ZWdvcnktZmlsdGVyIiwgTlVMTCwgTlVMTCwNCiAJCQkJCSAJCQkJ
CQkwLCBCTFVFVE9PVEhfQ0FURUdPUllfTlVNX0NBVEVHT1JJRVMsIDAsIEdfUEFSQU1fUkVBRFdS
SVRFKSk7DQo=


--=-+SsUD0q6wmTzUk7itxHG--

--=-Rclc8EFxFAaqdgthqwgy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIaNbn53i2YxNrdi0RAgLTAKCalDCwHeb15gNUEaP+xM6kfBcAGACgicQK
QLVaaeBeJHtS4II2x3I2kNM=
=a9ns
-----END PGP SIGNATURE-----

--=-Rclc8EFxFAaqdgthqwgy--



--===============1763010851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1763010851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1763010851==--

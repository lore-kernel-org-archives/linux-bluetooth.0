Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <74d0deb3050921035545e2a33d@mail.gmail.com>
From: pHilipp Zabel <philipp.zabel@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_46948_30612908.1127300111941"
Subject: [Bluez-devel] hcid: memory alignment problems on arm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Sep 2005 12:55:11 +0200

------=_Part_46948_30612908.1127300111941
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

hcid causes alignment traps on arm architecture with the dbus part enabled.
I worked around this with the attached patch.
Can anybody help me to do this the right way?

--
Philipp

------=_Part_46948_30612908.1127300111941
Content-Type: text/x-patch; name="hcid-alignment-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid-alignment-fix.patch"

LS0tIGJsdWV6LXV0aWxzLTIuMjAvaGNpZC9kYnVzLmMub3JpZwkyMDA1LTA5LTIxIDExOjI3OjI2
ICswMjAwCisrKyBibHVlei11dGlscy0yLjIwL2hjaWQvZGJ1cy5jCTIwMDUtMDktMjEgMTE6Mjc6
MzUgKzAyMDAKQEAgLTEyMCw2ICsxMjEsNyBAQAogCURCdXNNZXNzYWdlICptZXNzYWdlOwogI2lm
ZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJdWludDhfdCAqYWRkciA9ICh1
aW50OF90ICopICZjaS0+YmRhZGRyOworCXVpbnQzMl90IGNpX291dCA9IGNpLT5vdXQ7CiAjZWxz
ZQogCURCdXNNZXNzYWdlSXRlciBpdGVyOwogI2VuZGlmCkBAIC0xMzgsNyArMTQwLDcgQEAKIAli
YWNweSgmcmVxLT5iZGEsICZjaS0+YmRhZGRyKTsKIAogI2lmZGVmIEhBVkVfREJVU19NRVNTQUdF
X0lURVJfR0VUX0JBU0lDCi0JZGJ1c19tZXNzYWdlX2FwcGVuZF9hcmdzKG1lc3NhZ2UsIERCVVNf
VFlQRV9CT09MRUFOLCAmY2ktPm91dCwKKwlkYnVzX21lc3NhZ2VfYXBwZW5kX2FyZ3MobWVzc2Fn
ZSwgREJVU19UWVBFX0JPT0xFQU4sICZjaV9vdXQsCiAJCQlEQlVTX1RZUEVfQVJSQVksIERCVVNf
VFlQRV9CWVRFLAogCQkJJmFkZHIsIHNpemVvZihiZGFkZHJfdCksIERCVVNfVFlQRV9JTlZBTElE
KTsKICNlbHNlCkBAIC0yNjEsNiArMjYzLDggQEAKIAlEQnVzTWVzc2FnZSAqbWVzc2FnZTsKICNp
Zm5kZWYgSEFWRV9EQlVTX01FU1NBR0VfSVRFUl9HRVRfQkFTSUMKIAlEQnVzTWVzc2FnZUl0ZXIg
aXRlcjsKKyNlbHNlCisJaW50MzJfdCB0bXBfcnNzaSA9IHJzc2k7CiAjZW5kaWYKIAljaGFyICps
b2NhbF9hZGRyLCAqcGVlcl9hZGRyOwogCWJkYWRkcl90IHRtcDsKQEAgLTI3NiwxMSArMjgwLDEy
IEBACiAJfQogCiAjaWZkZWYgSEFWRV9EQlVTX01FU1NBR0VfSVRFUl9HRVRfQkFTSUMKKwogCWRi
dXNfbWVzc2FnZV9hcHBlbmRfYXJncyhtZXNzYWdlLAogCQkJCQlEQlVTX1RZUEVfU1RSSU5HLCAm
bG9jYWxfYWRkciwKIAkJCQkJREJVU19UWVBFX1NUUklORywgJnBlZXJfYWRkciwKIAkJCQkJREJV
U19UWVBFX1VJTlQzMiwgJmNsYXNzLAotCQkJCQlEQlVTX1RZUEVfSU5UMzIsICZyc3NpLAorCQkJ
CQlEQlVTX1RZUEVfSU5UMzIsICZ0bXBfcnNzaSwKIAkJCQkJREJVU19UWVBFX0lOVkFMSUQpOwog
I2Vsc2UKIAlkYnVzX21lc3NhZ2VfYXBwZW5kX2l0ZXJfaW5pdChtZXNzYWdlLCAmaXRlcik7Cg==

------=_Part_46948_30612908.1127300111941--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606191038m42f48295w784bf0062ae184a3@mail.gmail.com>
Date: Mon, 19 Jun 2006 14:38:56 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606190517w50ef4027p258030f7593ebd6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_456_22280999.1150738736662"
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
	<1149884042.3985.6.camel@aeonflux.holtmann.net>
	<1150099297.2589.15.camel@aeonflux.holtmann.net>
	<564d96fb0606120452m4e4ced33x66ca63fd675ad3@mail.gmail.com>
	<1150715237.4277.17.camel@localhost>
	<564d96fb0606190513r4c59cd28v9bd23a9a45e55e8b@mail.gmail.com>
	<564d96fb0606190517w50ef4027p258030f7593ebd6a@mail.gmail.com>
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_456_22280999.1150738736662
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Sorry again :-(
> restarting the services I notice the Port -> Po.
>
> I will investigate.

A patch is attached. It creates the following invariant when handling strings:

d->unitSize == strlen(d->val.str) + sizeof(uint8_t)

Different parts of the code had different "opinions".

Rafael,
INdT

------=_Part_456_22280999.1150738736662
Content-Type: application/octet-stream; name=sdp-3.1.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eon3zx6d
Content-Disposition: attachment; filename="sdp-3.1.patch"

LS0tIHNyYy9zZHAuYwkyMDA2LTA2LTA5IDEyOjQ1OjA4LjAwMDAwMDAwMCAtMDMwMAorKysgL2hv
bWUvcmFmYWVsL3NkcC0zLjEuYwkyMDA2LTA2LTE5IDE0OjE3OjQxLjAwMDAwMDAwMCAtMDMwMApA
QCAtNDMyLDIyICs0MzIsNiBAQAogCQkJfQogCiAJCQltZW1jcHkoZC0+dmFsLnN0ciwgdmFsdWUs
IGxlbmd0aCk7Ci0KLQkJCWlmIChsZW5ndGggPD0gVUNIQVJfTUFYKSB7Ci0JCQkJZC0+dW5pdFNp
emUgKz0gc2l6ZW9mKHVpbnQ4X3QpOwotCQkJCWlmIChkdGQgIT0gU0RQX1VSTF9TVFI4ICYmIGR0
ZCAhPSBTRFBfVEVYVF9TVFI4KSB7Ci0JCQkJCWlmIChkdGQgPT0gU0RQX1VSTF9TVFIxNikKLQkJ
CQkJCWR0ZCA9IFNEUF9VUkxfU1RSODsKLQkJCQkJZWxzZQotCQkJCQkJZHRkID0gU0RQX1RFWFRf
U1RSODsKLQkJCQl9Ci0JCQl9IGVsc2UgewotCQkJCWQtPnVuaXRTaXplICs9IHNpemVvZih1aW50
MTZfdCk7Ci0JCQkJaWYgKGR0ZCA9PSBTRFBfVEVYVF9TVFI4KQotCQkJCQlkdGQgPSBTRFBfVEVY
VF9TVFIxNjsKLQkJCQllbHNlCi0JCQkJCWR0ZCA9IFNEUF9VUkxfU1RSMTY7Ci0JCQl9CiAJCX0g
ZWxzZSB7CiAJCQlTRFBFUlIoIlN0cmluZ3Mgb2Ygc2l6ZSA+IFVTSFJUX01BWCBub3Qgc3VwcG9y
dGVkXG4iKTsKIAkJCWZyZWUoZCk7CkBAIC03NDIsMTAgKzcyNiw2IEBACiAJY2FzZSBTRFBfVEVY
VF9TVFIzMjoKIAkJc3JjID0gKHVuc2lnbmVkIGNoYXIgKilkLT52YWwuc3RyOwogCQlkYXRhX3Np
emUgPSBkLT51bml0U2l6ZSAtIHNpemVvZih1aW50OF90KTsKLQkJaWYgKGRhdGFfc2l6ZSAtIHNp
emVvZih1aW50OF90KSA8PSBVQ0hBUl9NQVgpCi0JCQlkYXRhX3NpemUgLT0gc2l6ZW9mKHVpbnQ4
X3QpOwotCQllbHNlCi0JCQlkYXRhX3NpemUgLT0gc2l6ZW9mKHVpbnQxNl90KTsKIAkJc2RwX3Nl
dF9zZXFfbGVuKHNlcXAsIGRhdGFfc2l6ZSk7CiAJCWJyZWFrOwogCWNhc2UgU0RQX1VSTF9TVFI4
OgpAQCAtOTczLDcgKzk1Myw3IEBACiAJU0RQREJHKCJTdHIgOiAlc1xuIiwgcyk7CiAKIAlkLT52
YWwuc3RyID0gczsKLQlkLT51bml0U2l6ZSA9IG47CisJZC0+dW5pdFNpemUgPSBuICsgc2l6ZW9m
KHVpbnQ4X3QpOwogCXJldHVybiBkOwogfQogCg==
------=_Part_456_22280999.1150738736662
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_456_22280999.1150738736662
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_456_22280999.1150738736662--

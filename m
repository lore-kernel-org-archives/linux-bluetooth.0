Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <74d0deb305092202185bd2308b@mail.gmail.com>
From: pHilipp Zabel <philipp.zabel@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid: memory alignment problems on arm
In-Reply-To: <1127336002.23006.0.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1678_26529081.1127380702888"
References: <74d0deb3050921035545e2a33d@mail.gmail.com>
	 <1127336002.23006.0.camel@blade>
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
Date: Thu, 22 Sep 2005 11:18:22 +0200

------=_Part_1678_26529081.1127380702888
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

On 9/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> the patch looks good, but you must redo it against the latest CVS. I
> removed the compat code for the D-Bus 0.23 API.

Thanks, I have attached an updated patch against CVS.

--
Philipp

------=_Part_1678_26529081.1127380702888
Content-Type: text/x-patch; name="hcid-alignment-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid-alignment-fix.patch"

LS0tIHV0aWxzL2hjaWQvZGJ1cy5jLm9yaWcJMjAwNS0wOS0yMiAxMToxMjoxNyArMDIwMAorKysg
dXRpbHMvaGNpZC9kYnVzLmMJMjAwNS0wOS0yMiAxMToxNDozNiArMDIwMApAQCAtMTI0LDYgKzEy
NCw3IEBACiAJREJ1c1BlbmRpbmdDYWxsICpwZW5kaW5nID0gTlVMTDsKIAlzdHJ1Y3QgcGluX3Jl
cXVlc3QgKnJlcTsKIAl1aW50OF90ICphZGRyID0gKHVpbnQ4X3QgKikgJmNpLT5iZGFkZHI7CisJ
dWludDMyX3QgdG1wX291dCA9IGNpLT5vdXQ7CiAKIAltZXNzYWdlID0gZGJ1c19tZXNzYWdlX25l
d19tZXRob2RfY2FsbChTRVJWSUNFX05BTUUsIFBBVEhfTkFNRSwKIAkJCQkJCUlOVEVSRkFDRV9O
QU1FLCBSRVFVRVNUX05BTUUpOwpAQCAtMTM2LDcgKzEzNyw3IEBACiAJcmVxLT5kZXYgPSBkZXY7
CiAJYmFjcHkoJnJlcS0+YmRhLCAmY2ktPmJkYWRkcik7CiAKLQlkYnVzX21lc3NhZ2VfYXBwZW5k
X2FyZ3MobWVzc2FnZSwgREJVU19UWVBFX0JPT0xFQU4sICZjaS0+b3V0LAorCWRidXNfbWVzc2Fn
ZV9hcHBlbmRfYXJncyhtZXNzYWdlLCBEQlVTX1RZUEVfQk9PTEVBTiwgJnRtcF9vdXQsCiAJCQlE
QlVTX1RZUEVfQVJSQVksIERCVVNfVFlQRV9CWVRFLAogCQkJJmFkZHIsIHNpemVvZihiZGFkZHJf
dCksIERCVVNfVFlQRV9JTlZBTElEKTsKIApAQCAtMjMzLDYgKzIzNCw3IEBACiB7CiAJREJ1c01l
c3NhZ2UgKm1lc3NhZ2U7CiAJY2hhciAqbG9jYWxfYWRkciwgKnBlZXJfYWRkcjsKKwlpbnQzMl90
IHRtcF9yc3NpID0gcnNzaTsKIAliZGFkZHJfdCB0bXA7CiAKIAliYXN3YXAoJnRtcCwgbG9jYWwp
OyBsb2NhbF9hZGRyID0gYmF0b3N0cigmdG1wKTsKQEAgLTI0OSw3ICsyNTEsNyBAQAogCQkJCQlE
QlVTX1RZUEVfU1RSSU5HLCAmbG9jYWxfYWRkciwKIAkJCQkJREJVU19UWVBFX1NUUklORywgJnBl
ZXJfYWRkciwKIAkJCQkJREJVU19UWVBFX1VJTlQzMiwgJmNsYXNzLAotCQkJCQlEQlVTX1RZUEVf
SU5UMzIsICZyc3NpLAorCQkJCQlEQlVTX1RZUEVfSU5UMzIsICZ0bXBfcnNzaSwKIAkJCQkJREJV
U19UWVBFX0lOVkFMSUQpOwogCiAJaWYgKGRidXNfY29ubmVjdGlvbl9zZW5kKGNvbm5lY3Rpb24s
IG1lc3NhZ2UsIE5VTEwpID09IEZBTFNFKSB7Cg==
------=_Part_1678_26529081.1127380702888--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

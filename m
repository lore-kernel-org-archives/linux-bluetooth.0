Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712220255q60347c54v36f510baf63b673e@mail.gmail.com>
Date: Sat, 22 Dec 2007 11:55:33 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198282576.8050.296.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4948_28608769.1198320933282"
References: <8a8adccc0712211417o3d2c8467m543e113eee1839c6@mail.gmail.com>
	<1198282576.8050.296.camel@aeonflux>
Subject: Re: [Bluez-devel] [PATCH] Make links in about dialog launch
	browser/email client
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_4948_28608769.1198320933282
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 22, 2007 1:16 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
> > Attached patch does this. It now uses the screen of the about dialog
>
> can't we have a generic do_open function and then call it from both
> hooks. From a code perspective it makes it simpler.
>
> Also what is the deal with gnome-open and xdg-open. Wouldn't it be
> enough to use only xdg-open. It should be present on all major distros
> by now.
>
> Coding style wise, please don't put a space between the function name
> and the "(". I know it is unusual for GNOME stuff, but this one follows
> the kernel coding style like all bluez-* packages. Also please respect
> the 80 characters width rule. Meaning break long functions calls to
> multiple lines.
>
Marcel,

Thanks for the review. Updated patch attached

Jaap

------=_Part_4948_28608769.1198320933282
Content-Type: text/x-patch; name=bluez-gnome-clickable2.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fai1c0vs0
Content-Disposition: attachment; filename=bluez-gnome-clickable2.patch

SW5kZXg6IGFuYWx5emVyL2RpYWxvZy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2Js
dWV6L2dub21lL2FuYWx5emVyL2RpYWxvZy5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIxCmRp
ZmYgLXUgLXIxLjIxIGRpYWxvZy5jCi0tLSBhbmFseXplci9kaWFsb2cuYwkyMiBEZWMgMjAwNyAw
MDowOToxNSAtMDAwMAkxLjIxCisrKyBhbmFseXplci9kaWFsb2cuYwkyMiBEZWMgMjAwNyAxMDo1
Mzo1MiAtMDAwMApAQCAtNDksMTQgKzQ5LDQ1IEBACiAJZ3RrX3dpZGdldF9kZXN0cm95KGRpYWxv
Zyk7CiB9CiAKK3N0YXRpYyB2b2lkIG9wZW5fdXJsKGNvbnN0IGNoYXIgKnVybCwgR2RrU2NyZWVu
ICpzY3JlZW4pCit7CisJR0Vycm9yICplcnJvciA9IE5VTEw7CisJZ2Jvb2xlYW4gcmV0OworCWNo
YXIgKmNtZGxpbmU7CisJR3RrV2lkZ2V0ICplcnJvcl9kaWFsb2c7CisKKwljbWRsaW5lID0gZ19z
dHJjb25jYXQoInhkZy1vcGVuICIsIHVybCwgTlVMTCk7CisJcmV0ID0gZ2RrX3NwYXduX2NvbW1h
bmRfbGluZV9vbl9zY3JlZW4oc2NyZWVuLCBjbWRsaW5lLCAmZXJyb3IpOworCWdfZnJlZSAoY21k
bGluZSk7CisKKwlpZiAocmV0ID09IEZBTFNFKSB7CisJCWVycm9yX2RpYWxvZyA9IGd0a19tZXNz
YWdlX2RpYWxvZ19uZXcoTlVMTCwgR1RLX0RJQUxPR19NT0RBTCwgCisJCQkJR1RLX01FU1NBR0Vf
SU5GTywgR1RLX0JVVFRPTlNfT0ssIAorCQkJCSJGYWlsZWQgdG8gc2hvdyB1cmwgJXMiLCBlcnJv
ci0+bWVzc2FnZSk7IAorCQlndGtfZGlhbG9nX3J1bihHVEtfRElBTE9HIChlcnJvcl9kaWFsb2cp
KTsKKwkJZ19lcnJvcl9mcmVlKGVycm9yKTsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIGFib3V0X3Vy
bF9ob29rKEd0a0Fib3V0RGlhbG9nICpkaWFsb2csCiAJCQkJCWNvbnN0IGdjaGFyICp1cmwsIGdw
b2ludGVyIGRhdGEpCiB7CisJR2RrU2NyZWVuICpnc2NyZWVuOworCisJZ3NjcmVlbiA9IGd0a193
aW5kb3dfZ2V0X3NjcmVlbihHVEtfV0lORE9XKGRpYWxvZykpOworCW9wZW5fdXJsKHVybCwgZ3Nj
cmVlbik7CiB9CiAKIHN0YXRpYyB2b2lkIGFib3V0X2VtYWlsX2hvb2soR3RrQWJvdXREaWFsb2cg
KmRpYWxvZywKIAkJCQkJY29uc3QgZ2NoYXIgKmVtYWlsLCBncG9pbnRlciBkYXRhKQogeworCWNo
YXIgKnVybDsKKwlHZGtTY3JlZW4gKmdzY3JlZW47CisKKwlnc2NyZWVuID0gZ3RrX3dpbmRvd19n
ZXRfc2NyZWVuKEdUS19XSU5ET1coZGlhbG9nKSk7CisJdXJsID0gZ19zdHJjb25jYXQgKCJtYWls
dG86IiwgZW1haWwsIE5VTEwpOworCW9wZW5fdXJsKHVybCwgZ3NjcmVlbik7CisJZ19mcmVlICh1
cmwpOwogfQogCiB2b2lkIHNob3dfYWJvdXRfZGlhbG9nKHZvaWQpCkluZGV4OiBhcHBsZXQvbWFp
bi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6L2dub21lL2FwcGxldC9tYWlu
LmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuOTUKZGlmZiAtdSAtcjEuOTUgbWFpbi5jCi0tLSBh
cHBsZXQvbWFpbi5jCTIyIERlYyAyMDA3IDAwOjA5OjE1IC0wMDAwCTEuOTUKKysrIGFwcGxldC9t
YWluLmMJMjIgRGVjIDIwMDcgMTA6NTM6NTIgLTAwMDAKQEAgLTE1MDEsMTQgKzE1MDEsNDUgQEAK
IAlndGtfd2lkZ2V0X2Rlc3Ryb3koZGlhbG9nKTsKIH0KIAorc3RhdGljIHZvaWQgb3Blbl91cmwo
Y29uc3QgY2hhciAqdXJsLCBHZGtTY3JlZW4gKnNjcmVlbikKK3sKKwlHRXJyb3IgKmVycm9yID0g
TlVMTDsKKwlnYm9vbGVhbiByZXQ7CisJY2hhciAqY21kbGluZTsKKwlHdGtXaWRnZXQgKmVycm9y
X2RpYWxvZzsKKworCWNtZGxpbmUgPSBnX3N0cmNvbmNhdCgieGRnLW9wZW4gIiwgdXJsLCBOVUxM
KTsKKwlyZXQgPSBnZGtfc3Bhd25fY29tbWFuZF9saW5lX29uX3NjcmVlbihzY3JlZW4sIGNtZGxp
bmUsICZlcnJvcik7CisJZ19mcmVlIChjbWRsaW5lKTsKKworCWlmIChyZXQgPT0gRkFMU0UpIHsK
KwkJZXJyb3JfZGlhbG9nID0gZ3RrX21lc3NhZ2VfZGlhbG9nX25ldyhOVUxMLCBHVEtfRElBTE9H
X01PREFMLCAKKwkJCQlHVEtfTUVTU0FHRV9JTkZPLCBHVEtfQlVUVE9OU19PSywgCisJCQkJIkZh
aWxlZCB0byBzaG93IHVybCAlcyIsIGVycm9yLT5tZXNzYWdlKTsgCisJCWd0a19kaWFsb2dfcnVu
KEdUS19ESUFMT0cgKGVycm9yX2RpYWxvZykpOworCQlnX2Vycm9yX2ZyZWUoZXJyb3IpOworCX0K
K30KKwogc3RhdGljIHZvaWQgYWJvdXRfdXJsX2hvb2soR3RrQWJvdXREaWFsb2cgKmRpYWxvZywK
IAkJCQkJY29uc3QgZ2NoYXIgKnVybCwgZ3BvaW50ZXIgZGF0YSkKIHsKKwlHZGtTY3JlZW4gKmdz
Y3JlZW47CisKKwlnc2NyZWVuID0gZ3RrX3dpbmRvd19nZXRfc2NyZWVuKEdUS19XSU5ET1coZGlh
bG9nKSk7CisJb3Blbl91cmwodXJsLCBnc2NyZWVuKTsKIH0KIAogc3RhdGljIHZvaWQgYWJvdXRf
ZW1haWxfaG9vayhHdGtBYm91dERpYWxvZyAqZGlhbG9nLAogCQkJCQljb25zdCBnY2hhciAqZW1h
aWwsIGdwb2ludGVyIGRhdGEpCiB7CisJY2hhciAqdXJsOworCUdka1NjcmVlbiAqZ3NjcmVlbjsK
KworCWdzY3JlZW4gPSBndGtfd2luZG93X2dldF9zY3JlZW4oR1RLX1dJTkRPVyhkaWFsb2cpKTsK
Kwl1cmwgPSBnX3N0cmNvbmNhdCAoIm1haWx0bzoiLCBlbWFpbCwgTlVMTCk7CisJb3Blbl91cmwo
dXJsLCBnc2NyZWVuKTsKKwlnX2ZyZWUgKHVybCk7CiB9CiAKIHN0YXRpYyB2b2lkIGFib3V0X2Nh
bGxiYWNrKEd0a1dpZGdldCAqaXRlbSwgZ3BvaW50ZXIgdXNlcl9kYXRhKQo=
------=_Part_4948_28608769.1198320933282
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------=_Part_4948_28608769.1198320933282
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_4948_28608769.1198320933282--

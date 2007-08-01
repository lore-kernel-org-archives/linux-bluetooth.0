Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0708010656r2f0125f5qd84a2a97691859d3@mail.gmail.com>
Date: Wed, 1 Aug 2007 10:56:40 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb0707310734w7004e158te4b82dfea931bb40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_48378_19716791.1185976600579"
References: <e1effdeb0707310734w7004e158te4b82dfea931bb40@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH]Adapter D-Bus path on raw mode
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

------=_Part_48378_19716791.1185976600579
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/31/07, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>
> here is the patch to avoid register the D-Bus adapter path when the
> RAW flag is active.
>
> ListAdapters and FindAdapter were fixed too.
>
> Claudio
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>

Hi Marcel,

here is a new version based on your suggestions.

BR,
Claudio.

------=_Part_48378_19716791.1185976600579
Content-Type: text/x-diff; name=raw03.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4tvtj5p
Content-Disposition: attachment; filename="raw03.patch"

SW5kZXg6IGhjaWQvZGJ1cy1tYW5hZ2VyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
Ymx1ZXovdXRpbHMvaGNpZC9kYnVzLW1hbmFnZXIuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42
OApkaWZmIC11IC1yMS42OCBkYnVzLW1hbmFnZXIuYwotLS0gaGNpZC9kYnVzLW1hbmFnZXIuYwk0
IE1heSAyMDA3IDE1OjMyOjI3IC0wMDAwCTEuNjgKKysrIGhjaWQvZGJ1cy1tYW5hZ2VyLmMJMSBB
dWcgMjAwNyAxMzo1Mjo1MyAtMDAwMApAQCAtMTAzLDYgKzEwMyw3IEBACiB7CiAJREJ1c01lc3Nh
Z2UgKnJlcGx5OwogCWNoYXIgcGF0aFtNQVhfUEFUSF9MRU5HVEhdLCAqcGF0aF9wdHIgPSBwYXRo
OworCXN0cnVjdCBoY2lfZGV2X2luZm8gZGk7CiAJY29uc3QgY2hhciAqcGF0dGVybjsKIAlpbnQg
ZGV2X2lkOwogCkBAIC0xMTUsNiArMTE2LDEyIEBACiAJaWYgKGRldl9pZCA8IDApCiAJCXJldHVy
biBlcnJvcl9ub19zdWNoX2FkYXB0ZXIoY29ubiwgbXNnKTsKIAorCWlmIChoY2lfZGV2aW5mbyhk
ZXZfaWQsICZkaSkgPCAwKQorCQlyZXR1cm4gZXJyb3Jfbm9fc3VjaF9hZGFwdGVyKGNvbm4sIG1z
Zyk7CisKKwlpZiAoaGNpX3Rlc3RfYml0KEhDSV9SQVcsICZkaS5mbGFncykpCisJCXJldHVybiBl
cnJvcl9ub19zdWNoX2FkYXB0ZXIoY29ubiwgbXNnKTsKKwogCXJlcGx5ID0gZGJ1c19tZXNzYWdl
X25ld19tZXRob2RfcmV0dXJuKG1zZyk7CiAJaWYgKCFyZXBseSkKIAkJcmV0dXJuIERCVVNfSEFO
RExFUl9SRVNVTFRfTkVFRF9NRU1PUlk7CkBAIC0xNzcsNiArMTg0LDkgQEAKIAkJaWYgKGhjaV9k
ZXZpbmZvKGRyLT5kZXZfaWQsICZkaSkgPCAwKQogCQkJY29udGludWU7CiAKKwkJaWYgKGhjaV90
ZXN0X2JpdChIQ0lfUkFXLCAmZGkuZmxhZ3MpKQorCQkJY29udGludWU7CisKIAkJc25wcmludGYo
cGF0aCwgc2l6ZW9mKHBhdGgpLCAiJXMvJXMiLCBCQVNFX1BBVEgsIGRpLm5hbWUpOwogCiAJCWRi
dXNfbWVzc2FnZV9pdGVyX2FwcGVuZF9iYXNpYygmYXJyYXlfaXRlciwKSW5kZXg6IGhjaWQvbWFp
bi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6L3V0aWxzL2hjaWQvbWFpbi5j
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjk4CmRpZmYgLXUgLXIxLjk4IG1haW4uYwotLS0gaGNp
ZC9tYWluLmMJMzEgSnVsIDIwMDcgMTI6Mjc6MjMgLTAwMDAJMS45OAorKysgaGNpZC9tYWluLmMJ
MSBBdWcgMjAwNyAxMzo1Mjo1MyAtMDAwMApAQCAtNTIzLDE0ICs1MjMsMTQgQEAKIAlpZiAoaW9j
dGwoZGQsIEhDSURFVlVQLCBkZXZfaWQpIDwgMCAmJiBlcnJubyAhPSBFQUxSRUFEWSkgewogCQll
cnJvcigiQ2FuJ3QgaW5pdCBkZXZpY2UgaGNpJWQ6ICVzICglZCkiLAogCQkJCQlkZXZfaWQsIHN0
cmVycm9yKGVycm5vKSwgZXJybm8pOwotCQlleGl0KDEpOworCQlnb3RvIGZhaWw7CiAJfQogCiAJ
aWYgKGhjaV9kZXZpbmZvKGRldl9pZCwgJmRpKSA8IDApCi0JCWV4aXQoMSk7CisJCWdvdG8gZmFp
bDsKIAogCWlmIChoY2lfdGVzdF9iaXQoSENJX1JBVywgJmRpLmZsYWdzKSkKLQkJZXhpdCgwKTsK
KwkJZ290byBkb25lOwogCiAJaWYgKGhjaWQub2ZmbW9kZSA9PSBIQ0lEX09GRk1PREVfREVWRE9X
TikgewogCQljaGFyIG1vZGVbMTZdOwpAQCAtNTM4LDIwICs1MzgsMjkgQEAKIAkJaWYgKHJlYWRf
ZGV2aWNlX21vZGUoJmRpLmJkYWRkciwgbW9kZSwgc2l6ZW9mKG1vZGUpKSA9PSAwICYmCiAJCQkJ
CQlzdHJjbXAobW9kZSwgIm9mZiIpID09IDApIHsKIAkJCWlvY3RsKGRkLCBIQ0lERVZET1dOLCBk
ZXZfaWQpOwotCQkJZXhpdCgwKTsKKwkJCWdvdG8gZG9uZTsKIAkJfQogCX0KLQorZG9uZToKIAlo
Y2lfY2xvc2VfZGV2KGRkKTsKLQogCWV4aXQoMCk7CitmYWlsOgorCWhjaV9jbG9zZV9kZXYoZGQp
OworCWV4aXQoMSk7CiB9CiAKIHN0YXRpYyB2b2lkIGRldmljZV9kZXZyZWdfc2V0dXAoaW50IGRl
dl9pZCkKIHsKKwlzdHJ1Y3QgaGNpX2Rldl9pbmZvIGRpOworCiAJaWYgKGhjaWQuYXV0b19pbml0
KQogCQlpbml0X2RldmljZShkZXZfaWQpOwotCWhjaWRfZGJ1c19yZWdpc3Rlcl9kZXZpY2UoZGV2
X2lkKTsKKworCWlmIChoY2lfZGV2aW5mbyhkZXZfaWQsICZkaSkgPCAwKQorCQlyZXR1cm47CisK
KwlpZiAoIWhjaV90ZXN0X2JpdChIQ0lfUkFXLCAmZGkuZmxhZ3MpKQorCQloY2lkX2RidXNfcmVn
aXN0ZXJfZGV2aWNlKGRldl9pZCk7CiB9CiAKIHN0YXRpYyB2b2lkIGRldmljZV9kZXZ1cF9zZXR1
cChpbnQgZGV2X2lkKQo=
------=_Part_48378_19716791.1185976600579
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
------=_Part_48378_19716791.1185976600579
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_48378_19716791.1185976600579--

Return-Path: <cyrus@holtmann.org>
Message-ID: <3ad703600712110300j7a3e628cj1e4d55dd9d4a0d5b@mail.gmail.com>
Date: Tue, 11 Dec 2007 12:00:13 +0100
From: "Geoffrey Doret" <gdoret@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_37112_11380897.1197370818924"
Subject: [Bluez-devel] Patch proposal for serial manager
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

------=_Part_37112_11380897.1197370818924
Content-Type: multipart/alternative;
	boundary="----=_Part_37113_3484982.1197370818925"

------=_Part_37113_3484982.1197370818925
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have added a connect service method in the serial service manager that
take the address of an adapter as first parameter to be able to use more
than one adapter. I realy would like to contribute to bluez and see my patch
applied to the CVS. This is a first proposal, if you have any remarks, I
will take them into account.

Geoffrey Doret

------=_Part_37113_3484982.1197370818925
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I have added a connect service method in the serial service manager that take the address of an adapter as first parameter to be able to use more than one adapter. I realy would like to contribute to bluez and see my patch applied to the CVS. This is a first proposal, if you have any remarks, I will take them into account.
<br><br>Geoffrey Doret<br><br><br>

------=_Part_37113_3484982.1197370818925--

------=_Part_37112_11380897.1197370818924
Content-Type: application/octet-stream; name=patch4
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fa2fw5sx0
Content-Disposition: attachment; filename=patch4

SW5kZXg6IHV0aWxzL3NlcmlhbC9tYW5hZ2VyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jv
b3QvYmx1ZXovdXRpbHMvc2VyaWFsL21hbmFnZXIuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45
OQpkaWZmIC11IC1yMS45OSBtYW5hZ2VyLmMKLS0tIHV0aWxzL3NlcmlhbC9tYW5hZ2VyLmMJMjYg
Tm92IDIwMDcgMTM6NDM6NTcgLTAwMDAJMS45OQorKysgdXRpbHMvc2VyaWFsL21hbmFnZXIuYwkx
MSBEZWMgMjAwNyAxMDoxNDoyMCAtMDAwMApAQCAtMTkxNywyNiArMTkxNyw0MyBAQAogCXN0cnVj
dCBwZW5kaW5nX2Nvbm5lY3QgKnBlbmRpbmcsICpwYzsKIAlEQnVzRXJyb3IgZGVycjsKIAliZGFk
ZHJfdCBzcmM7Ci0JY29uc3QgY2hhciAqYmRhLCAqcGF0dGVybjsKKwljb25zdCBjaGFyICphZGFw
dGVyLCAqYmRhLCAqcGF0dGVybjsKIAlsb25nIHZhbDsKIAlpbnQgZGV2X2lkLCBlcnI7CiAJY2hh
ciB1dWlkW01BWF9MRU5fVVVJRF9TVFJdOwogCiAJZGJ1c19lcnJvcl9pbml0KCZkZXJyKTsKLQlp
ZiAoIWRidXNfbWVzc2FnZV9nZXRfYXJncyhtc2csICZkZXJyLAotCQkJCURCVVNfVFlQRV9TVFJJ
TkcsICZiZGEsCi0JCQkJREJVU19UWVBFX1NUUklORywgJnBhdHRlcm4sCi0JCQkJREJVU19UWVBF
X0lOVkFMSUQpKSB7Ci0JCWVycm9yX2ludmFsaWRfYXJndW1lbnRzKGNvbm4sIG1zZywgZGVyci5t
ZXNzYWdlKTsKLQkJZGJ1c19lcnJvcl9mcmVlKCZkZXJyKTsKLQkJcmV0dXJuIERCVVNfSEFORExF
Ul9SRVNVTFRfSEFORExFRDsKKwlpZihkYnVzX21lc3NhZ2VfaGFzX3NpZ25hdHVyZShtc2csICJz
c3MiKSkgeworCQlpZiAoIWRidXNfbWVzc2FnZV9nZXRfYXJncyhtc2csICZkZXJyLAorCQkJCQlE
QlVTX1RZUEVfU1RSSU5HLCAmYWRhcHRlciwKKwkJCQkJREJVU19UWVBFX1NUUklORywgJmJkYSwK
KwkJCQkJREJVU19UWVBFX1NUUklORywgJnBhdHRlcm4sCisJCQkJCURCVVNfVFlQRV9JTlZBTElE
KSkgeworCQkJZXJyb3JfaW52YWxpZF9hcmd1bWVudHMoY29ubiwgbXNnLCBkZXJyLm1lc3NhZ2Up
OworCQkJZGJ1c19lcnJvcl9mcmVlKCZkZXJyKTsKKwkJCXJldHVybiBEQlVTX0hBTkRMRVJfUkVT
VUxUX0hBTkRMRUQ7CisJCX0KKwkJLyogSGFuZGxlIGVtcHR5IGFkYXB0ZXIgYXMgdGhlIGRlZmF1
bHQgKi8KKwkJaWYoIWFkYXB0ZXJbMF0pCisJCQlhZGFwdGVyID0gTlVMTDsKKwl9IGVsc2Ugewor
CQlpZiAoIWRidXNfbWVzc2FnZV9nZXRfYXJncyhtc2csICZkZXJyLAorCQkJCQlEQlVTX1RZUEVf
U1RSSU5HLCAmYmRhLAorCQkJCQlEQlVTX1RZUEVfU1RSSU5HLCAmcGF0dGVybiwKKwkJCQkJREJV
U19UWVBFX0lOVkFMSUQpKSB7CisJCQllcnJvcl9pbnZhbGlkX2FyZ3VtZW50cyhjb25uLCBtc2cs
IGRlcnIubWVzc2FnZSk7CisJCQlkYnVzX2Vycm9yX2ZyZWUoJmRlcnIpOworCQkJcmV0dXJuIERC
VVNfSEFORExFUl9SRVNVTFRfSEFORExFRDsKKwkJfQorCQkvKiBVc2UgdGhlIGRlZmF1bHQgYWRh
cHRlciAqLworCQlhZGFwdGVyID0gTlVMTDsKIAl9CiAKIAlwZW5kaW5nID0gZmluZF9wZW5kaW5n
X2Nvbm5lY3RfYnlfcGF0dGVybihiZGEsIHBhdHRlcm4pOwogCWlmIChwZW5kaW5nKQogCQlyZXR1
cm4gZXJyb3JfaW5fcHJvZ3Jlc3MoY29ubiwgbXNnLCAiQ29ubmVjdGlvbiBpbiBwcm9ncmVzcyIp
OwogCi0JZGV2X2lkID0gaGNpX2dldF9yb3V0ZShOVUxMKTsKKwlkZXZfaWQgPSBhZGFwdGVyID8g
aGNpX2RldmlkKGFkYXB0ZXIpIDogaGNpX2dldF9yb3V0ZShOVUxMKTsKIAlpZiAoKGRldl9pZCA8
IDApIHx8IChoY2lfZGV2YmEoZGV2X2lkLCAmc3JjKSA8IDApKQogCQlyZXR1cm4gZXJyb3JfZmFp
bGVkKGNvbm4sIG1zZywgIkFkYXB0ZXIgbm90IGF2YWlsYWJsZSIpOwogCkBAIC0yMTQ2LDYgKzIx
NjMsNyBAQAogCXsgIkxpc3RQcm94aWVzIiwJCWxpc3RfcHJveGllcywJCSIiLAkiYXMiCX0sCiAJ
eyAiUmVtb3ZlUHJveHkiLAkJcmVtb3ZlX3Byb3h5LAkJInMiLAkiIgl9LAogCXsgIkNvbm5lY3RT
ZXJ2aWNlIiwJCWNvbm5lY3Rfc2VydmljZSwJInNzIiwJInMiCX0sCisJeyAiQ29ubmVjdFNlcnZp
Y2VUb0FkYXB0ZXIiLAljb25uZWN0X3NlcnZpY2UsCSJzc3MiLAkicyIJfSwKIAl7ICJEaXNjb25u
ZWN0U2VydmljZSIsCQlkaXNjb25uZWN0X3NlcnZpY2UsCSJzIiwJIiIJfSwKIAl7ICJDYW5jZWxD
b25uZWN0U2VydmljZSIsCWNhbmNlbF9jb25uZWN0X3NlcnZpY2UsCSJzcyIsCSIiCX0sCiAJeyBO
VUxMLCBOVUxMLCBOVUxMLCBOVUxMIH0sCkluZGV4OiB1dGlscy9zZXJpYWwvc2VyaWFsLWFwaS50
eHQKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXovdXRpbHMvc2VyaWFsL3Nlcmlh
bC1hcGkudHh0LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIxCmRpZmYgLXUgLXIxLjIxIHNlcmlh
bC1hcGkudHh0Ci0tLSB1dGlscy9zZXJpYWwvc2VyaWFsLWFwaS50eHQJMjYgTm92IDIwMDcgMTM6
NDE6MzkgLTAwMDAJMS4yMQorKysgdXRpbHMvc2VyaWFsL3NlcmlhbC1hcGkudHh0CTExIERlYyAy
MDA3IDEwOjE0OjIwIC0wMDAwCkBAIC02Nyw2ICs2NywyMSBAQAogCQkJCQlvcmcuYmx1ZXouRXJy
b3IuQ29ubmVjdGlvbkF0dGVtcHRGYWlsZWQKIAkJCQkJb3JnLmJsdWV6LkVycm9yLk5vdFN1cHBv
cnRlZAogCQkJCQlvcmcuYmx1ZXouRXJyb3IuRmFpbGVkCisJCQorCQlzdHJpbmcgQ29ubmVjdFNl
cnZpY2VUb0FkYXB0ZXIoc3RyaW5nIGFkYXB0ZXIsIHN0cmluZyBhZGRyZXNzLAorCQkJCXN0cmlu
ZyBwYXR0ZXJuKQorCisJCQlDb25uZWN0cyB0byBhIHNwZWNpZmljIFJGQ09NTSBiYXNlZCBzZXJ2
aWNlIG9uIGEKKwkJCXJlbW90ZSBkZXZpY2UgdXNpbmcgdGhlIHNwZWNpZmllZCBhZGFwdGVyIGFu
ZCB0aGVuCisJCQljcmVhdGVzIGEgUkZDT01NIFRUWSBkZXZpY2UgZm9yIGl0LiBUaGUgUkZDT01N
IFRUWQorCQkJZGV2aWNlIGlzIHJldHVybmVkLgorCisJCQlQb3NzaWJsZSBlcnJvcnM6b3JnLmJs
dWV6LkVycm9yLkludmFsaWRBcmd1bWVudHMKKwkJCQkJb3JnLmJsdWV6LkVycm9yLkNhbmNlbGVk
CisJCQkJCW9yZy5ibHVlei5FcnJvci5JblByb2dyZXNzCisJCQkJCW9yZy5ibHVlei5FcnJvci5D
b25uZWN0aW9uQXR0ZW1wdEZhaWxlZAorCQkJCQlvcmcuYmx1ZXouRXJyb3IuTm90U3VwcG9ydGVk
CisJCQkJCW9yZy5ibHVlei5FcnJvci5GYWlsZWQKIAogCQl2b2lkIENhbmNlbENvbm5lY3RTZXJ2
aWNlKHN0cmluZyBhZGRyZXNzLCBzdHJpbmcgcGF0dGVybikKIAo=
------=_Part_37112_11380897.1197370818924
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
------=_Part_37112_11380897.1197370818924
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_37112_11380897.1197370818924--

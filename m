Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Dec 2008 13:05:51 +0800
Subject: RE: [patch] obexd: if path == NULL, don't call
 dbus_connection_get_object_path_data
Message-ID: <0463F45F3606F4428ED35AC8C709F92E046C04CB@pdsmsx502.ccr.corp.intel.com>
References: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
	 <3D8E1963-54E4-4974-98B3-6E9095046D30@gmail.com>
	 <0463F45F3606F4428ED35AC8C709F92E046C0469@pdsmsx502.ccr.corp.intel.com>
 <1230090097.4954.27.camel@californication>
In-Reply-To: <1230090097.4954.27.camel@californication>
Content-Type: multipart/mixed;
	boundary="_002_0463F45F3606F4428ED35AC8C709F92E046C04CBpdsmsx502ccrcor_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_0463F45F3606F4428ED35AC8C709F92E046C04CBpdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel

>
>You should really start thinking for the error =3D> return paradigm all
>the time. This makes the code a lot simpler to read.
>
>Regards
>Marcel
>

OK, Got it. Resent

Raymond


--_002_0463F45F3606F4428ED35AC8C709F92E046C04CBpdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch"
Content-Description: 0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch
Content-Disposition: attachment;
	filename="0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch";
	size=753; creation-date="Wed, 24 Dec 2008 11:10:33 GMT";
	modification-date="Wed, 24 Dec 2008 13:02:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYWVhODUzYTIzMzhiNjVmZWI2OGUwMTAzZWY4Nzk1NDY3Y2FkYTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIExpdSA8cmF5bW9uZC5saXVAaW50ZWwuY29tPgpE
YXRlOiBXZWQsIDI0IERlYyAyMDA4IDEwOjU0OjQ3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnVn
IGZpeDogaWYgcGF0aCA9PSBOVUxMLCBkb24ndCBjYWxsIGRidXNfY29ubmVjdGlvbl9nZXRfb2Jq
ZWN0X3BhdGhfZGF0YQoKLS0tCiBnZGJ1cy9vYmplY3QuYyB8ICAgIDMgKysrCiAxIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9nZGJ1
cy9vYmplY3QuYyBiL2dkYnVzL29iamVjdC5jCmluZGV4IDQzMmE4YTAuLmE0MTYxN2QgMTAwNjQ0
Ci0tLSBhL2dkYnVzL29iamVjdC5jCisrKyBiL2dkYnVzL29iamVjdC5jCkBAIC00OTQsNiArNDk0
LDkgQEAgZ2Jvb2xlYW4gZ19kYnVzX3VucmVnaXN0ZXJfaW50ZXJmYWNlKERCdXNDb25uZWN0aW9u
ICpjb25uZWN0aW9uLAogCXN0cnVjdCBnZW5lcmljX2RhdGEgKmRhdGEgPSBOVUxMOwogCXN0cnVj
dCBpbnRlcmZhY2VfZGF0YSAqaWZhY2U7CiAKKwlpZiAoIXBhdGgpCisJCXJldHVybiBGQUxTRTsK
KwogCWlmIChkYnVzX2Nvbm5lY3Rpb25fZ2V0X29iamVjdF9wYXRoX2RhdGEoY29ubmVjdGlvbiwg
cGF0aCwKIAkJCQkJCSh2b2lkICopICZkYXRhKSA9PSBGQUxTRSkKIAkJcmV0dXJuIEZBTFNFOwot
LSAKMS41LjYuMwoK

--_002_0463F45F3606F4428ED35AC8C709F92E046C04CBpdsmsx502ccrcor_--

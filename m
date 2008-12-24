Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Dec 2008 11:13:50 +0800
Subject: [patch] obexd: if path == NULL, don't call
 dbus_connection_get_object_path_data
Message-ID: <0463F45F3606F4428ED35AC8C709F92E046C0469@pdsmsx502.ccr.corp.intel.com>
References: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
 <3D8E1963-54E4-4974-98B3-6E9095046D30@gmail.com>
In-Reply-To: <3D8E1963-54E4-4974-98B3-6E9095046D30@gmail.com>
Content-Type: multipart/mixed;
	boundary="_002_0463F45F3606F4428ED35AC8C709F92E046C0469pdsmsx502ccrcor_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_0463F45F3606F4428ED35AC8C709F92E046C0469pdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

	Just a minor fix for g_dbus_unregister_interface to avoid calling dbus_con=
nection_get_object_path_data when path is NULL.

Best Regards,
Raymond Liu

--_002_0463F45F3606F4428ED35AC8C709F92E046C0469pdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch"
Content-Description: 0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch
Content-Disposition: attachment;
	filename="0001-bug-fix-if-path-NULL-don-t-call-dbus_connection.patch";
	size=792; creation-date="Wed, 24 Dec 2008 11:10:33 GMT";
	modification-date="Wed, 24 Dec 2008 10:56:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZDdhYjNkZmU5NmZlZDQ1NWYzOWJlYTIxODFlNzE2MDM1MTVmZmRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIExpdSA8cmF5bW9uZC5saXVAaW50ZWwuY29tPgpE
YXRlOiBXZWQsIDI0IERlYyAyMDA4IDEwOjU0OjQ3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnVn
IGZpeDogaWYgcGF0aCA9PSBOVUxMLCBkb24ndCBjYWxsIGRidXNfY29ubmVjdGlvbl9nZXRfb2Jq
ZWN0X3BhdGhfZGF0YQoKLS0tCiBnZGJ1cy9vYmplY3QuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dkYnVz
L29iamVjdC5jIGIvZ2RidXMvb2JqZWN0LmMKaW5kZXggNDMyYThhMC4uMWM4YmNjNCAxMDA2NDQK
LS0tIGEvZ2RidXMvb2JqZWN0LmMKKysrIGIvZ2RidXMvb2JqZWN0LmMKQEAgLTQ5NCw3ICs0OTQs
NyBAQCBnYm9vbGVhbiBnX2RidXNfdW5yZWdpc3Rlcl9pbnRlcmZhY2UoREJ1c0Nvbm5lY3Rpb24g
KmNvbm5lY3Rpb24sCiAJc3RydWN0IGdlbmVyaWNfZGF0YSAqZGF0YSA9IE5VTEw7CiAJc3RydWN0
IGludGVyZmFjZV9kYXRhICppZmFjZTsKIAotCWlmIChkYnVzX2Nvbm5lY3Rpb25fZ2V0X29iamVj
dF9wYXRoX2RhdGEoY29ubmVjdGlvbiwgcGF0aCwKKwlpZiAoIXBhdGggfHwgZGJ1c19jb25uZWN0
aW9uX2dldF9vYmplY3RfcGF0aF9kYXRhKGNvbm5lY3Rpb24sIHBhdGgsCiAJCQkJCQkodm9pZCAq
KSAmZGF0YSkgPT0gRkFMU0UpCiAJCXJldHVybiBGQUxTRTsKIAotLSAKMS41LjYuMwoK

--_002_0463F45F3606F4428ED35AC8C709F92E046C0469pdsmsx502ccrcor_--

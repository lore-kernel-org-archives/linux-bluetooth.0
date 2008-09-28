Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C92192.4C866249"
Subject: [PATCH] Add ability to start wizard from properties
Date: Sun, 28 Sep 2008 12:47:29 -0500
Message-ID: <FA7963CC89065B49AED46A6F797F0FA6F28696@AUSX3MPC128.aus.amer.dell.com>
From: <Mario_Limonciello@Dell.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C92192.4C866249
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:

When packaged, generally the Bluetooth properties application is added =
to the Preferences menu as a configuration tool for Bluetooth.  This =
leaves a gap in the experience since there is no way to configure "New" =
devices by following that flow.  This patch adds a button to the UI that =
will spawn the wizard to allow users to pair.

Regards

Mario Limonciello=20
Dell | Linux Engineering=20
Mario_Limonciello@Dell.com=20

------_=_NextPart_001_01C92192.4C866249
Content-Type: text/x-patch;
	name="07_add_wizard_preferences.patch"
Content-Transfer-Encoding: base64
Content-Description: 07_add_wizard_preferences.patch
Content-Disposition: attachment;
	filename="07_add_wizard_preferences.patch"

ZGlmZiAtTnVyIC14ICcqLm9yaWcnIC14ICcqficgYmx1ZXotZ25vbWUtMS41L3Byb3BlcnRpZXMv
bWFpbi5jIGJsdWV6LWdub21lLTEuNS5uZXcvcHJvcGVydGllcy9tYWluLmMKLS0tIGJsdWV6LWdu
b21lLTEuNS9wcm9wZXJ0aWVzL21haW4uYwkyMDA4LTA4LTI0IDExOjA1OjUwLjAwMDAwMDAwMCAt
MDUwMAorKysgYmx1ZXotZ25vbWUtMS41Lm5ldy9wcm9wZXJ0aWVzL21haW4uYwkyMDA4LTA5LTI4
IDEyOjE5OjQ2LjAwMDAwMDAwMCAtMDUwMApAQCAtNTEsNiArNTEsMTYgQEAKIAlndGtfbWFpbl9x
dWl0KCk7CiB9CiAKK3N0YXRpYyB2b2lkIHdpemFyZF9jYWxsYmFjayhHT2JqZWN0ICp3aWRnZXQs
IGdwb2ludGVyIHVzZXJfZGF0YSkKK3sKKyAgICAgICAgY29uc3QgY2hhciAqY29tbWFuZCA9ICJi
bHVldG9vdGgtd2l6YXJkIjsKKworICAgICAgICBpZiAoIWdfc3Bhd25fY29tbWFuZF9saW5lX2Fz
eW5jKGNvbW1hbmQsIE5VTEwpKQorICAgICAgICAgICAgICAgIGdfcHJpbnRlcnIoIkNvdWxkbid0
IGV4ZWN1dGUgY29tbWFuZDogJXNcbiIsIGNvbW1hbmQpOworCisJY2xvc2VfY2FsbGJhY2sod2lk
Z2V0LHVzZXJfZGF0YSk7Cit9CisKIHN0YXRpYyBHdGtXaWRnZXQgKmNyZWF0ZV93aW5kb3coR3Rr
V2lkZ2V0ICpub3RlYm9vaykKIHsKIAlHdGtXaWRnZXQgKndpbmRvdzsKQEAgLTc2LDYgKzg2LDEx
IEBACiAJZ3RrX2J1dHRvbl9ib3hfc2V0X2xheW91dChHVEtfQlVUVE9OX0JPWChidXR0b25ib3gp
LCBHVEtfQlVUVE9OQk9YX0VORCk7CiAJZ3RrX2JveF9wYWNrX3N0YXJ0KEdUS19CT1godmJveCks
IGJ1dHRvbmJveCwgRkFMU0UsIEZBTFNFLCAwKTsKIAorCWJ1dHRvbiA9IGd0a19idXR0b25fbmV3
X3dpdGhfbW5lbW9uaWMoXygiU2V0dXAgX05ldyBEZXZpY2UiKSk7CisJZ3RrX2NvbnRhaW5lcl9h
ZGQoR1RLX0NPTlRBSU5FUihidXR0b25ib3gpLCBidXR0b24pOworCWdfc2lnbmFsX2Nvbm5lY3Qo
R19PQkpFQ1QoYnV0dG9uKSwgImNsaWNrZWQiLAorCQkJCQlHX0NBTExCQUNLKHdpemFyZF9jYWxs
YmFjayksIHdpbmRvdyk7CisKIAlidXR0b24gPSBndGtfYnV0dG9uX25ld19mcm9tX3N0b2NrKEdU
S19TVE9DS19DTE9TRSk7CiAJZ3RrX2NvbnRhaW5lcl9hZGQoR1RLX0NPTlRBSU5FUihidXR0b25i
b3gpLCBidXR0b24pOwogCWdfc2lnbmFsX2Nvbm5lY3QoR19PQkpFQ1QoYnV0dG9uKSwgImNsaWNr
ZWQiLAo=

------_=_NextPart_001_01C92192.4C866249--

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286959079-3566-1-git-send-email-lucas.pawlik@gmail.com>
References: <1286959079-3566-1-git-send-email-lucas.pawlik@gmail.com>
Date: Wed, 13 Oct 2010 11:33:24 +0200
Message-ID: <AANLkTimEv+RYqUC76dOYc7t4ciwC2FSi-AYG0d8KdaUn@mail.gmail.com>
Subject: Re: [PATCH] Fix problem with hanging up held call
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=005045016771f0b03404927c48d5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--005045016771f0b03404927c48d5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

There was an error in my patch. Patch attached to this mail fix it.

2010/10/13 Lukasz Pawlik <lucas.pawlik@gmail.com>:
> According to the HFP specification AT+CHUP command should not have impact
> on the state of any held calls. Previously held call was terminated when
> there was second alerting call. This patch fix this problem. AT+CHUP
> command will go towards alerting call.
> ---
> =A0audio/telephony-maemo6.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
> index 05ff332..00a4b25 100644
> --- a/audio/telephony-maemo6.c
> +++ b/audio/telephony-maemo6.c
> @@ -498,6 +498,7 @@ void telephony_last_dialed_number_req(void *telephony=
_device)
> =A0void telephony_terminate_call_req(void *telephony_device)
> =A0{
> =A0 =A0 =A0 =A0struct csd_call *call;
> + =A0 =A0 =A0 struct csd_call *alerting;
> =A0 =A0 =A0 =A0int err;
>
> =A0 =A0 =A0 =A0call =3D find_call_with_status(CSD_CALL_STATUS_ACTIVE);
> @@ -511,6 +512,9 @@ void telephony_terminate_call_req(void *telephony_dev=
ice)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 alerting =3D find_call_with_status(CSD_CALL_STATUS_MO_ALERT=
ING);
> + =A0 =A0 =A0 if (call->on_hold && alerting)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D release_call(alerting);
> =A0 =A0 =A0 =A0if (call->conference)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D release_conference();
> =A0 =A0 =A0 =A0else
> --
> 1.7.0.4
>
>

--005045016771f0b03404927c48d5
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-problem-with-hanging-up-held-call.patch"
Content-Disposition: attachment;
	filename="0001-Fix-problem-with-hanging-up-held-call.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gf802rt70

RnJvbSA3YjdjNGFkZjk4MmEwYzk4ZGYxNDMzMWJmMzU3NjE5ZDFiNDgzMjI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWthc3ogUGF3bGlrIDxsdWNhcy5wYXdsaWtAZ21haWwuY29t
PgpEYXRlOiBXZWQsIDEzIE9jdCAyMDEwIDEwOjU0OjIxICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
Rml4IHByb2JsZW0gd2l0aCBoYW5naW5nIHVwIGhlbGQgY2FsbAoKQWNjb3JkaW5nIHRvIHRoZSBI
RlAgc3BlY2lmaWNhdGlvbiBBVCtDSFVQIGNvbW1hbmQgc2hvdWxkIG5vdCBoYXZlIGltcGFjdApv
biB0aGUgc3RhdGUgb2YgYW55IGhlbGQgY2FsbHMuIFByZXZpb3VzbHkgaGVsZCBjYWxsIHdhcyB0
ZXJtaW5hdGVkIHdoZW4KdGhlcmUgd2FzIHNlY29uZCBhbGVydGluZyBjYWxsLiBUaGlzIHBhdGNo
IGZpeCB0aGlzIHByb2JsZW0uIEFUK0NIVVAKY29tbWFuZCB3aWxsIGdvIHRvd2FyZHMgYWxlcnRp
bmcgY2FsbC4KLS0tCiBhdWRpby90ZWxlcGhvbnktbWFlbW82LmMgfCAgICA2ICsrKysrLQogMSBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYXVkaW8vdGVsZXBob255LW1hZW1vNi5jIGIvYXVkaW8vdGVsZXBob255LW1hZW1vNi5jCmlu
ZGV4IDA1ZmYzMzIuLjFhYWMwMzQgMTAwNjQ0Ci0tLSBhL2F1ZGlvL3RlbGVwaG9ueS1tYWVtbzYu
YworKysgYi9hdWRpby90ZWxlcGhvbnktbWFlbW82LmMKQEAgLTQ5OCw2ICs0OTgsNyBAQCB2b2lk
IHRlbGVwaG9ueV9sYXN0X2RpYWxlZF9udW1iZXJfcmVxKHZvaWQgKnRlbGVwaG9ueV9kZXZpY2Up
CiB2b2lkIHRlbGVwaG9ueV90ZXJtaW5hdGVfY2FsbF9yZXEodm9pZCAqdGVsZXBob255X2Rldmlj
ZSkKIHsKIAlzdHJ1Y3QgY3NkX2NhbGwgKmNhbGw7CisJc3RydWN0IGNzZF9jYWxsICphbGVydGlu
ZzsKIAlpbnQgZXJyOwogCiAJY2FsbCA9IGZpbmRfY2FsbF93aXRoX3N0YXR1cyhDU0RfQ0FMTF9T
VEFUVVNfQUNUSVZFKTsKQEAgLTUxMSw3ICs1MTIsMTAgQEAgdm9pZCB0ZWxlcGhvbnlfdGVybWlu
YXRlX2NhbGxfcmVxKHZvaWQgKnRlbGVwaG9ueV9kZXZpY2UpCiAJCXJldHVybjsKIAl9CiAKLQlp
ZiAoY2FsbC0+Y29uZmVyZW5jZSkKKwlhbGVydGluZyA9IGZpbmRfY2FsbF93aXRoX3N0YXR1cyhD
U0RfQ0FMTF9TVEFUVVNfTU9fQUxFUlRJTkcpOworCWlmIChjYWxsLT5vbl9ob2xkICYmIGFsZXJ0
aW5nKQorCQllcnIgPSByZWxlYXNlX2NhbGwoYWxlcnRpbmcpOworCWVsc2UgaWYgKGNhbGwtPmNv
bmZlcmVuY2UpCiAJCWVyciA9IHJlbGVhc2VfY29uZmVyZW5jZSgpOwogCWVsc2UKIAkJZXJyID0g
cmVsZWFzZV9jYWxsKGNhbGwpOwotLSAKMS43LjAuNAoK
--005045016771f0b03404927c48d5--

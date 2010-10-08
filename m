Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim4WEh7ZLTiWbhiWcv1VXV+jpb_V8NqJjeq=OzH@mail.gmail.com>
References: <1286369566-1453-1-git-send-email-lucas.pawlik@gmail.com>
	<20101006133206.GA8696@jh-x301>
	<AANLkTim4WEh7ZLTiWbhiWcv1VXV+jpb_V8NqJjeq=OzH@mail.gmail.com>
Date: Fri, 8 Oct 2010 10:35:56 +0200
Message-ID: <AANLkTim4tHR+3ccDJi+X8jLDiZo+PXTQjfCWtZ85bhjZ@mail.gmail.com>
Subject: Re: [PATCH] Fix problem with invalid read from array
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0022152d7fed42c2de049216e681
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0022152d7fed42c2de049216e681
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Attaching patch without change in src/adapter.c file.

Lukasz Pawlik

2010/10/6 Lukasz Pawlik <lucas.pawlik@gmail.com>:
> Hi,
>
> Sorry. My bad. It was never my intention to change src/adapter.c. I've
> prepared two patches with the same name and of course send the wrong
> one. Problem with invalid read fix change made in src/sdpd-service.c
> file.
>
> Lukasz
>
> 2010/10/6 Johan Hedberg <johan.hedberg@gmail.com>:
>> Hi Lukasz,
>>
>> On Wed, Oct 06, 2010, Lukasz Pawlik wrote:
>>> This patch fix problem with reading data from out of the array range in
>>> function used to create EIR response.
>>
>> You'll need to explain in more detail exactly what was wrong with the
>> old code and how your patch fixes it (and why it is the correct fix).
>>
>>> - =A0 =A0 uint8_t data[240];
>>> + =A0 =A0 uint8_t data[242];
>>
>> Why 242? The core spec defines the EIR data as a 240 byte field.
>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 uuid128_data[SIZEOF_UUID128 - k])
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 uuid128_data[SIZEOF_UUID128 - 1 - k])
>>
>> This change looks fine (the index of the last byte is sizeof(uuid128) - =
1).
>>
>> Johan
>>
>

--0022152d7fed42c2de049216e681
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-problem-with-invalid-read-from-array.patch"
Content-Disposition: attachment;
	filename="0001-Fix-problem-with-invalid-read-from-array.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gf0shyhf0

RnJvbSA1ZTZjYThlOWRmZjBjZWQ1YWFjYzFjYmZhMTIzMTg2ODBhZGU5NTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWthc3ogUGF3bGlrIDxsdWNhcy5wYXdsaWtAZ21haWwuY29t
PgpEYXRlOiBGcmksIDggT2N0IDIwMTAgMDk6MjM6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBG
aXggcHJvYmxlbSB3aXRoIGludmFsaWQgcmVhZCBmcm9tIGFycmF5CgpUaGlzIHBhdGNoIGZpeCBw
cm9ibGVtIHdpdGggcmVhZGluZyBkYXRhIGZyb20gb3V0IG9mIHRoZSBhcnJheSByYW5nZSBpbgpm
dW5jdGlvbiB1c2VkIHRvIGNyZWF0ZSBFSVIgcmVzcG9uc2UuCi0tLQogc3JjL3NkcGQtc2Vydmlj
ZS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3NkcGQtc2VydmljZS5jIGIvc3JjL3NkcGQtc2Vydmlj
ZS5jCmluZGV4IDI2YWI5YTUuLjY3ZGQ5YWYgMTAwNjQ0Ci0tLSBhL3NyYy9zZHBkLXNlcnZpY2Uu
YworKysgYi9zcmMvc2RwZC1zZXJ2aWNlLmMKQEAgLTIwNCw3ICsyMDQsNyBAQCBzdGF0aWMgdm9p
ZCBlaXJfZ2VuZXJhdGVfdXVpZDEyOChzZHBfbGlzdF90ICpsaXN0LAogCQlmb3IgKGkgPSAwOyBp
IDwgaW5kZXg7IGkrKykgewogCQkJZm9yIChrID0gMDsgayA8IFNJWkVPRl9VVUlEMTI4OyBrKysp
IHsKIAkJCQlpZiAodXVpZDEyOFtpICogU0laRU9GX1VVSUQxMjggKyBrXSAhPQotCQkJCQl1dWlk
MTI4X2RhdGFbU0laRU9GX1VVSUQxMjggLSBrXSkKKwkJCQkJdXVpZDEyOF9kYXRhW1NJWkVPRl9V
VUlEMTI4IC0gMSAtIGtdKQogCQkJCQlicmVhazsKIAkJCX0KIAkJCWlmIChrID09IFNJWkVPRl9V
VUlEMTI4KQotLSAKMS43LjAuNAoK
--0022152d7fed42c2de049216e681--

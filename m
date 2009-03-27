Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1238022096.8206.1.camel@localhost.localdomain>
References: <35c90d960903261651i46cb32c6qc061f7f718e3d669@mail.gmail.com>
	 <1238022096.8206.1.camel@localhost.localdomain>
Date: Thu, 26 Mar 2009 17:43:10 -0700
Message-ID: <35c90d960903261743p451f2792rf03d9e6ce593dc6d@mail.gmail.com>
Subject: Re: [PATCH] AVDTP Qualification: Fix error handling for AVDTP set
	configuration command
From: Nick Pelly <npelly@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001517503d865e66e204660f0432
List-ID: <linux-bluetooth.vger.kernel.org>

--001517503d865e66e204660f0432
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 3/25/09, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>  > +
>  > +               if ((cap->category == AVDTP_MEDIA_TRANSPORT) &&
>  > (cap->length != 0)) {
>  > +                       err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
>  > +                       goto failed;
>
>  no need to put brackets around cap->cat == ... check etc. The comparison
>  takes precedence over &&. Please fix and re-send the patch.

fixed

--001517503d865e66e204660f0432
Content-Type: text/x-patch; charset=US-ASCII;
	name="0005-AVDTP-Qualification-Fix-error-handling-for-AVDTP-se.patch"
Content-Disposition: attachment;
	filename="0005-AVDTP-Qualification-Fix-error-handling-for-AVDTP-se.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fss5eym9

RnJvbSBmMGQ1MjcwNjIzNTkyMTJjMzUwNmJmMjA5MDgyOTQwNmNmZDE1ZjBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIFBlbGx5IDxucGVsbHlAZ29vZ2xlLmNvbT4KRGF0ZTog
VGh1LCAyNiBNYXIgMjAwOSAxNjoyMzoyNSAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIEFWRFRQIFF1
YWxpZmljYXRpb246IEZpeCBlcnJvciBoYW5kbGluZyBmb3IgQVZEVFAgc2V0IGNvbmZpZ3VyYXRp
b24gY29tbWFuZC4KCi0tLQogYXVkaW8vYXZkdHAuYyB8ICAgMTEgKysrKysrKysrKysKIDEgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hdWRpby9hdmR0cC5jIGIvYXVkaW8vYXZkdHAuYwppbmRleCAyOTdiNTc4Li43NzY0MzY5IDEw
MDY0NAotLS0gYS9hdWRpby9hdmR0cC5jCisrKyBiL2F1ZGlvL2F2ZHRwLmMKQEAgLTEyMDAsNiAr
MTIwMCw3IEBAIHN0YXRpYyBnYm9vbGVhbiBhdmR0cF9zZXRjb25mX2NtZChzdHJ1Y3QgYXZkdHAg
KnNlc3Npb24sIHVpbnQ4X3QgdHJhbnNhY3Rpb24sCiAJdWludDhfdCBlcnIsIGNhdGVnb3J5ID0g
MHgwMDsKIAlzdHJ1Y3QgYXVkaW9fZGV2aWNlICpkZXY7CiAJYmRhZGRyX3Qgc3JjLCBkc3Q7CisJ
R1NMaXN0ICpsOwogCiAJaWYgKHNpemUgPCBzaXplb2Yoc3RydWN0IHNldGNvbmZfcmVxKSkgewog
CQllcnJvcigiVG9vIHNob3J0IGdldGNhcCByZXF1ZXN0Iik7CkBAIC0xMjQ3LDYgKzEyNDgsMTYg
QEAgc3RhdGljIGdib29sZWFuIGF2ZHRwX3NldGNvbmZfY21kKHN0cnVjdCBhdmR0cCAqc2Vzc2lv
biwgdWludDhfdCB0cmFuc2FjdGlvbiwKIAkJCQkJc2l6ZSAtIHNpemVvZihzdHJ1Y3Qgc2V0Y29u
Zl9yZXEpLAogCQkJCQkmc3RyZWFtLT5jb2RlYyk7CiAKKwkvKiBWZXJpZnkgdGhhdCB0aGUgTWVk
aWEgVHJhbnNwb3J0IGNhcGFiaWxpdHkncyBsZW5ndGggPSAwLiBSZWplY3Qgb3RoZXJ3aXNlICov
CisJZm9yIChsID0gc3RyZWFtLT5jYXBzOyBsICE9IE5VTEw7IGwgPSBnX3NsaXN0X25leHQobCkp
IHsKKwkJc3RydWN0IGF2ZHRwX3NlcnZpY2VfY2FwYWJpbGl0eSAqY2FwID0gbC0+ZGF0YTsKKwor
CQlpZiAoY2FwLT5jYXRlZ29yeSA9PSBBVkRUUF9NRURJQV9UUkFOU1BPUlQgJiYgY2FwLT5sZW5n
dGggIT0gMCkgeworCQkJZXJyID0gQVZEVFBfQkFEX01FRElBX1RSQU5TUE9SVF9GT1JNQVQ7CisJ
CQlnb3RvIGZhaWxlZDsKKwkJfQorCX0KKwogCWlmIChzZXAtPmluZCAmJiBzZXAtPmluZC0+c2V0
X2NvbmZpZ3VyYXRpb24pIHsKIAkJaWYgKCFzZXAtPmluZC0+c2V0X2NvbmZpZ3VyYXRpb24oc2Vz
c2lvbiwgc2VwLCBzdHJlYW0sCiAJCQkJCQkJc3RyZWFtLT5jYXBzLCAmZXJyLAotLSAKMS41LjUK
Cg==
--001517503d865e66e204660f0432--

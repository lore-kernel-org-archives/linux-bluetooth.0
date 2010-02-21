Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100219173257.GA12855@jh-x301>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
	 <20100219173257.GA12855@jh-x301>
Date: Sun, 21 Feb 2010 14:54:51 +0200
Message-ID: <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=00504502ca148e0ae404801bd213
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--00504502ca148e0ae404801bd213
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2010 at 7:32 PM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:

> Please try to at least do a compile check before you submit patches.
> This one gives the following error:
> audio/avdtp.c: In function =91handle_unanswered_req=92:
> audio/avdtp.c:908: error: comparison between pointer and integer
>
> What you probably want is session->req->signal_id =3D=3D AVDTP_ABORT.
>

Sorry. The attached patch compiles without warnings on "./configure && make=
".
(new dependency to a capabilities lib prevents ./bootstrap-configure atm)

Br,
Daniel

--00504502ca148e0ae404801bd213
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-double-free-on-AVDTP-Abort-response.patch"
Content-Disposition: attachment;
	filename="0001-Fix-double-free-on-AVDTP-Abort-response.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5xtwlu90

RnJvbSBmNDUwMDZlYzc1YzIzYjU1NDcwZTgwODhmZTY0ZThmMGI2YWI2NDA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgT3JzdGFkaXVzIDxkYW5pZWwub3JzdGFkaXVzQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAyMSBGZWIgMjAxMCAxNDozOTo0OSArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIEZpeCBkb3VibGUgZnJlZSBvbiBBVkRUUCBBYm9ydCByZXNwb25zZQoKVGhlIHBlbmRp
bmcgcmVxdWVzdCBtaWdodCBiZSBmcmVlZCB0d2ljZSB3aGVuIHJlY2VpdmluZyBhbiBBYm9ydApy
ZXNwb25zZSwgaW4gaGFuZGxlX3VuYW5zd2VyZWRfcmVxIGFuZCBzZXNzaW9uX2NiLiBBdm9pZCBm
cmVlaW5nCml0IGluIGhhbmRsZV91bmFuc3dlcmVkX3JlcS4KLS0tCiBhdWRpby9hdmR0cC5jIHwg
ICAgNyArKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hdWRpby9hdmR0cC5jIGIvYXVkaW8vYXZkdHAuYwppbmRleCAy
NTkxODQ1Li5hZGQwOGYxIDEwMDY0NAotLS0gYS9hdWRpby9hdmR0cC5jCisrKyBiL2F1ZGlvL2F2
ZHRwLmMKQEAgLTkwNSw2ICs5MDUsMTMgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3VuYW5zd2VyZWRf
cmVxKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbiwKIAlzdHJ1Y3QgYXZkdHBfbG9jYWxfc2VwICpsc2Vw
OwogCXN0cnVjdCBhdmR0cF9lcnJvciBlcnI7CiAKKwlpZiAoc2Vzc2lvbi0+cmVxLT5zaWduYWxf
aWQgPT0gQVZEVFBfQUJPUlQpIHsKKwkJLyogQXZvaWQgZnJlZWluZyB0aGUgQWJvcnQgcmVxdWVz
dCBoZXJlICovCisJCWRlYnVnKCJoYW5kbGVfdW5hbnN3ZXJlZF9yZXE6IEFib3J0IHJlcSwgcmV0
dXJuaW5nIik7CisJCXNlc3Npb24tPnJlcS0+c3RyZWFtID0gTlVMTDsKKwkJcmV0dXJuOworCX0K
KwogCXJlcSA9IHNlc3Npb24tPnJlcTsKIAlzZXNzaW9uLT5yZXEgPSBOVUxMOwogCi0tIAoxLjYu
MC40Cgo=
--00504502ca148e0ae404801bd213--

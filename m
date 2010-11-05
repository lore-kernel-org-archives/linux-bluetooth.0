Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101104181606.GA15745@jh-x301>
References: <AANLkTikyPtikmH=ep2va2iLke9NoteTr5wpThfR6v=vf@mail.gmail.com>
	<20101104181606.GA15745@jh-x301>
Date: Fri, 5 Nov 2010 10:59:55 +0200
Message-ID: <AANLkTimKWv3XcJ6qfJK6QNCY38vza+Nj12cGfdAELXxu@mail.gmail.com>
Subject: Re: [PATCH] Fix add disconnect watch in connecting state
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016367f96788d642604944a7fdd
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016367f96788d642604944a7fdd
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 4, 2010 at 8:16 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> This doesn't seem quite right to me. Aren't you now adding a disconnect
> callback twice: once for CONNECTING and a second time for CONNECTED? It
> seems like you should only add it when new_state == CONNECTING, right?
>

Yes, that seems right, attaching updated patch.

/Daniel

--0016367f96788d642604944a7fdd
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Fix-add-disconnect-watch-in-connecting-state.patch"
Content-Disposition: attachment;
	filename="0001-Fix-add-disconnect-watch-in-connecting-state.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg4tyxls0

RnJvbSBlNDJjZTYzODc4ZjM2ODg5M2U1ZTExOWQyN2E1NDc3ZGQ0MzBmOWFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgT3JzdGFkaXVzIDxkYW5pZWwub3JzdGFkaXVzQG5v
a2lhLmNvbT4KRGF0ZTogRnJpLCA1IE5vdiAyMDEwIDEwOjQ5OjQxICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gRml4IGFkZCBkaXNjb25uZWN0IHdhdGNoIGluIGNvbm5lY3Rpbmcgc3RhdGUKCklmIGRp
c2Nvbm5lY3RfY2IgaXMgbm90IGFkZGVkIHVudGlsIHRoZSBjb25uZWN0ZWQgc3RhdGUsIHRoZQpj
YWxsYmFjayB3aWxsIG5vdCBiZSB0cmlnZ2VyZWQgaWYgRGV2aWNlLkRpc2Nvbm5lY3RlZCBpcyBj
YWxsZWQKd2hpbGUgdGhlIGF1ZGlvIHByb2ZpbGVzIGFyZSBzdGlsbCBjb25uZWN0aW5nLgotLS0K
IGF1ZGlvL2RldmljZS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXVkaW8vZGV2aWNlLmMgYi9hdWRpby9k
ZXZpY2UuYwppbmRleCA5NTU0YzdiLi5lZmY4MjMxIDEwMDY0NAotLS0gYS9hdWRpby9kZXZpY2Uu
YworKysgYi9hdWRpby9kZXZpY2UuYwpAQCAtMjMxLDcgKzIzMSw3IEBAIHN0YXRpYyB2b2lkIGRl
dmljZV9zZXRfc3RhdGUoc3RydWN0IGF1ZGlvX2RldmljZSAqZGV2LCBhdWRpb19zdGF0ZV90IG5l
d19zdGF0ZSkKIAkJCQkJCQlwcml2LT5kY19pZCk7CiAJCQlwcml2LT5kY19pZCA9IDA7CiAJCX0K
LQl9IGVsc2UgaWYgKG5ld19zdGF0ZSA9PSBBVURJT19TVEFURV9DT05ORUNURUQpCisJfSBlbHNl
IGlmIChuZXdfc3RhdGUgPT0gQVVESU9fU1RBVEVfQ09OTkVDVElORykKIAkJcHJpdi0+ZGNfaWQg
PSBkZXZpY2VfYWRkX2Rpc2Nvbm5lY3Rfd2F0Y2goZGV2LT5idGRfZGV2LAogCQkJCQkJZGlzY29u
bmVjdF9jYiwgZGV2LCBOVUxMKTsKIAotLSAKMS42LjAuNAoK
--0016367f96788d642604944a7fdd--

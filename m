Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101207150608.GA1867@vigoh>
References: <AANLkTinu7oKUD5FmGyJ2x+ZYqRmOyFijuZgWtgjg=tk=@mail.gmail.com>
	<20101207150608.GA1867@vigoh>
Date: Wed, 8 Dec 2010 13:46:34 +0800
Message-ID: <AANLkTinN3R4q-YA=4jweveB4LfE9S2SwhCK2xXYORw6W@mail.gmail.com>
Subject: Re: [PATCH 1/1] bluetooth: add NULL pointer check in hci
From: Jun Nie <niej0001@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Brian Gix <bgix@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=00221532c430dd8bf30496dfa426
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--00221532c430dd8bf30496dfa426
Content-Type: text/plain; charset=ISO-8859-1

2010/12/7 Gustavo F. Padovan <padovan@profusion.mobi>:
> Hi Jun,
>
> * Jun Nie <niej0001@gmail.com> [2010-12-07 15:01:21 +0800]:
>
>> Resend it to fix checkpatch.pl warning.
>
>> From 75dc111b5d9f62619bbeec803b15e84412ae050e Mon Sep 17 00:00:00 2001
>> From: Jun Nie <njun@marvell.com>
>> Date: Tue, 7 Dec 2010 14:03:38 +0800
>> Subject: [PATCH] bluetooth: add NULL pointer check in hci
>
> Clearly a bug fix, but can you add a commit message to your patch. Thanks.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>

Add commit message for understanding in a glance.

Jun

--00221532c430dd8bf30496dfa426
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Disposition: attachment;
	filename="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghfshqhe0

RnJvbSBlNzI5ZWRhM2IyY2ZhZTUwMWM3MDRlMmViMzllMDdhYTFiODYwN2YwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDcgRGVjIDIwMTAgMTQ6MDM6MzggKzA4MDAKU3ViamVjdDogW1BBVENIXSBibHVldG9vdGg6IGFk
ZCBOVUxMIHBvaW50ZXIgY2hlY2sgaW4gaGNpCgpJZiB3ZSBmYWlsIHRvIGZpbmQgYSBoY2kgZGV2
aWNlIHBvaW50ZXIgaW4gaGNpX3VhcnQsIGRvbid0IHRyeQp0byBkZXJlZiB0aGUgTlVMTCBvbmUg
d2UgZG8gaGF2ZS4KClNpZ25lZC1vZmYtYnk6IEp1biBOaWUgPG5qdW5AbWFydmVsbC5jb20+Ci0t
LQogZHJpdmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMgfCAgICA2ICsrKystLQogMSBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGRpc2Mu
YwppbmRleCA3MjAxNDgyLi4zYzZjYWJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2JsdWV0b290aC9o
Y2lfbGRpc2MuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGRpc2MuYwpAQCAtMzExLDgg
KzMxMSwxMCBAQCBzdGF0aWMgdm9pZCBoY2lfdWFydF90dHlfY2xvc2Uoc3RydWN0IHR0eV9zdHJ1
Y3QgKnR0eSkKIAogCQlpZiAodGVzdF9hbmRfY2xlYXJfYml0KEhDSV9VQVJUX1BST1RPX1NFVCwg
Jmh1LT5mbGFncykpIHsKIAkJCWh1LT5wcm90by0+Y2xvc2UoaHUpOwotCQkJaGNpX3VucmVnaXN0
ZXJfZGV2KGhkZXYpOwotCQkJaGNpX2ZyZWVfZGV2KGhkZXYpOworCQkJaWYgKGhkZXYpIHsKKwkJ
CQloY2lfdW5yZWdpc3Rlcl9kZXYoaGRldik7CisJCQkJaGNpX2ZyZWVfZGV2KGhkZXYpOworCQkJ
fQogCQl9CiAJfQogfQotLSAKMS43LjAuNAoK
--00221532c430dd8bf30496dfa426--

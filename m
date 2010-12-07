Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 7 Dec 2010 15:01:21 +0800
Message-ID: <AANLkTinu7oKUD5FmGyJ2x+ZYqRmOyFijuZgWtgjg=tk=@mail.gmail.com>
Subject: [PATCH 1/1] bluetooth: add NULL pointer check in hci
From: Jun Nie <niej0001@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=002215048ad374fd560496cc92a9
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--002215048ad374fd560496cc92a9
Content-Type: text/plain; charset=ISO-8859-1

Resend it to fix checkpatch.pl warning.

--002215048ad374fd560496cc92a9
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Disposition: attachment;
	filename="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghefrqu21

RnJvbSA3NWRjMTExYjVkOWY2MjYxOWJiZWVjODAzYjE1ZTg0NDEyYWUwNTBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDcgRGVjIDIwMTAgMTQ6MDM6MzggKzA4MDAKU3ViamVjdDogW1BBVENIXSBibHVldG9vdGg6IGFk
ZCBOVUxMIHBvaW50ZXIgY2hlY2sgaW4gaGNpCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTmllIDxuanVu
QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIHwgICAgNiAr
KysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvaGNpX2xkaXNjLmMKaW5kZXggNzIwMTQ4Mi4uM2M2Y2FiYyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMKKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xk
aXNjLmMKQEAgLTMxMSw4ICszMTEsMTAgQEAgc3RhdGljIHZvaWQgaGNpX3VhcnRfdHR5X2Nsb3Nl
KHN0cnVjdCB0dHlfc3RydWN0ICp0dHkpCiAKIAkJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChIQ0lf
VUFSVF9QUk9UT19TRVQsICZodS0+ZmxhZ3MpKSB7CiAJCQlodS0+cHJvdG8tPmNsb3NlKGh1KTsK
LQkJCWhjaV91bnJlZ2lzdGVyX2RldihoZGV2KTsKLQkJCWhjaV9mcmVlX2RldihoZGV2KTsKKwkJ
CWlmIChoZGV2KSB7CisJCQkJaGNpX3VucmVnaXN0ZXJfZGV2KGhkZXYpOworCQkJCWhjaV9mcmVl
X2RldihoZGV2KTsKKwkJCX0KIAkJfQogCX0KIH0KLS0gCjEuNy4wLjQKCg==
--002215048ad374fd560496cc92a9--

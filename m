Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 7 Dec 2010 14:16:06 +0800
Message-ID: <AANLkTi=6FdPs6VfUFhoYEEQ7rw9c5nrcVWJTnzc7cK_X@mail.gmail.com>
Subject: add NULL pointer check in hci
From: Jun Nie <niej0001@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=00221532c430a9dec90496cbf00c
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--00221532c430a9dec90496cbf00c
Content-Type: text/plain; charset=ISO-8859-1

>From 6e396f74efeb13e468804c19249424cb3a5f93d8 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 7 Dec 2010 14:03:38 +0800
Subject: [PATCH] bluetooth: add NULL pointer check in hci

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/bluetooth/hci_ldisc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 7201482..b58936c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -311,8 +311,10 @@ static void hci_uart_tty_close(struct tty_struct *tty)

 		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			hu->proto->close(hu);
-			hci_unregister_dev(hdev);
-			hci_free_dev(hdev);
+			if(hdev) {
+				hci_unregister_dev(hdev);
+				hci_free_dev(hdev);
+			}
 		}
 	}
 }
-- 
1.7.0.4

--00221532c430a9dec90496cbf00c
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Disposition: attachment;
	filename="0001-bluetooth-add-NULL-pointer-check-in-hci.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghee5dw20

RnJvbSA2ZTM5NmY3NGVmZWIxM2U0Njg4MDRjMTkyNDk0MjRjYjNhNWY5M2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDcgRGVjIDIwMTAgMTQ6MDM6MzggKzA4MDAKU3ViamVjdDogW1BBVENIXSBibHVldG9vdGg6IGFk
ZCBOVUxMIHBvaW50ZXIgY2hlY2sgaW4gaGNpCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTmllIDxuanVu
QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIHwgICAgNiAr
KysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvaGNpX2xkaXNjLmMKaW5kZXggNzIwMTQ4Mi4uYjU4OTM2YyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMKKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xk
aXNjLmMKQEAgLTMxMSw4ICszMTEsMTAgQEAgc3RhdGljIHZvaWQgaGNpX3VhcnRfdHR5X2Nsb3Nl
KHN0cnVjdCB0dHlfc3RydWN0ICp0dHkpCiAKIAkJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChIQ0lf
VUFSVF9QUk9UT19TRVQsICZodS0+ZmxhZ3MpKSB7CiAJCQlodS0+cHJvdG8tPmNsb3NlKGh1KTsK
LQkJCWhjaV91bnJlZ2lzdGVyX2RldihoZGV2KTsKLQkJCWhjaV9mcmVlX2RldihoZGV2KTsKKwkJ
CWlmKGhkZXYpIHsKKwkJCQloY2lfdW5yZWdpc3Rlcl9kZXYoaGRldik7CisJCQkJaGNpX2ZyZWVf
ZGV2KGhkZXYpOworCQkJfQogCQl9CiAJfQogfQotLSAKMS43LjAuNAoK
--00221532c430a9dec90496cbf00c--

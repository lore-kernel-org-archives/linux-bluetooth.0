Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6F2A12.8020201@gmail.com>
Date: Tue, 28 Jul 2009 18:40:50 +0200
From: Karl Beldan <karl.beldan@gmail.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix typo in stats for hci_uart
Content-Type: multipart/mixed;
 boundary="------------000206040907040503070603"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000206040907040503070603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

s/stat.cmd_tx++/stat.sco_tx++ for HCI_SCODATA_PKT

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 drivers/bluetooth/hci_ldisc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 4895f0e..a08b207 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -101,7 +101,7 @@ static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
 		break;
 
 	case HCI_SCODATA_PKT:
-		hdev->stat.cmd_tx++;
+		hdev->stat.sco_tx++;
 		break;
 	}
 }
-- 
1.6.3.2.306.g4f4fa


--------------000206040907040503070603
Content-Type: text/plain;
 name="0001-Bluetooth-Fix-typo-in-stats-for-hci_uart.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0001-Bluetooth-Fix-typo-in-stats-for-hci_uart.patch"

RnJvbSAyYjc4OWFhOTgzZDVlMjcwMTFjNWZkMmFlNDQ0YjQ5NWFkOWE5YjgxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLYXJsIEJlbGRhbiA8a2FybC5iZWxkYW5AZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDI4IEp1bCAyMDA5IDE4OjAzOjEyICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gQmx1ZXRvb3RoOiBGaXggdHlwbyBpbiBzdGF0cyBmb3IgaGNpX3VhcnQKCnMvc3Rh
dC5jbWRfdHgrKy9zdGF0LnNjb190eCsrIGZvciBIQ0lfU0NPREFUQV9QS1QKClNpZ25lZC1v
ZmYtYnk6IEthcmwgQmVsZGFuIDxrYXJsLmJlbGRhbkBtb2JpbGUtZGV2aWNlcy5mcj4KLS0t
CiBkcml2ZXJzL2JsdWV0b290aC9oY2lfbGRpc2MuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xk
aXNjLmMKaW5kZXggNDg5NWYwZS4uYTA4YjIwNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibHVl
dG9vdGgvaGNpX2xkaXNjLmMKKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMK
QEAgLTEwMSw3ICsxMDEsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaGNpX3VhcnRfdHhfY29t
cGxldGUoc3RydWN0IGhjaV91YXJ0ICpodSwgaW50IHBrdF90eXBlKQogCQlicmVhazsKIAog
CWNhc2UgSENJX1NDT0RBVEFfUEtUOgotCQloZGV2LT5zdGF0LmNtZF90eCsrOworCQloZGV2
LT5zdGF0LnNjb190eCsrOwogCQlicmVhazsKIAl9CiB9Ci0tIAoxLjYuMy4yLjMwNi5nNGY0
ZmEKCg==
--------------000206040907040503070603--

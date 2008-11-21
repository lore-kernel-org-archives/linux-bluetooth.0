Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 20 Nov 2008 18:24:00 -0800
Message-ID: <35c90d960811201824o64e0d814s8cf55ba6ee145517@mail.gmail.com>
Subject: patch: Respect HCI_UART_DEBUG config in hci_ll.c
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0cd50a54f1d55f045c29bccf
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd50a54f1d55f045c29bccf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Author: Nick Pelly <npelly@google.com>
Date:   Mon Apr 21 12:18:51 2008 -0700

    bluetooth: Respect HCI_UART_DEBUG config in hci_ll.c

    Following the pattern from hci_*.c, turn off BT_DBG messages unless
    they have been requested via HCI_UART_DEBUG

    Signed-off-by: Brian Swetland <swetland@google.com>

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index b91d45a..2d2f66e 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -51,6 +51,11 @@

 #include "hci_uart.h"

+#ifndef CONFIG_BT_HCIUART_DEBUG
+#undef  BT_DBG
+#define BT_DBG( A... )
+#endif
+
 /* HCILL commands */
 #define HCILL_GO_TO_SLEEP_IND  0x30
 #define HCILL_GO_TO_SLEEP_ACK  0x31

--000e0cd50a54f1d55f045c29bccf
Content-Type: text/plain; charset=US-ASCII; name="fix_hcill_debug.txt"
Content-Disposition: attachment; filename="fix_hcill_debug.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fns7dt0t0

Y29tbWl0IDRjNzAxODFiNzQ5MjI1NTM0ZWFhY2E2YjU3YWM0OGJlNjM5MWMyYjkKQXV0aG9yOiBO
aWNrIFBlbGx5IDxucGVsbHlAZ29vZ2xlLmNvbT4KRGF0ZTogICBNb24gQXByIDIxIDEyOjE4OjUx
IDIwMDggLTA3MDAKCiAgICBibHVldG9vdGg6IFJlc3BlY3QgSENJX1VBUlRfREVCVUcgY29uZmln
IGluIGhjaV9sbC5jCiAgICAKICAgIEZvbGxvd2luZyB0aGUgcGF0dGVybiBmcm9tIGhjaV8qLmMs
IHR1cm4gb2ZmIEJUX0RCRyBtZXNzYWdlcyB1bmxlc3MKICAgIHRoZXkgaGF2ZSBiZWVuIHJlcXVl
c3RlZCB2aWEgSENJX1VBUlRfREVCVUcKICAgIAogICAgU2lnbmVkLW9mZi1ieTogQnJpYW4gU3dl
dGxhbmQgPHN3ZXRsYW5kQGdvb2dsZS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9v
dGgvaGNpX2xsLmMgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGwuYwppbmRleCBiOTFkNDVhLi4y
ZDJmNjZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGwuYworKysgYi9kcml2
ZXJzL2JsdWV0b290aC9oY2lfbGwuYwpAQCAtNTEsNiArNTEsMTEgQEAKIAogI2luY2x1ZGUgImhj
aV91YXJ0LmgiCiAKKyNpZm5kZWYgQ09ORklHX0JUX0hDSVVBUlRfREVCVUcKKyN1bmRlZiAgQlRf
REJHCisjZGVmaW5lIEJUX0RCRyggQS4uLiApCisjZW5kaWYKKwogLyogSENJTEwgY29tbWFuZHMg
Ki8KICNkZWZpbmUgSENJTExfR09fVE9fU0xFRVBfSU5ECTB4MzAKICNkZWZpbmUgSENJTExfR09f
VE9fU0xFRVBfQUNLCTB4MzEK
--000e0cd50a54f1d55f045c29bccf--

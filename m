Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 5/8] unit/gatt: minor fix for test PDUs
Date: Tue,  9 Dec 2014 15:08:37 -0800
Message-Id: <1418166520-32993-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 505e41e..5f5ad1b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1136,12 +1136,12 @@ int main(int argc, char *argv[])
 	define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uuid_128,
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
-			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
 					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
 					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
 					0x18, 0x00, 0x00),
 			raw_pdu(0x07, 0x10, 0x00, 0x17, 0x00),
-			raw_pdu(06, 0x18, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
+			raw_pdu(0x06, 0x18, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
 					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
 					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
 					0x18, 0x00, 0x00),
-- 
2.2.0.rc0.207.ga3a616c


Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 8/8] unit/gatt: minor consistency in test data
Date: Tue, 10 Feb 2015 12:16:24 -0800
Message-Id: <1423599385-36295-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add 0x for consistency
---
 unit/test-gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 94e7e35..a4cd5e1 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1894,7 +1894,7 @@ int main(int argc, char *argv[])
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
-			raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
+			raw_pdu(0x09, 0x07, 0x11, 0x00, 0x02, 0x12, 0x00, 0x25,
 					0x2a),
 			raw_pdu(0x08, 0x12, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x09, 0x15, 0x13, 0x00, 0x02, 0x14, 0x00, 0x85,
@@ -1947,7 +1947,7 @@ int main(int argc, char *argv[])
 			NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
-			raw_pdu(0x09, 0x07, 0x11, 0x00, 02, 0x12, 0x00, 0x25,
+			raw_pdu(0x09, 0x07, 0x11, 0x00, 0x02, 0x12, 0x00, 0x25,
 					0x2a),
 			raw_pdu(0x08, 0x12, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x09, 0x15, 0x13, 0x00, 0x02, 0x14, 0x00, 0x85,
-- 
2.2.0.rc0.207.ga3a616c


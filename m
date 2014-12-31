Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 11/14] unit/gatt: Add clarifying note about dup tests.
Date: Tue, 30 Dec 2014 16:32:29 -0800
Message-Id: <1419985952-18334-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BV-05-C tests are identical to the BV-04-C tests, so add a note
explaining as such.
---
 unit/test-gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 24f5695..9981afe 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1664,6 +1664,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x29, 0x00, 0x29, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x29, 0x00, 0x0a));
 
+	/*
+	 * Note: /TP/GAD/CL/BV-05-C and /TP/GAD/SV/BV-05-C are identical to
+	 * /TP/GAD/CL/BV-04-C and /TP/GAD/SV/BV-04-C for BlueZ
+	 */
+
 	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL, NULL,
 			MTU_EXCHANGE_CLIENT_PDUS,
 			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
-- 
2.2.0.rc0.207.ga3a616c


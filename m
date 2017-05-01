Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] unit/test-gatt: Add test for unknown request
Date: Mon,  1 May 2017 18:56:59 +0300
Message-Id: <20170501155700.23761-2-luiz.dentz@gmail.com>
In-Reply-To: <20170501155700.23761-1-luiz.dentz@gmail.com>
References: <20170501155700.23761-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This send an unknown request (0xbf) to test if a response is sent since
the spec mandates the server to always respond to all requests it
receives:

BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part F page 2173

  'A client may send attribute protocol requests to a server, and the
  server shall respond to all requests that it receives.'
---
 unit/test-gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c7a8fa5..371cb46 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -4461,5 +4461,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x01),
 			raw_pdu(0x01, 0x18, 0x25, 0x00, 0x06));
 
+	define_test_server("/robustness/unkown-request",
+			test_server, service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0xbf, 0x00),
+			raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
+
 	return tester_run();
 }
-- 
2.9.3


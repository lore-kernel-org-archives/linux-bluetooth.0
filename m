Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/9] unit/avrcp: Add /TP/CFG/BI-01-C test
Date: Fri, 28 Feb 2014 10:22:52 +0200
Message-Id: <1393575778-28681-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies the get capabilities response issued from the Target when
an invalid capability is requested (0x7f).
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a43985a..0924a7e 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -311,6 +311,8 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 {
 	uint32_t id = 0x001958;
 
+	DBG("params[0] %d params_len %d", params[0], *params_len);
+
 	if (*params_len != 1)
 		goto fail;
 
@@ -441,5 +443,14 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
 				0x05, 0x02, 0x01, 0x00, 0x19, 0x58));
 
+	define_test("/TP/CFG/BI-01-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
+				0x01, 0x7f),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58, 0x10,
+				0x00, 0x00, 0x01,
+				AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2


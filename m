Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/35] unit/test-avrcp: Add /TP/INV/BI-02-C test
Date: Fri, 25 Apr 2014 11:38:41 +0300
Message-Id: <1398415152-22950-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the General Reject Response issued by the TG.
---
 unit/test-avrcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ad76e5c..a483f0e 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1166,6 +1166,12 @@ int main(int argc, char *argv[])
 				0xff, 0x00, 0x00, 0x01,
 				AVRCP_STATUS_INVALID_COMMAND));
 
+	/* Invalid PDU ID - Browsing TG */
+	define_test("/TP/INV/BI-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, 0xff, 0x00, 0x00),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GENERAL_REJECT,
+				0x00, 0x01, AVRCP_STATUS_INVALID_COMMAND));
+
 	/* Next Group command transfer - CT */
 	define_test("/TP/BGN/BV-01-I", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
-- 
1.9.0


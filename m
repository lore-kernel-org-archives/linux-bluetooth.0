Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] unit/avrcp: Add /TP/MDI/BV-05-C test
Date: Thu,  6 Mar 2014 16:43:03 +0200
Message-Id: <1394116985-28247-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that Target responds to Get element attributes cmd.
---
 unit/test-avrcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 45ac798..2df3d6c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -482,11 +482,14 @@ static ssize_t avrcp_handle_get_element_attrs(struct avrcp *session,
 						uint8_t *params,
 						void *user_data)
 {
-	DBG("");
+	DBG("params_len %d params[8] %d", params_len, params[8]);
 
 	if (params_len < 9)
 		return -EINVAL;
 
+	if (params_len != 9 + params[8] * 4)
+		return -EINVAL;
+
 	avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
 
 	return -EAGAIN;
@@ -850,5 +853,17 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
 				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
 				0x00, 0x00, 0x00));
+
+	/* Get element attributes - TG */
+	define_test("/TP/MDI/BV-05-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x0d, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+				0x00, 0x00, 0x00, 0x01),
+			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_GET_ELEMENT_ATTRIBUTES,
+				0x00, 0x00, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2


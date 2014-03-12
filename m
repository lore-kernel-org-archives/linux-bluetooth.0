Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 2/9] android/avrcp: Add avrcp_send_passthrough function
Date: Wed, 12 Mar 2014 16:40:25 +0200
Message-Id: <1394635232-23774-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZL5hjJzaxsnXtrHTzJSHSKYjemUnUr=YRE4Zq9qCmoj0g@mail.gmail.com>
 <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This function allows to send AVRCP vendor unique commands.
---
 android/avrcp-lib.c | 11 +++++++++++
 android/avrcp-lib.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5400f80..f719a00 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -471,3 +471,14 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 				AVC_SUBUNIT_PANEL, AVRCP_REGISTER_NOTIFICATION,
 				params, params_len);
 }
+
+int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
+{
+	uint8_t params[5];
+
+	hton24(params, vendor);
+	bt_put_be16(op, &params[3]);
+
+	return avctp_send_passthrough(session->conn, AVC_VENDOR_UNIQUE, params,
+								sizeof(params));
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 91a7d47..cc6c2ee 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -164,3 +164,4 @@ int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t code, uint8_t *params,
 					size_t params_len);
+int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.8.3.2


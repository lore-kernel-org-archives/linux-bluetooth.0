Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 5/6] obexd/messages: Add prototypes for MASInstance response
Date: Tue, 07 Oct 2014 09:36:55 +0530
Message-id: <1412654816-14971-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/plugins/messages.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/obexd/plugins/messages.h b/obexd/plugins/messages.h
index 00a16b1..3aaeec1 100644
--- a/obexd/plugins/messages.h
+++ b/obexd/plugins/messages.h
@@ -307,3 +307,19 @@ int messages_set_delete(void *session, const char *handle, uint8_t value,
  * session: Backend session.
  */
 void messages_abort(void *session);
+
+
+
+/* Retrieves MAS Instance Information for the given mas-instance id.
+ *
+ * session: Backend session.
+ * mas_id: MAS Instance id requested by the MCE.
+ *
+ * Callback shall be called for every mas_instance_id request received from MCE.
+ */
+typedef void (*messages_mas_instance_info_cb)(void *session, int err,
+		uint16_t size, const char *name, void *user_data);
+
+int messages_get_mas_instance_info(void *session, uint16_t mas_instance_id,
+				messages_mas_instance_info_cb callback,
+				void *user_data);
-- 
1.9.1


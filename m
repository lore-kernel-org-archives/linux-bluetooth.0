Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 6/6] obexd/message-dummy: Add MAS Instance description to
 response
Date: Tue, 07 Oct 2014 09:36:56 +0530
Message-id: <1412654816-14971-7-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/plugins/messages-dummy.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index bb0627f..11da432 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -365,6 +365,24 @@ int messages_set_delete(void *session, const char *handle, uint8_t value,
 	return -ENOSYS;
 }
 
+
+int messages_get_mas_instance_info(void *s, uint16_t mas_instance_id,
+					messages_mas_instance_info_cb callback,
+					void *user_data)
+{
+	struct session *session =  s;
+
+/*
+ * The MAS Instance information is implementation specific.
+ */
+
+	char *info = "9876543210 : MAS INSTANCE INFO";
+
+	DBG("");
+	callback(session, 0, 0, info, user_data);
+
+	return 0;
+}
 void messages_abort(void *s)
 {
 	struct session *session = s;
-- 
1.9.1


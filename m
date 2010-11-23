Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/7] Add phonebook_req_cancel prototype
Date: Tue, 23 Nov 2010 20:11:24 +0200
Message-Id: <1290535889-17038-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_req_cancel function prototype to cancel pending request
to backend.
---
 plugins/phonebook.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index d7cfa46..7ae5ccc 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -107,3 +107,9 @@ int phonebook_get_entry(const char *folder, const char *id,
  */
 int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 			phonebook_cache_ready_cb ready_cb, void *user_data);
+
+/* 
+ * Function used to cancel pending request to backend and free resources
+ * allocated for phonebook request structure.
+ */
+void phonebook_req_cancel(void *request);
-- 
1.7.0.4


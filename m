Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/7] Add phonebook_req_cancel to tracker
Date: Tue, 23 Nov 2010 20:11:25 +0200
Message-Id: <1290535889-17038-4-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_req_cancel function to phonebook_tracker.c that cancels
pending request and deallocates memory of requst object.
---
 plugins/phonebook-tracker.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index afe0f2f..6ee5750 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1803,6 +1803,22 @@ done:
 	return path;
 }
 
+void phonebook_req_cancel(void *request)
+{
+	struct phonebook_req *req = request;
+
+	if (!req)
+		return;
+
+	if (req->call) {
+		dbus_pending_call_cancel(req->call);
+		dbus_pending_call_unref(req->call);
+	}
+
+	g_free(req);
+	req = NULL;
+}
+
 int phonebook_pull(const char *name, const struct apparam_field *params,
 					phonebook_cb cb, void *user_data)
 {
-- 
1.7.0.4


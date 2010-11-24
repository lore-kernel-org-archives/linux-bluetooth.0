Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/6] Add phonebook_req_cancel to tracker
Date: Wed, 24 Nov 2010 17:07:12 +0200
Message-Id: <1290611236-25656-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_req_cancel function to phonebook_tracker.c that cancels
pending request.
---
 plugins/phonebook-tracker.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 20053f6..5fd0074 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1799,6 +1799,17 @@ done:
 	return path;
 }
 
+void phonebook_req_cancel(void *request)
+{
+	struct DBusPendingCall *call = request;
+
+	if (!call)
+		return;
+
+	dbus_pending_call_cancel(call);
+	dbus_pending_call_unref(call);
+}
+
 int phonebook_pull(const char *name, const struct apparam_field *params,
 					phonebook_cb cb, void *user_data)
 {
-- 
1.7.0.4


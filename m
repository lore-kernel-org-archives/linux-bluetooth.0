Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/7] Add phonebook request
Date: Tue, 23 Nov 2010 20:11:23 +0200
Message-Id: <1290535889-17038-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290535889-17038-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook request structure to phonebook-tracker and pointer to
pending call in PBAP object.
---
 plugins/pbap.c              |    1 +
 plugins/phonebook-tracker.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 1a7d001..3264e85 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -147,6 +147,7 @@ struct pbap_session {
 struct pbap_object {
 	GString *buffer;
 	struct pbap_session *session;
+	void *request;
 };
 
 static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 20053f6..afe0f2f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1035,6 +1035,10 @@ struct phonebook_index {
 	int index;
 };
 
+struct phonebook_req {
+	DBusPendingCall *call;
+};
+
 static DBusConnection *connection = NULL;
 
 static const char *name2query(const char *name)
-- 
1.7.0.4


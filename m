Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Move find_session in adapter.c
Date: Mon, 28 Feb 2011 13:34:24 +0200
Message-Id: <1298892865-14930-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1298892865-14930-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1298892865-14930-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

find_session is moved to be before set_mode, to avoid declaration
of prototype. It is used in the subsequent patch.
---
 src/adapter.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2e11832..49a23ec 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -452,6 +452,20 @@ static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
 	return 0;
 }
 
+static struct session_req *find_session(GSList *list, const char *sender)
+{
+	GSList *l;
+
+	for (l = list; l; l = l->next) {
+		struct session_req *req = l->data;
+
+		if (g_str_equal(req->owner, sender))
+			return req;
+	}
+
+	return NULL;
+}
+
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 			DBusMessage *msg)
 {
@@ -620,20 +634,6 @@ static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 						adapter);
 }
 
-static struct session_req *find_session(GSList *list, const char *sender)
-{
-	GSList *l;
-
-	for (l = list; l; l = l->next) {
-		struct session_req *req = l->data;
-
-		if (g_str_equal(req->owner, sender))
-			return req;
-	}
-
-	return NULL;
-}
-
 static uint8_t get_needed_mode(struct btd_adapter *adapter, uint8_t mode)
 {
 	GSList *l;
-- 
1.7.1


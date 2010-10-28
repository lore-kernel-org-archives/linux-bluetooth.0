Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Fix not being able to set discoverable when discoverable timeout is set
Date: Thu, 28 Oct 2010 11:00:59 +0300
Message-Id: <1288252859-10337-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Since setting Discoverable property now has the ability to turn on the
adapter if off we should no longer ignore discoverable mode if a timeout
is set.
---
 src/adapter.c |   51 +++++++++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b5e73b7..19fe5a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -529,6 +529,32 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 	return session_ref(req);
 }
 
+static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
+{
+	int err;
+
+	if (mode == MODE_CONNECTABLE)
+		err = adapter_ops->set_connectable(adapter->dev_id);
+	else
+		err = adapter_ops->set_discoverable(adapter->dev_id);
+
+	if (err < 0)
+		return err;
+
+	if (mode == MODE_CONNECTABLE)
+		return 0;
+
+	adapter_remove_discov_timeout(adapter);
+
+	if (adapter->discov_timeout)
+		adapter_set_discov_timeout(adapter, adapter->discov_timeout);
+
+	if (mode != MODE_LIMITED && adapter->mode == MODE_LIMITED)
+		adapter_set_limited_discoverable(adapter, FALSE);
+
+	return 0;
+}
+
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 			DBusMessage *msg)
 {
@@ -559,25 +585,11 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 	if (new_mode == adapter->mode)
 		return 0;
 
-	if (new_mode == MODE_CONNECTABLE)
-		err = adapter_ops->set_connectable(adapter->dev_id);
-	else
-		err = adapter_ops->set_discoverable(adapter->dev_id);
+	err = adapter_set_mode(adapter, new_mode);
 
 	if (err < 0)
 		return err;
 
-	if (new_mode > MODE_CONNECTABLE) {
-		adapter_remove_discov_timeout(adapter);
-
-		if (adapter->discov_timeout)
-			adapter_set_discov_timeout(adapter,
-						adapter->discov_timeout);
-
-		if (new_mode != MODE_LIMITED && adapter->mode == MODE_LIMITED)
-			adapter_set_limited_discoverable(adapter, FALSE);
-	}
-
 done:
 	modestr = mode2str(new_mode);
 	write_device_mode(&adapter->bdaddr, modestr);
@@ -2429,18 +2441,13 @@ static int adapter_up(struct btd_adapter *adapter, const char *mode)
 		write_device_mode(&adapter->bdaddr, onmode);
 
 		return adapter_up(adapter, onmode);
-	} else if (!g_str_equal(mode, "connectable") &&
-			adapter->discov_timeout == 0) {
-		/* Set discoverable only if timeout is 0 */
+	} else if (!g_str_equal(mode, "connectable")) {
 		adapter->mode = MODE_DISCOVERABLE;
 		scan_mode = SCAN_PAGE | SCAN_INQUIRY;
 	}
 
 proceed:
-	if (scan_mode == SCAN_PAGE)
-		err = adapter_ops->set_connectable(adapter->dev_id);
-	else
-		err = adapter_ops->set_discoverable(adapter->dev_id);
+	err = adapter_set_mode(adapter, adapter->mode);
 
 	if (err < 0)
 		return err;
-- 
1.7.1


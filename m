Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 02/14] mgmt: print error message when start_discovery fails
Date: Fri, 27 Jul 2012 19:29:46 -0300
Message-Id: <1343428198-23621-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we fail to communicate with the MGMT socket is better to print the
error message on the mgmtops plugin, where it really happened, instead
of leaving this job to its users.
---
 src/adapter.c |    6 +-----
 src/mgmt.c    |    7 +++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c9c82e3..5dd9821 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -997,13 +997,9 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 static gboolean discovery_cb(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	int err;
 
 	adapter->discov_id = 0;
-
-	err = mgmt_start_discovery(adapter->dev_id);
-	if (err < 0)
-		error("start_discovery: %s (%d)", strerror(-err), -err);
+	mgmt_start_discovery(adapter->dev_id);
 
 	return FALSE;
 }
diff --git a/src/mgmt.c b/src/mgmt.c
index c55b1a8..d73cf2a 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1961,8 +1961,11 @@ int mgmt_start_discovery(int index)
 
 	cp->type = info->discov_type;
 
-	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
-		return -errno;
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0) {
+		int err = -errno;
+		error("failed to write to MGMT socket: %s", strerror(err));
+		return err;
+	}
 
 	return 0;
 }
-- 
1.7.10.4


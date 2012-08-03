Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] mgmt: print error message when start_discovery fails
Date: Fri,  3 Aug 2012 11:42:34 -0300
Message-Id: <1344004954-2762-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <CAJdJm_N6R5C_EPpK985mYajc7i+R=5T44AvTF_C7-5giR1Z8XQ@mail.gmail.com>
References: <CAJdJm_N6R5C_EPpK985mYajc7i+R=5T44AvTF_C7-5giR1Z8XQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we fail to communicate with the MGMT socket is better to print the
error message on the mgmtops plugin, where it really happened, instead
of leaving this job to its users.
---
 src/adapter.c | 6 +-----
 src/mgmt.c    | 7 +++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9e69b50..fa06cd2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1002,13 +1002,9 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
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
index c893972..8ae86d3 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1990,8 +1990,11 @@ int mgmt_start_discovery(int index)
 
 	cp->type = info->discov_type;
 
-	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
-		return -errno;
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0) {
+		int err = -errno;
+		error("failed to write to MGMT socket: %s", strerror(-err));
+		return err;
+	}
 
 	return 0;
 }
-- 
1.7.11.2


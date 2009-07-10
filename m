Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/2] Adding read_name to hciops plugin.
Date: Fri, 10 Jul 2009 15:16:01 +0530
Message-Id: <1247219161-7917-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1247219161-7917-1-git-send-email-alok.barsode@azingo.com>
References: <1247219161-7917-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   18 ++++++++++++++++++
 src/adapter.c    |   13 +++----------
 src/adapter.h    |    1 +
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 7f63a49..4df799b 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -704,6 +704,23 @@ static int hciops_set_name(int index, const char *name)
 	return err;
 }
 
+static int hciops_read_name(int index)
+{
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_NAME, 0, 0);
+	if (err < 0)
+		err = -errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 {
 	remote_name_req_cancel_cp cp;
@@ -740,6 +757,7 @@ static struct btd_adapter_ops hci_ops = {
 	.resolve_name = hciops_resolve_name,
 	.cancel_resolve_name = hciops_cancel_resolve_name,
 	.set_name = hciops_set_name,
+	.read_name = hciops_read_name,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 4b94ed8..06640e7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -877,7 +877,7 @@ void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr)
 void adapter_setname_complete(bdaddr_t *local, uint8_t status)
 {
 	struct btd_adapter *adapter;
-	int dd, err;
+	int err;
 
 	if (status)
 		return;
@@ -888,18 +888,11 @@ void adapter_setname_complete(bdaddr_t *local, uint8_t status)
 		return;
 	}
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0) {
-		error("HCI device open failed: hci%d", adapter->dev_id);
-		return;
-	}
-
-	err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_NAME, 0, 0);
+	err = adapter_ops->read_name(adapter->dev_id);
 	if (err < 0)
 		error("Sending getting name command failed: %s (%d)",
 						strerror(errno), errno);
 
-	hci_close_dev(dd);
 }
 
 static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
@@ -2132,7 +2125,7 @@ int adapter_start(struct btd_adapter *adapter)
 		return err;
 	}
 
-	hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_NAME, 0, 0);
+	adapter_ops->read_name(adapter->dev_id);
 
 	if (!(features[6] & LMP_SIMPLE_PAIR))
 		goto setup;
diff --git a/src/adapter.h b/src/adapter.h
index 9845ac7..d34fb80 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -174,6 +174,7 @@ struct btd_adapter_ops {
 	int (*resolve_name) (int index, bdaddr_t *bdaddr);
 	int (*cancel_resolve_name) (int index, bdaddr_t *bdaddr);
 	int (*set_name) (int index, const char *name);
+	int (*read_name) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3


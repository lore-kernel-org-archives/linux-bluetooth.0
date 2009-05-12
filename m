Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/7] Adding set_powered method to hciops plugin.
Date: Tue, 12 May 2009 17:56:51 +0530
Message-Id: <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   20 ++++++++++++++++++++
 src/adapter.c    |   12 ++----------
 src/adapter.h    |    1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2e91129..c0368d0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -462,11 +462,31 @@ done:
 	return err;
 }
 
+static int hciops_powered(int index, gboolean powered)
+{
+	int dd;
+
+	if (powered)
+		return hciops_start(index);
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
+					1, SCAN_DISABLED);
+
+	hci_close_dev(dd);
+
+	return hciops_stop(index);
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
 	.start = hciops_start,
 	.stop = hciops_stop,
+	.set_powered = hciops_powered,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 2efdbc8..caf82b1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -406,21 +406,13 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 	scan_enable = mode2scan(new_mode);
 
 	if (!adapter->up && scan_enable != SCAN_DISABLED) {
-		err = adapter_ops->start(adapter->dev_id);
+		err = adapter_ops->set_powered(adapter->dev_id, TRUE);
 		if (err < 0)
 			return err;
 	}
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return -EIO;
-
 	if (adapter->up && scan_enable == SCAN_DISABLED) {
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
-					1, &scan_enable);
-		hci_close_dev(dd);
-
-		err = adapter_ops->stop(adapter->dev_id);
+		err = adapter_ops->set_powered(adapter->dev_id, FALSE);
 		if (err < 0)
 			return err;
 
diff --git a/src/adapter.h b/src/adapter.h
index 97e9888..5c292fb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -152,6 +152,7 @@ struct btd_adapter_ops {
 	void (*cleanup) (void);
 	int (*start) (int index);
 	int (*stop) (int index);
+	int (*set_powered) (int index, gboolean powered);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.5.6.3

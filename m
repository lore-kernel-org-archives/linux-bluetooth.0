Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix stopping inquiry before adapter object is initialized
Date: Tue,  1 Feb 2011 17:47:28 +0200
Message-Id: <1296575248-20185-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1296575248-20185-1-git-send-email-luiz.dentz@gmail.com>
References: <1296575248-20185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This can cause errors on command complete since the adapter object could
not be found to set its mode.
---
 plugins/hciops.c |   50 ++++++++++++++++++++++++++------------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 80ae61a..e5160ea 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -455,6 +455,29 @@ static void start_adapter(int index)
 	memset(dev->eir, 0, sizeof(dev->eir));
 }
 
+static int hciops_stop_inquiry(int index)
+{
+	struct dev_info *dev = &devs[index];
+	struct hci_dev_info di;
+	int err;
+
+	DBG("hci%d", index);
+
+	if (hci_devinfo(index, &di) < 0)
+		return -errno;
+
+	if (hci_test_bit(HCI_INQUIRY, &di.flags))
+		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
+						OCF_INQUIRY_CANCEL, 0, 0);
+	else
+		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
+					OCF_EXIT_PERIODIC_INQUIRY, 0, 0);
+	if (err < 0)
+		err = -errno;
+
+	return err;
+}
+
 static gboolean init_adapter(int index)
 {
 	struct dev_info *dev = &devs[index];
@@ -494,6 +517,9 @@ static gboolean init_adapter(int index)
 	hciops_set_discoverable(index, discoverable);
 	hciops_set_pairable(index, pairable);
 
+	if (dev->already_up)
+		hciops_stop_inquiry(index);
+
 done:
 	btd_adapter_unref(adapter);
 	return TRUE;
@@ -2600,29 +2626,6 @@ static void device_event(int event, int index)
 	}
 }
 
-static int hciops_stop_inquiry(int index)
-{
-	struct dev_info *dev = &devs[index];
-	struct hci_dev_info di;
-	int err;
-
-	DBG("hci%d", index);
-
-	if (hci_devinfo(index, &di) < 0)
-		return -errno;
-
-	if (hci_test_bit(HCI_INQUIRY, &di.flags))
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-						OCF_INQUIRY_CANCEL, 0, 0);
-	else
-		err = hci_send_cmd(dev->sk, OGF_LINK_CTL,
-					OCF_EXIT_PERIODIC_INQUIRY, 0, 0);
-	if (err < 0)
-		err = -errno;
-
-	return err;
-}
-
 static gboolean init_known_adapters(gpointer user_data)
 {
 	struct hci_dev_list_req *dl;
@@ -2666,7 +2669,6 @@ static gboolean init_known_adapters(gpointer user_data)
 			continue;
 
 		init_conn_list(dr->dev_id);
-		hciops_stop_inquiry(dr->dev_id);
 
 		dev->pending = 0;
 		hci_set_bit(PENDING_VERSION, &dev->pending);
-- 
1.7.1


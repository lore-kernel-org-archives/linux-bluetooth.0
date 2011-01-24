Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix initialization when adapter is already up
Date: Mon, 24 Jan 2011 11:13:07 +0200
Message-Id: <1295860387-10608-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When handling HCI_DEV_REG event it should not be necessary to generate a
HCI_DEV_UP since init_known_adapters already does it in case the adapter
is ulready up.
---
 plugins/hciops.c |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 7240d51..260ac7d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2253,25 +2253,6 @@ fail:
 	exit(1);
 }
 
-static void device_devreg_setup(int index)
-{
-	struct hci_dev_info di;
-
-	DBG("hci%d", index);
-
-	init_device(index);
-
-	memset(&di, 0, sizeof(di));
-
-	if (hci_devinfo(index, &di) < 0)
-		return;
-
-	if (ignore_device(&di))
-		return;
-
-	devs[index].already_up = hci_test_bit(HCI_UP, &di.flags);
-}
-
 static void init_conn_list(int index)
 {
 	struct dev_info *dev = &devs[index];
@@ -2318,11 +2299,7 @@ static void device_event(int event, int index)
 	switch (event) {
 	case HCI_DEV_REG:
 		info("HCI dev %d registered", index);
-		device_devreg_setup(index);
-		if (devs[index].already_up) {
-			init_conn_list(index);
-			device_event(HCI_DEV_UP, index);
-		}
+		init_device(index);
 		break;
 
 	case HCI_DEV_UNREG:
@@ -2418,6 +2395,7 @@ static gboolean init_known_adapters(gpointer user_data)
 		if (!dev->already_up)
 			continue;
 
+		init_conn_list(dr->dev_id);
 		hciops_stop_inquiry(dr->dev_id);
 
 		dev->pending = 0;
-- 
1.7.1


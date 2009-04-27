Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 3/8] Modifying device_devreg_setup. Check if device is up in device_devreg_setup instead of using devup parameter.
Date: Mon, 27 Apr 2009 19:45:40 +0530
Message-Id: <1240841745-11006-3-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/main.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index 02b4ebf..d12edc5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -477,9 +477,10 @@ fail:
 	exit(1);
 }
 
-static void device_devreg_setup(int dev_id, gboolean devup)
+static void device_devreg_setup(int dev_id)
 {
 	struct hci_dev_info di;
+	gboolean devup;
 
 	init_device(dev_id);
 
@@ -488,6 +489,8 @@ static void device_devreg_setup(int dev_id, gboolean devup)
 	if (hci_devinfo(dev_id, &di) < 0)
 		return;
 
+	devup = hci_test_bit(HCI_UP, &di.flags);
+
 	if (!hci_test_bit(HCI_RAW, &di.flags))
 		manager_register_adapter(dev_id, devup);
 }
@@ -528,10 +531,10 @@ static void init_all_devices(int ctl)
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		gboolean devup;
 
-		devup = hci_test_bit(HCI_UP, &dr->dev_opt);
-
 		info("HCI dev %d registered", dr->dev_id);
-		device_devreg_setup(dr->dev_id, devup);
+		device_devreg_setup(dr->dev_id);
+
+		devup = hci_test_bit(HCI_UP, &dr->dev_opt);
 		if (devup) {
 			info("HCI dev %d already up", dr->dev_id);
 			device_devup_setup(dr->dev_id);
@@ -561,7 +564,7 @@ void device_event(int event, int dev_id)
 	switch (event) {
 	case HCI_DEV_REG:
 		info("HCI dev %d registered", dev_id);
-		device_devreg_setup(dev_id, FALSE);
+		device_devreg_setup(dev_id);
 		break;
 
 	case HCI_DEV_UNREG:
-- 
1.5.6.3

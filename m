Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix minor coding style issue in hci_core.c
Date: Sat, 19 Oct 2013 10:19:15 -0700
Message-Id: <1382203155-27291-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few variable assignments ended up with missing a space between the
variable and equal sign.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c5fb3a3..6ccc4eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -423,7 +423,7 @@ static int idle_timeout_set(void *data, u64 val)
 		return -EINVAL;
 
 	hci_dev_lock(hdev);
-	hdev->idle_timeout= val;
+	hdev->idle_timeout = val;
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -451,7 +451,7 @@ static int sniff_min_interval_set(void *data, u64 val)
 		return -EINVAL;
 
 	hci_dev_lock(hdev);
-	hdev->sniff_min_interval= val;
+	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -479,7 +479,7 @@ static int sniff_max_interval_set(void *data, u64 val)
 		return -EINVAL;
 
 	hci_dev_lock(hdev);
-	hdev->sniff_max_interval= val;
+	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -588,7 +588,7 @@ static int conn_min_interval_set(void *data, u64 val)
 		return -EINVAL;
 
 	hci_dev_lock(hdev);
-	hdev->le_conn_min_interval= val;
+	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -616,7 +616,7 @@ static int conn_max_interval_set(void *data, u64 val)
 		return -EINVAL;
 
 	hci_dev_lock(hdev);
-	hdev->le_conn_max_interval= val;
+	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
 	return 0;
-- 
1.8.3.1


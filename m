Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 16/16] Bluetooth: hci_core: remove obsolete adv_instance
Date: Mon, 25 May 2015 00:39:14 +0200
Message-Id: <1432507154-22925-17-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that the obsolete adv_instance is no longer being referenced
anywhere in the code it can be removed without breaking the build.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 include/net/bluetooth/hci_core.h | 6 ------
 net/bluetooth/hci_core.c         | 1 -
 2 files changed, 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 36cc941..f8cf00f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -378,7 +378,6 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
-	struct adv_info		adv_instance;
 	struct list_head	adv_instances;
 	unsigned int		adv_instance_cnt;
 	__u8			cur_adv_instance;
@@ -569,11 +568,6 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.scan_duration = 0;
 }
 
-static inline void adv_info_init(struct hci_dev *hdev)
-{
-	memset(&hdev->adv_instance, 0, sizeof(struct adv_info));
-}
-
 bool hci_discovery_active(struct hci_dev *hdev);
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 01fc98e..8ed8184 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3186,7 +3186,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
-	adv_info_init(hdev);
 
 	return hdev;
 }
-- 
1.9.1


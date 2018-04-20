Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: btbcm: btbcm_initialize(): Initialize hw_name to "BCM"
Date: Fri, 20 Apr 2018 14:44:07 +0200
Message-Id: <20180420124407.19712-6-hdegoede@redhat.com>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
References: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Initialize hw_name to "BCM", this avoids the need for a number of NULL
checks on hw_name later.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d44aa6ff1ed5..99cde1f9467d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -350,7 +350,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
 		     bool reinit)
 {
 	u16 subver, rev, pid, vid;
-	const char *hw_name = NULL;
+	const char *hw_name = "BCM";
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
 	const struct bcm_subver_table *bcm_subver_table;
@@ -403,14 +403,13 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
 		kfree_skb(skb);
 
 		snprintf(fw_name, len, "brcm/%s-%4.4x-%4.4x.hcd",
-			 hw_name ? : "BCM", vid, pid);
+			 hw_name, vid, pid);
 	} else {
-		snprintf(fw_name, len, "brcm/%s.hcd",
-			 hw_name ? : "BCM");
+		snprintf(fw_name, len, "brcm/%s.hcd", hw_name);
 	}
 
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    hw_name ? : "BCM", (subver & 0xe000) >> 13,
+		    hw_name, (subver & 0xe000) >> 13,
 		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
 	return 0;
-- 
2.17.0

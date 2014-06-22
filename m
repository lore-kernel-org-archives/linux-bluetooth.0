Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/7] android/bluetooth: Pass device to send_bond_state_change function
Date: Sun, 22 Jun 2014 22:47:02 +0200
Message-Id: <1403470027-24720-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
References: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d42fe8c..4031b17 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -745,7 +745,7 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 	g_key_file_free(key_file);
 }
 
-static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
+static void send_bond_state_change(struct device *dev, uint8_t status,
 								uint8_t state)
 {
 	struct hal_ev_bond_state_changed ev;
@@ -861,7 +861,7 @@ static void update_device_state(struct device *dev, uint8_t addr_type,
 	new_bond = device_bond_state(dev);
 
 	if (old_bond != new_bond)
-		send_bond_state_change(&dev->bdaddr, status, new_bond);
+		send_bond_state_change(dev, status, new_bond);
 }
 
 static void send_device_property(struct device *dev, uint8_t type,
-- 
1.9.3


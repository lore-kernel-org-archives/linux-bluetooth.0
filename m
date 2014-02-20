Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add comment explainging store hint for long term keys
Date: Wed, 19 Feb 2014 17:11:58 -0800
Message-Id: <1392858718-40052-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code itself is not descriptive on what store hint is used for
long term keys and why. So add some extensive comment here. Similar
to what has already been done for identity resolving key store hint.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e8b9d2f261ee..5f5e388716ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4771,6 +4771,17 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
 
 	memset(&ev, 0, sizeof(ev));
 
+	/* Devices using resolvable or non-resolvable random addresses
+	 * without providing an indentity resolving key don't require
+	 * to store long term keys. Their addresses will change the
+	 * next time around.
+	 *
+	 * Only when a remote device provides an identity address
+	 * make sure the long term key is stored. If the remote
+	 * identity is known, the long term keys are internally
+	 * mapped to the identity address. So allow static random
+	 * and public addresses here.
+	 */
 	if (key->bdaddr_type == ADDR_LE_DEV_RANDOM &&
 	    (key->bdaddr.b[5] & 0xc0) != 0xc0)
 		ev.store_hint = 0x00;
-- 
1.8.5.3


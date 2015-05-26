Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: fix typos
Date: Tue, 26 May 2015 03:31:09 +0200
Message-Id: <1432603869-19491-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few comments had minor typos. These are being fixed.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fd87e7..a6f21f8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7577,7 +7577,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	memset(&ev, 0, sizeof(ev));
 
 	/* Devices using resolvable or non-resolvable random addresses
-	 * without providing an indentity resolving key don't require
+	 * without providing an identity resolving key don't require
 	 * to store long term keys. Their addresses will change the
 	 * next time around.
 	 *
@@ -7617,7 +7617,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
 	/* For identity resolving keys from devices that are already
 	 * using a public address or static random address, do not
 	 * ask for storing this key. The identity resolving key really
-	 * is only mandatory for devices using resovlable random
+	 * is only mandatory for devices using resolvable random
 	 * addresses.
 	 *
 	 * Storing all identity resolving keys has the downside that
@@ -7646,7 +7646,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 	memset(&ev, 0, sizeof(ev));
 
 	/* Devices using resolvable or non-resolvable random addresses
-	 * without providing an indentity resolving key don't require
+	 * without providing an identity resolving key don't require
 	 * to store signature resolving keys. Their addresses will change
 	 * the next time around.
 	 *
-- 
1.9.1


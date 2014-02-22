Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix issue with missing management event opcode
Date: Fri, 21 Feb 2014 21:35:30 -0800
Message-Id: <1393047330-34334-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The event opcode for New Identity Resolving Key event is missing from
supported event list. Just add it there.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 12fa6399c796..bc329d911706 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_DEVICE_UNBLOCKED,
 	MGMT_EV_DEVICE_UNPAIRED,
 	MGMT_EV_PASSKEY_NOTIFY,
+	MGMT_EV_NEW_IRK,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
-- 
1.8.5.3


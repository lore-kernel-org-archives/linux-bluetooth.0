Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: AMP: Register AMP only if High Speed enabled
Date: Thu,  4 Oct 2012 11:26:55 +0300
Message-Id: <1349339215-8422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make sure that AMP controller is registered only if HS enables.
Return EINVAL if High Speed is not enabled and dev_type is HCI_AMP.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bd26cb5..746af2d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1708,7 +1708,10 @@ int hci_register_dev(struct hci_dev *hdev)
 		id = ida_simple_get(&hci_index_ida, 0, 0, GFP_KERNEL);
 		break;
 	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, 0, GFP_KERNEL);
+		if (enable_hs)
+			id = ida_simple_get(&hci_index_ida, 1, 0, GFP_KERNEL);
+		else
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.5


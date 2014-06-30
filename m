Return-Path: <cyrus@holtmann.org>
From: Kiran Kumar Raparthy <kiran.kumar@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Stultz <john.stultz@linaro.org>,
	Kiran Kumar Raparthy <kiran.kumar@linaro.org>
Subject: [RFC] Bluetooth: Fallback to SCO on error code 0x10 (Connection Accept Timeout).
Date: Mon, 30 Jun 2014 11:25:01 +0530
Message-Id: <1404107701-19096-1-git-send-email-kiran.kumar@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nick Pelly <npelly@google.com>

Fallback to SCO on error code 0x10 (Connection Accept Timeout).

This is to support the Motorola HF850 carkit which reports the error code 0x10
for an eSCO attempt, even though it advertises eSCO support.

With this patch we will retry with a SCO connection, which succeeds.

This is one of the number of patches from the Android AOSP common.git tree,
which is used on almost all Android devices.  I wanted to submit it for review
to see if it should go upstream.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Nick Pelly <npelly@google.com>
[kiran: Added context to commit message]
Signed-off-by: Kiran Kumar Raparthy <kiran.kumar@linaro.org>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 15010a2..754a136 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3223,6 +3223,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x10:	/* Connection Accept Timeout */
 	case 0x0d:	/* Connection Rejected due to Limited Resources */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
-- 
1.8.2.1

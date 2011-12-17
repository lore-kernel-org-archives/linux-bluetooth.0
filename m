Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 20/22] Bluetooth: move power_off to system workqueue
Date: Sat, 17 Dec 2011 19:29:40 -0200
Message-Id: <1324157382-1815-21-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

hdev->workqueue will be only for for rx/tx/cmd processing, all other small
works should go to the system workqueue for now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |    2 +-
 net/bluetooth/mgmt.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5c7fec8..e4ff7b6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -936,7 +936,7 @@ void hci_power_on(struct hci_dev *hdev)
 		return;
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->flags))
-		queue_delayed_work(hdev->workqueue, &hdev->power_off,
+		schedule_delayed_work(&hdev->power_off,
 					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 30cbdd7..4402c4d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -417,7 +417,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (cp->val)
 		hci_power_on(hdev);
 	else
-		queue_work(hdev->workqueue, &hdev->power_off.work);
+		schedule_work(&hdev->power_off.work);
 
 	err = 0;
 
-- 
1.7.6.4


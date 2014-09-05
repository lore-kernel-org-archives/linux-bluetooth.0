Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/7] Bluetooth: Don't take any action in smp_resume_cb if not encrypted
Date: Fri,  5 Sep 2014 20:50:47 +0300
Message-Id: <1409939452-5928-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409939452-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1409939452-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When smp_resume_cb is called if we're not encrypted (i.e. the callback
wasn't called because the connection became encrypted) we shouldn't take
any action at all. This patch moves also the security_timer cancellation
behind this condition.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b8ecc7bd3e3b..9accb4739488 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1533,10 +1533,12 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	if (!smp)
 		return;
 
+	if (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
+		return;
+
 	cancel_delayed_work(&smp->security_timer);
 
-	if (test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
-		queue_work(hdev->workqueue, &smp->distribute_work);
+	queue_work(hdev->workqueue, &smp->distribute_work);
 }
 
 static void smp_ready_cb(struct l2cap_chan *chan)
-- 
1.9.3


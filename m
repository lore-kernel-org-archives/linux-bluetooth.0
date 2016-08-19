Return-Path: <boris.brezillon@free-electrons.com>
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jason.abele@gmail.com,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 2/4] Bluetooth: hci_h5: fix a race in the closing path
Date: Fri, 19 Aug 2016 09:38:45 +0200
Message-Id: <1471592327-14133-3-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The H5 timer should not be rescheduled while we are closing the device,
otherwise it's defeating the del_timer_sync() call done in h5_close().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/bluetooth/hci_h5.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0879d64b1caf..d9720c59cffa 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -140,7 +140,12 @@ static void h5_timed_event(unsigned long arg)
 	}
 
 	if (h5->state != H5_ACTIVE) {
-		mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
+		/*
+		 * Do not re-schedule the timer if the device is being closed.
+		 */
+		if (!test_bit(HCI_UART_CLOSING, &hu->flags))
+			mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
+
 		goto wakeup;
 	}
 
-- 
2.7.4

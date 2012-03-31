Return-Path: <cyrus@holtmann.org>
Message-ID: <4F77055A.2070502@ahsoftware.de>
Date: Sat, 31 Mar 2012 15:23:38 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: bluetooth: fix deadlock on device reset and power down
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've experienced a deadlock on shutdown using kernel 3.3 and tracked it 
down. Because I'm not very familiar with the bluetooth stack I'm not 
sure if the below patch is correct, but it fixed the problem here.

This patch should go to the stable tree too, if approved.

Regards,

Alexander

--------------
 From 9d0902dc07504ab28a31de471cfb3225fb0404c6 Mon Sep 17 00:00:00 2001
From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 31 Mar 2012 15:03:27 +0200
Subject: [PATCH] bluetooth: fix deadlock on device reset and power down

Commit 09fd0de5bd8f8ef3317e5365f92f1a13dcd89aa9 introduced a deadlock:

bluetoothd calls ioctl HCIDEVDOWN
     hci_sock_ioctl()
         hci_dev_close()
             hci_dev_do_close()
                 hci_dev_lock(hdev);
                 inquiry_cache_flush();
                 hci_conn_hash_flush();
                     hci_conn_del()
                         cancel_delayed_work_sync()
                             hci_conn_timeout()
                                 hci_dev_lock(hdev); /* DEADLOCK */
                 hci_dev_unlock(hdev);

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
  net/bluetooth/hci_core.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5aeb624..3428036 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -629,8 +629,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)

  	hci_dev_lock(hdev);
  	inquiry_cache_flush(hdev);
-	hci_conn_hash_flush(hdev);
  	hci_dev_unlock(hdev);
+	hci_conn_hash_flush(hdev);

  	hci_notify(hdev, HCI_DEV_DOWN);

@@ -713,8 +713,8 @@ int hci_dev_reset(__u16 dev)

  	hci_dev_lock(hdev);
  	inquiry_cache_flush(hdev);
-	hci_conn_hash_flush(hdev);
  	hci_dev_unlock(hdev);
+	hci_conn_hash_flush(hdev);

  	if (hdev->flush)
  		hdev->flush(hdev);
-- 
1.7.6.5


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Route traffic only through BR/EDR controller
Date: Fri, 29 Jun 2012 15:07:02 +0300
Message-Id: <1340971622-16318-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If AMP controller is first in the list then Bluetooth traffic might
be routed through it (if source is not specified). The patch
prevents this case and also checks that source is BR/EDR.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 858907f..743572e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -442,7 +442,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
-		    test_bit(HCI_RAW, &d->flags))
+		    test_bit(HCI_RAW, &d->flags) ||
+		    d->dev_type != HCI_BREDR)
 			continue;
 
 		/* Simple routing:
-- 
1.7.9.5


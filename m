Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ll: Fix NULL pointer deref on FW upload failure
Date: Sat, 15 Apr 2017 23:54:13 +0200
Message-Id: <20170415215413.15648-1-sre@kernel.org>
In-Reply-To: <20170415194854.byado7bxupbdhivp@earth>
References: <20170415194854.byado7bxupbdhivp@earth>
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid NULL pointer dereference occurring due to freeing
skb containing an error pointer. It can easily be triggered
by using the driver with broken uart (i.e. due to misconfigured
pinmuxing).

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/bluetooth/hci_ll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 485e8eb04542..adc444f309a3 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -537,8 +537,7 @@ static int read_local_version(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading TI version information failed (%ld)",
 			   PTR_ERR(skb));
-		err = PTR_ERR(skb);
-		goto out;
+		return PTR_ERR(skb);
 	}
 	if (skb->len != sizeof(*ver)) {
 		err = -EILSEQ;
-- 
2.11.0

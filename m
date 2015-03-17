Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Add hdev_init callback for HCI channels
Date: Tue, 17 Mar 2015 13:48:49 +0200
Message-Id: <1426592930-5842-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to make the mgmt command handling more generic we can't have a
direct call to mgmt_init_hdev() from mgmt_control(). This patch adds a
new callback to struct hci_mgmt_chan. And sets it to point to the
mgmt_init_hdev() function for the HCI_CHANNEL_CONTROL instance.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/mgmt.c             | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e4dc18eed446..93e7b2b05a17 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1305,6 +1305,7 @@ struct hci_mgmt_chan {
 	unsigned short channel;
 	size_t handler_count;
 	const struct hci_mgmt_handler *handlers;
+	void (*hdev_init) (struct sock *sk, struct hci_dev *hdev);
 };
 
 int hci_mgmt_chan_register(struct hci_mgmt_chan *c);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5124efb53de5..363a4348c40b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6445,8 +6445,8 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 		goto done;
 	}
 
-	if (hdev)
-		mgmt_init_hdev(sk, hdev);
+	if (hdev && chan->hdev_init)
+		chan->hdev_init(sk, hdev);
 
 	cp = buf + sizeof(*hdr);
 
@@ -7658,6 +7658,7 @@ static struct hci_mgmt_chan chan = {
 	.channel	= HCI_CHANNEL_CONTROL,
 	.handler_count	= ARRAY_SIZE(mgmt_handlers),
 	.handlers	= mgmt_handlers,
+	.hdev_init	= mgmt_init_hdev,
 };
 
 int mgmt_init(void)
-- 
2.1.0


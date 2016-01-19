Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <b38611@freescale.com>
To: <gustavo@padovan.org>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@intel.com>,
	<b38611@freescale.com>
Subject: [PATCH] Bluetooth: add hdev check to avoid passing null pointer
Date: Tue, 19 Jan 2016 18:34:21 +0800
Message-ID: <1453199661-7918-1-git-send-email-b38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Function hci_mgmt_cmd() may pass hdev with null pointer to hci_mgmt_handler->func()
like below code:
	err = handler->func(sk, hdev, cp, len);

Add hdev check to avoid passing null pointer.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 net/bluetooth/hci_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1298d72..7fdfc80 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1186,6 +1186,8 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 
 	if (hdev && chan->hdev_init)
 		chan->hdev_init(sk, hdev);
+	else if (!hdev)
+		goto done;
 
 	cp = buf + sizeof(*hdr);
 
-- 
1.9.1

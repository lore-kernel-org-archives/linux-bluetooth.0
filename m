Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 1/3] Bluetooth: Use GFP_KERNEL in mgmt_handlers
Date: Thu,  7 Jun 2012 19:05:44 -0300
Message-Id: <1339106746-22886-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

add_uuid and get_connections mgmt_handlers are executed by user
threads running in kernel-mode.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..8c7a6f9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1268,7 +1268,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
+	uuid = kmalloc(sizeof(*uuid), GFP_KERNEL);
 	if (!uuid) {
 		err = -ENOMEM;
 		goto failed;
@@ -1667,7 +1667,7 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
-	rp = kmalloc(rp_len, GFP_ATOMIC);
+	rp = kmalloc(rp_len, GFP_KERNEL);
 	if (!rp) {
 		err = -ENOMEM;
 		goto unlock;
-- 
1.7.10.3


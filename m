Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Use reject error code in pair device method
Date: Fri, 23 Jan 2015 12:53:32 +0100
Message-Id: <1422014012-6840-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1422014012-6840-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422014012-6840-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user space is trying to do LE pair but LE has not been enabled then
MGMT_STATUS_REJECT will be returned.

Same result code will be returned also in case of BREDR pairing if BREDR
is not enabled.

Having separate error code for that scenario might be useful for
debugging at least.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 41e3005..e03e63c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3246,6 +3246,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (PTR_ERR(conn) == -EBUSY)
 			status = MGMT_STATUS_BUSY;
+		else if (PTR_ERR(conn) == -EOPNOTSUPP)
+			status = MGMT_STATUS_REJECTED;
 		else
 			status = MGMT_STATUS_CONNECT_FAILED;
 
-- 
1.8.4


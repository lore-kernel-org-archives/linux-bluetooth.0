Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] Bluetooth: Enhance error codes pair device command
Date: Wed, 11 Feb 2015 12:31:42 +0100
Message-Id: <1423654302-32348-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654302-32348-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user space is trying to pair on not enabled transport
MGMT_STATUS_REJECT will be returned.

If user space is trying to pair on transport which controller does not
support, MGMT_STATUS_NOT_SUPPORTED will be returned.

Having separate error code for that scenario might be useful for
debugging at least.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ec5390..1b528de 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3249,6 +3249,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (PTR_ERR(conn) == -EBUSY)
 			status = MGMT_STATUS_BUSY;
+		else if (PTR_ERR(conn) == -EOPNOTSUPP)
+			status = MGMT_STATUS_NOT_SUPPORTED;
+		else if (PTR_ERR(conn) == -ECONNREFUSED)
+			status = MGMT_STATUS_REJECTED;
 		else
 			status = MGMT_STATUS_CONNECT_FAILED;
 
-- 
1.8.4


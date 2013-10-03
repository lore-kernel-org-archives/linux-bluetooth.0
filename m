Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Restrict SSP setting changes to BR/EDR enabled controllers
Date: Wed,  2 Oct 2013 21:31:52 -0700
Message-Id: <1380774712-13370-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only when BR/EDR is supported and enabled, allow changing of the SSP
setting. Just checking if the hardware supports SSP is not enough
since it might be the case that BR/EDR is disabled.

In the case that BR/EDR is disabled, but SSP supported by the
controller the not supported error message is now returned.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03fca4c..e93d19a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1296,11 +1296,15 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	u8 val;
+	u8 val, status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
+	status = mgmt_bredr_support(hdev);
+	if (status)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP, status);
+
 	if (!lmp_ssp_capable(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				  MGMT_STATUS_NOT_SUPPORTED);
-- 
1.8.3.1


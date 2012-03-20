Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [RFC 3/4] Bluetooth: Check HCI_PINQUIRY in start_discovery
Date: Mon, 19 Mar 2012 23:32:51 -0300
Message-Id: <1332210772-13806-4-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a HCI_PINQUIRY check to start_discovery. If
periodic inquiry is enabled, we fail MGMT Start Discovery
command with MGMT_STATUS_BUSY code.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8f9016..a3365ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2317,6 +2317,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (test_bit(HCI_PINQUIRY, &hdev->dev_flags)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				 MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 				 MGMT_STATUS_BUSY);
-- 
1.7.9.4


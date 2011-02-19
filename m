Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Fix inititial value for remote authentication requirements
Date: Sat, 19 Feb 2011 12:06:01 -0300
Message-Id: <1298127962-18576-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The remote authentication requirements for conections need to be
initialized to 0xff (unknown) since it is possible that we receive a IO
Capability Request before we have received information about the remote
requirements.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a050a69..6d8b988 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -286,6 +286,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->state = BT_OPEN;
 	conn->auth_type = HCI_AT_GENERAL_BONDING;
 	conn->io_capability = hdev->io_capability;
+	conn->remote_auth = 0xff;
 
 	conn->power_save = 1;
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-- 
1.7.4.1


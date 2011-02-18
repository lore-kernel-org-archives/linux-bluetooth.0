Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] Bluetooth: Enable support for Out of Band authentication
Date: Fri, 18 Feb 2011 12:12:21 +0100
Message-ID: <1298027541-21403-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-7-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-7-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaa905..a7c7349 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2335,9 +2335,14 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.capability = conn->io_capability;
-		cp.oob_data = 0;
 		cp.authentication = hci_get_auth_req(conn);
 
+		if ((conn->out == 1 || conn->remote_oob == 0x01) &&
+				hci_find_remote_oob_data(hdev, &conn->dst))
+			cp.oob_data = 0x01;
+		else
+			cp.oob_data = 0x00;
+
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
 							sizeof(cp), &cp);
 	} else {
-- 
1.7.0.4


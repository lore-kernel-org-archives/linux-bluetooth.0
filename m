Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 5/5] Bluetooth: Enable support for out of band association model
Date: Mon, 21 Mar 2011 14:07:01 +0100
Message-ID: <1300712821-23172-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300712821-23172-1-git-send-email-szymon.janc@tieto.com>
References: <1300712821-23172-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote side reports oob availability or we are pairing initiator
use oob data for pairing if available.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fba5998..393b43b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2373,9 +2373,14 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.capability = conn->io_capability;
-		cp.oob_data = 0;
 		cp.authentication = hci_get_auth_req(conn);
 
+		if ((conn->out == 0x01 || conn->remote_oob == 0x01) &&
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


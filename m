Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix SCO connection reference
Date: Thu, 11 Apr 2013 11:35:42 -0300
Message-Id: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes decrementing SCO connection reference right after
stablishing the SCO connection with defer setup enabled. The dump below
shows a disconnection command with handle 0, the connection is still in
BT_CONNECT2 state and there isn't a handle associated with it.

< HCI Command: Accept Synchronous Connection (0x01|0x0029) plen 21
  bdaddr 78:47:1D:B3:72:6C
> HCI Event: Command Status (0x0f) plen 4
  Accept Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
  handle 0 reason 0x13
  Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
  Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
  status 0x00 handle 46 bdaddr 78:47:1D:B3:72:6C
  type eSCO
  Air mode: CVSD
< SCO data: handle 46 flags 0x00 dlen 48

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a2b128..7a05759 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1860,7 +1860,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else {
 			conn->state = BT_CONNECT2;
 			hci_proto_connect_cfm(conn, 0);
-			hci_conn_put(conn);
 		}
 	} else {
 		/* Connection rejected */
-- 
1.7.11.7


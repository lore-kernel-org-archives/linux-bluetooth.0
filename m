Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Fix legacy pairing with some devices
Date: Mon, 28 May 2012 11:47:19 +0200
Message-ID: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some devices e.g. SonyEricsson Xperia ray and arc S don't do SDP search
before pairing. No L2CAP is connected so default HCI_DISCONN_TIMEOUT
(2 seconds) timeout value is being used. This results in problems with
legacy pairing as remote user has only few seconds to enter PIN before
ACL is disconnected.

Increase disconnect timeout to HCI_PAIRING_TIMEOUT if SSP is disabled
and no linkey exists.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac86b65..98e8020 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1762,7 +1762,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
-			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+
+			if (!hci_conn_ssp_enabled(conn) &&
+			    !hci_find_link_key(hdev, &ev->bdaddr))
+				conn->disc_timeout = HCI_PAIRING_TIMEOUT;
+			else
+				conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 		} else
 			conn->state = BT_CONNECTED;
 
-- 
on behalf of ST-Ericsson


Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bing Zhao
	<bzhao@marvell.com>, Hiren Tandel <hirent@marvell.com>,
        Rahul Tank
	<rahult@marvell.com>, Quinton Yuan <qyuan@marvell.com>
Subject: [PATCH] Bluetooth: Fix to auto accept pairing request for no MITM case
Date: Wed, 5 Feb 2014 11:01:40 -0800
Message-ID: <1391626900-11168-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Hiren Tandel <hirent@marvell.com>

With existing implementation, during incoming SSP if no side
requires MITM protection, user confirm request event is
forwarded to user space for further user confirmation without
checking io capability of local host. But in case if there is no
agent registered with bluez user space daemon which means device
has NoInputNoOutput capability at that moment, it rejects the
request.

This patch will check for io capability of local host before
forwarding request to user space. If local host has
NoInputNoOutput capability, there is no point in forwarding
request to user space. Hence local host kernel goes ahead with
auto accept, by sending User Confirmation Request Reply command.

Signed-off-by: Hiren Tandel <hirent@marvell.com>
Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Quinton Yuan <qyuan@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 net/bluetooth/hci_event.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d2c6878..b61f0c6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3239,8 +3239,13 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 
 		/* If we're not the initiators request authorization to
 		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). */
-		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
+		 * confirm_hint set to 1).
+		 * But if local host has NoInputNoOutput capability,
+		 * then no use of passing request to user space,
+		 * so go ahead with auto accept.
+		 */
+		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			BT_DBG("Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
-- 
1.8.0

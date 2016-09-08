Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
Subject: [PATCH] Bluetooth: Fix reason code used for rejecting SCO connections
Date: Thu,  8 Sep 2016 12:00:11 +0200
Message-Id: <1473328811-25338-1-git-send-email-frederic.dalleau@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A comment in the code states that SCO connection should be rejected
with the proper error value between 0xd-0xf. The code uses
HCI_ERROR_REMOTE_LOW_RESOURCES which is 0x14.

This led to following error:
< HCI Command: Reject Synchronous Co.. (0x01|0x002a) plen 7
        Address: 34:51:C9:EF:02:CA (Apple, Inc.)
        Reason: Remote Device Terminated due to Low Resources (0x14)
> HCI Event: Command Status (0x0f) plen 4
      Reject Synchronous Connection Request (0x01|0x002a) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Instead make use of HCI_ERROR_REJ_LIMITED_RESOURCES which is 0xd.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
---
 net/bluetooth/hci_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b0e23df..3d94f18 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1716,7 +1716,7 @@ void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 			 * function. To be safe hard-code one of the
 			 * values that's suitable for SCO.
 			 */
-			rej.reason = HCI_ERROR_REMOTE_LOW_RESOURCES;
+			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
 
 			hci_req_add(req, HCI_OP_REJECT_SYNC_CONN_REQ,
 				    sizeof(rej), &rej);
-- 
2.7.4


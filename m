Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 26 Sep 2014 16:50:07 +0200
Message-ID: <CAHF=Y4o84_KVO2rr81h1wnBsFfsJ9nj=QNCEUC1E2=3cTYPZfw@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix sending redundant "LE Set Scan Enable
 (disable)" commands
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checking the LE scanning state (HCI_LE_SCAN) before queuing a new "LE
Set Scan Enable (disable)" command is not enough to avoid sending
extra redundant commands. Since HCI_LE_SCAN is only updated upon
"Command Complete" confirmation, multiple "LE Set Scan Enable
(disable)" can get queued before the first one gets delivered.

I encountered this issue when unpairing (MGMT_OP_UNPAIR_DEVICE) and
immediately pairing (MGMT_OP_PAIR_DEVICE) the only auto-connected
device. MGMT_OP_UNPAIR_DEVICE stopped scanning since there were no
more auto-connected devices and MGMT_OP_PAIR_DEVICE also stopped
scanning because some controllers cannot scan while connecting.

I added a dedicated flag (le_scan_disable_queued) in hci_dev for this
purpose since dev_flags is already full.

Signed-off-by: Alfonso Acosta <fons@spotify.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 4 +++-
 net/bluetooth/hci_event.c        | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 37ff1ae..04c2f2f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -292,6 +292,7 @@ struct hci_dev {
  struct sk_buff_head rx_q;
  struct sk_buff_head raw_q;
  struct sk_buff_head cmd_q;
+ int le_scan_disable_queued;

  struct sk_buff *recv_evt;
  struct sk_buff *sent_cmd;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..d0d27e7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5441,10 +5441,12 @@ static void hci_cmd_work(struct work_struct *work)
 void hci_req_add_le_scan_disable(struct hci_request *req)
 {
  struct hci_cp_le_set_scan_enable cp;
-
+ if(req->hdev->le_scan_disable_queued)
+  return;
  memset(&cp, 0, sizeof(cp));
  cp.enable = LE_SCAN_DISABLE;
  hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+ req->hdev->le_scan_disable_queued = 1;
 }

 static void add_to_white_list(struct hci_request *req,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b0a2a6..ad81335 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1122,7 +1122,7 @@ static void hci_cc_le_set_scan_enable(struct
hci_dev *hdev,
  __u8 status = *((__u8 *) skb->data);

  BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
+ hdev->le_scan_disable_queued = 0;
  if (status)
  return;

-- 
1.9.1

Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Bluetooth: Remove useless external function to count controllers
Date: Sat,  5 Oct 2013 11:47:41 -0700
Message-Id: <1380998869-64411-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The list of controllers can be counted ahead of time and inline
inside the AMP discover handling. There is no need to export such
a function at all.

In addition just count the AMP controller and only allocated space
for a single mandatory BR/EDR controller. No need to allocate more
space than needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 13 -------------
 net/bluetooth/a2mp.c             | 10 +++++++++-
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4194851..ab52dc7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -706,19 +706,6 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
-/* hci_dev_list shall be locked */
-static inline uint8_t __hci_num_ctrl(void)
-{
-	uint8_t count = 0;
-	struct list_head *p;
-
-	list_for_each(p, &hci_dev_list) {
-		count++;
-	}
-
-	return count;
-}
-
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index eb0f05e..a6e45e1 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -129,6 +129,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_discov_rsp *rsp;
 	u16 ext_feat;
 	u8 num_ctrl;
+	struct hci_dev *hdev;
 
 	if (len < sizeof(*req))
 		return -EINVAL;
@@ -152,7 +153,14 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	read_lock(&hci_dev_list_lock);
 
-	num_ctrl = __hci_num_ctrl();
+	/* at minimum the BR/EDR needs to be listed */
+	num_ctrl = 1;
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		if (hdev->dev_type == HCI_AMP)
+			num_ctrl++;
+	}
+
 	len = num_ctrl * sizeof(struct a2mp_cl) + sizeof(*rsp);
 	rsp = kmalloc(len, GFP_ATOMIC);
 	if (!rsp) {
-- 
1.8.3.1


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 11/26] Bluetooth: A2MP: Helper functions to count HCI devs
Date: Fri, 23 Mar 2012 18:13:51 +0200
Message-Id: <1332519246-16656-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper functions used to cound HCI devices (AMP controllers) and
build controller list packet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    2 ++
 include/net/bluetooth/hci_core.h |   13 +++++++++++++
 net/bluetooth/a2mp.c             |   30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 38ac0e6..3a7bd76 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -56,6 +56,8 @@
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
+#define HCI_BREDR_ID	0
+
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_NO_RESET,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 259d4a1..6a2fe3f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -643,6 +643,19 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
+/* hci_dev_list shall be locked */
+static inline uint8_t __hci_num_ctrl(void)
+{
+	uint8_t count = 0;
+	struct list_head *p;
+
+	list_for_each(p, &hci_dev_list) {
+		count++;
+	}
+
+	return count;
+}
+
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a2677d6..17659f7 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -65,6 +65,36 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
+{
+	cl->id = 0;
+	cl->type = 0;
+	cl->status = 1;
+}
+
+/* hci_dev_list shall be locked */
+static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
+{
+	int i = 0;
+	struct hci_dev *hdev;
+
+	__a2mp_cl_bredr(cl);
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		/* Iterate through AMP controllers */
+		if (hdev->id == HCI_BREDR_ID)
+			continue;
+
+		/* Starting from second entry */
+		if (++i >= num_ctrl)
+			return;
+
+		cl[i].id = hdev->id;
+		cl[i].type = hdev->amp_type;
+		cl[i].status = hdev->amp_status;
+	}
+}
+
 /* Processing A2MP messages */
 static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
 				   struct a2mp_cmd *hdr)
-- 
1.7.9.1


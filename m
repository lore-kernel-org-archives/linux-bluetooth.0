Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, mathewm@codeaurora.org
Subject: [PATCHv7 06/19] Bluetooth: AMP: Physical link struct and heplers
Date: Thu, 27 Sep 2012 17:26:11 +0300
Message-Id: <1348755984-6403-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define physical link structures. Physical links are represented by
hci_conn structure. For BR/EDR we use type ACL_LINK and for AMP
we use AMP_LINK.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h      |    3 +++
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/amp.c              |   29 +++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index e861675..3414dfd 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -14,6 +14,9 @@
 #ifndef __AMP_H
 #define __AMP_H
 
+struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
+			     u8 remote_id);
+
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ccc08e5..77b6a19 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -207,6 +207,7 @@ enum {
 #define ESCO_LINK	0x02
 /* Low Energy links do not have defined link type. Use invented one */
 #define LE_LINK		0x80
+#define AMP_LINK	0x81
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b1c7d06..464eae3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -318,6 +318,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	__u8		remote_id;
 	bool		flush_key;
 
 	unsigned int	sent;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 2d4e79e..50a7b2f 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -17,6 +17,35 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/amp.h>
 
+/* Physical Link interface */
+static u8 __next_handle(struct amp_mgr *mgr)
+{
+	if (++mgr->handle == 0)
+		mgr->handle = 1;
+
+	return mgr->handle;
+}
+
+struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
+			     u8 remote_id)
+{
+	bdaddr_t *dst = mgr->l2cap_conn->dst;
+	struct hci_conn *hcon;
+
+	hcon = hci_conn_add(hdev, AMP_LINK, dst);
+	if (!hcon)
+		return NULL;
+
+	hcon->state = BT_CONNECT;
+	hcon->out = true;
+	hcon->attempt++;
+	hcon->handle = __next_handle(mgr);
+	hcon->remote_id = remote_id;
+	hcon->amp_mgr = mgr;
+
+	return hcon;
+}
+
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
 {
 	struct hci_cp_read_local_amp_assoc cp;
-- 
1.7.9.5


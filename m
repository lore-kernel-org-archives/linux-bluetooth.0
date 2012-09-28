Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: A2MP: Correct assoc_len size
Date: Fri, 28 Sep 2012 14:41:30 +0300
Message-Id: <1348832490-13448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120928011706.GC5522@localhost>
References: <20120928011706.GC5522@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Correct assoc_len and fix warning for x86-64 by using %zu specifier
reported by Fengguang Wu <fengguang.wu@intel.com>.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a55449e..82ccedf 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -381,12 +381,15 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct hci_dev *hdev;
 	struct amp_ctrl *ctrl;
 	struct hci_conn *hcon;
+	u16 assoc_len;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	BT_DBG("id %d status 0x%2.2x assoc len %lu", rsp->id, rsp->status,
-	       len - sizeof(*rsp));
+	assoc_len = len - sizeof(*rsp);
+
+	BT_DBG("id %d status 0x%2.2x assoc len %zu", rsp->id, rsp->status,
+	       assoc_len);
 
 	if (rsp->status)
 		return -EINVAL;
@@ -394,7 +397,7 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	/* Save remote ASSOC data */
 	ctrl = amp_ctrl_lookup(mgr, rsp->id);
 	if (ctrl) {
-		u8 *assoc, assoc_len = len - sizeof(*rsp);
+		u8 *assoc;
 
 		assoc = kzalloc(assoc_len, GFP_KERNEL);
 		if (!assoc) {
@@ -468,7 +471,8 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	}
 
 	if (ctrl) {
-		u8 *assoc, assoc_len = le16_to_cpu(hdr->len) - sizeof(*req);
+		u16 assoc_len = le16_to_cpu(hdr->len) - sizeof(*req);
+		u8 *assoc;
 
 		ctrl->id = rsp.remote_id;
 
-- 
1.7.9.5


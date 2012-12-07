Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] Bluetooth: AMP: Use set_bit / test_bit for amp_mgr state
Date: Fri,  7 Dec 2012 14:59:08 +0200
Message-Id: <1354885148-4677-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Using bit operations solves problems with multiple requests
and clearing state.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    2 +-
 net/bluetooth/a2mp.c         |    6 +++---
 net/bluetooth/amp.c          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 8b39327..487b54c 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -34,7 +34,7 @@ struct amp_mgr {
 	struct kref		kref;
 	__u8			ident;
 	__u8			handle;
-	enum amp_mgr_state	state;
+	unsigned long		state;
 	unsigned long		flags;
 
 	struct list_head	amp_ctrls;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index c960c20..50d2771 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -290,7 +290,7 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto done;
 	}
 
-	mgr->state = READ_LOC_AMP_INFO;
+	set_bit(READ_LOC_AMP_INFO, &mgr->state);
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
 
 done:
@@ -506,7 +506,7 @@ send_rsp:
 		a2mp_send(mgr, A2MP_CREATEPHYSLINK_RSP, hdr->ident,
 			  sizeof(rsp), &rsp);
 	} else {
-		mgr->state = WRITE_REMOTE_AMP_ASSOC;
+		set_bit(WRITE_REMOTE_AMP_ASSOC, &mgr->state);
 		mgr->ident = hdr->ident;
 	}
 
@@ -848,7 +848,7 @@ struct amp_mgr *amp_mgr_lookup_by_state(u8 state)
 
 	mutex_lock(&amp_mgr_list_lock);
 	list_for_each_entry(mgr, &amp_mgr_list, list) {
-		if (mgr->state == state) {
+		if (test_and_clear_bit(state, &mgr->state)) {
 			amp_mgr_get(mgr);
 			mutex_unlock(&amp_mgr_list_lock);
 			return mgr;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index f55d3f2..1bbb59d 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -236,7 +236,7 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 
 	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
 
-	mgr->state = READ_LOC_AMP_ASSOC;
+	set_bit(READ_LOC_AMP_ASSOC, &mgr->state);
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
 }
 
@@ -250,7 +250,7 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 	cp.len_so_far = cpu_to_le16(0);
 	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
 
-	mgr->state = READ_LOC_AMP_ASSOC_FINAL;
+	set_bit(READ_LOC_AMP_ASSOC_FINAL, &mgr->state);
 
 	/* Read Local AMP Assoc final link information data */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
-- 
1.7.10.4


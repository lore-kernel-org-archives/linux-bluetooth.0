Return-Path: <cyrus@holtmann.org>
From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] net: bluetooth: Replaced kzalloc and memcpy with kmemdup
Date: Sat, 16 Mar 2013 16:07:10 +0200
Message-Id: <1363442830-13754-1-git-send-email-gheorghiuandru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Replaced calls to kzalloc followed by memcpy with a single call to kmemdup.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 net/bluetooth/a2mp.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index eb0f4b1..140e81c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -397,13 +397,12 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	if (ctrl) {
 		u8 *assoc;
 
-		assoc = kzalloc(assoc_len, GFP_KERNEL);
+		assoc = kmemdup(rsp->amp_assoc, assoc_len, GFP_KERNEL);
 		if (!assoc) {
 			amp_ctrl_put(ctrl);
 			return -ENOMEM;
 		}
 
-		memcpy(assoc, rsp->amp_assoc, assoc_len);
 		ctrl->assoc = assoc;
 		ctrl->assoc_len = assoc_len;
 		ctrl->assoc_rem_len = assoc_len;
@@ -472,13 +471,12 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		size_t assoc_len = le16_to_cpu(hdr->len) - sizeof(*req);
 		u8 *assoc;
 
-		assoc = kzalloc(assoc_len, GFP_KERNEL);
+		assoc = kmemdup(rep->amp_assoc, assoc_len, GFP_KERNEL);
 		if (!assoc) {
 			amp_ctrl_put(ctrl);
 			return -ENOMEM;
 		}
 
-		memcpy(assoc, req->amp_assoc, assoc_len);
 		ctrl->assoc = assoc;
 		ctrl->assoc_len = assoc_len;
 		ctrl->assoc_rem_len = assoc_len;
-- 
1.7.9.5

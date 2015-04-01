Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Restrict BNEP flags to only valid ones
Date: Wed,  1 Apr 2015 13:51:54 -0700
Message-Id: <1427921514-22465-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BNEP flags should be clearly restricted to valid ones. So this puts
extra checks in place to ensure this.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/bnep/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 05f57e491ccb..8287ff4eff61 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -525,6 +525,7 @@ static struct device_type bnep_type = {
 
 int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 {
+	__u32 valid_flags = 0;
 	struct net_device *dev;
 	struct bnep_session *s, *ss;
 	u8 dst[ETH_ALEN], src[ETH_ALEN];
@@ -535,6 +536,9 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	if (!l2cap_is_socket(sock))
 		return -EBADFD;
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	baswap((void *) dst, &l2cap_pi(sock->sk)->chan->dst);
 	baswap((void *) src, &l2cap_pi(sock->sk)->chan->src);
 
@@ -611,11 +615,15 @@ failed:
 
 int bnep_del_connection(struct bnep_conndel_req *req)
 {
+	__u32 valid_flags = 0;
 	struct bnep_session *s;
 	int  err = 0;
 
 	BT_DBG("");
 
+	if (req->flags & ~valid_flags)
+		return -EINVAL;
+
 	down_read(&bnep_session_sem);
 
 	s = __bnep_get_session(req->dst);
@@ -631,10 +639,12 @@ int bnep_del_connection(struct bnep_conndel_req *req)
 
 static void __bnep_copy_ci(struct bnep_conninfo *ci, struct bnep_session *s)
 {
+	__u32 valid_flags = 0;
+
 	memset(ci, 0, sizeof(*ci));
 	memcpy(ci->dst, s->eh.h_source, ETH_ALEN);
 	strcpy(ci->device, s->dev->name);
-	ci->flags = s->flags;
+	ci->flags = s->flags & valid_flags;
 	ci->state = s->state;
 	ci->role  = s->role;
 }
-- 
2.1.0


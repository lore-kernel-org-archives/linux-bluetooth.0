Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Show device address type for L2CAP debugfs entries
Date: Wed, 14 Jan 2015 13:44:21 -0800
Message-Id: <1421271861-7212-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The devices address types are BR/EDR Public, LE Public and LE Random and
any of these three is valid for L2CAP connections. So show the correct
type in the debugfs list.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 11029b212874..4e7477d34eb8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7527,8 +7527,8 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 	read_lock(&chan_list_lock);
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		seq_printf(f, "%pMR %pMR %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
-			   &c->src, &c->dst,
+		seq_printf(f, "%pMR (%u) %pMR (%u) %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
+			   &c->src, c->src_type, &c->dst, c->dst_type,
 			   c->state, __le16_to_cpu(c->psm),
 			   c->scid, c->dcid, c->imtu, c->omtu,
 			   c->sec_level, c->mode);
-- 
2.1.0


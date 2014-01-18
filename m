Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove useless l2cap_seq_list_remove function
Date: Sat, 18 Jan 2014 21:32:59 +0200
Message-Id: <1390073579-19074-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The only user of l2cap_seq_list_remove() was l2cap_seq_list_pop() which
only removes the head, meaning only the "else if (seq_list->head ==
seq)" branch was ever being used. This patch moves the code from this
branch straight into l2cap_seq_list_pop() and removes the (now useless)
l2cap_seq_list_remove().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cd534599fbfa..138394ad3e51 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -330,44 +330,20 @@ static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_list,
 	return seq_list->list[seq & seq_list->mask] != L2CAP_SEQ_LIST_CLEAR;
 }
 
-static u16 l2cap_seq_list_remove(struct l2cap_seq_list *seq_list, u16 seq)
+static inline u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
 {
+	u16 seq = seq_list->head;
 	u16 mask = seq_list->mask;
 
-	if (seq_list->head == L2CAP_SEQ_LIST_CLEAR) {
-		/* In case someone tries to pop the head of an empty list */
-		return L2CAP_SEQ_LIST_CLEAR;
-	} else if (seq_list->head == seq) {
-		/* Head can be removed in constant time */
-		seq_list->head = seq_list->list[seq & mask];
-		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
-
-		if (seq_list->head == L2CAP_SEQ_LIST_TAIL) {
-			seq_list->head = L2CAP_SEQ_LIST_CLEAR;
-			seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
-		}
-	} else {
-		/* Walk the list to find the sequence number */
-		u16 prev = seq_list->head;
-		while (seq_list->list[prev & mask] != seq) {
-			prev = seq_list->list[prev & mask];
-			if (prev == L2CAP_SEQ_LIST_TAIL)
-				return L2CAP_SEQ_LIST_CLEAR;
-		}
+	seq_list->head = seq_list->list[seq & mask];
+	seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
 
-		/* Unlink the number from the list and clear it */
-		seq_list->list[prev & mask] = seq_list->list[seq & mask];
-		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
-		if (seq_list->tail == seq)
-			seq_list->tail = prev;
+	if (seq_list->head == L2CAP_SEQ_LIST_TAIL) {
+		seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+		seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
 	}
-	return seq;
-}
 
-static inline u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
-{
-	/* Remove the head in constant time */
-	return l2cap_seq_list_remove(seq_list, seq_list->head);
+	return seq;
 }
 
 static void l2cap_seq_list_clear(struct l2cap_seq_list *seq_list)
-- 
1.8.4.2


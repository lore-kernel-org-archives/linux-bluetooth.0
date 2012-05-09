Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: improve readability of l2cap_seq_list code.
Date: Wed,  9 May 2012 18:28:00 -0300
Message-Id: <1336598880-28568-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes one indentation level.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 54d835b..2a98482 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -310,14 +310,16 @@ static inline u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
 
 static void l2cap_seq_list_clear(struct l2cap_seq_list *seq_list)
 {
-	if (seq_list->head != L2CAP_SEQ_LIST_CLEAR) {
-		u16 i;
-		for (i = 0; i <= seq_list->mask; i++)
-			seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
+	u16 i;
 
-		seq_list->head = L2CAP_SEQ_LIST_CLEAR;
-		seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
-	}
+	if (seq_list->head == L2CAP_SEQ_LIST_CLEAR)
+		return;
+
+	for (i = 0; i <= seq_list->mask; i++)
+		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
+
+	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
 }
 
 static void l2cap_seq_list_append(struct l2cap_seq_list *seq_list, u16 seq)
@@ -326,15 +328,16 @@ static void l2cap_seq_list_append(struct l2cap_seq_list *seq_list, u16 seq)
 
 	/* All appends happen in constant time */
 
-	if (seq_list->list[seq & mask] == L2CAP_SEQ_LIST_CLEAR) {
-		if (seq_list->tail == L2CAP_SEQ_LIST_CLEAR)
-			seq_list->head = seq;
-		else
-			seq_list->list[seq_list->tail & mask] = seq;
+	if (seq_list->list[seq & mask] != L2CAP_SEQ_LIST_CLEAR)
+		return;
 
-		seq_list->tail = seq;
-		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_TAIL;
-	}
+	if (seq_list->tail == L2CAP_SEQ_LIST_CLEAR)
+		seq_list->head = seq;
+	else
+		seq_list->list[seq_list->tail & mask] = seq;
+
+	seq_list->tail = seq;
+	seq_list->list[seq & mask] = L2CAP_SEQ_LIST_TAIL;
 }
 
 static void l2cap_chan_timeout(struct work_struct *work)
-- 
1.7.10.1


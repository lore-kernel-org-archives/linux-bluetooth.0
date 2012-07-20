Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump] Fix printing link handle
Date: Fri, 20 Jul 2012 14:15:18 +0300
Message-Id: <1342782918-4224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Print logical and physical link handles as hex 0x%2.2x
---
 parser/hci.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 742a1b5..364a06c 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1125,7 +1125,7 @@ static inline void create_physical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("handle %d key length %d key type %d\n",
+	printf("handle 0x%2.2x key length %d key type %d\n",
 		cp->handle, cp->key_length, cp->key_type);
 	p_indent(level, frm);
 	printf("key ");
@@ -1140,7 +1140,7 @@ static inline void create_logical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("handle %d\n", cp->handle);
+	printf("handle 0x%2.2x\n", cp->handle);
 
 	p_indent(level, frm);
 	printf("tx_flow ");
@@ -3647,7 +3647,7 @@ static inline void phys_link_complete_dump(int level, struct frame *frm)
 	evt_physical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d\n", evt->status, evt->handle);
+	printf("status 0x%2.2x handle 0x%2.2x\n", evt->status, evt->handle);
 
 	if (evt->status > 0) {
 		p_indent(level, frm);
@@ -3660,7 +3660,7 @@ static inline void disconn_phys_link_complete_dump(int level, struct frame *frm)
 	evt_disconn_physical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d reason 0x%2.2x\n",
+	printf("status 0x%2.2x handle 0x%2.2x reason 0x%2.2x\n",
 				evt->status, evt->handle, evt->reason);
 
 	if (evt->status > 0) {
@@ -3677,7 +3677,7 @@ static inline void phys_link_loss_warning_dump(int level, struct frame *frm)
 	evt_physical_link_loss_warning *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("handle %d reason 0x%2.2x\n", evt->handle, evt->reason);
+	printf("handle 0x%2.2x reason 0x%2.2x\n", evt->handle, evt->reason);
 }
 
 static inline void phys_link_handle_dump(int level, struct frame *frm)
@@ -3685,7 +3685,7 @@ static inline void phys_link_handle_dump(int level, struct frame *frm)
 	evt_physical_link_recovery *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("handle %d\n", evt->handle);
+	printf("handle 0x%2.2x\n", evt->handle);
 }
 
 static inline void logical_link_complete_dump(int level, struct frame *frm)
@@ -3693,7 +3693,7 @@ static inline void logical_link_complete_dump(int level, struct frame *frm)
 	evt_logical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x log_handle %d handle %d tx_flow_id %d\n",
+	printf("status 0x%2.2x log_handle 0x%2.2x handle 0x%2.2x tx_flow_id %d\n",
 			evt->status, btohs(evt->log_handle), evt->handle,
 			evt->tx_flow_id);
 
@@ -3708,7 +3708,8 @@ static inline void flow_spec_modify_dump(int level, struct frame *frm)
 	evt_flow_spec_modify_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d\n", evt->status, btohs(evt->handle));
+	printf("status 0x%2.2x handle 0x%2.2x\n",
+					evt->status, btohs(evt->handle));
 
 	if (evt->status > 0) {
 		p_indent(level, frm);
-- 
1.7.9.5


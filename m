Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 hcidump 1/2] amp: Fix printing link handle
Date: Fri, 17 Aug 2012 16:46:18 +0300
Message-Id: <1345211179-3761-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342782918-4224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342782918-4224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Print logical link handle as 0x%4.4x and physical link handle
as 0x%2.2x
---
 parser/hci.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 920b973..115cf1e 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1128,7 +1128,7 @@ static inline void create_physical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("handle %d key length %d key type %d\n",
+	printf("phy handle 0x%2.2x key length %d key type %d\n",
 		cp->handle, cp->key_length, cp->key_type);
 	p_indent(level, frm);
 	printf("key ");
@@ -1143,7 +1143,7 @@ static inline void create_logical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("handle %d\n", cp->handle);
+	printf("phy handle 0x%2.2x\n", cp->handle);
 
 	p_indent(level, frm);
 	printf("tx_flow ");
@@ -3317,7 +3317,7 @@ static inline void flow_spec_complete_dump(int level, struct frame *frm)
 	evt_flow_spec_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d flags %d %s\n",
+	printf("status 0x%2.2x handle 0x%4.4x flags %d %s\n",
 				evt->status, btohs(evt->handle), evt->flags,
 				evt->direction == 0 ? "outgoing" : "incoming");
 
@@ -3650,7 +3650,7 @@ static inline void phys_link_complete_dump(int level, struct frame *frm)
 	evt_physical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d\n", evt->status, evt->handle);
+	printf("status 0x%2.2x phy handle 0x%2.2x\n", evt->status, evt->handle);
 
 	if (evt->status > 0) {
 		p_indent(level, frm);
@@ -3663,7 +3663,7 @@ static inline void disconn_phys_link_complete_dump(int level, struct frame *frm)
 	evt_disconn_physical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d reason 0x%2.2x\n",
+	printf("status 0x%2.2x handle 0x%2.2x reason 0x%2.2x\n",
 				evt->status, evt->handle, evt->reason);
 
 	if (evt->status > 0) {
@@ -3680,7 +3680,7 @@ static inline void phys_link_loss_warning_dump(int level, struct frame *frm)
 	evt_physical_link_loss_warning *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("handle %d reason 0x%2.2x\n", evt->handle, evt->reason);
+	printf("phy handle 0x%2.2x reason 0x%2.2x\n", evt->handle, evt->reason);
 }
 
 static inline void phys_link_handle_dump(int level, struct frame *frm)
@@ -3688,7 +3688,7 @@ static inline void phys_link_handle_dump(int level, struct frame *frm)
 	evt_physical_link_recovery *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("handle %d\n", evt->handle);
+	printf("phy handle 0x%2.2x\n", evt->handle);
 }
 
 static inline void logical_link_complete_dump(int level, struct frame *frm)
@@ -3696,7 +3696,8 @@ static inline void logical_link_complete_dump(int level, struct frame *frm)
 	evt_logical_link_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x log_handle %d handle %d tx_flow_id %d\n",
+	printf("status 0x%2.2x log handle 0x%4.4x phy handle 0x%2.2x"
+							" tx_flow_id %d\n",
 			evt->status, btohs(evt->log_handle), evt->handle,
 			evt->tx_flow_id);
 
@@ -3711,7 +3712,8 @@ static inline void flow_spec_modify_dump(int level, struct frame *frm)
 	evt_flow_spec_modify_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle %d\n", evt->status, btohs(evt->handle));
+	printf("status 0x%2.2x handle 0x%4.4x\n",
+					evt->status, btohs(evt->handle));
 
 	if (evt->status > 0) {
 		p_indent(level, frm);
-- 
1.7.9.5


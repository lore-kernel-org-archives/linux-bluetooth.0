Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 hcidump 2/2] l2cap: clean l2cap chan create/move dump
Date: Fri, 17 Aug 2012 16:46:19 +0300
Message-Id: <1345211179-3761-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345211179-3761-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342782918-4224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345211179-3761-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Print psm as hex, add "chan" to create, move req/rsp.
---
 parser/l2cap.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 8dc825b..45968e8 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -972,7 +972,8 @@ static inline void create_req(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Create req: psm %d scid 0x%4.4x id %d\n", psm, scid, h->id);
+	printf("Create chan req: psm 0x%4.4x scid 0x%4.4x ctrl id %d\n",
+							psm, scid, h->id);
 }
 
 static inline void create_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
@@ -986,7 +987,8 @@ static inline void create_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Create rsp: dcid 0x%4.4x scid 0x%4.4x result %d status %d\n", dcid, scid, result, status);
+	printf("Create chan rsp: dcid 0x%4.4x scid 0x%4.4x result %d status %d\n",
+						dcid, scid, result, status);
 }
 
 static inline void move_req(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
@@ -997,7 +999,7 @@ static inline void move_req(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Move req: icid 0x%4.4x id %d\n", icid, h->id);
+	printf("Move chan req: icid 0x%4.4x ctrl id %d\n", icid, h->id);
 }
 
 static inline void move_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
@@ -1009,7 +1011,7 @@ static inline void move_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Move rsp: icid 0x%4.4x result %d\n", icid, result);
+	printf("Move chan rsp: icid 0x%4.4x result %d\n", icid, result);
 }
 
 static inline void move_cfm(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
@@ -1021,7 +1023,7 @@ static inline void move_cfm(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Move cfm: icid 0x%4.4x result %d\n", icid, result);
+	printf("Move chan cfm: icid 0x%4.4x result %d\n", icid, result);
 }
 
 static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
@@ -1032,7 +1034,7 @@ static inline void move_cfm_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm
 	if (p_filter(FILT_L2CAP))
 		return;
 
-	printf("Move cfm rsp: icid 0x%4.4x\n", icid);
+	printf("Move chan cfm rsp: icid 0x%4.4x\n", icid);
 }
 
 static inline void a2mp_command_rej(int level, struct frame *frm)
-- 
1.7.9.5


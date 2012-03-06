Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v5 5/5] Minor indentation cleanup and fix display of physical link key
Date: Mon,  5 Mar 2012 16:35:51 -0800
Message-Id: <1330994151-488-6-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
References: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index a0e3034..e459e9e 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1124,12 +1124,11 @@ static inline void create_physical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-
 	printf("handle %d key length %d key type %d\n",
 		cp->handle, cp->key_length, cp->key_type);
+	p_indent(level, frm);
 	printf("key ");
-
-	for (i = 0; i < cp->key_length && cp->key_length < 32; i++)
+	for (i = 0; i < cp->key_length && cp->key_length <= 32; i++)
 		printf("%2.2x", cp->key[i]);
 	printf("\n");
 }
@@ -1140,12 +1139,16 @@ static inline void create_logical_link_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-
 	printf("handle %d\n", cp->handle);
+
+	p_indent(level, frm);
 	printf("tx_flow ");
 	for (i = 0; i < 16; i++)
 		printf("%2.2x", cp->tx_flow[i]);
-	printf("\nrx_flow ");
+	printf("\n");
+
+	p_indent(level, frm);
+	printf("rx_flow ");
 	for (i = 0; i < 16; i++)
 		printf("%2.2x", cp->rx_flow[i]);
 	printf("\n");
@@ -2605,6 +2608,8 @@ static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(rp->status));
 	} else {
+		p_indent(level, frm);
+		printf("assoc data");
 		for (i = 0; i < len; i++) {
 			if (!(i % 16)) {
 				printf("\n");
-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

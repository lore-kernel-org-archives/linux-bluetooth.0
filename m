Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 hcidump 4/4] amp: Add decoding AMP Assoc data in HCI parser
Date: Thu, 28 Jun 2012 16:09:22 +0300
Message-Id: <1340888962-18959-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340888962-18959-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338887361-11585-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340888962-18959-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/hci.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 984b554..5b837e9 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -36,6 +36,7 @@
 #include "parser/parser.h"
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
+#include "lib/amp.h"
 
 static uint16_t manufacturer = DEFAULT_COMPID;
 
@@ -2599,7 +2600,6 @@ static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
 {
 	read_local_amp_assoc_rp *rp = frm->ptr;
 	uint16_t len = btohs(rp->length);
-	int i;
 
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle 0x%2.2x remaining len %d\n",
@@ -2608,16 +2608,7 @@ static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(rp->status));
 	} else {
-		p_indent(level, frm);
-		printf("assoc data");
-		for (i = 0; i < len; i++) {
-			if (!(i % 16)) {
-				printf("\n");
-				p_indent(level, frm);
-			}
-			printf("%2.2x ", rp->fragment[i]);
-		}
-		printf("\n");
+		amp_assoc_dump(level + 1, rp->fragment, len);
 	}
 }
 
-- 
1.7.9.5


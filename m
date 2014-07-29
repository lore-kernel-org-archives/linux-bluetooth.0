Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 09/12] tools: Fix memory leak
Date: Tue, 29 Jul 2014 17:20:58 +0300
Message-Id: <1406643661-29323-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

lmpver and hciver are allocated through malloc and need to be freed.
---
 tools/parser/hci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 351f843..1a639af 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -2445,17 +2445,25 @@ static inline void read_local_version_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(rp->status));
 	} else {
+		char *lmpver = lmp_vertostr(rp->lmp_ver);
+		char *hciver = hci_vertostr(rp->hci_ver);
+
 		p_indent(level, frm);
 		printf("HCI Version: %s (0x%x) HCI Revision: 0x%x\n",
-					hci_vertostr(rp->hci_ver),
+					hciver ? hciver : "n/a",
 					rp->hci_ver, btohs(rp->hci_rev));
 		p_indent(level, frm);
 		printf("LMP Version: %s (0x%x) LMP Subversion: 0x%x\n",
-					lmp_vertostr(rp->lmp_ver),
+					lmpver ? lmpver : "n/a",
 					rp->lmp_ver, btohs(rp->lmp_subver));
 		p_indent(level, frm);
 		printf("Manufacturer: %s (%d)\n",
 				bt_compidtostr(manufacturer), manufacturer);
+
+		if (lmpver)
+			bt_free(lmpver);
+		if (hciver)
+			bt_free(hciver);
 	}
 }
 
@@ -3178,13 +3186,18 @@ static inline void read_remote_version_complete_dump(int level, struct frame *fr
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(evt->status));
 	} else {
+		char *lmpver = lmp_vertostr(evt->lmp_ver);
+
 		p_indent(level, frm);
 		printf("LMP Version: %s (0x%x) LMP Subversion: 0x%x\n",
-			lmp_vertostr(evt->lmp_ver), evt->lmp_ver,
+			lmpver ? lmpver : "n/a", evt->lmp_ver,
 			btohs(evt->lmp_subver));
 		p_indent(level, frm);
 		printf("Manufacturer: %s (%d)\n",
 			bt_compidtostr(manufacturer), manufacturer);
+
+		if (lmpver)
+			bt_free(lmpver);
 	}
 }
 
-- 
1.9.1


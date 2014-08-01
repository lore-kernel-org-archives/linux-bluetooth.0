Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 1/3] tools: Fix memory leak
Date: Fri,  1 Aug 2014 14:18:48 +0300
Message-Id: <1406891930-32361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20140801103830.GC24358@t440s.P-661HNU-F1>
References: <20140801103830.GC24358@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

lmpver and hciver are allocated through malloc and need to be freed.
---
 tools/parser/hci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 351f843..cd52cb5 100644
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
+			free(lmpver);
+		if (hciver)
+			free(hciver);
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
+			free(lmpver);
 	}
 }
 
-- 
1.9.1


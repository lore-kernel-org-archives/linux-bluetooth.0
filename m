Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Message-Id: <20151210192637.B48CC26026A@galant.ogmig.net>
Date: Thu, 10 Dec 2015 19:26:37 +0000 (GMT)
From: plunky@ogmig.net (Iain Hibbert)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 9a8d226f5136b01a3979bb29756f98cd306f2a79 Mon Sep 17 00:00:00 2001
From: Iain Hibbert <plunky@netbsd.org>
Date: Sat, 10 Jan 2015 08:15:45 +0000
Subject: [PATCH] use free()/bt_free() consistently

the bluetooth library has functions bt_malloc() and bt_free() which
are simple wrappers around malloc()/free() but they are used inconsistently,
fix this by using free() instead of bt_free() where the library uses
malloc() instead of bt_malloc()
---
 tools/ciptool.c    |  4 ++--
 tools/hciconfig.c  |  6 +++---
 tools/hcitool.c    | 12 ++++++------
 tools/parser/lmp.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/ciptool.c b/tools/ciptool.c
index e60493d..bd4cbca 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -251,7 +251,7 @@ static void cmd_search(int ctl, bdaddr_t *bdaddr, int argc, char **argv)
 			if (!get_psm(&src, &dst, &psm))
 				continue;
 
-			bt_free(info);
+			free(info);
 
 			printf("\tConnecting to device %s\n", addr);
 			do_connect(ctl, dev_id, &src, &dst, psm, 0);
@@ -259,7 +259,7 @@ static void cmd_search(int ctl, bdaddr_t *bdaddr, int argc, char **argv)
 		}
 	}
 
-	bt_free(info);
+	free(info);
 	fprintf(stderr, "\tNo devices in range or visible\n");
 	exit(1);
 }
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 9029f7d..f8d0238 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -88,7 +88,7 @@ static void print_pkt_type(struct hci_dev_info *di)
 	char *str;
 	str = hci_ptypetostr(di->pkt_type);
 	printf("\tPacket type: %s\n", str);
-	bt_free(str);
+	free(str);
 }
 
 static void print_link_policy(struct hci_dev_info *di)
@@ -1166,9 +1166,9 @@ static void cmd_version(int ctl, int hdev, char *opt)
 		bt_compidtostr(ver.manufacturer), ver.manufacturer);
 
 	if (hciver)
-		bt_free(hciver);
+		free(hciver);
 	if (lmpver)
-		bt_free(lmpver);
+		free(lmpver);
 
 	hci_close_dev(dd);
 }
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 02c4ebe..be649d1 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -547,7 +547,7 @@ static void cmd_inq(int dev_id, int argc, char **argv)
 			(info+i)->dev_class[0]);
 	}
 
-	bt_free(info);
+	free(info);
 }
 
 /* Device scanning */
@@ -775,7 +775,7 @@ static void cmd_scan(int dev_id, int argc, char **argv)
 					ver ? ver : "n/a",
 					version.lmp_ver, version.lmp_subver);
 				if (ver)
-					bt_free(ver);
+					free(ver);
 			}
 
 			if (hci_read_remote_features(dd, handle, features, 20000) == 0) {
@@ -799,7 +799,7 @@ static void cmd_scan(int dev_id, int argc, char **argv)
 		printf("\n");
 	}
 
-	bt_free(info);
+	free(info);
 
 	hci_close_dev(dd);
 }
@@ -957,7 +957,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 			bt_compidtostr(version.manufacturer),
 			version.manufacturer);
 		if (ver)
-			bt_free(ver);
+			free(ver);
 	}
 
 	memset(features, 0, sizeof(features));
@@ -1840,7 +1840,7 @@ static void cmd_lp(int dev_id, int argc, char **argv)
 		str = hci_lptostr(policy);
 		if (str) {
 			printf("Link policy settings: %s\n", str);
-			bt_free(str);
+			free(str);
 		} else {
 			fprintf(stderr, "Invalig settings\n");
 			exit(1);
@@ -2669,7 +2669,7 @@ static void cmd_leinfo(int dev_id, int argc, char **argv)
 			bt_compidtostr(version.manufacturer),
 			version.manufacturer);
 		if (ver)
-			bt_free(ver);
+			free(ver);
 	}
 
 	memset(features, 0, sizeof(features));
diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index 3d2772c..9d99ee4 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -685,7 +685,7 @@ static inline void version_dump(int level, struct frame *frm)
 	p_indent(level, frm);
 	tmp = lmp_vertostr(ver);
 	printf("VersNr %d (%s)\n", ver, tmp);
-	bt_free(tmp);
+	free(tmp);
 
 	p_indent(level, frm);
 	printf("CompId %d (%s)\n", compid, bt_compidtostr(compid));
-- 
2.2.0


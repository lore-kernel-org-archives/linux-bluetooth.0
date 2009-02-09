Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Fix memory leaks
Date: Mon,  9 Feb 2009 21:50:56 -0200
Message-Id: <1234223456-30790-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some printfs was using as parameter functions that return dinamic
allocated memory. Now, we free them!

---
 tools/hciconfig.c |   15 ++++++++++++---
 tools/hcitool.c   |    6 ++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 960f450..a89aed1 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -85,7 +85,10 @@ static void print_dev_list(int ctl, int flags)
 
 static void print_pkt_type(struct hci_dev_info *di)
 {
-	printf("\tPacket type: %s\n", hci_ptypetostr(di->pkt_type));
+	char *str;
+	str = hci_ptypetostr(di->pkt_type);
+	printf("\tPacket type: %s\n", str);
+	bt_free(str);
 }
 
 static void print_link_policy(struct hci_dev_info *di)
@@ -95,7 +98,10 @@ static void print_link_policy(struct hci_dev_info *di)
 
 static void print_link_mode(struct hci_dev_info *di)
 {
-	printf("\tLink mode: %s\n", hci_lmtostr(di->link_mode));
+	char *str;
+	str =  hci_lmtostr(di->link_mode);
+	printf("\tLink mode: %s\n", str);
+	bt_free(str);
 }
 
 static void print_dev_features(struct hci_dev_info *di, int format)
@@ -1586,10 +1592,13 @@ static void print_dev_hdr(struct hci_dev_info *di)
 static void print_dev_info(int ctl, struct hci_dev_info *di)
 {
 	struct hci_dev_stats *st = &di->stat;
+	char *str;
 
 	print_dev_hdr(di);
 
-	printf("\t%s\n", hci_dflagstostr(di->flags) );
+	str = hci_dflagstostr(di->flags);
+	printf("\t%s\n", str);
+	bt_free(str);
 
 	printf("\tRX bytes:%d acl:%d sco:%d events:%d errors:%d\n",
 		st->byte_rx, st->acl_rx, st->sco_rx, st->evt_rx, st->err_rx);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index e24bde9..faf4cb4 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -102,11 +102,13 @@ static int conn_list(int s, int dev_id, long arg)
 
 	for (i = 0; i < cl->conn_num; i++, ci++) {
 		char addr[18];
+		char *str;
 		ba2str(&ci->bdaddr, addr);
+		str = hci_lmtostr(ci->link_mode);
 		printf("\t%s %s %s handle %d state %d lm %s\n",
 			ci->out ? "<" : ">", type2str(ci->type),
-			addr, ci->handle, ci->state,
-			hci_lmtostr(ci->link_mode));
+			addr, ci->handle, ci->state, str);
+		bt_free(str);
 	}
 
 	return 0;
-- 
1.6.0.6


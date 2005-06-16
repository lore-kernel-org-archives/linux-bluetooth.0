Return-Path: <lcapitulino@conectiva.com.br>
Message-ID: <42B1DE9B.5020607@conectiva.com.br>
Date: Thu, 16 Jun 2005 17:18:35 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Subject: [PATCH] - Fixes hcitool error code on memory allocations.
Content-Type: multipart/mixed;
 boundary="------------010006040800060006020403"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010006040800060006020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

This patch adds proper error code and message for memory allocations
errors in hcitool program.

Comments are welcome.

tools/hcitool.c |   72 +++++++++++++++++++++++++++++++++++++-------------------
1 files changed, 48 insertions(+), 24 deletions(-)

-- 
Luiz Fernando N. Capitulino

--------------010006040800060006020403
Content-Type: text/x-patch;
 name="hcitool_malloc_audit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcitool_malloc_audit.patch"

 tools/hcitool.c |   72 +++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 48 insertions(+), 24 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/tools/hcitool.c a~/tools/hcitool.c
--- a/tools/hcitool.c	2005-05-09 15:33:24.000000000 -0300
+++ a~/tools/hcitool.c	2005-06-12 20:30:11.000000000 -0300
@@ -1030,8 +1030,10 @@ static void cmd_dc(int dev_id, int argc,
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1165,8 +1167,10 @@ static void cmd_rssi(int dev_id, int arg
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1236,8 +1240,10 @@ static void cmd_lq(int dev_id, int argc,
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1309,8 +1315,10 @@ static void cmd_tpl(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1382,8 +1390,10 @@ static void cmd_afh(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1465,8 +1475,10 @@ static void cmd_cpt(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1546,8 +1558,10 @@ static void cmd_lst(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1631,8 +1645,10 @@ static void cmd_auth(int dev_id, int arg
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1700,8 +1716,10 @@ static void cmd_enc(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1770,8 +1788,10 @@ static void cmd_key(int dev_id, int argc
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1839,8 +1859,10 @@ static void cmd_clkoff(int dev_id, int a
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
@@ -1912,8 +1934,10 @@ static void cmd_clock(int dev_id, int ar
 	}
 
 	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr)
-		return;
+	if (!cr) {
+		perror("Can't allocate memory");
+		exit(1);
+	}
 
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;

--------------010006040800060006020403--

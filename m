Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Change fprintf(stderr,...) to perror()
Date: Sun, 15 Feb 2009 16:47:23 -0300
Message-Id: <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clean up code. Now hcitool use only perror to show errors messages
without  parameters.
---
 tools/hcitool.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 4793c46..9687ab2 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -797,7 +797,7 @@ static void cmd_name(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_get_route(&bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Device is not available.\n");
+			perror("Device is not available.");
 			exit(1);
 		}
 	}
@@ -860,7 +860,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 		dev_id = hci_get_route(&bdaddr);
 
 	if (dev_id < 0) {
-		fprintf(stderr, "Device is not available or not connected.\n");
+		perror("Device is not available or not connected.");
 		exit(1);
 	}
 
@@ -1231,7 +1231,7 @@ static void cmd_cc(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_get_route(&bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Device is not available.\n");
+			perror("Device is not available.");
 			exit(1);
 		}
 	}
@@ -1288,7 +1288,7 @@ static void cmd_dc(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1369,7 +1369,7 @@ static void cmd_sr(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1426,7 +1426,7 @@ static void cmd_rssi(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1500,7 +1500,7 @@ static void cmd_lq(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1576,7 +1576,7 @@ static void cmd_tpl(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1652,7 +1652,7 @@ static void cmd_afh(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1739,7 +1739,7 @@ static void cmd_cpt(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1823,7 +1823,7 @@ static void cmd_lp(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -1861,13 +1861,13 @@ static void cmd_lp(int dev_id, int argc, char **argv)
 			printf("Link policy settings: %s\n", str);
 			bt_free(str);
 		} else {
-			fprintf(stderr, "Can't allocate memory\n");
+			perror("Can't allocate memory");
 			exit(1);
 		}
 	} else {
 		unsigned int val;
 		if (hci_strtolp(argv[1], &val) < 0) {
-			fprintf(stderr, "Invalig arguments\n");
+			perror("Invalig arguments");
 			exit(1);
 		}
 		policy = val;
@@ -1922,7 +1922,7 @@ static void cmd_lst(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -2012,7 +2012,7 @@ static void cmd_auth(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -2084,7 +2084,7 @@ static void cmd_enc(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -2157,7 +2157,7 @@ static void cmd_key(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
@@ -2229,7 +2229,7 @@ static void cmd_clkoff(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror( "Not connected.");
 			exit(1);
 		}
 	}
@@ -2306,7 +2306,7 @@ static void cmd_clock(int dev_id, int argc, char **argv)
 	if (dev_id < 0) {
 		dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 		if (dev_id < 0) {
-			fprintf(stderr, "Not connected.\n");
+			perror("Not connected.");
 			exit(1);
 		}
 	}
-- 
1.6.0.6


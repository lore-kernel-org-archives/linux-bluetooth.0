Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] hcitool: Fix memory leak in cmd_info
Date: Fri,  7 Feb 2014 19:28:41 -0300
Message-Id: <1391812125-19594-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Free memory pointed by cr variable after it is used.
---
 tools/hcitool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 8a92067..c2df8e3 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -961,6 +961,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 					htobs(di.pkt_type & ACL_PTYPE_MASK),
 					0, 0x01, &handle, 25000) < 0) {
 			perror("Can't create connection");
+			free(cr);
 			close(dd);
 			exit(1);
 		}
@@ -969,6 +970,8 @@ static void cmd_info(int dev_id, int argc, char **argv)
 	} else
 		handle = htobs(cr->conn_info->handle);
 
+	free(cr);
+
 	printf("\tBD Address:  %s\n", argv[0]);
 
 	comp = batocomp(&bdaddr);
-- 
1.8.5.3


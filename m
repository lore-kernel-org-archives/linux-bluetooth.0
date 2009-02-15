Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Fix more memory leaks in hcitool
Date: Sun, 15 Feb 2009 16:47:21 -0300
Message-Id: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Free some mallocs.
---
 tools/hcitool.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index faf4cb4..3ba9234 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -110,6 +110,7 @@ static int conn_list(int s, int dev_id, long arg)
 			addr, ci->handle, ci->state, str);
 		bt_free(str);
 	}
+	bt_free(cl);
 
 	return 0;
 }
@@ -134,9 +135,12 @@ static int find_conn(int s, int dev_id, long arg)
 	}
 
 	for (i = 0; i < cl->conn_num; i++, ci++)
-		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
+		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr)) {
+			bt_free(cl);
 			return 1;
+		}
 
+	bt_free(cl);
 	return 0;
 }
 
@@ -894,6 +898,7 @@ static void cmd_info(int dev_id, int argc, char **argv)
 		cc = 1;
 	} else
 		handle = htobs(cr->conn_info->handle);
+	bt_free(cr);
 
 	printf("\tBD Address:  %s\n", argv[0]);
 
-- 
1.6.0.6


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] hcidump: Fix memory leak
Date: Fri,  7 Feb 2014 19:28:42 -0300
Message-Id: <1391812125-19594-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Memory pointed by frm.data variable was not freed in both failure and
success flows.
---
 tools/hcidump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 50123d2..2bbc207 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -309,7 +309,7 @@ static void read_dump(int fd)
 		if (err < 0)
 			goto failed;
 		if (!err)
-			return;
+			goto done;
 
 		if (parser.flags & DUMP_PKTLOG) {
 			switch (ph.type) {
@@ -407,7 +407,7 @@ static void read_dump(int fd)
 		if (err < 0)
 			goto failed;
 		if (!err)
-			return;
+			goto done;
 
 		frm.ptr = frm.data;
 		frm.len = frm.data_len;
@@ -432,8 +432,13 @@ static void read_dump(int fd)
 		parse(&frm);
 	}
 
+done:
+	free(frm.data);
+	return;
+
 failed:
 	perror("Read failed");
+	free(frm.data);
 	exit(1);
 }
 
-- 
1.8.5.3


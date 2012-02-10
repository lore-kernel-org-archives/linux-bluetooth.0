Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 22/22] hciemu: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:07 -0300
Message-Id: <1328910007-25604-23-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/hciemu.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 7eb8814..ac44aa8 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -388,8 +388,11 @@ static void num_completed_pkts(struct vhci_conn *conn)
 	np = (void *) ptr; ptr += EVT_NUM_COMP_PKTS_SIZE;
 	np->num_hndl = 1;
 
-	*((uint16_t *) ptr) = htobs(conn->handle); ptr += 2;
-	*((uint16_t *) ptr) = htobs(vdev.acl_cnt); ptr += 2;
+	bt_put_le16(conn->handle, ptr);
+	ptr += 2;
+
+	bt_put_le16(vdev.acl_cnt, ptr);
+	ptr += 2;
 
 	write_snoop(vdev.dd, HCI_EVENT_PKT, 1, buf, ptr - buf);
 
@@ -1009,7 +1012,7 @@ static int getbdaddrbyname(char *str, bdaddr_t *ba)
 		bdaddr_t b;
 
 		memcpy(&b, &addr, 4);
-		*(uint16_t *) (&b.b[4]) = htons(atoi(str));
+		bt_put_be16(atoi(str), &b.b[4]);
 		baswap(ba, &b);
 
 		return 0;
-- 
1.7.8.1


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 15/15] hciemu: Fix build errors due to unaligned memory access
Date: Fri, 31 Aug 2012 10:36:25 +0200
Message-ID: <1346402185-9487-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors on ARM.

  CC     test/hciemu.o
test/hciemu.c: In function num_completed_pkts:
test/hciemu.c:429:4: error: cast increases required alignment of target
	 type [-Werror=cast-align]
test/hciemu.c:430:4: error: cast increases required alignment of target
	type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [test/hciemu.o] Error 1
make: *** [all] Error 2

Change-Id: Ica73d897065bf1116ee8a7052c169a1a3ba25ff7
---
 test/hciemu.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 4c62223..8e31dbb 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -426,8 +426,10 @@ static void num_completed_pkts(struct vhci_conn *conn)
 	np = (void *) ptr; ptr += EVT_NUM_COMP_PKTS_SIZE;
 	np->num_hndl = 1;
 
-	*((uint16_t *) ptr) = htobs(conn->handle); ptr += 2;
-	*((uint16_t *) ptr) = htobs(vdev.acl_cnt); ptr += 2;
+	bt_put_be16(conn->handle, ptr);
+	ptr += 2;
+	bt_put_be16(vdev.acl_cnt, ptr);
+	ptr += 2;
 
 	write_snoop(vdev.dd, HCI_EVENT_PKT, 1, buf, ptr - buf);
 
-- 
1.7.9.5


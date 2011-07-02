Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 2 Jul 2011 13:44:56 -0400
Subject: [PATCH] Add NULL packet stat to hciconfig
Message-ID: <1309628696.22449.13.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.h         |    1 +
 tools/hciconfig.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 51184ee..7f4812d 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2284,6 +2284,7 @@ struct hci_filter {
 
 /* Ioctl requests structures */
 struct hci_dev_stats {
+	uint32_t null_rx;	/* # NULL pkts recvd */
 	uint32_t err_rx;
 	uint32_t err_tx;
 	uint32_t cmd_tx;
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index cbd0d0e..cb65c06 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1863,8 +1863,9 @@ static void print_dev_info(int ctl, struct hci_dev_info *di)
 	printf("\t%s\n", str);
 	bt_free(str);
 
-	printf("\tRX bytes:%d acl:%d sco:%d events:%d errors:%d\n",
-		st->byte_rx, st->acl_rx, st->sco_rx, st->evt_rx, st->err_rx);
+	printf("\tRX bytes:%d acl:%d sco:%d events:%d errors:%d nulls:%d\n",
+		st->byte_rx, st->acl_rx, st->sco_rx, st->evt_rx, st->err_rx,
+		st->null_rx);
 
 	printf("\tTX bytes:%d acl:%d sco:%d commands:%d errors:%d\n",
 		st->byte_tx, st->acl_tx, st->sco_tx, st->cmd_tx, st->err_tx);
-- 
1.7.4.1


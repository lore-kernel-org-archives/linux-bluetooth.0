Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/2] Use hciops functions instead of HCI raw sockets
Date: Tue, 21 Sep 2010 22:22:26 -0300
Message-Id: <1285118546-29558-2-git-send-email-epx@signove.com>
In-Reply-To: <1285118546-29558-1-git-send-email-epx@signove.com>
References: <1285118546-29558-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |   84 +++++++++++++++------------------------------------
 1 files changed, 25 insertions(+), 59 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 670260b..954a9b8 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -32,8 +32,9 @@
 #include <time.h>
 #include <stdlib.h>
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/hci.h>
-#include <bluetooth/hci_lib.h>
+#include <bluetooth/l2cap.h>
+#include "../src/adapter.h"
+#include "../src/manager.h"
 #include <sys/ioctl.h>
 
 #include "config.h"
@@ -60,8 +61,6 @@ struct mcap_csp {
 	guint		ind_timer;	/* CSP-Slave: indication timer */
 	guint		set_timer;	/* CSP-Slave: delayed set timer */
 	void		*set_data;	/* CSP-Slave: delayed set data */
-	gint		dev_id;		/* CSP-Slave: device ID */
-	gint		dev_hci_fd;	/* CSP-Slave fd to read BT clock */
 	void		*csp_priv_data;	/* CSP-Master: In-flight request data */
 };
 
@@ -173,8 +172,6 @@ void mcap_sync_init(struct mcap_mcl *mcl)
 
 	mcl->csp->rem_req_acc = 10000; /* safe divisor */
 	mcl->csp->set_data = NULL;
-	mcl->csp->dev_id = -1;
-	mcl->csp->dev_hci_fd = -1;
 	mcl->csp->csp_priv_data = NULL;
 
 	reset_tmstamp(mcl->csp, NULL, 0);
@@ -185,9 +182,6 @@ void mcap_sync_stop(struct mcap_mcl *mcl)
 	if (!mcl->csp)
 		return;
 
-	if (mcl->csp->dev_hci_fd > -1)
-		hci_close_dev(mcl->csp->dev_hci_fd);
-
 	if (mcl->csp->ind_timer)
 		g_source_remove(mcl->csp->ind_timer);
 
@@ -200,7 +194,6 @@ void mcap_sync_stop(struct mcap_mcl *mcl)
 	if (mcl->csp->csp_priv_data)
 		g_free(mcl->csp->csp_priv_data);
 
-	mcl->csp->dev_hci_fd = -1;
 	mcl->csp->ind_timer = 0;
 	mcl->csp->set_timer = 0;
 	mcl->csp->set_data = NULL;
@@ -247,54 +240,23 @@ static gboolean valid_btclock(uint32_t btclk)
 	return btclk <= MCAP_BTCLOCK_MAX;
 }
 
-static int mcl_hci_fd(struct mcap_mcl *mcl)
-{
-	if (mcl->csp->dev_hci_fd < 0) {
-		if (mcl->csp->dev_id < 0)
-			mcl->csp->dev_id = hci_get_route(&mcl->addr);
-		mcl->csp->dev_hci_fd = hci_open_dev(mcl->csp->dev_id);
-	}
-	return mcl->csp->dev_hci_fd;
-}
-
-static void mcl_hci_fd_close(struct mcap_mcl *mcl)
-{
-	hci_close_dev(mcl->csp->dev_hci_fd);
-	mcl->csp->dev_hci_fd = -1;
-}
-
 /* This call may fail; either deal with retry or use read_btclock_retry */
 static gboolean read_btclock(struct mcap_mcl *mcl, uint32_t *btclock,
 							uint16_t *btaccuracy)
 {
-	int fd, ret, handle, which;
-	struct hci_conn_info_req *cr;
-
-	if (mcl) {
-		which = 1;
-		fd = mcl_hci_fd(mcl);
-
-		cr = g_malloc0(sizeof(*cr) + sizeof(struct hci_conn_info));
-		bacpy(&cr->bdaddr, &mcl->addr);
-		cr->type = ACL_LINK;
+	int ret, handle, which = 1;
+	struct btd_adapter *adapter;
 
-		ret = ioctl(fd, HCIGETCONNINFO, (unsigned long) cr);
-		g_free(cr);
+	adapter = manager_find_adapter(&mcl->ms->src);
 
-		if (ret < 0)
-			return FALSE;
-		else
-			handle = htobs(cr->conn_info->handle);
-	} else {
-		fd = hci_open_dev(hci_get_route(NULL));
-		which = 0;
-		handle = 0;
-	}
+	if (!adapter)
+		return FALSE;
 
-	ret = hci_read_clock(fd, handle, which, btclock, btaccuracy, 1000);
+	if (btd_adapter_get_conn_handle(adapter, &mcl->addr, &handle))
+		return FALSE;
 
-	if (!mcl)
-		hci_close_dev(fd);
+	ret = btd_adapter_read_clock(adapter, handle, which, 1000, btclock,
+								btaccuracy);
 
 	return ret < 0 ? FALSE : TRUE;
 }
@@ -315,15 +277,19 @@ static gboolean read_btclock_retry(struct mcap_mcl *mcl, uint32_t *btclock,
 
 static gboolean get_btrole(struct mcap_mcl *mcl)
 {
-	int fd = mcl_hci_fd(mcl);
-	struct hci_dev_info di = { dev_id: mcl->csp->dev_id };
+	int sock, flags;
+	socklen_t len;
 
-	if (ioctl(fd, HCIGETDEVINFO, (void *) &di)) {
-		mcl_hci_fd_close(mcl);
-		return FALSE;
-        }
+	if (mcl->cc == NULL)
+		return -1;
+
+	sock = g_io_channel_unix_get_fd(mcl->cc);
+	len = sizeof(flags);
+
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, &len))
+		DBG("CSP: could not read role");
 
-	return di.link_mode == HCI_LM_MASTER;
+	return flags & L2CAP_LM_MASTER;
 }
 
 uint64_t mcap_get_timestamp(struct mcap_mcl *mcl,
-- 
1.7.0.4


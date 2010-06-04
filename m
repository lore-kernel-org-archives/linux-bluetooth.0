Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 25/26] Initial support for clock synchronization protocol
Date: Fri,  4 Jun 2010 10:27:18 +0200
Message-Id: <1275640039-7245-26-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-25-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
 <1275640039-7245-9-git-send-email-sancane@gmail.com>
 <1275640039-7245-10-git-send-email-sancane@gmail.com>
 <1275640039-7245-11-git-send-email-sancane@gmail.com>
 <1275640039-7245-12-git-send-email-sancane@gmail.com>
 <1275640039-7245-13-git-send-email-sancane@gmail.com>
 <1275640039-7245-14-git-send-email-sancane@gmail.com>
 <1275640039-7245-15-git-send-email-sancane@gmail.com>
 <1275640039-7245-16-git-send-email-sancane@gmail.com>
 <1275640039-7245-17-git-send-email-sancane@gmail.com>
 <1275640039-7245-18-git-send-email-sancane@gmail.com>
 <1275640039-7245-19-git-send-email-sancane@gmail.com>
 <1275640039-7245-20-git-send-email-sancane@gmail.com>
 <1275640039-7245-21-git-send-email-sancane@gmail.com>
 <1275640039-7245-22-git-send-email-sancane@gmail.com>
 <1275640039-7245-23-git-send-email-sancane@gmail.com>
 <1275640039-7245-24-git-send-email-sancane@gmail.com>
 <1275640039-7245-25-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    4 +-
 mcap/mcap.c |    3 +-
 mcap/sync.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)
 create mode 100644 mcap/sync.c

diff --git a/Makefile.am b/Makefile.am
index 93566b6..f96d556 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -170,8 +170,8 @@ builtin_sources += plugins/service.c
 endif
 
 if MCAP
-mcap_sources += mcap/mcap_internal.h	\
-		mcap/mcap_lib.h		\
+mcap_sources += mcap/mcap_internal.h \
+		mcap/mcap_lib.h	mcap/sync.c \
 		mcap/mcap.h mcap/mcap.c
 endif
 
diff --git a/mcap/mcap.c b/mcap/mcap.c
index 656b254..d907eca 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1511,8 +1511,7 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) &&
 					(cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
-		send4B_cmd(mcl, cmd[0], MCAP_REQUEST_NOT_SUPPORTED,
-							MCAP_MDLID_RESERVED);
+		proc_sync_cmd(mcl, cmd, len);
 		return;
 	}
 
diff --git a/mcap/sync.c b/mcap/sync.c
new file mode 100644
index 0000000..76f1377
--- /dev/null
+++ b/mcap/sync.c
@@ -0,0 +1,85 @@
+/*
+ *
+ *  MCAP for BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *
+ *  Authors:
+ *  Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <netinet/in.h>
+
+#include "log.h"
+
+#include "mcap.h"
+#include "mcap_lib.h"
+#include "mcap_internal.h"
+
+static int send_unsupported_req(struct mcap_mcl *mcl, uint8_t oc)
+{
+	uint8_t *rsp;
+	mcap4B_rsp *rsp_err;
+	int sent;
+
+
+	rsp = g_malloc0(sizeof(mcap4B_rsp));
+
+	rsp_err = (mcap4B_rsp *)rsp;
+	rsp_err->op = oc;
+	rsp_err->rc = MCAP_REQUEST_NOT_SUPPORTED;
+	rsp_err->mdl = htons (MCAP_MDLID_RESERVED);
+
+	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
+					rsp,
+					sizeof(mcap4B_rsp));
+	g_free(rsp);
+	return sent;
+}
+
+void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	switch (cmd[0]) {
+	case MCAP_MD_SYNC_CAP_REQ:
+		DBG("TODO: received MCAP_MD_SYNC_CAP_REQ: %d",
+							MCAP_MD_SYNC_CAP_REQ);
+		/* Not implemented yet. Reply with unsupported request */
+		send_unsupported_req(mcl, cmd[0]);
+		break;
+	case MCAP_MD_SYNC_CAP_RSP:
+		DBG("TODO: received MCAP_MD_SYNC_CAP_RSP: %d",
+							MCAP_MD_SYNC_CAP_RSP);
+		break;
+	case MCAP_MD_SYNC_SET_REQ:
+		DBG("TODO: received MCAP_MD_SYNC_SET_REQ: %d",
+							MCAP_MD_SYNC_SET_REQ);
+		/* Not implemented yet. Reply with unsupported request */
+		send_unsupported_req(mcl, cmd[0]);
+		break;
+	case MCAP_MD_SYNC_SET_RSP:
+		DBG("TODO: received MCAP_MD_SYNC_SET_RSP: %d",
+							MCAP_MD_SYNC_SET_RSP);
+		break;
+	case MCAP_MD_SYNC_INFO_IND:
+		DBG("TODO: received MCAP_MD_SYNC_INFO_IND :%d",
+							MCAP_MD_SYNC_INFO_IND);
+		break;
+	}
+}
-- 
1.6.3.3


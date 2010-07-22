Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 25/60] Initial support for clock synchronization protocol
Date: Thu, 22 Jul 2010 10:56:18 +0200
Message-Id: <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 Makefile.am |    4 +-
 mcap/mcap.c |    3 +-
 mcap/mcap_sync.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)
 create mode 100644 mcap/mcap_sync.c

diff --git a/Makefile.am b/Makefile.am
index d1e6b0e..87c79a5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -170,8 +170,8 @@ builtin_sources += plugins/service.c
 endif
 
 if MCAP
-mcap_sources += mcap/mcap_internal.h	\
-		mcap/mcap_lib.h		\
+mcap_sources += mcap/mcap_internal.h \
+		mcap/mcap_lib.h	mcap/mcap_sync.c \
 		mcap/mcap.h mcap/mcap.c
 endif
 
diff --git a/mcap/mcap.c b/mcap/mcap.c
index b70545a..a32511e 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1510,8 +1510,7 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) &&
 					(cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
-		send4B_cmd(mcl, cmd[0], MCAP_REQUEST_NOT_SUPPORTED,
-							MCAP_MDLID_RESERVED);
+		proc_sync_cmd(mcl, cmd, len);
 		return;
 	}
 
diff --git a/mcap/mcap_sync.c b/mcap/mcap_sync.c
new file mode 100644
index 0000000..76f1377
--- /dev/null
+++ b/mcap/mcap_sync.c
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


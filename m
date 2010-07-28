Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 16/16] Add initial support for synchronization protocol
Date: Wed, 28 Jul 2010 10:07:33 +0200
Message-Id: <1280304453-9328-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304453-9328-3-git-send-email-sancane@gmail.com>
References: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
 <1280304453-9328-1-git-send-email-sancane@gmail.com>
 <1280304453-9328-2-git-send-email-sancane@gmail.com>
 <1280304453-9328-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am        |    3 +-
 health/mcap.c      |    2 +-
 health/mcap.h      |   38 +++++++++++++++++++++++++++++++
 health/mcap_sync.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 health/mcap_sync.c

diff --git a/Makefile.am b/Makefile.am
index c8bd62a..084879b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -171,7 +171,8 @@ endif
 
 if MCAP
 mcap_sources += health/mcap_lib.h health/mcap_internal.h \
-		health/mcap.h health/mcap.c
+		health/mcap.h health/mcap.c \
+		health/mcap_sync.c
 endif
 
 builtin_modules += hciops
diff --git a/health/mcap.c b/health/mcap.c
index f5f60ee..f00a484 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1513,7 +1513,7 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 
 	if (cmd[0] >= MCAP_MD_SYNC_CAP_REQ &&
 					cmd[0] <= MCAP_MD_SYNC_INFO_IND) {
-		/* TODO: proc_sync_cmd(mcl, cmd, len);*/
+		proc_sync_cmd(mcl, cmd, len);
 		return;
 	}
 
diff --git a/health/mcap.h b/health/mcap.h
index bb05969..9b95473 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -111,6 +111,44 @@ typedef struct {
 	uint16_t        mdl;
 } __attribute__ ((packed)) mcap_rsp;
 
+/*
+ * MCAP Clock Synchronization Protocol
+ */
+typedef struct {
+        uint8_t         op;
+        uint16_t        timest;
+} __attribute__ ((packed)) mcap_md_sync_cap_req;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         rc;
+	uint8_t         btclock;
+        uint16_t        sltime;
+	uint16_t        timestnr;
+	uint16_t        timestna;
+} __attribute__ ((packed)) mcap_md_sync_cap_rsp;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         timestui;
+        uint32_t        btclock;
+	uint64_t        timestst;
+} __attribute__ ((packed)) mcap_md_sync_set_req;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         rc;
+        uint32_t        btclock;
+	uint64_t        timestst;
+	uint16_t        timestsa;
+} __attribute__ ((packed)) mcap_md_sync_set_rsp;
+
+typedef struct {
+        uint8_t         op;
+        uint32_t        btclock;
+	uint64_t        timestst;
+	uint16_t        timestsa;
+} __attribute__ ((packed)) mcap_md_sync_info_ind;
 
 #ifdef __cplusplus
 }
diff --git a/health/mcap_sync.c b/health/mcap_sync.c
new file mode 100644
index 0000000..569a40a
--- /dev/null
+++ b/health/mcap_sync.c
@@ -0,0 +1,62 @@
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
+void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	switch (cmd[0]) {
+	case MCAP_MD_SYNC_CAP_REQ:
+		DBG("TODO: received MCAP_MD_SYNC_CAP_REQ: %d",
+							MCAP_MD_SYNC_CAP_REQ);
+		/* Not implemented yet. Reply with unsupported request */
+		break;
+	case MCAP_MD_SYNC_CAP_RSP:
+		DBG("TODO: received MCAP_MD_SYNC_CAP_RSP: %d",
+							MCAP_MD_SYNC_CAP_RSP);
+		break;
+	case MCAP_MD_SYNC_SET_REQ:
+		DBG("TODO: received MCAP_MD_SYNC_SET_REQ: %d",
+							MCAP_MD_SYNC_SET_REQ);
+		/* Not implemented yet. Reply with unsupported request */
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


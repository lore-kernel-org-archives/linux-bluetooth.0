Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 14/16] Implement mgmt start and stop discovery
Date: Fri, 29 Apr 2011 21:27:30 -0300
Message-Id: <1304123252-14464-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements mgmt_start_discovery and mgmt_stop_discovery
callbacks for mgmtops.
---
 plugins/mgmtops.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index e4eac81..a7a7d67 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1587,14 +1587,34 @@ static int mgmt_set_limited_discoverable(int index, gboolean limited)
 
 static int mgmt_start_discovery(int index)
 {
+	struct mgmt_hdr hdr;
+
 	DBG("index %d", index);
-	return -ENOSYS;
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.opcode = htobs(MGMT_OP_START_DISCOVERY);
+	hdr.index = htobs(index);
+
+	if (write(mgmt_sock, &hdr, sizeof(hdr)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_stop_discovery(int index)
 {
+	struct mgmt_hdr hdr;
+
 	DBG("index %d", index);
-	return -ENOSYS;
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.opcode = htobs(MGMT_OP_STOP_DISCOVERY);
+	hdr.index = htobs(index);
+
+	if (write(mgmt_sock, &hdr, sizeof(hdr)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_start_inquiry(int index, uint8_t length, gboolean periodic)
-- 
1.7.1


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 15/16] Remove inquiry and scanning callbacks from btd_adapter_ops
Date: Fri, 29 Apr 2011 21:27:31 -0300
Message-Id: <1304123252-14464-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discovery procedure is implemented in discovery callbacks
(start_discovery and stop_discovery). We don't need inquiry and
scanning specifics callbacks in btd_adapter_ops anymore.
---
 plugins/hciops.c  |    4 ----
 plugins/mgmtops.c |   48 ------------------------------------------------
 src/adapter.h     |    4 ----
 3 files changed, 0 insertions(+), 56 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c3a28b9..db3ca84 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3812,10 +3812,6 @@ static struct btd_adapter_ops hci_ops = {
 	.set_limited_discoverable = hciops_set_limited_discoverable,
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
-	.start_inquiry = hciops_start_inquiry,
-	.stop_inquiry = hciops_stop_inquiry,
-	.start_scanning = hciops_start_scanning,
-	.stop_scanning = hciops_stop_scanning,
 	.resolve_name = hciops_resolve_name,
 	.cancel_resolve_name = hciops_cancel_resolve_name,
 	.set_name = hciops_set_name,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index a7a7d67..9e1cfac 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1617,50 +1617,6 @@ static int mgmt_stop_discovery(int index)
 	return 0;
 }
 
-static int mgmt_start_inquiry(int index, uint8_t length, gboolean periodic)
-{
-	struct mgmt_hdr hdr;
-
-	DBG("index %d length %u periodic %d", index, length, periodic);
-
-	memset(&hdr, 0, sizeof(hdr));
-	hdr.opcode = htobs(MGMT_OP_START_DISCOVERY);
-	hdr.index = htobs(index);
-
-	if (write(mgmt_sock, &hdr, sizeof(hdr)) < 0)
-		return -errno;
-
-	return 0;
-}
-
-static int mgmt_stop_inquiry(int index)
-{
-	struct mgmt_hdr hdr;
-
-	DBG("index %d", index);
-
-	memset(&hdr, 0, sizeof(hdr));
-	hdr.opcode = htobs(MGMT_OP_STOP_DISCOVERY);
-	hdr.index = htobs(index);
-
-	if (write(mgmt_sock, &hdr, sizeof(hdr)) < 0)
-		return -errno;
-
-	return 0;
-}
-
-static int mgmt_start_scanning(int index, int timeout)
-{
-	DBG("index %d", index);
-	return -ENOSYS;
-}
-
-static int mgmt_stop_scanning(int index)
-{
-	DBG("index %d", index);
-	return -ENOSYS;
-}
-
 static int mgmt_resolve_name(int index, bdaddr_t *bdaddr)
 {
 	char addr[18];
@@ -2057,10 +2013,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_limited_discoverable = mgmt_set_limited_discoverable,
 	.start_discovery = mgmt_start_discovery,
 	.stop_discovery = mgmt_stop_discovery,
-	.start_inquiry = mgmt_start_inquiry,
-	.stop_inquiry = mgmt_stop_inquiry,
-	.start_scanning = mgmt_start_scanning,
-	.stop_scanning = mgmt_stop_scanning,
 	.resolve_name = mgmt_resolve_name,
 	.cancel_resolve_name = mgmt_cancel_resolve_name,
 	.set_name = mgmt_set_name,
diff --git a/src/adapter.h b/src/adapter.h
index 1db9225..4e15c17 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -187,10 +187,6 @@ struct btd_adapter_ops {
 	int (*set_limited_discoverable) (int index, gboolean limited);
 	int (*start_discovery) (int index);
 	int (*stop_discovery) (int index);
-	int (*start_inquiry) (int index, uint8_t length, gboolean periodic);
-	int (*stop_inquiry) (int index);
-	int (*start_scanning) (int index, int timeout);
-	int (*stop_scanning) (int index);
 
 	int (*resolve_name) (int index, bdaddr_t *bdaddr);
 	int (*cancel_resolve_name) (int index, bdaddr_t *bdaddr);
-- 
1.7.1


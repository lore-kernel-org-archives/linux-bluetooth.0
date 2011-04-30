Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 01/16] Add discovery callbacks to btd_adapter_ops
Date: Fri, 29 Apr 2011 21:27:17 -0300
Message-Id: <1304123252-14464-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start_discovery and stop_discovery callbacks to
struct btd_adapter_ops. These callbacks are responsible for starting
and stoping the discovery procedure. It also creates dummy functions
in hciops and mgmtops which implements those callbacks.
---
 plugins/hciops.c  |   14 ++++++++++++++
 plugins/mgmtops.c |   14 ++++++++++++++
 src/adapter.h     |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index d1156e2..14c973f 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3122,6 +3122,18 @@ static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hciops_start_discovery(int index)
+{
+	DBG("index %d", index);
+	return -ENOSYS;
+}
+
+static int hciops_stop_discovery(int index)
+{
+	DBG("index %d", index);
+	return -ENOSYS;
+}
+
 static int hciops_fast_connectable(int index, gboolean enable)
 {
 	struct dev_info *dev = &devs[index];
@@ -3671,6 +3683,8 @@ static struct btd_adapter_ops hci_ops = {
 	.set_discoverable = hciops_set_discoverable,
 	.set_pairable = hciops_set_pairable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
+	.start_discovery = hciops_start_discovery,
+	.stop_discovery = hciops_stop_discovery,
 	.start_inquiry = hciops_start_inquiry,
 	.stop_inquiry = hciops_stop_inquiry,
 	.start_scanning = hciops_start_scanning,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index a8a7ac2..ac180f9 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1588,6 +1588,18 @@ static int mgmt_set_limited_discoverable(int index, gboolean limited)
 	return -ENOSYS;
 }
 
+static int mgmt_start_discovery(int index)
+{
+	DBG("index %d", index);
+	return -ENOSYS;
+}
+
+static int mgmt_stop_discovery(int index)
+{
+	DBG("index %d", index);
+	return -ENOSYS;
+}
+
 static int mgmt_start_inquiry(int index, uint8_t length, gboolean periodic)
 {
 	struct mgmt_hdr hdr;
@@ -2026,6 +2038,8 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_discoverable = mgmt_set_discoverable,
 	.set_pairable = mgmt_set_pairable,
 	.set_limited_discoverable = mgmt_set_limited_discoverable,
+	.start_discovery = mgmt_start_discovery,
+	.stop_discovery = mgmt_stop_discovery,
 	.start_inquiry = mgmt_start_inquiry,
 	.stop_inquiry = mgmt_stop_inquiry,
 	.start_scanning = mgmt_start_scanning,
diff --git a/src/adapter.h b/src/adapter.h
index 7cc7c02..1a5c687 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -187,6 +187,8 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index, gboolean discoverable);
 	int (*set_pairable) (int index, gboolean pairable);
 	int (*set_limited_discoverable) (int index, gboolean limited);
+	int (*start_discovery) (int index);
+	int (*stop_discovery) (int index);
 	int (*start_inquiry) (int index, uint8_t length, gboolean periodic);
 	int (*stop_inquiry) (int index);
 	int (*start_scanning) (int index);
-- 
1.7.1


Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] mgmtops: Handle Start Discovery Complete in case of failure
Date: Mon, 9 Apr 2012 11:17:23 +0530
Message-ID: <1333950443-32114-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of start discovery complete event in cases
when discovery fails to get started.

Change-Id: I214c8deb10fd97a529faeec50d789478aea2f402
---
 plugins/mgmtops.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 612368f..d8518af 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1258,6 +1258,36 @@ static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 		oob_read_local_data_complete(adapter, rp->hash, rp->randomizer);
 }
 
+static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
+				     void *buf, size_t len)
+{
+	uint8_t *type = buf;
+	struct btd_adapter *adapter;
+
+	if (len != sizeof(*type)) {
+		error("start_discovery_complete event size mismatch "
+		      "(%zu != %zu)", len, sizeof(*type));
+		return;
+	}
+
+	if (index > max_index) {
+		error("Unexpected index %u in start_discovery_complete",
+		      index);
+		return;
+	}
+
+	if (!status)
+		return;
+
+	DBG("hci%u type%d status%d", index, *type, status);
+
+	adapter = manager_find_adapter_by_id(index);
+
+	if (adapter)
+		/* Start discovery failed, inform upper layers. */
+		adapter_set_discovering(adapter, FALSE);
+}
+
 static void mgmt_read_rssi_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_rp_read_rssi *rp = buf;
@@ -1546,7 +1576,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		DBG("set_fast_connectable complete");
 		break;
 	case MGMT_OP_START_DISCOVERY:
-		DBG("start_discovery complete");
+		start_discovery_complete(sk, index, ev->status, ev->data, len);
 		break;
 	case MGMT_OP_STOP_DISCOVERY:
 		DBG("stop_discovery complete");
-- 
1.7.0.4


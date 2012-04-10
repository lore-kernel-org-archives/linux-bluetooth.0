Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v3] mgmtops: Handle Start Discovery Complete in case of failure
Date: Tue, 10 Apr 2012 17:18:47 +0530
Message-ID: <1334058527-25520-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of start discovery complete event in cases
when discovery fails to get started.
---
 plugins/mgmtops.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index c08117f..733f1a6 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1255,6 +1255,35 @@ static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 		oob_read_local_data_complete(adapter, rp->hash, rp->randomizer);
 }
 
+static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
+							void *buf, size_t len)
+{
+	uint8_t *type = buf;
+	struct btd_adapter *adapter;
+
+	if (len != sizeof(*type)) {
+		error("start_discovery_complete event size mismatch "
+					"(%zu != %zu)", len, sizeof(*type));
+		return;
+	}
+
+	DBG("hci%u type %u status %u", index, *type, status);
+
+	if (index > max_index) {
+		error("Unexpected index %u in start_discovery_complete",
+								index);
+		return;
+	}
+
+	if (!status)
+		return;
+
+	adapter = manager_find_adapter_by_id(index);
+	if (adapter)
+		/* Start discovery failed, inform upper layers. */
+		adapter_set_discovering(adapter, FALSE);
+}
+
 static void read_local_oob_data_failed(int sk, uint16_t index)
 {
 	struct btd_adapter *adapter;
@@ -1421,7 +1450,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
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


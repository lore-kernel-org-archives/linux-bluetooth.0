Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/3] Add hci utility function to change LE connection parameters
Date: Tue, 22 Feb 2011 18:42:06 -0300
Message-Id: <1298410927-9165-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c     |   37 +++++++++++++++++++++++++++++++++++++
 lib/hci_lib.h |    4 ++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 048fda4..688b0b4 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2767,3 +2767,40 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 
 	return 0;
 }
+
+int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
+			uint16_t max_interval, uint16_t latency,
+			uint16_t supervision_timeout, int to)
+{
+	evt_le_connection_update_complete evt;
+	le_connection_update_cp cp;
+	struct hci_request rq;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = handle;
+	cp.min_interval = min_interval;
+	cp.max_interval = max_interval;
+	cp.latency = latency;
+	cp.supervision_timeout = supervision_timeout;
+	cp.min_ce_length = htobs(0x0001);
+	cp.max_ce_length = htobs(0x0001);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_CONN_UPDATE;
+	rq.cparam = &cp;
+	rq.clen = LE_CONN_UPDATE_CP_SIZE;
+	rq.event = EVT_LE_CONN_UPDATE_COMPLETE;
+	rq.rparam = &evt;
+	rq.rlen = sizeof(evt);
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (evt.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index b63a2a4..5be8d50 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -128,6 +128,10 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint16_t min_ce_length, uint16_t max_ce_length,
 		uint16_t *handle, int to);
 
+int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
+			uint16_t max_interval, uint16_t latency,
+			uint16_t supervision_timeout, int to);
+
 int hci_for_each_dev(int flag, int(*func)(int dd, int dev_id, long arg), long arg);
 int hci_get_route(bdaddr_t *bdaddr);
 
-- 
1.7.4.1


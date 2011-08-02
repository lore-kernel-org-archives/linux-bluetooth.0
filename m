Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 8/8] Add handle for RSSI monitor alert event in mgmt
Date: Tue,  2 Aug 2011 18:37:40 -0300
Message-Id: <1312321060-19283-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes mgmtops plugin adding the handler for the RSSI threshold alert
event. This event is sent by the kernel when the alerting state/type
changes.
---
 plugins/mgmtops.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index e01f330..3d909ab 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1385,6 +1385,27 @@ static void mgmt_discovering(int sk, uint16_t index, void *buf, size_t len)
 	adapter_set_state(adapter, state);
 }
 
+static void rssi_monitor_alert(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_ev_rssi_monitor_alert *ev = buf;
+	struct controller_info *info;
+
+	if (len != sizeof(*ev)) {
+		error("Too small rssi_monitor_alert event");
+		return;
+	}
+
+	if (index > max_index) {
+		error("Unexpected index %u in RSSI monitor alert event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	btd_event_rssi_monitor_alert(&info->bdaddr, &ev->bdaddr,
+							ev->alert_type);
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1489,6 +1510,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_DISCOVERING:
 		mgmt_discovering(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_RSSI_MONITOR_ALERT:
+		rssi_monitor_alert(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
 	default:
 		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
-- 
1.7.6


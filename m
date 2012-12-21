Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 07/25] mgmt: Add set observer and set broadcaster command
Date: Fri, 21 Dec 2012 16:26:34 -0400
Message-Id: <1356121612-15172-8-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement Set Observer and Set Broadcaster support in MGMT API.

For observer, setting TRUE will make the adapter start LE discovery,
otherwise, setting FALSE will make the adapter stop LE discovery.

For broadcaster, setting TRUE will make the new data sent by Set
Controller Data command to be set in adapter and the advertising will
start. Setting FALSE will stop advertising.
---
 src/mgmt.c |   16 ++++++++++++++++
 src/mgmt.h |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index 03ec049..0f212b2 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1651,6 +1651,12 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_DEVICE_ID:
 		DBG("set_did complete");
 		break;
+	case MGMT_OP_SET_BROADCASTER:
+		DBG("set_broadcaster complete");
+		break;
+	case MGMT_OP_SET_OBSERVER:
+		DBG("set_observer complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -2358,6 +2364,16 @@ int mgmt_set_fast_connectable(int index, gboolean enable)
 	return 0;
 }
 
+int mgmt_set_broadcaster(int index, gboolean enable)
+{
+	return mgmt_set_mode(index, MGMT_OP_SET_BROADCASTER, enable);
+}
+
+int mgmt_set_observer(int index, gboolean enable)
+{
+	return mgmt_set_mode(index, MGMT_OP_SET_OBSERVER, enable);
+}
+
 int mgmt_read_clock(int index, const bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy)
 {
diff --git a/src/mgmt.h b/src/mgmt.h
index 1ea8488..1607a95 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -32,6 +32,8 @@ int mgmt_set_pairable(int index, gboolean pairable);
 int mgmt_set_name(int index, const char *name);
 int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor);
 int mgmt_set_fast_connectable(int index, gboolean enable);
+int mgmt_set_broadcaster(int index, gboolean enable);
+int mgmt_set_observer(int index, gboolean enable);
 
 int mgmt_start_discovery(int index);
 int mgmt_start_le_scanning(int index);
-- 
1.7.9.5


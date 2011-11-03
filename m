Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix mgmt response when adapter goes down or is removed
Date: Thu,  3 Nov 2011 14:40:33 +0200
Message-Id: <1320324033-16280-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320317931-15260-1-git-send-email-johan.hedberg@gmail.com>
References: <1320317931-15260-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When an adapter gets powered off or is removed any pending commands
should receive a ENETDOWN or ENODEV status response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Fix uint8_t -> u8

 net/bluetooth/mgmt.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbc8a6d..747366a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -262,7 +262,7 @@ static void mgmt_pending_foreach(u16 opcode, int index,
 
 		cmd = list_entry(p, struct pending_cmd, list);
 
-		if (cmd->opcode != opcode)
+		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
 		if (index >= 0 && cmd->index != index)
@@ -1949,6 +1949,14 @@ done:
 	return err;
 }
 
+static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
+{
+	u8 *status = data;
+
+	cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
+	mgmt_pending_remove(cmd);
+}
+
 int mgmt_index_added(u16 index)
 {
 	return mgmt_event(MGMT_EV_INDEX_ADDED, index, NULL, 0, NULL);
@@ -1956,6 +1964,10 @@ int mgmt_index_added(u16 index)
 
 int mgmt_index_removed(u16 index)
 {
+	u8 status = ENODEV;
+
+	mgmt_pending_foreach(0, index, cmd_status_rsp, &status);
+
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, index, NULL, 0, NULL);
 }
 
@@ -1992,6 +2004,11 @@ int mgmt_powered(u16 index, u8 powered)
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, mode_rsp, &match);
 
+	if (!powered) {
+		u8 status = ENETDOWN;
+		mgmt_pending_foreach(0, index, cmd_status_rsp, &status);
+	}
+
 	ev.val = powered;
 
 	ret = mgmt_event(MGMT_EV_POWERED, index, &ev, sizeof(ev), match.sk);
-- 
1.7.7.1


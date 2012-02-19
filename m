Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: mgmt: Change ordering of cmd_status paramters
Date: Sun, 19 Feb 2012 13:54:24 +0200
Message-Id: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In accordance to the latest mgmt API specification the opcode comes
first and then the status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ad54b5f..36e68b4 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -318,8 +318,8 @@ struct mgmt_ev_cmd_complete {
 
 #define MGMT_EV_CMD_STATUS		0x0002
 struct mgmt_ev_cmd_status {
-	__u8 status;
 	__le16 opcode;
+	__u8 status;
 } __packed;
 
 #define MGMT_EV_CONTROLLER_ERROR	0x0003
-- 
1.7.9


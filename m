Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] mgmtops: Handle "Class Of Device Changed" event
Date: Thu, 23 Feb 2012 11:58:26 -0400
Message-Id: <1330012707-32536-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids misleading "Unknown Management opcode 7 (index 0)" errors.
---
 plugins/mgmtops.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4a7bfff..91b4a22 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1587,6 +1587,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_NEW_SETTINGS:
 		mgmt_new_settings(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_CLASS_OF_DEV_CHANGED:
+		DBG("hci%u Class of Device changed", index);
+		break;
 	case MGMT_EV_NEW_LINK_KEY:
 		mgmt_new_link_key(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
-- 
1.7.5.4


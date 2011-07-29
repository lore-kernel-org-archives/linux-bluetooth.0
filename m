Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Fix global_mode shall be updated by plug-in
Date: Fri, 29 Jul 2011 11:33:48 +0300
Message-Id: <1311928428-5708-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, use of RequestSession and SetProperty adapter method
calls sets global_mode to on. Switching adapter off via plug-in
interface in this scenario releases all sessions, that, in turn,
restores adapter's state to global_mode, which is on.

Result is the adapter is switched off and immediately switched on.
This patch fixes such inconsistency by overwriting global_mode to
mode off when request comes from plug-in.
---
 src/adapter.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e1b8d5d..4c88a0e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3425,6 +3425,8 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	if (adapter->off_timer)
 		return 0;
 
+	adapter->global_mode = MODE_OFF;
+
 	if (adapter->connections == NULL)
 		return adapter_ops->set_powered(adapter->dev_id, FALSE);
 
-- 
1.7.4.1


Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix spurious DeviceDisappeared signals after name resolution
Date: Thu, 23 Dec 2010 13:39:25 -0400
Message-Id: <1293125965-11782-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

update_oor_devices() was being called twice, first after a inquiry, then
after name resolution. This caused the just found devices to be always
reported as "disappeared" after name resolution.
---
 src/adapter.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 69d3da0..096d684 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2641,13 +2641,14 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 	}
 
 	if (discov_active == FALSE) {
-		update_oor_devices(adapter);
 		if (type & DISC_RESOLVNAME) {
 			if (adapter_resolve_names(adapter) == 0) {
 				adapter->state |= STATE_RESOLVNAME;
 				return;
 			}
 		}
+
+		update_oor_devices(adapter);
 	} else if (adapter->disc_sessions && main_opts.discov_interval)
 			adapter->scheduler_id = g_timeout_add_seconds(
 						main_opts.discov_interval,
-- 
1.7.0.4


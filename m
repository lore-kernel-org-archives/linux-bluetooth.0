Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 04/16] Code cleanup event.c
Date: Fri, 29 Apr 2011 21:27:20 -0300
Message-Id: <1304123252-14464-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove btd_event_le_set_scan_enable_complete() since it is not
used anymore.

The adapter's state is updated in cc_le_set_scan_enable() which
handles LE Set Scan Enable command complete events.
---
 src/event.c |   27 ---------------------------
 src/event.h |    1 -
 2 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/src/event.c b/src/event.c
index 5373e33..7feec1f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -690,33 +690,6 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 
 /* Section reserved to device HCI callbacks */
 
-void btd_event_le_set_scan_enable_complete(bdaddr_t *local, uint8_t status)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	if (status) {
-		error("Can't enable/disable LE scan");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-
-	/* Enabling or disabling ? */
-	if (state & STATE_LE_SCAN)
-		state &= ~STATE_LE_SCAN;
-	else
-		state |= STATE_LE_SCAN;
-
-	adapter_set_state(adapter, state);
-}
-
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 {
 	struct btd_adapter *adapter;
diff --git a/src/event.h b/src/event.h
index 765390a..005d8a7 100644
--- a/src/event.h
+++ b/src/event.h
@@ -35,7 +35,6 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer);
 void btd_event_bonding_complete(bdaddr_t *local, bdaddr_t *peer,
 							uint8_t status);
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
-void btd_event_le_set_scan_enable_complete(bdaddr_t *local, uint8_t status);
 void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer);
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
-- 
1.7.1


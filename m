Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/2] Moving inquiry_complete() from security.c to adapter.c
Date: Mon,  9 Nov 2009 19:55:29 +0530
Message-Id: <1257776729-6313-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h  |    2 +
 src/security.c |   62 ++-----------------------------------------------------
 3 files changed, 55 insertions(+), 59 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index aedf50a..90b1d08 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2853,6 +2853,56 @@ void adapter_handle_start_inquiry(struct btd_adapter *adapter,
 	}
 }
 
+void adapter_handle_inquiry_complete(struct btd_adapter *adapter,
+					uint8_t status, gboolean periodic)
+{
+	int state;
+
+	/* Don't send the signal if the cmd failed */
+	if (status) {
+		error("Inquiry Failed with status 0x%02x", status);
+		return;
+	}
+
+	/*
+	 * The following scenarios can happen:
+	 * 1. standard inquiry: always send discovery completed signal
+	 * 2. standard inquiry + name resolving: send discovery completed
+	 *    after name resolving
+	 * 3. periodic inquiry: skip discovery completed signal
+	 * 4. periodic inquiry + standard inquiry: always send discovery
+	 *    completed signal
+	 *
+	 * Keep in mind that non D-Bus requests can arrive.
+	 */
+	if (periodic) {
+		state = adapter_get_state(adapter);
+		state &= ~PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
+	if (adapter_resolve_names(adapter) == 0)
+		return;
+
+	state = adapter_get_state(adapter);
+	/*
+	 * workaround to identify situation when there is no devices around
+	 * but periodic inquiry is active.
+	 */
+	if (!(state & STD_INQUIRY) && !(state & PERIODIC_INQUIRY)) {
+		state |= PERIODIC_INQUIRY;
+		adapter_set_state(adapter, state);
+		return;
+	}
+
+	/* reset the discover type to be able to handle D-Bus and non D-Bus
+	 * requests */
+	state &= ~STD_INQUIRY;
+	state &= ~PERIODIC_INQUIRY;
+	adapter_set_state(adapter, state);
+}
+
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index 44e1cc2..8dc4331 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -119,6 +119,8 @@ void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 void adapter_handle_start_inquiry(struct btd_adapter *adapter,
 					uint8_t status, gboolean periodic);
+void adapter_handle_inquiry_complete(struct btd_adapter *adapter,
+					uint8_t status, gboolean periodic);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
diff --git a/src/security.c b/src/security.c
index 06f9d1a..db56e44 100644
--- a/src/security.c
+++ b/src/security.c
@@ -554,62 +554,6 @@ reject:
 	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, dba);
 }
 
-static void inquiry_complete(bdaddr_t *local, uint8_t status, gboolean periodic)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	/* Don't send the signal if the cmd failed */
-	if (status) {
-		error("Inquiry Failed with status 0x%02x", status);
-		return;
-	}
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("Unable to find matching adapter");
-		return;
-	}
-
-	/*
-	 * The following scenarios can happen:
-	 * 1. standard inquiry: always send discovery completed signal
-	 * 2. standard inquiry + name resolving: send discovery completed
-	 *    after name resolving
-	 * 3. periodic inquiry: skip discovery completed signal
-	 * 4. periodic inquiry + standard inquiry: always send discovery
-	 *    completed signal
-	 *
-	 * Keep in mind that non D-Bus requests can arrive.
-	 */
-	if (periodic) {
-		state = adapter_get_state(adapter);
-		state &= ~PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-		return;
-	}
-
-	if (adapter_resolve_names(adapter) == 0)
-		return;
-
-	state = adapter_get_state(adapter);
-	/*
-	 * workaround to identify situation when there is no devices around
-	 * but periodic inquiry is active.
-	 */
-	if (!(state & STD_INQUIRY) && !(state & PERIODIC_INQUIRY)) {
-		state |= PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-		return;
-	}
-
-	/* reset the discover type to be able to handle D-Bus and non D-Bus
-	 * requests */
-	state &= ~STD_INQUIRY;
-	state &= ~PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
 static inline void remote_features_notify(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_remote_host_features_notify *evt = ptr;
@@ -637,10 +581,10 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 		adapter_handle_start_inquiry(adapter, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
-		inquiry_complete(sba, status, TRUE);
+		adapter_handle_inquiry_complete(adapter, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
-		inquiry_complete(sba, status, FALSE);
+		adapter_handle_inquiry_complete(adapter, status, FALSE);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
 		adapter_setname_complete(sba, status);
@@ -969,7 +913,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer
 
 	case EVT_INQUIRY_COMPLETE:
 		evt = (evt_cmd_status *) ptr;
-		inquiry_complete(&di->bdaddr, evt->status, FALSE);
+		adapter_handle_inquiry_complete(adapter, evt->status, FALSE);
 		break;
 
 	case EVT_INQUIRY_RESULT:
-- 
1.5.6.3


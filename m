Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Emit Connect signal for LE capable devices
Date: Thu, 25 Nov 2010 12:22:49 -0500
Message-Id: <1290705769-15487-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   61 ++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9abe477..308908a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1207,12 +1207,14 @@ static inline void remote_features_information(int index, void *ptr)
 	write_features_info(&BDADDR(index), &dba, evt->features, NULL);
 }
 
-static inline void conn_complete(int index, void *ptr)
+static inline void conn_complete(int index, gboolean le, void *ptr)
 {
-	evt_conn_complete *evt = ptr;
 	char filename[PATH_MAX];
 	char local_addr[18], peer_addr[18], *str;
 	struct btd_adapter *adapter;
+	bdaddr_t *evt_bdaddr;
+	uint16_t evt_handle;
+	uint8_t evt_status;
 
 	adapter = manager_find_adapter(&BDADDR(index));
 	if (!adapter) {
@@ -1220,27 +1222,39 @@ static inline void conn_complete(int index, void *ptr)
 		return;
 	}
 
-	if (evt->link_type != ACL_LINK)
-		return;
+	if (le) {
+		evt_le_connection_complete *evt = ptr;
+		evt_bdaddr = &evt->peer_bdaddr;
+		evt_handle = evt->handle;
+		evt_status = evt->status;
+	}  else {
+		evt_conn_complete *evt = ptr;
+		evt_bdaddr = &evt->bdaddr;
+		evt_handle = evt->handle;
+		evt_status = evt->status;
+
+		if (evt->link_type != ACL_LINK)
+			return;
+	}
 
-	btd_event_conn_complete(&BDADDR(index), evt->status,
-					btohs(evt->handle), &evt->bdaddr);
+	btd_event_conn_complete(&BDADDR(index), evt_status,
+					btohs(evt_handle), evt_bdaddr);
 
-	if (evt->status)
+	if (evt_status)
 		return;
 
-	update_lastused(&BDADDR(index), &evt->bdaddr);
+	update_lastused(&BDADDR(index), evt_bdaddr);
 
 	/* check if the remote version needs be requested */
 	ba2str(&BDADDR(index), local_addr);
-	ba2str(&evt->bdaddr, peer_addr);
+	ba2str(evt_bdaddr, peer_addr);
 
 	create_name(filename, sizeof(filename), STORAGEDIR, local_addr,
 							"manufacturers");
 
 	str = textfile_get(filename, peer_addr);
 	if (!str)
-		btd_adapter_get_remote_version(adapter, btohs(evt->handle),
+		btd_adapter_get_remote_version(adapter, btohs(evt_handle),
 									TRUE);
 	else
 		free(str);
@@ -1282,17 +1296,11 @@ static inline void conn_request(int index, void *ptr)
 	btd_event_remote_class(&BDADDR(index), &evt->bdaddr, class);
 }
 
-static inline void le_metaevent(int index, void *ptr)
+static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
-	evt_le_meta_event *meta = ptr;
 	le_advertising_info *info;
 	uint8_t num, i;
 
-	DBG("LE Meta Event");
-
-	if (meta->subevent != EVT_LE_ADVERTISING_REPORT)
-		return;
-
 	num = meta->data[0];
 	info = (le_advertising_info *) (meta->data + 1);
 
@@ -1302,6 +1310,23 @@ static inline void le_metaevent(int index, void *ptr)
 	}
 }
 
+static inline void le_metaevent(int index, void *ptr)
+{
+	evt_le_meta_event *meta = ptr;
+
+	DBG("LE Meta Event");
+
+	switch (meta->subevent) {
+	case EVT_LE_ADVERTISING_REPORT:
+		le_advertising_report(index, meta);
+		break;
+
+	case EVT_LE_CONN_COMPLETE:
+		conn_complete(index, TRUE, meta->data);
+		break;
+	}
+}
+
 static void stop_hci_dev(int index)
 {
 	GIOChannel *chan = CHANNEL(index);
@@ -1399,7 +1424,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond,
 		break;
 
 	case EVT_CONN_COMPLETE:
-		conn_complete(index, ptr);
+		conn_complete(index, FALSE, ptr);
 		break;
 
 	case EVT_DISCONN_COMPLETE:
-- 
1.7.3.2


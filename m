Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2] Emit Connect signal for LE capable devices
Date: Mon, 29 Nov 2010 13:36:29 -0500
Message-Id: <1291055789-3733-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20101129125208.GA15399@jh-x301>
References: <20101129125208.GA15399@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index e5678d7..c446fd0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1266,6 +1266,42 @@ static inline void conn_complete(int index, void *ptr)
 		free(str);
 }
 
+static inline void le_conn_complete(int index, void *ptr)
+{
+	evt_le_connection_complete *evt = ptr;
+	char filename[PATH_MAX];
+	char local_addr[18], peer_addr[18], *str;
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(&BDADDR(index));
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
+	btd_event_conn_complete(&BDADDR(index), evt->status,
+					btohs(evt->handle), &evt->peer_bdaddr);
+
+	if (evt->status)
+		return;
+
+	update_lastused(&BDADDR(index), &evt->peer_bdaddr);
+
+	/* check if the remote version needs be requested */
+	ba2str(&BDADDR(index), local_addr);
+	ba2str(&evt->peer_bdaddr, peer_addr);
+
+	create_name(filename, sizeof(filename), STORAGEDIR, local_addr,
+							"manufacturers");
+
+	str = textfile_get(filename, peer_addr);
+	if (!str)
+		btd_adapter_get_remote_version(adapter, btohs(evt->handle),
+									TRUE);
+	else
+		free(str);
+}
+
 static inline void disconn_complete(int index, void *ptr)
 {
 	evt_disconn_complete *evt = ptr;
@@ -1306,17 +1342,11 @@ static inline void conn_request(int index, void *ptr)
 	btd_event_remote_class(&BDADDR(index), &evt->bdaddr, class);
 }
 
-static inline void le_metaevent(int index, void *ptr)
+static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
-	evt_le_meta_event *meta = ptr;
 	le_advertising_info *info;
 	uint8_t num, i;
 
-	DBG("hci%d LE Meta Event %u", index, meta->subevent);
-
-	if (meta->subevent != EVT_LE_ADVERTISING_REPORT)
-		return;
-
 	num = meta->data[0];
 	info = (le_advertising_info *) (meta->data + 1);
 
@@ -1326,6 +1356,23 @@ static inline void le_metaevent(int index, void *ptr)
 	}
 }
 
+static inline void le_metaevent(int index, void *ptr)
+{
+	evt_le_meta_event *meta = ptr;
+
+	DBG("hci%d LE Meta Event %u", index, meta->subevent);
+
+	switch (meta->subevent) {
+	case EVT_LE_ADVERTISING_REPORT:
+		le_advertising_report(index, meta);
+		break;
+
+	case EVT_LE_CONN_COMPLETE:
+		le_conn_complete(index, meta->data);
+		break;
+	}
+}
+
 static void stop_hci_dev(int index)
 {
 	GIOChannel *chan = CHANNEL(index);
-- 
1.7.3.2


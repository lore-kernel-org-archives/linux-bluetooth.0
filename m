Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 4/6] dbusoob: Set device name in device object
Date: Tue, 30 Oct 2012 18:05:26 +0100
Message-Id: <1351616728-10075-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/dbusoob.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 5c5b6ef..0278941 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -193,6 +193,7 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
 
 static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 {
+	bdaddr_t local = *adapter_get_address(adapter);
 	bdaddr_t bdaddr;
 
 	str2ba(data->addr, &bdaddr);
@@ -207,9 +208,13 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 		write_remote_class(adapter_get_address(adapter), &bdaddr,
 								data->class);
 
-	if (data->name)
-		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
-								data->name);
+	if (data->name) {
+		char *str;
+
+		str = g_strdup(data->name);
+		btd_event_remote_name(&local, &bdaddr, str);
+		g_free(str);
+	}
 
 	return TRUE;
 }
-- 
1.7.9.5


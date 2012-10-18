Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 02/16] adapter: Read name in storage at init
Date: Thu, 18 Oct 2012 15:01:37 +0200
Message-Id: <1350565311-18330-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 3b24816..233527a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2506,6 +2506,18 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 	g_free(path);
 }
 
+static void load_config(struct btd_adapter *adapter)
+{
+	char name[MAX_NAME_LENGTH + 1];
+
+	/* Get name */
+	if (read_local_name(&adapter->bdaddr, name) < 0)
+		adapter->name = NULL;
+	else
+		adapter->name = g_strdup(name);
+
+}
+
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 {
 	adapter->up = up;
@@ -2525,6 +2537,7 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 	if (main_opts.gatt_enabled)
 		btd_adapter_gatt_server_start(adapter);
 
+	load_config(adapter);
 	load_drivers(adapter);
 	btd_profile_foreach(probe_profile, adapter);
 	clear_blocked(adapter);
-- 
1.7.9.5


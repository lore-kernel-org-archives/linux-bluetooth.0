Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bassem Boubaker <bassem.boubaker@actia.fr>
To: linux-bluetooth@vger.kernel.org
Cc: nicolas.adell@actia.fr, Bassem Boubaker <bassem.boubaker@actia.fr>
Subject: [PATCH] Introduce "PairableDefaultStatus" property in the main.conf file.
Date: Thu,  8 Mar 2018 15:35:22 +0100
Message-Id: <1520519722-2332-1-git-send-email-bassem.boubaker@actia.fr>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This property sets the default pairable status at the adapter start.

By default, bluez activate the pairable status (wether forever
or for a specific period of time with PairableTimeout property).
We can choose to disable it directly for security reason.

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
---
 src/adapter.c | 13 +++++++++++--
 src/hcid.h    |  1 +
 src/main.c    | 10 ++++++++++
 src/main.conf |  4 ++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6d7d615..c9fe020 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -207,6 +207,7 @@ struct btd_adapter {
 	bool stored_discoverable;	/* stored discoverable mode */
 	uint32_t discoverable_timeout;	/* discoverable time(sec) */
 	uint32_t pairable_timeout;	/* pairable time(sec) */
+	bool pairable_default_status;	/*The default status of pairable when booting*/
 
 	char *current_alias;		/* current adapter name alias */
 	char *stored_alias;		/* stored adapter name alias */
@@ -5713,6 +5714,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 						main_opts.did_version);
 	adapter->discoverable_timeout = main_opts.discovto;
 	adapter->pairable_timeout = main_opts.pairto;
+	adapter->pairable_default_status = main_opts.pair_default_status;
 
 	DBG("System name: %s", adapter->system_name);
 	DBG("Major class: %u", adapter->major_class);
@@ -5720,6 +5722,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	DBG("Modalias: %s", adapter->modalias);
 	DBG("Discoverable timeout: %u seconds", adapter->discoverable_timeout);
 	DBG("Pairable timeout: %u seconds", adapter->pairable_timeout);
+	DBG("Pairable Default status: %d", adapter->pairable_default_status);
 
 	adapter->auths = g_queue_new();
 
@@ -8657,8 +8660,14 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_name(adapter, btd_adapter_get_name(adapter));
 
-	if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
-		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
+	if (adapter->pairable_default_status){
+		if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
+			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
+	}
+	else {
+		if ((adapter->current_settings & MGMT_SETTING_BONDABLE))
+			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
+	}
 
 	if (!kernel_conn_control)
 		set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
diff --git a/src/hcid.h b/src/hcid.h
index 62e2bd6..6fc1d26 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -46,6 +46,7 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	fast_conn;
+	gboolean	pair_default_status;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
diff --git a/src/main.c b/src/main.c
index 21f0b14..347a587 100644
--- a/src/main.c
+++ b/src/main.c
@@ -90,6 +90,7 @@ static const char *supported_options[] = {
 	"MultiProfile",
 	"FastConnectable",
 	"Privacy",
+	"PairableDefaultStatus",
 	NULL
 };
 
@@ -398,6 +399,14 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.fast_conn = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"PairableDefaultStatus", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		main_opts.pair_default_status = boolean;
+
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		g_clear_error(&err);
@@ -423,6 +432,7 @@ static void init_defaults(void)
 	main_opts.reverse_sdp = TRUE;
 	main_opts.name_resolv = TRUE;
 	main_opts.debug_keys = FALSE;
+	main_opts.pair_default_status = TRUE;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
diff --git a/src/main.conf b/src/main.conf
index 21986b3..c126b3d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -18,6 +18,10 @@
 # 0 = disable timer, i.e. stay pairable forever
 #PairableTimeout = 0
 
+# Permanently enable/disable the pairable property for adapters at start (for
+# security reason). Default is true. Uncomment line below to override it.
+#PairableDefaultStatus = true
+
 # Use vendor id source (assigner), vendor, product and version information for
 # DID profile support. The values are separated by ":" and assigner, VID, PID
 # and version.
-- 
2.7.4


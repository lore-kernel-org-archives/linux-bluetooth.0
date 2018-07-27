Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core: Add AlwaysPairable to main.conf
Date: Fri, 27 Jul 2018 16:02:17 +0300
Message-Id: <20180727130218.16975-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a new option called AlwaysPairable to main.conf, it can be
used to enable Adapter.Pairable even in case there is no Agent
available.

Since that could be consider a security problem to allow pairing
without user's consent the option defaults to false.
---
 src/adapter.c | 16 +++++++++++++++-
 src/agent.h   |  7 +++++++
 src/hcid.h    |  1 +
 src/main.c    | 11 +++++++++++
 src/main.conf |  5 +++++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index a60386f90..e4833b80c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7854,6 +7854,19 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 {
 	struct mgmt_cp_set_io_capability cp;
 
+	if (!main_opts.pairable) {
+		if (io_cap == IO_CAPABILITY_INVALID) {
+			if (adapter->current_settings & MGMT_SETTING_BONDABLE)
+				set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
+
+			return 0;
+		}
+
+		if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
+			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
+	} else if (io_cap == IO_CAPABILITY_INVALID)
+		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = io_cap;
 
@@ -8782,7 +8795,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_name(adapter, btd_adapter_get_name(adapter));
 
-	if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
+	if (main_opts.pairable &&
+			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
 
 	if (!kernel_conn_control)
diff --git a/src/agent.h b/src/agent.h
index 1e4692036..f14d14325 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -22,6 +22,13 @@
  *
  */
 
+#define IO_CAPABILITY_DISPLAYONLY	0x00
+#define IO_CAPABILITY_DISPLAYYESNO	0x01
+#define IO_CAPABILITY_KEYBOARDONLY	0x02
+#define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
+#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
+#define IO_CAPABILITY_INVALID		0xFF
+
 struct agent;
 
 typedef void (*agent_cb) (struct agent *agent, DBusError *err,
diff --git a/src/hcid.h b/src/hcid.h
index 704f0ba37..1eb3c5ac2 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -38,6 +38,7 @@ typedef enum {
 struct main_opts {
 	char		*name;
 	uint32_t	class;
+	gboolean	pairable;
 	uint32_t	pairto;
 	uint32_t	discovto;
 	uint8_t		privacy;
diff --git a/src/main.c b/src/main.c
index 4e2c4248e..4716f5388 100644
--- a/src/main.c
+++ b/src/main.c
@@ -82,6 +82,7 @@ static const char *supported_options[] = {
 	"Name",
 	"Class",
 	"DiscoverableTimeout",
+	"AlwaysPairable"
 	"PairableTimeout",
 	"DeviceID",
 	"ReverseServiceDiscovery",
@@ -289,6 +290,16 @@ static void parse_config(GKeyFile *config)
 		main_opts.discovto = val;
 	}
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"AlwaysPairable", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("pairable=%s", boolean ? "true" : "false");
+		main_opts.pairable = boolean;
+	}
+
 	val = g_key_file_get_integer(config, "General",
 						"PairableTimeout", &err);
 	if (err) {
diff --git a/src/main.conf b/src/main.conf
index 224334c5a..b2f843c75 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -13,6 +13,11 @@
 # 0 = disable timer, i.e. stay discoverable forever
 #DiscoverableTimeout = 0
 
+# Always allow pairing even if there are no agent registered
+# Possible values: true, false
+# Default: false
+#AlwaysPairable = false
+
 # How long to stay in pairable mode before going back to non-discoverable
 # The value is in seconds. Default is 0.
 # 0 = disable timer, i.e. stay pairable forever
-- 
2.17.1


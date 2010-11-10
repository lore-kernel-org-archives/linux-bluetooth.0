Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Add a new configuration option to disable Low Energy support
Date: Wed, 10 Nov 2010 19:56:01 -0200
Message-Id: <1289426161-10045-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disable LE interleave discovery and attribute server over LE link.
Option required to force disabling Low energy support for LE capable
adapters.
---
 src/adapter.c       |    2 +-
 src/attrib-server.c |    4 ++++
 src/hcid.h          |    1 +
 src/main.c          |    7 +++++++
 src/main.conf       |    7 ++++++-
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 31014e5..0741550 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2082,7 +2082,7 @@ static int adapter_setup(struct btd_adapter *adapter, const char *mode)
 	if (dev->features[7] & LMP_INQ_TX_PWR)
 		adapter_ops->read_inq_tx_pwr(adapter->dev_id);
 
-	if (dev->features[4] & LMP_LE) {
+	if (dev->features[4] & LMP_LE && main_opts.le) {
 		uint8_t simul = (dev->features[6] & LMP_LE_BREDR) ? 0x01 : 0x00;
 		err = adapter_ops->write_le_host(adapter->dev_id, 0x01, simul);
 		if (err < 0) {
diff --git a/src/attrib-server.c b/src/attrib-server.c
index f644091..375b731 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -40,6 +40,7 @@
 #include "glib-helper.h"
 #include "btio.h"
 #include "sdpd.h"
+#include "hcid.h"
 #include "att.h"
 #include "gattrib.h"
 
@@ -623,6 +624,9 @@ int attrib_server_init(void)
 
 	sdp_handle = record->handle;
 
+	if (!main_opts.le)
+		return 0;
+
 	/* LE socket */
 	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					NULL, NULL, &gerr,
diff --git a/src/hcid.h b/src/hcid.h
index 48d489a..a9484a6 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -56,6 +56,7 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	attrib_server;
+	gboolean	le;
 
 	uint8_t		scan;
 	uint8_t		mode;
diff --git a/src/main.c b/src/main.c
index adbb374..9abdd60 100644
--- a/src/main.c
+++ b/src/main.c
@@ -222,6 +222,13 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.attrib_server = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"EnableLE", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		main_opts.le = boolean;
+
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
 	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
diff --git a/src/main.conf b/src/main.conf
index f92bf42..c03f135 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -56,6 +56,11 @@ NameResolving = true
 # that they were created for.
 DebugKeys = false
 
+# Enable Low Energy support if the dongle supports. Default is false.
+# Enable/Disable interleave discovery and attribute server over LE.
+EnableLE = false
+
 # Enable the GATT Attribute Server. Default is false, because it is only
-# useful for testing.
+# useful for testing. Attribute server is not enabled over LE if EnableLE
+# is false.
 AttributeServer = false
-- 
1.7.3.2


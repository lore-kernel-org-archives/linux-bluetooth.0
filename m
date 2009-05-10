Return-Path: <cyrus@holtmann.org>
From: Ilya Rubtsov <lusyaru@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ilya Rubtsov <lusyaru@gmail.com>
Subject: [PATCH] Add NameResolving option to main.conf
Date: Sun, 10 May 2009 23:47:35 +0400
Message-Id: <1241984855-12007-1-git-send-email-lusyaru@gmail.com>
In-Reply-To: <4A065C92.4010700@gmail.com>
References: <4A065C92.4010700@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch adds new option to main.conf - NameResolving. If NameResolving=false then we don't ask remote devices for their names after inquiry. Default value is true.
---
 src/adapter.c |    9 ++++++---
 src/hcid.h    |    1 +
 src/main.c    |    8 ++++++++
 src/main.conf |    4 ++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 977e507..a54078c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1076,7 +1076,8 @@ static int start_inquiry(struct btd_adapter *adapter)
 
 	hci_close_dev(dd);
 
-	adapter->state |= RESOLVE_NAME;
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 
 	return 0;
 }
@@ -1126,7 +1127,8 @@ static int start_periodic_inquiry(struct btd_adapter *adapter)
 
 	hci_close_dev(dd);
 
-	adapter->state |= RESOLVE_NAME;
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 
 	return 0;
 }
@@ -2446,7 +2448,8 @@ struct btd_adapter *adapter_create(DBusConnection *conn, int id,
 	}
 
 	adapter->dev_id = id;
-	adapter->state |= RESOLVE_NAME;
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 	adapter->path = g_strdup(path);
 	adapter->already_up = devup;
 
diff --git a/src/hcid.h b/src/hcid.h
index 6e618a8..4fbbef1 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -59,6 +59,7 @@ struct main_opts {
 	uint16_t	link_policy;
 	gboolean	remember_powered;
 	gboolean	reverse_sdp;
+	gboolean	name_resolv;
 
 	uint8_t		scan;
 	uint8_t		mode;
diff --git a/src/main.c b/src/main.c
index d7bb399..0467fe1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -187,6 +187,13 @@ static void parse_config(GKeyFile *config)
 	} else
 		main_opts.reverse_sdp = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"NameResolving", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		main_opts.name_resolv = boolean;
+
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
 	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
@@ -304,6 +311,7 @@ static void init_defaults(void)
 	main_opts.discovto	= HCID_DEFAULT_DISCOVERABLE_TIMEOUT;
 	main_opts.remember_powered = TRUE;
 	main_opts.reverse_sdp = TRUE;
+	main_opts.name_resolv = TRUE;
 
 	if (gethostname(main_opts.host_name, sizeof(main_opts.host_name) - 1) < 0)
 		strcpy(main_opts.host_name, "noname");
diff --git a/src/main.conf b/src/main.conf
index c736e49..b252a82 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -46,3 +46,7 @@ RememberPowered = true
 # doesn't like us doing reverse SDP for some test cases (though there could in
 # theory be other useful purposes for this too). Defaults to true.
 ReverseServiceDiscovery = true
+
+# Enable name resolving after inquiry. Set it to 'false' if you don't need
+# remote devices name and want shorter discovery cycle. Defaults to 'true'.
+NameResolving = true
-- 
1.6.0.4


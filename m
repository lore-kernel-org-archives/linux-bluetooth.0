Return-Path: <cyrus@holtmann.org>
Message-ID: <4A065C92.4010700@gmail.com>
Date: Sun, 10 May 2009 08:48:18 +0400
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add DisableNameResolving option to main.conf
References: <4A02429C.8010201@gmail.com> <4A024529.90104@gmail.com> <4A0653F6.4020501@gmail.com>
In-Reply-To: <4A0653F6.4020501@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And now with variable named name_resolv with default value 'true'



diff --git a/src/adapter.c b/src/adapter.c
index 500f82f..bb3e770 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1076,7 +1076,8 @@ static int start_inquiry(struct btd_adapter *adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    if (main_opts.name_resolv)
+        adapter->state |= RESOLVE_NAME;
 
     return 0;
 }
@@ -1126,7 +1127,8 @@ static int start_periodic_inquiry(struct 
btd_adapter *adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    if (main_opts.name_resolv)
+        adapter->state |= RESOLVE_NAME;
 
     return 0;
 }
@@ -2446,7 +2448,8 @@ struct btd_adapter *adapter_create(DBusConnection 
*conn, int id,
     }
 
     adapter->dev_id = id;
-    adapter->state |= RESOLVE_NAME;
+    if (main_opts.name_resolv)
+        adapter->state |= RESOLVE_NAME;
     adapter->path = g_strdup(path);
     adapter->already_up = devup;
 
diff --git a/src/hcid.h b/src/hcid.h
index ae356d3..5e80fb6 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -59,6 +59,7 @@ struct main_opts {
     uint16_t    link_policy;
     gboolean    remember_powered;
     gboolean    reverse_sdp;
+    gboolean    name_resolv;
 
     uint8_t        scan;
     uint8_t        mode;
diff --git a/src/main.c b/src/main.c
index 08bef4a..53412c1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -187,6 +187,13 @@ static void parse_config(GKeyFile *config)
     } else
         main_opts.reverse_sdp = boolean;
 
+    boolean = g_key_file_get_boolean(config, "General",
+                        "NameResolving", &err);
+    if (err)
+        g_clear_error(&err);
+    else
+        main_opts.name_resolv = boolean;
+
     main_opts.link_mode = HCI_LM_ACCEPT;
 
     main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
@@ -304,6 +311,7 @@ static void init_defaults(void)
     main_opts.discovto    = HCID_DEFAULT_DISCOVERABLE_TIMEOUT;
     main_opts.remember_powered = TRUE;
     main_opts.reverse_sdp = TRUE;
+    main_opts.name_resolv = TRUE;
 
     if (gethostname(main_opts.host_name, sizeof(main_opts.host_name) - 
1) < 0)
         strcpy(main_opts.host_name, "noname");
diff --git a/src/main.conf b/src/main.conf
index c736e49..4f70a2c 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -46,3 +46,7 @@ RememberPowered = true
 # doesn't like us doing reverse SDP for some test cases (though there 
could in
 # theory be other useful purposes for this too). Defaults to true.
 ReverseServiceDiscovery = true
+
+# Enable name resolving after inquiry. Set it to 'false' if you don't need
+# remote devices name and want shorter discovery cycle. Default is 'true'
+NameResolving = true

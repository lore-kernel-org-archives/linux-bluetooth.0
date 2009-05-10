Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0653F6.4020501@gmail.com>
Date: Sun, 10 May 2009 08:11:34 +0400
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add DisableNameResolving option to main.conf
References: <4A02429C.8010201@gmail.com> <4A024529.90104@gmail.com>
In-Reply-To: <4A024529.90104@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I think I fixed coding style.. And it seems to work. And I think the 
code is quite understandble now :)


diff --git a/src/adapter.c b/src/adapter.c
index 500f82f..a7a02cc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
 -1076,7 +1076,8 @@ static int start_inquiry(struct btd_adapter *adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    if (!main_opts.disable_nameres)
+        adapter->state |= RESOLVE_NAME;
 
     return 0;
 }
 -1126,7 +1127,8 @@ static int start_periodic_inquiry(struct btd_adapter 
*adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    if (!main_opts.disable_nameres)
+        adapter->state |= RESOLVE_NAME;
 
     return 0;
 }
 -2446,7 +2448,8 @@ struct btd_adapter *adapter_create(DBusConnection 
*conn, int id,
     }
 
     adapter->dev_id = id;
-    adapter->state |= RESOLVE_NAME;
+    if (!main_opts.disable_nameres)
+        adapter->state |= RESOLVE_NAME;
     adapter->path = g_strdup(path);
     adapter->already_up = devup;
 
diff --git a/src/hcid.h b/src/hcid.h
index ae356d3..c10f65a 100644
--- a/src/hcid.h
+++ b/src/hcid.h
 -59,6 +59,7 @@ struct main_opts {
     uint16_t    link_policy;
     gboolean    remember_powered;
     gboolean    reverse_sdp;
+    gboolean    disable_nameres;
 
     uint8_t        scan;
     uint8_t        mode;
diff --git a/src/main.c b/src/main.c
index 08bef4a..d7d29b3 100644
--- a/src/main.c
+++ b/src/main.c
 -187,6 +187,13 @@ static void parse_config(GKeyFile *config)
     } else
         main_opts.reverse_sdp = boolean;
 
+    boolean = g_key_file_get_boolean(config, "General",
+                        "DisableNameResolving", &err);
+    if (err)
+        g_clear_error(&err);
+    else
+        main_opts.disable_nameres = boolean;
+
     main_opts.link_mode = HCI_LM_ACCEPT;
 
     main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
diff --git a/src/main.conf b/src/main.conf
index c736e49..0c6994a 100644
--- a/src/main.conf
+++ b/src/main.conf
 -46,3 +46,7 @@ RememberPowered = true
 # doesn't like us doing reverse SDP for some test cases (though there 
could in
 # theory be other useful purposes for this too). Defaults to true.
 ReverseServiceDiscovery = true
+
+# Disable name resolving after inquiry. Set it to 'true' if you don't need
+# remote devices name and want shorter discovery cycle
+DisableNameResolving = false

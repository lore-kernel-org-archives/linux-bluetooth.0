Return-Path: <cyrus@holtmann.org>
Message-ID: <4A024529.90104@gmail.com>
Date: Thu, 07 May 2009 06:19:21 +0400
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add DisableNameResolving option to main.conf
References: <4A02429C.8010201@gmail.com>
In-Reply-To: <4A02429C.8010201@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, there was mistake :(


diff --git a/src/adapter.c b/src/adapter.c
index 500f82f..02c6d9e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1076,7 +1076,7 @@ static int start_inquiry(struct btd_adapter *adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    adapter->state |= main_opts.disable_nameres;
 
     return 0;
 }
@@ -1126,7 +1126,7 @@ static int start_periodic_inquiry(struct 
btd_adapter *adapter)
 
     hci_close_dev(dd);
 
-    adapter->state |= RESOLVE_NAME;
+    adapter->state |= main_opts.disable_nameres;
 
     return 0;
 }
@@ -2446,7 +2446,7 @@ struct btd_adapter *adapter_create(DBusConnection 
*conn, int id,
     }
 
     adapter->dev_id = id;
-    adapter->state |= RESOLVE_NAME;
+    adapter->state |= main_opts.disable_nameres;
     adapter->path = g_strdup(path);
     adapter->already_up = devup;
 
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index e52b4f6..014360b 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -458,7 +458,7 @@ void hcid_dbus_inquiry_start(bdaddr_t *local)
     /* Disable name resolution for non D-Bus clients */
     if (!adapter_has_discov_sessions(adapter)) {
         state = adapter_get_state(adapter);
-        state &= ~RESOLVE_NAME;
+        state &= ~main_opts.disable_nameres;
         adapter_set_state(adapter, state);
     }
 }
@@ -687,7 +687,7 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, 
bdaddr_t *peer, uint32_t class,
     }
 
     /* the inquiry result can be triggered by NON D-Bus client */
-    if (adapter_get_state(adapter) & RESOLVE_NAME)
+    if (adapter_get_state(adapter) & main_opts.disable_nameres)
         name_status = NAME_REQUIRED;
     else
         name_status = NAME_NOT_REQUIRED;
diff --git a/src/hcid.h b/src/hcid.h
index ae356d3..efefa6c 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -59,6 +59,7 @@ struct main_opts {
     uint16_t    link_policy;
     gboolean    remember_powered;
     gboolean    reverse_sdp;
+    int        disable_nameres;
 
     uint8_t        scan;
     uint8_t        mode;
diff --git a/src/main.c b/src/main.c
index 08bef4a..5358db1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -187,6 +187,18 @@ static void parse_config(GKeyFile *config)
     } else
         main_opts.reverse_sdp = boolean;
 
+    boolean = g_key_file_get_boolean(config, "General",
+                        "DisableNameResolving", &err);
+    if (err) {
+        debug("%s", err->message);
+        g_clear_error(&err);
+    } else {       
+        if (boolean)
+            main_opts.disable_nameres = 0x00;
+        else
+            main_opts.disable_nameres = 0x10;
+    }
+
     main_opts.link_mode = HCI_LM_ACCEPT;
 
     main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
diff --git a/src/main.conf b/src/main.conf
index c736e49..75a8b04 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -46,3 +46,7 @@ RememberPowered = true
 # doesn't like us doing reverse SDP for some test cases (though there 
could in
 # theory be other useful purposes for this too). Defaults to true.
 ReverseServiceDiscovery = true
+
+# Disable name resolving after inquiry. Set it to 'true' if you don't 
need remote
+# devices name and want shorter discovery cycle
+DisableNameResolving = false

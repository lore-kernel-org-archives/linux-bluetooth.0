Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFBD3B6.6020706@gmx.de>
Date: Thu, 12 Nov 2009 10:21:58 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
CC: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de> <1257861916.10888.1372.camel@localhost.localdomain> <4AF97659.2050807@gmx.de>
In-Reply-To: <4AF97659.2050807@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I would like to explain in more detail why I use this option to start
bluetoothd without its own SDP-Server.

The goal is to test the SDP implementation of bluetooth-capable Daimler
headunits. For this i need my own SDP-Server implementation running,
cause this SDP Server answers with predefined and invalid SDP Responses
to special Requests from headunit.

The scenario is as follows:
1. Restart bluetoothd without its SDP Server and start my own SDP Server.
2. Wait for SDP Request of headunit to be able to inject the invalid SDP
Response.
3. Restart bluetoothd with its own SDP Server and wait for headunit to
connect successfully to our handsfree profile.

We need to perfom these kind of tests for robustness. This already
worked fine with the old versions of bluez running hcid instead of
bluetoothd. But with my patch I am able to run it again.

For my opinion this is not a use case for Daimler only, but for all
producers of Bluetooth-devices ( mobile phones etc. ) which need to
handle SDP Requests correctly and want to use Linux and bluez for
testing purposes. For me this is the best and easiest way for testing
Bluetooth-stuff like SDP implementation.

Below I provide the patch I am using. I would be happy if you (maybe
modify and ) add it, so i don't need to fix the bluez-source each time a
new release is available. But its up to you. :)

p.s.: As discussed with my project leader, Marcel Holtmann has been in
the Daimler lab in Sindelfingen already. I think he has a good idea of
what we are doing here. ( Just for the case my explanation of why i
appreciate such a fix was bad :))

Just let me know what decision you made.
Thanks a lot in any case.
_______________________________

diff -r -u bluez-4.51/debian/changelog bluez-4.51_patched/debian/changelog
--- bluez-4.51/debian/changelog    2009-11-10 09:57:06.000000000 +0100
+++ bluez-4.51_patched/debian/changelog    2009-11-10 09:55:43.000000000
+0100
@@ -1,3 +1,11 @@
+bluez (4.51-0ubuntu2-1) karmic; urgency=low
+
+  * patch orig source with 4.51.diff.gz provided by ubuntu
+  * patch bluetoothd so we are able to start without sdp server
+
+ -- Susanne Goldammer <susanne.goldammer@gmx.de>  Tue, 10 Nov 2009
10:00:24 +0200
+
+
 bluez (4.51-0ubuntu2) karmic; urgency=low
 
   * debian/patches/01_lower_sink_ranking.patch:
Nur in bluez-4.51/scripts: bluetooth.rules.
diff -r -u bluez-4.51/src/main.c bluez-4.51_patched/src/main.c
--- bluez-4.51/src/main.c    2009-08-01 21:47:07.000000000 +0200
+++ bluez-4.51_patched/src/main.c    2009-11-10 09:47:29.000000000 +0100
@@ -292,6 +292,8 @@
 static gboolean option_detach = TRUE;
 static gboolean option_debug = FALSE;
 static gboolean option_udev = FALSE;
+static gboolean option_runsdp = TRUE;
+
 
 static guint last_adapter_timeout = 0;
 
@@ -331,6 +333,9 @@
                 "Enable debug information output" },
     { "udev", 'u', 0, G_OPTION_ARG_NONE, &option_udev,
                 "Run from udev mode of operation" },
+        { "nosdp", 'S', G_OPTION_FLAG_REVERSE,
+                        G_OPTION_ARG_NONE, &option_runsdp,
+                        "Don't run SDP service (debuggin option)" },
     { NULL },
 };
 
@@ -416,7 +421,14 @@
         }
     }
 
-    start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
+        if (option_runsdp != 0) {
+               start_sdp_server(mtu, main_opts.deviceid,
SDP_SERVER_COMPAT);
+        }
+        else {
+               /* see scp-server.c: start_sdp_server() -> init_server() */
+               register_public_browse_group();
+               register_server_service();
+        }
 
     /* Loading plugins has to be done after D-Bus has been setup since
      * the plugins might wanna expose some paths on the bus. However the
@@ -445,7 +457,13 @@
 
     plugin_cleanup();
 
-    stop_sdp_server();
+    if (option_runsdp != 0) {
+        stop_sdp_server();
+    }
+    else {
+        /* see scp-server.c: stop_sdp_server() */
+        sdp_svcdb_reset();
+    }
 
     agent_exit();
 
Nur in bluez-4.51/tools: lexer.c.
Nur in bluez-4.51/tools: parser.c.
Nur in bluez-4.51/tools: parser.h.







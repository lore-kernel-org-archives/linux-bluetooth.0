Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFC1803.2080703@gmx.de>
Date: Thu, 12 Nov 2009 15:13:23 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de>	<1257861916.10888.1372.camel@localhost.localdomain>	<4AF97659.2050807@gmx.de>	<4AFBD3B6.6020706@gmx.de>	<20091112131357.1106213e@strolchi.home.s3e.de>	<4AFC05BD.40508@gmx.de> <20091112140840.1efa7475@strolchi.home.s3e.de>
In-Reply-To: <20091112140840.1efa7475@strolchi.home.s3e.de>
Content-Type: multipart/mixed;
 boundary="------------020406090700040502000504"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020406090700040502000504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

as discussed with seife :) here is a new patch made with bluez-4.57,
without debian extensions and no curly braces due to the mentioned
coding style.
I added it as attachment cause my mail program seems to change the tabs.
Let me know if it is still damaged. In my vi everything is ok with the tabs.

Here my short xplanation:
With the patch i wanted to change as few code as possible. So i replaced
the start_sdp_server() with the code executed before the l2cap socket is
created and server starts listening ( see init_server() in
sdpd-server.c). The same idea when stopping: Just omit the code
responsible for the socket creation and release.

Of course I am not sure if this is the best way cause i am not aware of
the thoughts, decisions and discussions which made the code becoming
what it is today. So i would really appreciate any explanation of why
someone would do it in another way.

Please let me know if it gets integrated into further bluez releases or
if any additional information is needed.

Thanks...


--------------020406090700040502000504
Content-Type: text/plain;
 name="no_sdp_server_option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no_sdp_server_option.patch"

diff -r -u bluez-4.57/src/main.c bluez-4.57_no_sdp_option/src/main.c
--- bluez-4.57/src/main.c	2009-10-04 05:56:37.000000000 +0200
+++ bluez-4.57_no_sdp_option/src/main.c	2009-11-12 14:38:16.000000000 +0100
@@ -296,6 +296,8 @@
 static gboolean option_detach = TRUE;
 static gboolean option_debug = FALSE;
 static gboolean option_udev = FALSE;
+static gboolean option_runsdp = TRUE;
+
 
 static guint last_adapter_timeout = 0;
 
@@ -335,6 +337,9 @@
 				"Enable debug information output" },
 	{ "udev", 'u', 0, G_OPTION_ARG_NONE, &option_udev,
 				"Run from udev mode of operation" },
+	{ "nosdp", 'S', G_OPTION_FLAG_REVERSE,
+				G_OPTION_ARG_NONE, &option_runsdp,
+				"Don't run SDP service (debuggin option)" },
 	{ NULL },
 };
 
@@ -429,7 +434,13 @@
 		}
 	}
 
-	start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
+	if (option_runsdp == TRUE)
+		start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
+	else {
+		/* see sdpd-server.c: start_sdp_server() -> init_server() */
+		register_public_browse_group();
+		register_server_service();
+	}
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
@@ -458,7 +469,11 @@
 
 	plugin_cleanup();
 
-	stop_sdp_server();
+	if (option_runsdp == TRUE) 
+		stop_sdp_server();
+	else
+		/* see sdpd-server.c: stop_sdp_server() */
+		sdp_svcdb_reset();
 
 	agent_exit();
 

--------------020406090700040502000504--

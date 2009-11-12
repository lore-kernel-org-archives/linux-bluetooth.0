Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFC26C3.50006@gmx.de>
Date: Thu, 12 Nov 2009 16:16:19 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de>	 <1257861916.10888.1372.camel@localhost.localdomain>	 <4AF97659.2050807@gmx.de>	<4AFBD3B6.6020706@gmx.de>	 <20091112131357.1106213e@strolchi.home.s3e.de>	<4AFC05BD.40508@gmx.de>	 <20091112140840.1efa7475@strolchi.home.s3e.de>  <4AFC1803.2080703@gmx.de> <1258037845.2158.0.camel@localhost.localdomain>
In-Reply-To: <1258037845.2158.0.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------070404050007040905010506"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070404050007040905010506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Bastien Nocera schrieb:
> On Thu, 2009-11-12 at 15:13 +0100, Susanne Goldammer wrote:
>   
>> +                               "Don't run SDP service (debuggin
>> option)" },
>>     
>
> Typo there: s/debuggin/debugging/
>
>   
Fixed. New patch attached.

--------------070404050007040905010506
Content-Type: text/plain;
 name="no_sdp_server_option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no_sdp_server_option.patch"

diff -r -u bluez-4.57/src/main.c bluez-4.57_no_sdp_option/src/main.c
--- bluez-4.57/src/main.c	2009-10-04 05:56:37.000000000 +0200
+++ bluez-4.57_no_sdp_option/src/main.c	2009-11-12 16:09:32.000000000 +0100
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
+				"Don't run SDP service (debugging option)" },
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
 

--------------070404050007040905010506--

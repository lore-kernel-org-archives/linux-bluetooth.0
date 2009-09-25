Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] misc fixups
Date: Fri, 25 Sep 2009 16:36:06 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909251636.06774.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was doing some code reviews of the 4.54 release and found a couple
things that should be fixed up. The first is that in audio/pcm_bluetooth.c,
a data structure is being overrun. Because the underlying buffer is 512 
bytes, no overflow really occurs. What appears to happen is too much 
data gets copied. 

The other issue is in  cups/main.c, error is a stack variable and its address
cannot be NULL. So, no need to check its value.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>


diff -urp bluez-4.54.orig/audio/pcm_bluetooth.c bluez-4.54/audio/pcm_bluetooth.c
--- bluez-4.54.orig/audio/pcm_bluetooth.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/audio/pcm_bluetooth.c	2009-09-25 14:35:35.000000000 -0400
@@ -729,7 +729,7 @@ static int bluetooth_a2dp_hw_params(snd_
 	req->h.length = sizeof(*req);
 
 	memcpy(&req->codec, &a2dp->sbc_capabilities,
-			sizeof(a2dp->sbc_capabilities));
+			sizeof(req->codec));
 
 	req->codec.transport = BT_CAPABILITIES_TRANSPORT_A2DP;
 	req->codec.length = sizeof(a2dp->sbc_capabilities);
diff -urp bluez-4.54.orig/cups/main.c bluez-4.54/cups/main.c
--- bluez-4.54.orig/cups/main.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/cups/main.c	2009-09-25 14:48:46.000000000 -0400
@@ -426,7 +426,7 @@ static gboolean list_known_printers(cons
 
 	dbus_message_unref(message);
 
-	if (&error != NULL && dbus_error_is_set(&error))
+	if (dbus_error_is_set(&error))
 		return FALSE;
 
 	dbus_message_iter_init(reply, &reply_iter);
@@ -527,7 +527,7 @@ static gboolean list_printers(void)
 
 	dbus_error_init(&error);
 	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
-	if (&error != NULL && dbus_error_is_set(&error))
+	if (dbus_error_is_set(&error))
 		return TRUE;
 
 	if (!hcid_exists)
@@ -547,7 +547,7 @@ static gboolean list_printers(void)
 
 	dbus_message_unref(message);
 
-	if (&error != NULL && dbus_error_is_set(&error)) {
+	if (dbus_error_is_set(&error)) {
 		dbus_connection_unref(conn);
 		/* No adapter */
 		return TRUE;

Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] misc fixups
Date: Mon, 28 Sep 2009 10:08:24 -0400
References: <200909251636.06774.sgrubb@redhat.com> <2d5a2c100909261529j700b78a6p12fdfc27f81f1015@mail.gmail.com>
In-Reply-To: <2d5a2c100909261529j700b78a6p12fdfc27f81f1015@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200909281008.24999.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 26 September 2009 06:29:14 pm you wrote:
> > The first is that in audio/pcm_bluetooth.c, a data structure is being
> > overrun. Because the underlying buffer is 512 bytes, no overflow really
> > occurs. What appears to happen is too much data gets copied.
> >
> > diff -urp bluez-4.54.orig/audio/pcm_bluetooth.c
> > bluez-4.54/audio/pcm_bluetooth.c ---
> > bluez-4.54.orig/audio/pcm_bluetooth.c       2009-09-25 11:33:47.000000000
> > -0400 +++ bluez-4.54/audio/pcm_bluetooth.c    2009-09-25
> > 14:35:35.000000000 -0400 @@ -729,7 +729,7 @@ static int
> > bluetooth_a2dp_hw_params(snd_
> >        req->h.length = sizeof(*req);
> >
> >        memcpy(&req->codec, &a2dp->sbc_capabilities,
> > -                       sizeof(a2dp->sbc_capabilities));
> > +                       sizeof(req->codec));
> 
> Be careful that this structs are different, we really want to copy sbc
> codec capabilities which is used to configure latter.

OK, I see the uint8_t data[0] in codec_capabilities_t which usually means data
to follow. Missed that. OK, the revised patch would just drop that.

-Steve


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

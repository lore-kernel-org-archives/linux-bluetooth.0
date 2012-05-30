Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 21:32:27 +0300
From: Ido Yariv <ido@wizery.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Fix multiple channels detaching mix-up
Message-ID: <20120530183227.GA16709@WorkStation.localnet>
References: <1338322808-15503-1-git-send-email-ido@wizery.com>
 <20120530073701.GB6539@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120530073701.GB6539@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, May 30, 2012 at 10:37:01AM +0300, Johan Hedberg wrote:
> Hi Ido,
> 
> On Tue, May 29, 2012, Ido Yariv wrote:
> > The identifier returned by g_attrib_register is not unique across
> > different channels. Since attrib_channel_detach assumes this identifier
> > to be unique, it may end up detaching the wrong channel when a device
> > disconnects.
> > 
> > Fix this by using the channel's pointer as a unique identifier for
> > detaching the channel. The identifier returned from g_attrib_register
> > will still be used to find the relevant event structure.
> > ---
> >  src/attrib-server.c |   22 +++++++---------------
> >  1 files changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/src/attrib-server.c b/src/attrib-server.c
> > index dd1bba4..39085de 100644
> > --- a/src/attrib-server.c
> > +++ b/src/attrib-server.c
> > @@ -72,7 +72,7 @@ struct gatt_channel {
> >  	GAttrib *attrib;
> >  	guint mtu;
> >  	gboolean le;
> > -	guint id;
> > +	guint event_id;
> >  	gboolean encrypted;
> >  	struct gatt_server *server;
> >  	guint cleanup_id;
> > @@ -1077,8 +1077,8 @@ guint attrib_channel_attach(GAttrib *attrib)
> >  
> >  
> >  	channel->attrib = g_attrib_ref(attrib);
> > -	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
> > -					channel_handler, channel, NULL);
> > +	channel->event_id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
> > +						channel_handler, channel, NULL);
> >  
> >  	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
> >  								channel);
> > @@ -1087,15 +1087,7 @@ guint attrib_channel_attach(GAttrib *attrib)
> >  
> >  	server->clients = g_slist_append(server->clients, channel);
> >  
> > -	return channel->id;
> > -}
> > -
> > -static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
> > -{
> > -	const struct gatt_channel *channel = data;
> > -	guint id = GPOINTER_TO_UINT(user_data);
> > -
> > -	return channel->id - id;
> > +	return GPOINTER_TO_UINT(channel);
> 
> I don't think converting a pointer to uint is safe since some systems
> can have 64-bit pointers but 32-bit uints. These macros are therefore
> only safe to be used in the other direction, i.e. when starting off with
> an uint and passing it to an API that expects a pointer.

You're absolutely right, good catch!

How about the below patch? Instead of casting to and from guint, we can
simply work with gpointer instead.

Thanks,
Ido.

>From 78254bb099f80ad38e10075fbb73a4d990217630 Mon Sep 17 00:00:00 2001
From: Ido Yariv <ido@wizery.com>
Date: Tue, 29 May 2012 21:11:16 +0300
Subject: [PATCH v2] attrib-server: Fix multiple channels detaching mix-up

The identifier returned by g_attrib_register is not unique across
different channels. Since attrib_channel_detach assumes this identifier
to be unique, it may end up detaching the wrong channel when a device
disconnects.

Fix this by using the channel's pointer as a unique identifier for
detaching the channel. The identifier returned from g_attrib_register
will still be used to find the relevant event structure.
---
 src/attrib-server.c |   26 +++++++++-----------------
 src/attrib-server.h |    4 ++--
 src/device.c        |    6 +++---
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index a6262d0..db2c52d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -73,7 +73,7 @@ struct gatt_channel {
 	GAttrib *attrib;
 	guint mtu;
 	gboolean le;
-	guint id;
+	guint event_id;
 	gboolean encrypted;
 	struct gatt_server *server;
 	guint cleanup_id;
@@ -1023,7 +1023,7 @@ done:
 							NULL, NULL, NULL);
 }
 
-guint attrib_channel_attach(GAttrib *attrib)
+gpointer attrib_channel_attach(GAttrib *attrib)
 {
 	struct gatt_server *server;
 	struct btd_device *device;
@@ -1078,8 +1078,8 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 
 	channel->attrib = g_attrib_ref(attrib);
-	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
-					channel_handler, channel, NULL);
+	channel->event_id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
+						channel_handler, channel, NULL);
 
 	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
 								channel);
@@ -1088,18 +1088,10 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 	server->clients = g_slist_append(server->clients, channel);
 
-	return channel->id;
+	return (gpointer)channel;
 }
 
-static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
-{
-	const struct gatt_channel *channel = data;
-	guint id = GPOINTER_TO_UINT(user_data);
-
-	return channel->id - id;
-}
-
-gboolean attrib_channel_detach(GAttrib *attrib, guint id)
+gboolean attrib_channel_detach(GAttrib *attrib, gpointer id)
 {
 	struct gatt_server *server;
 	struct gatt_channel *channel;
@@ -1123,14 +1115,14 @@ gboolean attrib_channel_detach(GAttrib *attrib, guint id)
 	if (server == NULL)
 		return FALSE;
 
-	l = g_slist_find_custom(server->clients, GUINT_TO_POINTER(id),
-								channel_id_cmp);
+	/* Make sure the channel was not already freed */
+	l = g_slist_find(server->clients, id);
 	if (!l)
 		return FALSE;
 
 	channel = l->data;
 
-	g_attrib_unregister(channel->attrib, channel->id);
+	g_attrib_unregister(channel->attrib, channel->event_id);
 	channel_remove(channel);
 
 	return TRUE;
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 7af0cfa..895d9ef 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -36,5 +36,5 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-guint attrib_channel_attach(GAttrib *attrib);
-gboolean attrib_channel_detach(GAttrib *attrib, guint id);
+gpointer attrib_channel_attach(GAttrib *attrib);
+gboolean attrib_channel_detach(GAttrib *attrib, gpointer id);
diff --git a/src/device.c b/src/device.c
index 7ff09aa..543055f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -154,7 +154,7 @@ struct btd_device {
 	GAttrib		*attrib;
 	GSList		*attios;
 	GSList		*attios_offline;
-	guint		attachid;		/* Attrib server attach */
+	gpointer	attachid;		/* Attrib server attach */
 	guint		auto_id;		/* Auto connect source id */
 
 	gboolean	connected;
@@ -205,7 +205,7 @@ static void att_cleanup(struct btd_device *device)
 {
 	if (device->attachid) {
 		attrib_channel_detach(device->attrib, device->attachid);
-		device->attachid = 0;
+		device->attachid = NULL;
 	}
 
 	if (device->cleanup_id) {
@@ -1944,7 +1944,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	attrib = g_attrib_new(io);
 	device->attachid = attrib_channel_attach(attrib);
-	if (device->attachid == 0)
+	if (device->attachid == NULL)
 		error("Attribute server attach failure!");
 
 	device->attrib = attrib;
-- 
1.7.7.6


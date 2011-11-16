Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC3B375.8090203@bmw-carit.de>
Date: Wed, 16 Nov 2011 13:58:29 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Subject: [PATCH 3/3] a2dp: avoid conversion between guint and pointers
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These conversions might cause a segmentation fault in 64 bit machines.
---
  audio/a2dp.c |   65 
++++++++++++++++++++++++++++++++++++++++++++++++++++-----
  1 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 75ad6ce..956ded1 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -4,6 +4,7 @@
   *
   *  Copyright (C) 2006-2010  Nokia Corporation
   *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
   *
   *
   *  This program is free software; you can redistribute it and/or modify
@@ -51,6 +52,7 @@
   * STREAMING state. */
  #define SUSPEND_TIMEOUT 5
  #define RECONFIGURE_TIMEOUT 500
+#define MAX_SETUP_COUNT 32
   #ifndef MIN
  # define MIN(x, y) ((x) < (y) ? (x) : (y))
@@ -75,6 +77,7 @@ struct a2dp_sep {
  	gboolean starting;
  	void *user_data;
  	GDestroyNotify destroy;
+	struct a2dp_setup *pending_setups[MAX_SETUP_COUNT];
  };
   struct a2dp_setup_cb {
@@ -638,15 +641,35 @@ static gboolean mpeg_getcap_ind(struct avdtp *session,
  	return TRUE;
  }
  +static guint register_pending_setup(struct a2dp_sep *a2dp_sep,
+					struct a2dp_setup *setup)
+{
+	guint setup_id;
+
+	for (setup_id = 1; setup_id < MAX_SETUP_COUNT; setup_id++)
+		if (a2dp_sep->pending_setups[setup_id] == NULL) {
+			a2dp_sep->pending_setups[setup_id] = setup;
+			break;
+		}
+
+	if (setup_id == MAX_SETUP_COUNT)
+		return 0;
+
+	return setup_id;
+}
+
  static void endpoint_setconf_cb(struct a2dp_sep *sep, guint setup_id,
  								gboolean ret)
  {
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
+	struct a2dp_setup *setup = sep->pending_setups[setup_id];
+
+	sep->pending_setups[setup_id] = NULL;
   	if (ret == FALSE) {
  		setup->err = g_new(struct avdtp_error, 1);
  		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
  					AVDTP_UNSUPPORTED_CONFIGURATION);
+		return;
  	}
   	auto_config(setup);
@@ -680,6 +703,7 @@ static gboolean endpoint_setconf_ind(struct avdtp 
*session,
  		struct avdtp_service_capability *cap = caps->data;
  		struct avdtp_media_codec_capability *codec;
  		gboolean ret;
+		guint setup_id;
   		if (cap->category == AVDTP_DELAY_REPORTING &&
  					!a2dp_sep->delay_reporting) {
@@ -701,10 +725,19 @@ static gboolean endpoint_setconf_ind(struct avdtp 
*session,
  			goto done;
  		}
  +		setup_id = register_pending_setup(a2dp_sep, setup);
+
+		if (setup_id == 0) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_SEP_IN_USE);
+			goto done;
+		}
+
  		ret = a2dp_sep->endpoint->set_configuration(a2dp_sep,
  						setup->dev, codec->data,
  						cap->length - sizeof(*codec),
-						GPOINTER_TO_UINT(setup),
+						setup_id,
  						endpoint_setconf_cb,
  						a2dp_sep->user_data);
  		if (ret == 0)
@@ -771,9 +804,11 @@ static gboolean endpoint_getcap_ind(struct avdtp 
*session,
  static void endpoint_open_cb(struct a2dp_sep *sep, guint setup_id,
  								gboolean ret)
  {
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
+	struct a2dp_setup *setup = sep->pending_setups[setup_id];
  	int err;
  +	sep->pending_setups[setup_id] = NULL;
+
  	if (ret == FALSE) {
  		setup->stream = NULL;
  		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
@@ -832,14 +867,24 @@ static void setconf_cfm(struct avdtp *session, 
struct avdtp_local_sep *sep,
  		struct avdtp_service_capability *service;
  		struct avdtp_media_codec_capability *codec;
  		int err;
+		guint setup_id;
   		service = avdtp_stream_get_codec(stream);
  		codec = (struct avdtp_media_codec_capability *) service->data;
  +		setup_id = register_pending_setup(a2dp_sep, setup);
+
+		if (setup_id == 0) {
+			setup->stream = NULL;
+			finalize_setup_errno(setup, -EPERM, finalize_config,
+						NULL);
+			return;
+		}
+
  		err = a2dp_sep->endpoint->set_configuration(a2dp_sep, dev,
  						codec->data, service->length -
  						sizeof(*codec),
-						GPOINTER_TO_UINT(setup),
+						setup_id,
  						endpoint_open_cb,
  						a2dp_sep->user_data);
  		if (err == 0)
@@ -1888,10 +1933,12 @@ static gboolean select_capabilities(struct avdtp 
*session,
  static void select_cb(struct a2dp_sep *sep, guint setup_id, void *ret,
  								int size)
  {
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
+	struct a2dp_setup *setup = sep->pending_setups[setup_id];
  	struct avdtp_service_capability *media_transport, *media_codec;
  	struct avdtp_media_codec_capability *cap;
  +	sep->pending_setups[setup_id] = NULL;
+
  	if (size < 0) {
  		DBG("Endpoint replied an invalid configuration");
  		goto done;
@@ -1987,6 +2034,7 @@ unsigned int a2dp_select_capabilities(struct avdtp 
*session,
  	struct avdtp_service_capability *service;
  	struct avdtp_media_codec_capability *codec;
  	int err;
+	guint setup_id;
   	sep = a2dp_select_sep(session, type, sender);
  	if (!sep) {
@@ -2027,9 +2075,14 @@ unsigned int a2dp_select_capabilities(struct 
avdtp *session,
  	service = avdtp_get_codec(setup->rsep);
  	codec = (struct avdtp_media_codec_capability *) service->data;
  +	setup_id = register_pending_setup(sep, setup);
+
+	if (setup_id == 0)
+		goto fail;
+
  	err = sep->endpoint->select_configuration(sep, codec->data,
  					service->length - sizeof(*codec),
-					GPOINTER_TO_UINT(setup),
+					setup_id,
  					select_cb, sep->user_data);
  	if (err == 0)
  		return cb_data->id;
-- 
1.7.6.4


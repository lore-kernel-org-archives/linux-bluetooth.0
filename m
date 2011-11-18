Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2] a2dp: avoid conversion between guint and pointers
Date: Fri, 18 Nov 2011 09:59:04 +0100
Message-ID: <1321606744-3605-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These conversions might cause a segmentation fault in 64 bit machines.
---
 audio/a2dp.c  |   21 ++++++++-------------
 audio/a2dp.h  |   13 +++++++------
 audio/media.c |   18 ++++++++++--------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 75ad6ce..5ca105c 100644
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
@@ -638,11 +639,9 @@ static gboolean mpeg_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void endpoint_setconf_cb(struct a2dp_sep *sep, guint setup_id,
-								gboolean ret)
-{
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 
+static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
+{
 	if (ret == FALSE) {
 		setup->err = g_new(struct avdtp_error, 1);
 		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
@@ -704,7 +703,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 		ret = a2dp_sep->endpoint->set_configuration(a2dp_sep,
 						setup->dev, codec->data,
 						cap->length - sizeof(*codec),
-						GPOINTER_TO_UINT(setup),
+						setup,
 						endpoint_setconf_cb,
 						a2dp_sep->user_data);
 		if (ret == 0)
@@ -768,10 +767,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void endpoint_open_cb(struct a2dp_sep *sep, guint setup_id,
-								gboolean ret)
+static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
 {
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 	int err;
 
 	if (ret == FALSE) {
@@ -839,7 +836,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		err = a2dp_sep->endpoint->set_configuration(a2dp_sep, dev,
 						codec->data, service->length -
 						sizeof(*codec),
-						GPOINTER_TO_UINT(setup),
+						setup,
 						endpoint_open_cb,
 						a2dp_sep->user_data);
 		if (err == 0)
@@ -1885,10 +1882,8 @@ static gboolean select_capabilities(struct avdtp *session,
 	return TRUE;
 }
 
-static void select_cb(struct a2dp_sep *sep, guint setup_id, void *ret,
-								int size)
+static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 {
-	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_media_codec_capability *cap;
 
@@ -2029,7 +2024,7 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 
 	err = sep->endpoint->select_configuration(sep, codec->data,
 					service->length - sizeof(*codec),
-					GPOINTER_TO_UINT(setup),
+					setup,
 					select_cb, sep->user_data);
 	if (err == 0)
 		return cb_data->id;
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 1637580..887c5ac 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -120,11 +121,11 @@ struct mpeg_codec_cap {
 #endif
 
 struct a2dp_sep;
+struct a2dp_setup;
 
-typedef void (*a2dp_endpoint_select_t) (struct a2dp_sep *sep, guint setup_id,
-							void *ret, int size);
-typedef void (*a2dp_endpoint_config_t) (struct a2dp_sep *sep, guint setup_id,
-								gboolean ret);
+typedef void (*a2dp_endpoint_select_t) (struct a2dp_setup *setup, void *ret,
+					int size);
+typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup, gboolean ret);
 
 struct a2dp_endpoint {
 	const char *(*get_name) (struct a2dp_sep *sep, void *user_data);
@@ -134,14 +135,14 @@ struct a2dp_endpoint {
 	int (*select_configuration) (struct a2dp_sep *sep,
 						uint8_t *capabilities,
 						size_t length,
-						guint setup_id,
+						struct a2dp_setup *setup,
 						a2dp_endpoint_select_t cb,
 						void *user_data);
 	int (*set_configuration) (struct a2dp_sep *sep,
 						struct audio_device *dev,
 						uint8_t *configuration,
 						size_t length,
-						guint setup_id,
+						struct a2dp_setup *setup,
 						a2dp_endpoint_config_t cb,
 						void *user_data);
 	void (*clear_configuration) (struct a2dp_sep *sep, void *user_data);
diff --git a/audio/media.c b/audio/media.c
index 612408c..a2ef437 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -481,12 +482,12 @@ static size_t get_capabilities(struct a2dp_sep *sep, uint8_t **capabilities,
 }
 
 struct a2dp_config_data {
-	guint setup_id;
+	struct a2dp_setup *setup;
 	a2dp_endpoint_config_t cb;
 };
 
 struct a2dp_select_data {
-	guint setup_id;
+	struct a2dp_setup *setup;
 	a2dp_endpoint_select_t cb;
 };
 
@@ -495,18 +496,18 @@ static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
 {
 	struct a2dp_select_data *data = user_data;
 
-	data->cb(endpoint->sep, data->setup_id, ret, size);
+	data->cb(data->setup, ret, size);
 }
 
 static int select_config(struct a2dp_sep *sep, uint8_t *capabilities,
-				size_t length, guint setup_id,
+				size_t length, struct a2dp_setup *setup,
 				a2dp_endpoint_select_t cb, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 	struct a2dp_select_data *data;
 
 	data = g_new0(struct a2dp_select_data, 1);
-	data->setup_id = setup_id;
+	data->setup = setup;
 	data->cb = cb;
 
 	if (select_configuration(endpoint, capabilities, length,
@@ -522,19 +523,20 @@ static void config_cb(struct media_endpoint *endpoint, void *ret, int size,
 {
 	struct a2dp_config_data *data = user_data;
 
-	data->cb(endpoint->sep, data->setup_id, ret ? TRUE : FALSE);
+	data->cb(data->setup, ret ? TRUE : FALSE);
 }
 
 static int set_config(struct a2dp_sep *sep, struct audio_device *dev,
 				uint8_t *configuration, size_t length,
-				guint setup_id, a2dp_endpoint_config_t cb,
+				struct a2dp_setup *setup,
+				a2dp_endpoint_config_t cb,
 				void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 	struct a2dp_config_data *data;
 
 	data = g_new0(struct a2dp_config_data, 1);
-	data->setup_id = setup_id;
+	data->setup = setup;
 	data->cb = cb;
 
 	if (set_configuration(endpoint, dev, configuration, length,
-- 
1.7.6.4


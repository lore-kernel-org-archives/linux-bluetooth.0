Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDNh5lvI"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C040100
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:14 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d6b9143782so55373017b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414693; x=1703019493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uujfn7iiFS8v3L+hrQnUGuHxUzCMZBZ+4Uxi8SEmPS0=;
        b=BDNh5lvIQm3j+gvTlH86mwLm7EUKg9X29wY6Qq7VnBsQEfqA2GrHPfQahxix1ugJRn
         m4wH4vue6xQh/ZLoWKrU3cq5XYsR88JesBlFj6sf6r1YPjf+llkmHgR/xC9dM0zo/95i
         bNXS1MeuZWVC2lqi9Z6ghl5INHU0XamWSnSIyvOTEfGxprSzaeN/5NJFkz/teKJ3lmMQ
         Qo6dhmfW0YcOJErNj1I2BblusiZhRHWVKCd/1G4XFluojARpSoizZFkQd5boMTBvV5az
         bJzc4inQNF4dnQQDcuEFQksSfygnOUKy/MFmbd4tPFLJldCRCNN5adtT9VDtDI3LV2vD
         whpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414693; x=1703019493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uujfn7iiFS8v3L+hrQnUGuHxUzCMZBZ+4Uxi8SEmPS0=;
        b=jXbwkBaKtbhcLYoJzfFWACjMaJwp9uShgo10LiFnkFxDjRFX+JcHcy8GBqD9AgRooo
         8RwGbGuiMCrBjlT7IAK8PidxIJuUPILCbmbvuXSuJZrjn8j9qTcCAFPpudcaN0QZJveT
         vq0JH/XdHx1T7JBLvAGT2XWrVvWNx6p3NZWGcYIQjMS9Rx5B+3ZC0fXkNj0XVjuSxuEV
         vUYeYEQsXMfqIxNbVm1sOl6GUwwEuzFPEGJ+zQgLAUenUcXHuFHbC/BWBu3laHVk8L0+
         NuAHg2C7wy1nDsP0BJn1NLowhEoJMsUBedi9O/0QLgH4LjO67Twoid5/66MGTakhJXs+
         aoKg==
X-Gm-Message-State: AOJu0Yx96YYAuBqYhxlpYFVgvE/mJSz3w0LxvE3VtqKv42vZprJ+Zkwa
	hlr+62mgFO1nUyZRLtSdno4tkOuiUnM=
X-Google-Smtp-Source: AGHT+IFjGuVg+2HC3CWsk2JSVCWR2tEQNg3ox1dAxUrInDQ6lxt7nxxGfsw58gefcKeSpewK2vZvaw==
X-Received: by 2002:a0d:f641:0:b0:5d7:1940:7d6c with SMTP id g62-20020a0df641000000b005d719407d6cmr5872566ywf.67.1702414692608;
        Tue, 12 Dec 2023 12:58:12 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id i16-20020a0ddf10000000b005e28951e3a4sm144735ywe.51.2023.12.12.12.58.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:58:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/6] shared/bap: Make bt_bap_select select a location
Date: Tue, 12 Dec 2023 15:58:02 -0500
Message-ID: <20231212205804.881265-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212205804.881265-1-luiz.dentz@gmail.com>
References: <20231212205804.881265-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_select select a location based on the PAC channel
count and PACS locations, this is then passed to the Endpoint as a
recommended ChannelAllocation.
---
 profiles/audio/media.c |  6 ++-
 src/shared/bap.c       | 97 ++++++++++++++++++++++++++++--------------
 src/shared/bap.h       |  2 +-
 3 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 62f53defa7af..b17c555b63e4 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -921,7 +921,7 @@ done:
 }
 
 static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
+			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -969,6 +969,10 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
 									&loc);
 
+	if (chan_alloc)
+		g_dbus_dict_append_entry(&dict, "ChannelAllocation",
+					 DBUS_TYPE_UINT32, &chan_alloc);
+
 	if (metadata) {
 		key = "Metadata";
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index cb505d1564d6..af2cc1ef1eb0 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -177,6 +177,11 @@ struct bt_bap {
 	void *user_data;
 };
 
+struct bt_bap_chan {
+	uint8_t count;
+	uint32_t location;
+};
+
 struct bt_bap_pac {
 	struct bt_bap_db *bdb;
 	char *name;
@@ -185,7 +190,7 @@ struct bt_bap_pac {
 	struct bt_bap_pac_qos qos;
 	struct iovec *data;
 	struct iovec *metadata;
-	struct queue *chan_map;
+	struct queue *channels;
 	struct bt_bap_pac_ops *ops;
 	void *user_data;
 };
@@ -2422,19 +2427,22 @@ static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 					void *user_data)
 {
 	struct bt_bap_pac *pac = user_data;
+	struct bt_bap_chan *chan;
 
 	if (!v)
 		return;
 
-	if (!pac->chan_map)
-		pac->chan_map = queue_new();
+	if (!pac->channels)
+		pac->channels = queue_new();
 
-	printf("PAC %p chan_map 0x%02x\n", pac, *v);
+	chan = new0(struct bt_bap_chan, 1);
+	chan->count = *v;
+	chan->location = bt_bap_pac_get_locations(pac) ? : pac->qos.location;
 
-	queue_push_tail(pac->chan_map, UINT_TO_PTR(*v));
+	queue_push_tail(pac->channels, chan);
 }
 
-static void bap_pac_update_chan_map(struct bt_bap_pac *pac, struct iovec *data)
+static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec *data)
 {
 	uint8_t type = 0x03;
 
@@ -2454,8 +2462,8 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 	else
 		pac->data = util_iov_dup(data, 1);
 
-	/* Update channel map */
-	bap_pac_update_chan_map(pac, data);
+	/* Update channels */
+	bap_pac_update_channels(pac, data);
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
@@ -2495,7 +2503,7 @@ static void bap_pac_free(void *data)
 	free(pac->name);
 	util_iov_free(pac->metadata, 1);
 	util_iov_free(pac->data, 1);
-	queue_destroy(pac->chan_map, NULL);
+	queue_destroy(pac->channels, free);
 	free(pac);
 }
 
@@ -4677,34 +4685,57 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	if (!lpac->ops || !lpac->ops->select)
 		return -EOPNOTSUPP;
 
-	for (lchan = queue_get_entries(lpac->chan_map); lchan;
+	for (lchan = queue_get_entries(lpac->channels); lchan;
 					lchan = lchan->next) {
-		uint8_t lmap = PTR_TO_UINT(lchan->data);
+		struct bt_bap_chan *lc = lchan->data;
+		struct bt_bap_chan map = *lc;
+		int i;
 
-		for (rchan = queue_get_entries(rpac->chan_map); rchan;
-					rchan = rchan->next) {
-			uint8_t rmap = PTR_TO_UINT(rchan->data);
+		for (i = 0, rchan = queue_get_entries(rpac->channels); rchan;
+					rchan = rchan->next, i++) {
+			struct bt_bap_chan *rc = rchan->data;
 
-			printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap);
-
-			/* Try matching the channel mapping */
-			if (lmap & rmap) {
-				lpac->ops->select(lpac, rpac, &rpac->qos,
-							func, user_data,
-							lpac->user_data);
-				if (count)
-					(*count)++;
-
-				/* Check if there are any channels left */
-				lmap &= ~(lmap & rmap);
-				if (!lmap)
-					break;
-
-				/* Check if device require AC*(i) settings */
-				if (rmap == 0x01)
-					lmap = lmap >> 1;
-			} else
+			/* Try matching the channel count */
+			if (!(map.count & rc->count))
 				break;
+
+			/* Check if location was set otherwise attempt to
+			 * assign one based on the number of channels it
+			 * supports.
+			 */
+			if (!rc->location) {
+				rc->location = bt_bap_pac_get_locations(rpac);
+				/* If channel count is 1 use a single
+				 * location
+				 */
+				if (rc->count == 0x01)
+					rc->location &= BIT(i);
+			}
+
+			/* Try matching the channel location */
+			if (!(map.location & rc->location))
+				break;
+
+			lpac->ops->select(lpac, rpac, map.location &
+						rc->location, &rpac->qos,
+						func, user_data,
+						lpac->user_data);
+			if (count)
+				(*count)++;
+
+			/* Check if there are any channels left to select */
+			map.count &= ~(map.count & rc->count);
+			if (!map.count)
+				break;
+
+			/* Check if there are any locations left to select */
+			map.location &= ~(map.location & rc->location);
+			if (!map.location)
+				break;
+
+			/* Check if device require AC*(i) settings */
+			if (rc->count == 0x01)
+				map.count = map.count >> 1;
 		}
 	}
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 470313e66fc0..9be198cec72c 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -151,7 +151,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 
 struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
+			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
 	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
-- 
2.43.0


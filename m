Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvJVBE3B"
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D20FCE
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:27 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9dadc3dc0so3614180a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329926; x=1702934726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s9zw6sFAj2uN5oaMFp5Z/ao9DhQ3lSa9x6vbe29U+4=;
        b=UvJVBE3B1xSmIJ8ZZuRTynSpbfgK0uHZc4aESGpW1q9ILzJn2XuVmb9/UU2Ji/Lh8+
         iOM7gRH2CZD/vmAyTi6Ral/jJejmFF2w7F4oBJz/FwkDVxBX2ZV/6VkgR5hmdbIGow7F
         Ooy08ZcX2paPReOv0tqa8zNKSY+k7ItW1AhMsfTDvnIS9q8Wym/RnXt88d0CkhV1wSeN
         QMgU/ZasezDBMbErQmhkiHymGf44YmTgqD3FinMZFkyinx4Rl6vxb5PMzSNX3djBy9dV
         Ynk86dVCgG3uZpUVbMm0ztRHKHEzkZMqUi0brQl8o2l0Tuit2YaCaXmaF6JA0jyAKmS9
         aFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329926; x=1702934726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s9zw6sFAj2uN5oaMFp5Z/ao9DhQ3lSa9x6vbe29U+4=;
        b=OTQhIQwkHom2PPwFacRBlvn821AyR7J2XzOFHPQT7UQ8ppa5N6StQSoFXlz4etYQEF
         txXXlyeIivrMYqPD3s1Nxxk8ZNiAwLw8YIh6HdXA95rltxoJHFJUY1vvrIrfrN2HHrZe
         vyYEG83wMdC1h/oKvwJnLt6EQkaErrJniIqCOcoTYEoIlSok9joHLP/BWQ+ZOfnOQ8ej
         Orj9BpjWlMVUMPYd2XyIFONGHOm/GhJ6qFpUBDHrL8BDOwgUfSPcQXPOqo3yQGusUVcC
         JicucIbup6junIZYrrFWEp3fQ5NXPQOhPdrJ2rATI2LwOAg3fRC6FFBxF9yo13WTkGsY
         QP+g==
X-Gm-Message-State: AOJu0YzsqsK9hW7jkvKXIic9KazaIgg2IYrxuCkCEp8iB4Jv4AHK3Pi/
	4m3bEH+S5mCRe9xwUpbWbzscNNBIBMA=
X-Google-Smtp-Source: AGHT+IECa7h8iX5zOEulEw++c9i1YtTNS+0blh4dDC0wkgnvcvGIWfLpJKyCY+b+W732U48DD051yQ==
X-Received: by 2002:a9d:76d7:0:b0:6d9:d36a:8cc0 with SMTP id p23-20020a9d76d7000000b006d9d36a8cc0mr4555240otl.28.1702329925658;
        Mon, 11 Dec 2023 13:25:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id s38-20020a0568302aa600b006da11489f70sm873757otu.44.2023.12.11.13.25.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:25:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/6] shared/bap: Make bt_bap_select select a location
Date: Mon, 11 Dec 2023 16:25:14 -0500
Message-ID: <20231211212516.577426-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211212516.577426-1-luiz.dentz@gmail.com>
References: <20231211212516.577426-1-luiz.dentz@gmail.com>
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
 src/shared/bap.c       | 88 +++++++++++++++++++++++++++---------------
 src/shared/bap.h       |  2 +-
 3 files changed, 63 insertions(+), 33 deletions(-)

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
index cb505d1564d6..e1dad95aca99 100644
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
 
@@ -4677,34 +4685,52 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	if (!lpac->ops || !lpac->ops->select)
 		return -EOPNOTSUPP;
 
-	for (lchan = queue_get_entries(lpac->chan_map); lchan;
+	for (lchan = queue_get_entries(lpac->channels); lchan;
 					lchan = lchan->next) {
-		uint8_t lmap = PTR_TO_UINT(lchan->data);
+		struct bt_bap_chan *lc = lchan->data;
+		uint8_t lmap = lc->count;
+		int i;
 
-		for (rchan = queue_get_entries(rpac->chan_map); rchan;
-					rchan = rchan->next) {
-			uint8_t rmap = PTR_TO_UINT(rchan->data);
+		printf("lmap 0x%02x\n", lmap);
 
-			printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap);
+		for (i = 0, rchan = queue_get_entries(rpac->channels); rchan;
+					rchan = rchan->next, i++) {
+			struct bt_bap_chan *rc = rchan->data;
 
-			/* Try matching the channel mapping */
-			if (lmap & rmap) {
-				lpac->ops->select(lpac, rpac, &rpac->qos,
-							func, user_data,
-							lpac->user_data);
-				if (count)
-					(*count)++;
+			printf("rc->count 0x%02x\n", rc->count);
 
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
+			if (!(lmap & rc->count))
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
+			lpac->ops->select(lpac, rpac, lc->location &
+						rc->location, &rpac->qos,
+						func, user_data,
+						lpac->user_data);
+			if (count)
+				(*count)++;
+
+			/* Check if there are any channels left to select */
+			lmap &= ~(lmap & rc->count);
+			if (!lmap)
+				break;
+
+			/* Check if device require AC*(i) settings */
+			if (rc->count == 0x01)
+				lmap = lmap >> 1;
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


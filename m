Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7E6ABBE
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeFELZ7z"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-590bb31ccf5so4050093eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587365; x=1703192165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uujfn7iiFS8v3L+hrQnUGuHxUzCMZBZ+4Uxi8SEmPS0=;
        b=eeFELZ7zJgyvhdelK7eNagKwQYkgUFKfJ9ZHBXhUVXHZVEiH19XqpXfft+UpWLG/jf
         //EjMPPUdEL9b7ZbjzUT6AmIlrkznihAvgO+ylfTUM9PDMZfHqJf//oPJLwikqxHmgpD
         +GPyJBtRn1YnhL6YzcUeG4Mc+dMMJufMjN9T+v946I8HjcMylbIGcfbEAFQzuVqVza0L
         osIGJHicjHYzdq3C56O593bKDmMxEOslAKMufpKpSTnrrsVqWjbd3GzaNJpiTPEv6YEZ
         iRER7MhrYHwT6gYTBsizlre4cHWM6kIHMwCQ0EJoV2wP0ybPkfJ7yCmMqwptLUc08rjY
         o0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587365; x=1703192165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uujfn7iiFS8v3L+hrQnUGuHxUzCMZBZ+4Uxi8SEmPS0=;
        b=IGgit23+PN33rrzpaGZy1GZkbztTGWZ+nfiHlXbhhsNrx5dGzNQDS9sEC4CBb9z05P
         97EsNmRbXJ3G989MQx0RdMTcPOLbXb3Rh/HbDQwWOB1eaM7fTo3LADyqa7SxYYt7B1kg
         OMLbEaXfUTrA2oNTjxJ/iP9otLCk0Y7LD9zjoXim3pF2rfNXCK2qmZqNmqr1LBFVMc+i
         gAC+OwZNzcD0Dp9Ao65J8G3z66J3+5BV/qlzcMTKxcsk2xFNJT74wqtgleCNpTkLngKz
         3RFHyQi/KGXRhm+r5BROL1R+gFxHEOFRX0ieFsmHx36ZJieC/idDaWasGjPsK7tNw79N
         hqfg==
X-Gm-Message-State: AOJu0YySkH97s04l0aVkblSpmkBU2dGIjnxp7bNEl4QTelSLpR+iPJKn
	TCNEhHyX1c77gC50B1Z64dJ9teyfxrY=
X-Google-Smtp-Source: AGHT+IFeHR0XEpkKlDIKEjd3R2AZfhGqUU4pZZ+l3g0hxPct6Q6vu0typ9muTrjocQA9ml5AiFknIg==
X-Received: by 2002:a05:6820:551:b0:58d:9776:2313 with SMTP id n17-20020a056820055100b0058d97762313mr8733075ooj.7.1702587365146;
        Thu, 14 Dec 2023 12:56:05 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3658057oof.22.2023.12.14.12.56.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:56:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 4/6] shared/bap: Make bt_bap_select select a location
Date: Thu, 14 Dec 2023 15:55:54 -0500
Message-ID: <20231214205556.1320286-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
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


Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L33Gp3ff"
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5529F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:04:40 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ba084395d9so1098807b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328679; x=1702933479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s9zw6sFAj2uN5oaMFp5Z/ao9DhQ3lSa9x6vbe29U+4=;
        b=L33Gp3ffXA+SLI5CjoGMUZpWAv1gcnue9D/eoY9dzSogoSc2fXhkHViG/gx/o/pzZH
         t0QMoGB2vN6meEfz71SAt87Na26t1qFqdE8X5uUcABgRtB5Apwaz2MkTKJHPLA7UPYW9
         j8/zrz0aSH1USrbmnRrUloD9HynZzqy4+P6kBXfVBUAMFLXFSGwHjlpTzMjS+B43MR4b
         UH/wMM5JmCVa+oO3WfmlMWdA2HSocxqPWM/kcWKpQnJj+3oyptU7tjERUq/o/z58Pvtl
         3/FcGt+Zuk6Js0akqBUJiDsQBDv1hgOFU90eW238WF/f0QD4qdiSsKrGi8FiflKHlrpW
         GZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328679; x=1702933479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s9zw6sFAj2uN5oaMFp5Z/ao9DhQ3lSa9x6vbe29U+4=;
        b=LaHqJEGxA7zlP+9/T2V4uFemwpknXzxYM1SC/V7O8ev9Y6frBQaAJQPK53S1I0FVmS
         /fesIdWUZuw1J8f9zqTUhCWh/IWJJmnoQ410utX/w9hQdce/i+4ex/cypBmZ0l/iE9Wd
         CVT/yJiXzQwiBxupyP2IxzERhWTqQPVoQGzES52DKZaRsk4TpSot3tiTnTxK5u0jCNIn
         tW9f+dsQCavBbZwXboI8MFr0T04L8QSAGkR5MqidIQzqzkEil4NevfaJtmeG9V5wv/iV
         H1aO2ZdfZPYkrY6ucnkmZRVMlMI7XBCIBinPMioQjiRrPiUKz37tOyxB7QEcxSQjjyVF
         Khgg==
X-Gm-Message-State: AOJu0Yyy/Zb/jVaKl0m16ZzOw8wJ0UG4ymmpR8nnhS8XM6tAJeFi1Yrp
	obQ68v6U1ndBgVYQaUkp2v0ZosAv6Nw=
X-Google-Smtp-Source: AGHT+IEIRl1pmFoD4AhfPBpZu+erLGTQlpPcC4mATYynAUyj7EbehlmBbfKZudItSkkGeHH7MdN+Wg==
X-Received: by 2002:a05:6808:3989:b0:3b9:fbfd:4efd with SMTP id gq9-20020a056808398900b003b9fbfd4efdmr6015685oib.116.1702328678876;
        Mon, 11 Dec 2023 13:04:38 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id k23-20020a05680808d700b003b85f47a3e1sm1996852oij.43.2023.12.11.13.04.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:04:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/6] shared/bap: Make bt_bap_select select a location
Date: Mon, 11 Dec 2023 16:04:27 -0500
Message-ID: <20231211210429.530964-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211210429.530964-1-luiz.dentz@gmail.com>
References: <20231211210429.530964-1-luiz.dentz@gmail.com>
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


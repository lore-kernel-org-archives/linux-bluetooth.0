Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BC247281
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211523; cv=pass; b=Hm8YvjX+tUHjpS4R/8hEn/toLDBmRJPDhsfQGvkI5pp/7URz8ctjvVr+OzRuxCd7VVEkPtDQvFuwUOANYQUY1Tiyz4ZBq3YkSJlySgiKvSjbflOJdX5zISGjerClaUsajMY7nd2QrbjVzSJ/n+4av3gVbV5GWRRRIMOY8RXDoU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211523; c=relaxed/simple;
	bh=uFclC/x5Qt1BApVEZzQnX6iQKJkmAsTq1pYPlQVw1d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5bPF6B6o7pQDeKbTIEjQUzlIo2zPrVZeXD9goWpt++Vc9Nu7pPz3wLnS92026cUT7V0Yl/EgucJ6iAWowSIEH/N6fKfRGgu8k5V5hyswYbdZApvXg6QOQDfN/0B0E/3Y7H19vmnLAlz3swg4Xa711I3bNtWu8WYdRNtY6vPoGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mkzCwX5m; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mkzCwX5m"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFm2drzzySs;
	Sat, 15 Nov 2025 14:58:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emxUBYJh75pRq3k3vaq/T94nFZO2gqU3u6jDnxCKnIA=;
	b=mkzCwX5mkxpI9GuzGPq1RI33G6kUhwKTyM/boXzf+IlLLrprI/LZv+5+dumEMG6vY9rMDs
	2nVTyH+anBvPAnao3PNTzJL4PqVQL71omBpxnwVdnMVVaVK8pAueQ+/neBztDNDj/1X8CT
	hDqDH3cdS3TTNvRe6nF/TZ3wA8BXBm8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211516;
	b=OriKpnmELmk+gZCKt+mvaN97UWYgmwYpasanXognrRKYLSK/4UypQx73a/EsARfgY/GQtT
	U7MmLLjPnBJ8mUkLwd06728gLVOFj0NNJJofIx89fbaNgpC/qY7YJxEINvS2fJSp5QXb//
	zIb2z9it83pyr5TWR+FG6XoaHuPqMEc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emxUBYJh75pRq3k3vaq/T94nFZO2gqU3u6jDnxCKnIA=;
	b=rrdEfMsAqDkvvf8pKXFlPp61dS0e3ePJZX+5nqQS95W/bcJBGcMKhKLWTPkJOFfcu+0ZMJ
	BBLfgHwmamaUVGZpZD0S6LyIZBW+Gqju6EtqUaxT4EhuDm1d6Jko2rD7PElL8pWja2rKjc
	R/HKjg+enabY+ZkhVRZdn1E1vpxACIg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 1/6] shared/bap: fix channel allocation logic in bt_bap_select()
Date: Sat, 15 Nov 2025 14:58:28 +0200
Message-ID: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_bap_select() does not correctly determine the need for multi-stream
configurations 6,7,8,9,11(i), as its result depends on whether Audio
Locations is read before or after the PACs, doesn't work with general
location bits, etc.

Fix the procedure to be simpler: create streams for all locations, up to
a specific number of channels.  By default, limit to max 2 channels per
direction for compatibility (BAP doesn't have explicit AC with larger
channel counts.) Also simplify the code.

Ignore lpac Locations when selecting: the value mostly makes sense for
Unicast Server role, but Client and Server cannot use the same value as
only a few bits can be set. As Client, we should be able to configure
any Location bits.  The sound server can simply ignore our suggested
channel allocation if really needed, or use SetConfiguration() API to
build custom configurations.
---

Notes:
    v4:
    - no change
    
    v3:
    - no change

 profiles/audio/bap.c |   3 +-
 src/shared/bap.c     | 205 +++++++++++++++++++++----------------------
 src/shared/bap.h     |   7 +-
 3 files changed, 104 insertions(+), 111 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 85bba9543..ec3502b06 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1919,7 +1919,8 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		queue_push_tail(select->eps, ep);
 	}
 
-	bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
+	bt_bap_select(data->bap, lpac, rpac, 0, &select->remaining,
+								select_cb, ep);
 
 	return true;
 }
diff --git a/src/shared/bap.c b/src/shared/bap.c
index a18f393f7..b779f6716 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -204,11 +204,6 @@ struct bt_bap {
 	void *user_data;
 };
 
-struct bt_bap_chan {
-	uint8_t count;
-	uint32_t location;
-};
-
 struct bt_bap_pac {
 	struct bt_bap_db *bdb;
 	char *name;
@@ -3848,50 +3843,6 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 	return util_iov_append(data, cont->iov_base, cont->iov_len);
 }
 
-static void bap_pac_chan_add(struct bt_bap_pac *pac, uint8_t count,
-				uint32_t location)
-{
-	struct bt_bap_chan *chan;
-
-	if (!pac->channels)
-		pac->channels = queue_new();
-
-	chan = new0(struct bt_bap_chan, 1);
-	chan->count = count;
-	chan->location = location;
-
-	queue_push_tail(pac->channels, chan);
-}
-
-static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
-					void *user_data)
-{
-	struct bt_bap_pac *pac = user_data;
-
-	if (!v)
-		return;
-
-	bap_pac_chan_add(pac, *v, bt_bap_pac_get_locations(pac));
-}
-
-static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec *data)
-{
-	uint8_t type = 0x03;
-
-	if (!data)
-		return;
-
-	util_ltv_foreach(data->iov_base, data->iov_len, &type,
-				bap_pac_foreach_channel, pac);
-
-	/* If record didn't set a channel count but set a location use that as
-	 * channel count.
-	 */
-	if (queue_isempty(pac->channels) && pac->qos.location)
-		bap_pac_chan_add(pac, pac->qos.location, pac->qos.location);
-
-}
-
 static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 					struct iovec *metadata)
 {
@@ -3901,9 +3852,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 	else
 		pac->data = util_iov_dup(data, 1);
 
-	/* Update channels */
-	bap_pac_update_channels(pac, data);
-
 	/* Merge metadata into existing record */
 	if (pac->metadata)
 		ltv_merge(pac->metadata, metadata);
@@ -4845,6 +4793,8 @@ static void read_source_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->source_loc_value = get_le32(value);
 
+	DBG(bap, "PACS Source Locations: 0x%08x", pacs->source_loc_value);
+
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->source && queue_isempty(bap->rdb->sources)) {
 		uint16_t value_handle;
@@ -4878,6 +4828,8 @@ static void read_sink_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->sink_loc_value = get_le32(value);
 
+	DBG(bap, "PACS Sink Locations: 0x%08x", pacs->sink_loc_value);
+
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
 		uint16_t value_handle;
@@ -4911,6 +4863,9 @@ static void read_pac_context(bool success, uint8_t att_ecode,
 
 	pacs->sink_context_value = le16_to_cpu(ctx->snk);
 	pacs->source_context_value = le16_to_cpu(ctx->src);
+
+	DBG(bap, "PACS Sink Context: 0x%04x", pacs->sink_context_value);
+	DBG(bap, "PACS Source Context: 0x%04x", pacs->source_context_value);
 }
 
 static void read_pac_supported_context(bool success, uint8_t att_ecode,
@@ -4934,6 +4889,11 @@ static void read_pac_supported_context(bool success, uint8_t att_ecode,
 
 	pacs->supported_sink_context_value = le16_to_cpu(ctx->snk);
 	pacs->supported_source_context_value = le16_to_cpu(ctx->src);
+
+	DBG(bap, "PACS Supported Sink Context: 0x%04x",
+					pacs->supported_sink_context_value);
+	DBG(bap, "PACS Supported Source Context: 0x%04x",
+					pacs->supported_source_context_value);
 }
 
 static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
@@ -6113,12 +6073,55 @@ static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return false;
 }
 
-int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			int *count, bt_bap_pac_select_t func,
-			void *user_data)
+static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+								void *user_data)
 {
-	const struct queue_entry *lchan, *rchan;
-	int selected = 0;
+	uint8_t *mask = user_data;
+
+	if (v)
+		*mask |= *v;
+}
+
+static uint8_t bap_pac_ch_counts(struct bt_bap_pac *pac)
+{
+	uint8_t type = 0x03;
+	uint8_t mask = 0;
+
+	if (!pac->data)
+		return 0;
+
+	util_ltv_foreach(pac->data->iov_base, pac->data->iov_len, &type,
+						bap_pac_ltv_ch_counts, &mask);
+
+	if (!mask)
+		mask = 0x01;  /* default (BAP v1.0.1 Sec 4.3.1) */
+
+	return mask;
+}
+
+static unsigned int bap_count_eps(struct queue *eps, uint8_t dir)
+{
+	const struct queue_entry *entry;
+	unsigned int count = 0;
+
+	for (entry = queue_get_entries(eps); entry; entry = entry->next) {
+		struct bt_bap_endpoint *ep = entry->data;
+
+		if (ep->dir == dir)
+			count++;
+	}
+
+	return count;
+}
+
+int bt_bap_select(struct bt_bap *bap,
+			struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			unsigned int max_channels, int *count,
+			bt_bap_pac_select_t func, void *user_data)
+{
+	uint32_t locations;
+	uint8_t ch_counts;
+	unsigned int num_ase;
 
 	if (!lpac || !rpac || !func)
 		return -EINVAL;
@@ -6126,66 +6129,54 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	if (!lpac->ops || !lpac->ops->select)
 		return -EOPNOTSUPP;
 
-	for (lchan = queue_get_entries(lpac->channels); lchan;
-					lchan = lchan->next) {
-		struct bt_bap_chan *lc = lchan->data;
-		struct bt_bap_chan map = *lc;
-		int i;
+	if (!max_channels)
+		max_channels = 2;  /* By default: don't go beyond BAP AC */
 
-		for (i = 0, rchan = queue_get_entries(rpac->channels); rchan;
-					rchan = rchan->next, i++) {
-			struct bt_bap_chan *rc = rchan->data;
+	ch_counts = bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac);
+	locations = bt_bap_pac_get_locations(rpac);
+	num_ase = bap_count_eps(bap->remote_eps, rpac->type);
 
-			/* Try matching the channel count */
-			if (!(map.count & rc->count))
-				break;
+	/* Fallback to unspecified/mono allocation if nothing is matching */
+	if (!locations || !ch_counts) {
+		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
+							lpac->user_data);
+		if (count)
+			(*count)++;
+		return 0;
+	}
 
-			/* Check if location was set otherwise attempt to
-			 * assign one based on the number of channels it
-			 * supports.
-			 */
-			if (!rc->location) {
-				rc->location = bt_bap_pac_get_locations(rpac);
-				/* If channel count is 1 use a single
-				 * location
-				 */
-				if (rc->count == 0x01)
-					rc->location &= BIT(i);
-			}
+	/* Allocate all locations to streams */
+	while (num_ase) {
+		uint32_t allocation = 0, alloc = 0;
+		unsigned int i, n;
 
-			/* Try matching the channel location */
-			if (!(map.location & rc->location))
+		/* Put max number of channels per stream */
+		for (i = 0, n = 0; i < 32 && n < 8; ++i) {
+			uint32_t loc = (1LL << i);
+
+			if (!(locations & loc))
 				continue;
 
-			lpac->ops->select(lpac, rpac, map.location &
-						rc->location, &rpac->qos,
-						func, user_data,
-						lpac->user_data);
-			selected++;
+			alloc |= loc;
+			if ((BIT(n) & ch_counts) && n < max_channels)
+				allocation = alloc;
 
-			/* Check if there are any channels left to select */
-			map.count &= ~(map.count & rc->count);
-			/* Check if there are any locations left to select */
-			map.location &= ~(map.location & rc->location);
-
-			if (!map.count || !map.location)
-				break;
-
-			/* Check if device require AC*(i) settings */
-			if (rc->count == 0x01)
-				map.count = map.count >> 1;
+			++n;
 		}
-	}
 
-	/* Fallback to no channel allocation since none could be matched. */
-	if (!selected) {
-		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
-					lpac->user_data);
-		selected++;
-	}
+		if (!allocation)
+			break;
 
-	if (count)
-		*count += selected;
+		/* Configure stream */
+		lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
+					func, user_data, lpac->user_data);
+		if (count)
+			(*count)++;
+
+		locations &= ~allocation;
+		max_channels -= __builtin_popcount(allocation);
+		num_ase--;
+	}
 
 	return 0;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index efeed604d..80e91f10a 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -172,9 +172,10 @@ void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
 
 /* Stream related functions */
-int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			int *count, bt_bap_pac_select_t func,
-			void *user_data);
+int bt_bap_select(struct bt_bap *bap,
+			struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			unsigned int max_channels, int *count,
+			bt_bap_pac_select_t func, void *user_data);
 
 void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 			void *user_data);
-- 
2.51.1


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F42609CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973571; cv=pass; b=TT7OdRnyVrVi61kYiueMg20mp6eJurXMl0Rxtr1uQQClxj7+92Hy8oCyjZcmVU3F5fJY/4UczqOvh6JulvJ8yVGg3/s8nA8ScglxraXJxXW7ndLUZym23wk8RMjwP7u+Pn+nbmwxaPtwEDM1kVuDPLWvUMXCopLwI56y79Lmto0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973571; c=relaxed/simple;
	bh=GICSarlKb/+qtMfEQ8DDglLC40N2KezsAFgnEYEciUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqvOxozAE7cnEGdjF58QcM8L1PL44VM/qL1y3evsjIYF89JmY1vUXzSbHyqqdeOWOLYhrCKsz3XIE+6B/nwZ2/t0jkU4joxlbPoWRKhEu0atND+Oc9+N9hdr+kUr12VlDeoDlalklfwPu+Yo+wCZv5Ohqdtku292loPMqu7VqWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Tn9JJx+b; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Tn9JJx+b"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6CFh6ZFbz1022;
	Wed, 12 Nov 2025 20:52:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762973561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NAtc61oJJx+IIx4LZuDHOEmWowAPcoefXhkg00mLx1E=;
	b=Tn9JJx+bAANxnkiBM/Pr4n6x1gVv2kdtG4XLFrFr4xkZ01lCKMYVUHexnbKqLXELjU3/Kc
	mIJhw5X2Cr828kukqlkSZe3MjqgTfYT0HdVGdV/N7XXqtqxJM6dcTU1msCkzcg1O0rGbKF
	cFw0xuLu4aaV1lakZ9iIvh6ZF89Imxk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1762973561;
	b=iW0SgIfaZk7SXxCPohbBp2mTfMWj68+cY3IHoTgUD9IfvG6LlSilEqp6GM78xrnq/cBKUj
	aye7v81R79vq1teLwJW8RdAwElVewapO1wofiKCZswHEiSpSCn1zY3hHew9tlpujQABHgE
	c40l8+ivBViqmjzE6QWsjvJYi1GkEuc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762973561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NAtc61oJJx+IIx4LZuDHOEmWowAPcoefXhkg00mLx1E=;
	b=T0CJyvi6cfjLnuPHo+aL8i8leFZFzZKjeVKaBHm6HjVaU8r+gzsby0KFuR1QpMSg94V4q4
	lZGW6e4J+b7ofy6yoKpRzW3pB6S8E+ZwcrUw05nZ6uHbbrA58re00zq3MC6uk4kNofrwfH
	2qHzqiI4G1u81vFdfumIadAumYAzugA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] shared/bap: fix channel allocation logic in bt_bap_select()
Date: Wed, 12 Nov 2025 20:52:35 +0200
Message-ID: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
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
 profiles/audio/bap.c |   2 +-
 src/shared/bap.c     | 193 +++++++++++++++++++------------------------
 src/shared/bap.h     |   4 +-
 3 files changed, 89 insertions(+), 110 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 85bba9543..9fb879345 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1919,7 +1919,7 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		queue_push_tail(select->eps, ep);
 	}
 
-	bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
+	bt_bap_select(lpac, rpac, 0, &select->remaining, select_cb, ep);
 
 	return true;
 }
diff --git a/src/shared/bap.c b/src/shared/bap.c
index a18f393f7..00474b2e0 100644
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
@@ -6113,12 +6073,39 @@ static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
+int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			unsigned int max_channels, int *count,
+			bt_bap_pac_select_t func, void *user_data)
+{
+	uint32_t locations;
+	uint8_t ch_counts;
+	unsigned int num_ase;
 
 	if (!lpac || !rpac || !func)
 		return -EINVAL;
@@ -6126,66 +6113,58 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
 
-			/* Try matching the channel count */
-			if (!(map.count & rc->count))
-				break;
+	if (rpac->type == BT_BAP_SINK)
+		num_ase = queue_length(rpac->bdb->sinks);
+	else
+		num_ase = queue_length(rpac->bdb->sources);
 
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
+	/* Fallback to unspecified/mono allocation if nothing is matching */
+	if (!locations || !ch_counts) {
+		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
+							lpac->user_data);
+		if (count)
+			(*count)++;
+		return 0;
+	}
 
-			/* Try matching the channel location */
-			if (!(map.location & rc->location))
+	/* Allocate all locations to streams */
+	while (num_ase) {
+		uint32_t allocation = 0, alloc = 0;
+		unsigned int i, n;
+
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
index efeed604d..7f2c491fc 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -173,8 +173,8 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			int *count, bt_bap_pac_select_t func,
-			void *user_data);
+			unsigned int max_channels, int *count,
+			bt_bap_pac_select_t func, void *user_data);
 
 void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 			void *user_data);
-- 
2.51.1


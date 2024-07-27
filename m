Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAB76026
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082545; cv=pass; b=QVfmOW0zNwWiYUQqtZEhZog0wwD2sefTjuaQuUTDgeJU+oA2lTaabFwbdEdbQTyJJwZ/paLD3SDAIaTcvI0ApG3bH2VmkaIcElTYPqzHmxcFTsABH1YQSUk3MW4VWXv2g8RepmvMkWZRCDq+7Koh4W7HpE5oKXqeyZeUK66ZfQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082545; c=relaxed/simple;
	bh=5c9oqIbtSzDNU/tHq9ndeUdxhjOA1nQva60tRw1G5lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLgBV/uxi+TPj2POBJzv8MvDFedxn7MeDWYwuUcCoOMx/BhMcgmOYEdWKDWvC31RqExIXad0YPGBCYJnHDLzXe5H33s8XifLzrKiE8y/UXwLqC18mmCBdgCEDoIg8u3vxpLxN+WeHLHeqGKOqauX0q8QXi3va7pVdVdZJkOoh8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RiQr/eT6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RiQr/eT6"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WWNqm0P0Hz49Q30;
	Sat, 27 Jul 2024 15:15:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722082532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwWRL9gVluEE5mZETOyGzBdx+mSdgSnhw5pLiwnu8C4=;
	b=RiQr/eT64cYrIqd3hKU/SkqK1sa5rAnzNmb38Qv6ToM3q3HsSUlPD6GSrPmWO4qh14CS1J
	UnDKlwFesV92VjiBnI3Y92aOv4LYYFlu3ikjxiJhai/c4woau0XlJdYtQs83VYlSf3i5t9
	s3SQTrjRGUoc1evLlx9ptwLd4gC2iPoFuinx30m6cn/i6QrarNRTSNCu9pK4LxSgeib5JC
	QHyn34vlerAqilA6VGKj7BfQzTaE6YniFpLAEy4KDsKGMEEJq/M1tAXPgEo+4xJFZf2UML
	qbJiPII/ixSFrPcVy35HRQ18UIDDuWglEMxx67oA9+r70lWHa3OLQfIfD8roIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1722082532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwWRL9gVluEE5mZETOyGzBdx+mSdgSnhw5pLiwnu8C4=;
	b=h67g+mbgaYDOD9o37OPN9fGgmhWciwB+MsRlQhtJXWoaHpTnD8B7yYNDRPYIlwsZ9H+WOg
	i59+VI4Bm4SzmGrarAod4j6HNSuxfbzvCO2VqXwpFGZPzC3xs5fupRW0wMNhVARCRAkExi
	72fk4g6cDbpr0P3nAK/0hrimQVD+YVxKdzWvmOFK+/N6Wm7JL6f0kVYWO02V259NKkxRcN
	JcQl9yFvR4q9Al1FA796brQYebQOUSSlGZV9RyXpZz9KA/MAeGyVi3ILOM8g+5aEMipsbV
	6/ftDL4i1U/h0gzdwWhExd6doaCVN8/bVM6tsP+61aaNW5VFIYXgOqXQyjsqkQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1722082532; a=rsa-sha256;
	cv=none;
	b=O1Hv7OS6K+2NzLUW9R85PyUUD8bgWUfxkFA34hGJN6QvjZsWPJEY1FEvTwX+rhOVUJz8Of
	mQScS/LK+77kynbvrCUoo/vfy65dPYoRD8HOsBT0OzS80B/onIJMdPyi7sc+UiZrroUh/R
	iXsGo8HK9BOVO2r/zDfKpg8J1cMlcjfLiZ9z4S8IUCG0L10sXC1S58vtR/LgJ8uz1ZL4Eu
	9aBw+hpOBELdXGj4BmM86GuoTyYBj0OcZJI3rApJPe9cM15Ng5gpTymdajeYiXMyrOsR1L
	ixVyaBO3MJlpM8MOgwTCfrqehyTqmNLPRjj9fxa18GxTtsusGo1lllN2D1wICA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: improve channel allocation logic in bt_bap_select()
Date: Sat, 27 Jul 2024 15:13:13 +0300
Message-ID: <81bcbcb669a6f329b7900fb0f6ff0c469ec7201f.1722082241.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently bt_bap_select() determines the need for multi-stream
configurations in a way that depends on accidental GATT detail (whether
Locations is read before or after the PAC) that shouldn't have any
effect on the configuration.

Whether a device gets configured with 1 (AC 1) or 2 (AC 6i) sink ASEs,
consider two devices: Galaxy Buds2 Pro:

    profiles/audio/bap.c:bap_attached() 0x60e000001c40
    src/shared/bap.c:foreach_pacs_char() PAC Context found: handle 0x0050
    src/shared/bap.c:foreach_pacs_char() PAC Supported Context found: handle 0x0053
    src/shared/bap.c:foreach_pacs_char() Sink PAC Location found: handle 0x0056
    src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0059

    Sink PACS Locations: 0x401
    One local PAC, with Locations: all bits
    rpac bt_bap_chan.location == 0x401 (PACS Locations read before PAC)
    -> bt_select() ChannelAllocation: 0x401

Earfun Air Pro 3:

    profiles/audio/bap.c:bap_attached() 0x60e000001e00
    src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x004b
    src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x004e
    src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0051
    src/shared/bap.c:foreach_pacs_char() Sink PAC found: handle 0x0054
    src/shared/bap.c:foreach_pacs_char() Sink PAC Location found: handle 0x0057

    Sink PACS Locations: 0x3
    One local PAC, with Locations: all bits
    rpac bt_bap_chan.location == 0x0 (PACS Locations read after PAC)
    -> bt_select() ChannelAllocation: 0x1 (ASE 1)
    -> bt_select() ChannelAllocation: 0x2 (ASE 2)

Both devices have 2+ Sink ASEs and two bits set in Locations, but
bt_bap_select() configures them differently. This occurs due to the
"if (!rc->location) { ... rc->location &= BIT(i);" logic which gets entered
only because of the ordering in which characteristics was read.  Without
"&= BIT(i)" branch, "map.location &= ~(map.location & rc->location)"
causes only one ASE be configured.  The behavior appears accidental,
and e.g. the BIT(i) logic in general is wrong as the rpac index i doesn't
have a relation to channel locations.

Rewrite the multi-ASE configuration logic, and make it independent of
chr read ordering.

Decide first whether to configure 1 or 2 ASE.  Use 2 ASE if locations
contain left/right channel pair and only 1 channel per ASE is supported.

The "right" result depends on what you want to do so this heuristic
tries to aim for a "common" configuration. See eg the above two devices:
their PAC/ASE data only differs in which two location bits are set, but
they need to be configured differently.

If 1 ASE, leave channel allocation to sound server.

If multiple ASE, multiplex as many as possible on each of them.

Remove bt_bap_chan as it's not needed -- also the PACS Locations
is global to the whole device and there are no per-PAC Locations in the
specification, so probably we shouldn't have something like that in the
internal model.
---

Notes:
    The BAP specification doesn't say that the ordering of characteristics
    in the PACS service should have a meaning, and the current logic looks
    wrong to me.
    
    From what's written in the spec, I don't see that there is a "right"
    configuration here to pick, so it seems we are forced to use some
    heuristic here.  It is hardcoded here, and we probably should make some
    changes later on to make it possible for the sound server to control
    which locations exactly are selected.
    
    One design could be to have the local PAC provide a list of Locations
    bitmasks, and BlueZ checks *in order* if the remote device has all the
    bits set in its Locations. If a match is found, BlueZ assigns exactly
    those bits to ASEs using multiple ASE, if needed. Otherwise, BlueZ uses
    a single ASE and punts the channel decision to the sound server.
    
    This would more or less be the same as what is done in this patch,
    except that the configs[] array is provided by the sound server in the
    local Client PAC.
    
    Also, if there are multiple codecs, bt_bap_select() probably should try
    to select them in order, and stop at the first successful selection.
    
    An alternative would be to leave all this to the sound server: change
    API so that SelectProperties() can return a multi-ASE configuration.
    
    The sound server already has to handle low-level details such as
    deciding which PAC configuration is best. This choice however depends on
    whether ASE multiplexing is done or not, so trying to do the decision
    partly in BlueZ and partly in sound server probably just makes things
    more complicated than they need to be. Sound server can first decide
    what Locations to connect, then allocate PACs multiplexing as much as
    possible. BAP Sec. 3.5.3 guarantees there are enough ASEs for all
    location bits.

 src/shared/bap.c | 196 ++++++++++++++++++++++-------------------------
 1 file changed, 93 insertions(+), 103 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 499e740c9..b64399193 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -187,11 +187,6 @@ struct bt_bap {
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
@@ -3249,50 +3244,6 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
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
@@ -3302,9 +3253,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 	else
 		pac->data = util_iov_dup(data, 1);
 
-	/* Update channels */
-	bap_pac_update_channels(pac, data);
-
 	/* Merge metadata into existing record */
 	if (pac->metadata)
 		ltv_merge(pac->metadata, metadata);
@@ -4178,6 +4126,8 @@ static void read_source_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->source_loc_value = get_le32(value);
 
+	DBG(bap, "PACS Source Locations: 0x%08x", pacs->source_loc_value);
+
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->source && queue_isempty(bap->rdb->sources)) {
 		uint16_t value_handle;
@@ -4211,6 +4161,8 @@ static void read_sink_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->sink_loc_value = get_le32(value);
 
+	DBG(bap, "PACS Sink Locations: 0x%08x", pacs->sink_loc_value);
+
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
 		uint16_t value_handle;
@@ -5386,12 +5338,53 @@ static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return false;
 }
 
+static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+								void *user_data)
+{
+	uint8_t *mask = user_data;
+
+	if (v)
+		*mask = *v;
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
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			int *count, bt_bap_pac_select_t func,
 			void *user_data)
 {
-	const struct queue_entry *lchan, *rchan;
-	int selected = 0;
+	uint32_t locations;
+	uint8_t ch_counts;
+	unsigned int i, num_ase;
+
+	/* Hardcoded supported (multi-ASE) configurations: L/R channel pairs */
+	static const uint32_t configs[] = {
+		0x1 | 0x2,
+		0x10 | 0x20,
+		0x40 | 0x80,
+		0x400 | 0x800,
+		0x1000 | 0x2000,
+		0x10000 | 0x30000,
+		0x40000 | 0x80000,
+		0x400000 | 0x800000,
+		0x1000000 | 0x2000000,
+		0x4000000 | 0x8000000,
+	};
 
 	if (!lpac || !rpac || !func)
 		return -EINVAL;
@@ -5399,66 +5392,63 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	if (!lpac->ops || !lpac->ops->select)
 		return -EOPNOTSUPP;
 
-	for (lchan = queue_get_entries(lpac->channels); lchan;
-					lchan = lchan->next) {
-		struct bt_bap_chan *lc = lchan->data;
-		struct bt_bap_chan map = *lc;
-		int i;
+	ch_counts = bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac);
+	locations = bt_bap_pac_get_locations(rpac) & lpac->qos.location;
+	num_ase = 1;
 
-		for (i = 0, rchan = queue_get_entries(rpac->channels); rchan;
-					rchan = rchan->next, i++) {
-			struct bt_bap_chan *rc = rchan->data;
+	/* Check if multi-ASE configuration is needed */
+	for (i = 0; i < ARRAY_SIZE(configs); ++i) {
+		unsigned int n = __builtin_popcount(configs[i]);
 
-			/* Try matching the channel count */
-			if (!(map.count & rc->count))
-				break;
+		if (n == 0 || n > 8 || (ch_counts & BIT(n - 1)))
+			continue;
 
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
+		if ((locations & configs[i]) == configs[i]) {
+			num_ase = n;
+			locations = configs[i];
+			break;
+		}
+	}
 
-			/* Try matching the channel location */
-			if (!(map.location & rc->location))
-				continue;
+	/* Otherwise leave channel allocation to sound server */
+	if (!locations || !ch_counts || num_ase == 1) {
+		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
+							lpac->user_data);
+		if (count)
+			(*count)++;
+		return 0;
+	}
 
-			lpac->ops->select(lpac, rpac, map.location &
-						rc->location, &rpac->qos,
-						func, user_data,
-						lpac->user_data);
-			selected++;
+	/* Allocate channels */
+	while (locations && num_ase > 0) {
+		uint32_t allocation = 0, alloc = 0;
+		unsigned int n;
 
-			/* Check if there are any channels left to select */
-			map.count &= ~(map.count & rc->count);
-			/* Check if there are any locations left to select */
-			map.location &= ~(map.location & rc->location);
+		/* Multiplex as many as possible */
+		for (i = 0, n = 0; i < 32 && n < 8; ++i) {
+			if (!(locations & BIT(i)))
+				continue;
 
-			if (!map.count || !map.location)
-				break;
+			alloc |= BIT(i);
+			if (BIT(n) & ch_counts)
+				allocation = alloc;
 
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
+
+		/* Select */
+		lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
+					func, user_data, lpac->user_data);
 
-	if (count)
-		*count += selected;
+		locations &= ~allocation;
+		--num_ase;
+
+		if (count)
+			(*count)++;
+	}
 
 	return 0;
 }
-- 
2.45.2


Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5C34CFCE
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035222; cv=pass; b=gOEl+TlhXlbzfTeYnFS+5XReiGaNScxKl4GCimjptLi74al85BhZIgJQ5TPXDc4Hlzri79yKZXn7WYznegC2FLMJB1+l1YtUfjctoqo4+OkCIKeT3NCVuhIZ2LRsgLtBi9n1nRpeI1JReVPpMbqAwrdHmhNQ4ZeySl8Ckdbphc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035222; c=relaxed/simple;
	bh=CwLeLjUNhxZ7ybZXW91cmzuQqzZ3H+ktYD+dp86P0aM=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZRSh6A0cRsIyKpODdj6AnT2uqfUllh/c54tx1BNP7Xd/W6SOpvLG6OU1s06124padA/b14sdLBSiOGbaJeVRPll4TffwlyopebYF5Py5sb7hxfOdaX/qVerjBMIiE+LuJx+3hPshxs+FAZKQRmupYJxqYbYR3N4aX9iP+n60uzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=L+BfE0kJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="L+BfE0kJ"
Received: from ehlo.thunderbird.net (unknown [193.138.7.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d6f3H488cz49PvN
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 14:00:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1763035211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59grb7uWN7bwSvvSgKcwX0K6syAsSjEyf1Se1iqVBzE=;
	b=L+BfE0kJvJXz1et0RKnNjIwRXSp8KbCFK97gO1oEijb3JJ3Junb4jCxqlJdlGL0RbfV2H3
	Zd4a5feXP50ugt8dD+9nzaBha0thXX1WgBFvKY039CRqtM3oeFJiOR+Jzq81T6NNJZPVmH
	76LA1VVMdIufc0hHrqjgo5s0b8r2jyuVnDiJ2/hq/PGvYDrq++CmCgtj3Eh6mjPxHf/16j
	7jTxgloGzaVC1vKRhmpIdxOzpTFvDQ56CDztbKIiA5gDnQOnLWuErzLHxg5h0K5ywGscNP
	vHU7sumDzZ2w7QHcBlPBf+qjrsCArrE0Ecg2kA0P0cmIZbWpLCDkS+QVuHIRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1763035211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59grb7uWN7bwSvvSgKcwX0K6syAsSjEyf1Se1iqVBzE=;
	b=eZnQ5tVy9ZqLnXXIycGDIzMfojarttAoF0VAz5zxFgnaENtO2ItqkA9oJLyCXGmExsad/J
	dmK/fKjhTzoG93bWUFbaIEpcNYVjVKSE4AeL0AXwq6Xm3Q4LWYeL4ZuCZHHU7bM0Q4gFCn
	a6b/qMlLzHB0tV5tI60i9p92VVCcRmLb7Z2i4caGgZ7wy5qVdjGXw7QcENrUk3sn+Mjc5j
	6WlhDht+CBi18Z3mfGAwIslTYts5kjEDzh48n0FU4ajD1IIKR9KibVC8shrJXJuF3n67C1
	Z6qCcgrpzNtdEn7AAc6y5CmvQ7QT2ae+dih759AapAEOBKqgVGsD24tB1YgEEQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1763035211;
	b=szby3wfQndvrGkoVbHHuWPF0wrABEB/Ze05SUhnhLLzH2O0xhpdeGPR1wXIccArGTQ0Tx5
	q5sVKqqnKIZ0JsQfxaXwn3tSSlaqe5ulbyRT7eaG0GwBvYCL+Z3PvCV3rN/ANrNrl9RhGb
	wGO5g6z4v0D/4M430psRdC3y5j5GEnEvmFI86DZkVMj+G3CaPtA9eIt1dMyZNHQuaQDd0g
	2dd/9fLosvsYjk8McMFih7ubYc2+GRGjwzDbGvf9EIyTSBWC6sVRL12wBFAcr/Zhwrt+eV
	aidraTBfB/Y11HeBqghk/FSZ71xCjjWgS6XqE2kP10noXONml8GjX+aLGMP5Hw==
Date: Thu, 13 Nov 2025 12:00:08 +0000
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_BlueZ_1/4=5D_shared/bap=3A_fix_ch?=
 =?US-ASCII?Q?annel_allocation_logic_in_bt=5Fbap=5Fselect=28=29?=
In-Reply-To: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
References: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
Message-ID: <04DCBC8D-A185-4094-9131-F4EECE18E936@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



12=2E marraskuuta 2025 18=2E52=2E35 UTC Pauli Virtanen <pav@iki=2Efi> kirj=
oitti:
>bt_bap_select() does not correctly determine the need for multi-stream
>configurations 6,7,8,9,11(i), as its result depends on whether Audio
>Locations is read before or after the PACs, doesn't work with general
>location bits, etc=2E
>
>Fix the procedure to be simpler: create streams for all locations, up to
>a specific number of channels=2E  By default, limit to max 2 channels per
>direction for compatibility (BAP doesn't have explicit AC with larger
>channel counts=2E) Also simplify the code=2E
>
>Ignore lpac Locations when selecting: the value mostly makes sense for
>Unicast Server role, but Client and Server cannot use the same value as
>only a few bits can be set=2E As Client, we should be able to configure
>any Location bits=2E  The sound server can simply ignore our suggested
>channel allocation if really needed, or use SetConfiguration() API to
>build custom configurations=2E
>---
> profiles/audio/bap=2Ec |   2 +-
> src/shared/bap=2Ec     | 193 +++++++++++++++++++------------------------
> src/shared/bap=2Eh     |   4 +-
> 3 files changed, 89 insertions(+), 110 deletions(-)
>
>diff --git a/profiles/audio/bap=2Ec b/profiles/audio/bap=2Ec
>index 85bba9543=2E=2E9fb879345 100644
>--- a/profiles/audio/bap=2Ec
>+++ b/profiles/audio/bap=2Ec
>@@ -1919,7 +1919,7 @@ static bool pac_select(struct bt_bap_pac *lpac, str=
uct bt_bap_pac *rpac,
> 		queue_push_tail(select->eps, ep);
> 	}
>=20
>-	bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
>+	bt_bap_select(lpac, rpac, 0, &select->remaining, select_cb, ep);
>=20
> 	return true;
> }
>diff --git a/src/shared/bap=2Ec b/src/shared/bap=2Ec
>index a18f393f7=2E=2E00474b2e0 100644
>--- a/src/shared/bap=2Ec
>+++ b/src/shared/bap=2Ec
>@@ -204,11 +204,6 @@ struct bt_bap {
> 	void *user_data;
> };
>=20
>-struct bt_bap_chan {
>-	uint8_t count;
>-	uint32_t location;
>-};
>-
> struct bt_bap_pac {
> 	struct bt_bap_db *bdb;
> 	char *name;
>@@ -3848,50 +3843,6 @@ static void *ltv_merge(struct iovec *data, struct =
iovec *cont)
> 	return util_iov_append(data, cont->iov_base, cont->iov_len);
> }
>=20
>-static void bap_pac_chan_add(struct bt_bap_pac *pac, uint8_t count,
>-				uint32_t location)
>-{
>-	struct bt_bap_chan *chan;
>-
>-	if (!pac->channels)
>-		pac->channels =3D queue_new();
>-
>-	chan =3D new0(struct bt_bap_chan, 1);
>-	chan->count =3D count;
>-	chan->location =3D location;
>-
>-	queue_push_tail(pac->channels, chan);
>-}
>-
>-static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint=
8_t *v,
>-					void *user_data)
>-{
>-	struct bt_bap_pac *pac =3D user_data;
>-
>-	if (!v)
>-		return;
>-
>-	bap_pac_chan_add(pac, *v, bt_bap_pac_get_locations(pac));
>-}
>-
>-static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec=
 *data)
>-{
>-	uint8_t type =3D 0x03;
>-
>-	if (!data)
>-		return;
>-
>-	util_ltv_foreach(data->iov_base, data->iov_len, &type,
>-				bap_pac_foreach_channel, pac);
>-
>-	/* If record didn't set a channel count but set a location use that as
>-	 * channel count=2E
>-	 */
>-	if (queue_isempty(pac->channels) && pac->qos=2Elocation)
>-		bap_pac_chan_add(pac, pac->qos=2Elocation, pac->qos=2Elocation);
>-
>-}
>-
> static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
> 					struct iovec *metadata)
> {
>@@ -3901,9 +3852,6 @@ static void bap_pac_merge(struct bt_bap_pac *pac, s=
truct iovec *data,
> 	else
> 		pac->data =3D util_iov_dup(data, 1);
>=20
>-	/* Update channels */
>-	bap_pac_update_channels(pac, data);
>-
> 	/* Merge metadata into existing record */
> 	if (pac->metadata)
> 		ltv_merge(pac->metadata, metadata);
>@@ -4845,6 +4793,8 @@ static void read_source_pac_loc(bool success, uint8=
_t att_ecode,
>=20
> 	pacs->source_loc_value =3D get_le32(value);
>=20
>+	DBG(bap, "PACS Source Locations: 0x%08x", pacs->source_loc_value);
>+
> 	/* Resume reading sinks if supported but for some reason is empty */
> 	if (pacs->source && queue_isempty(bap->rdb->sources)) {
> 		uint16_t value_handle;
>@@ -4878,6 +4828,8 @@ static void read_sink_pac_loc(bool success, uint8_t=
 att_ecode,
>=20
> 	pacs->sink_loc_value =3D get_le32(value);
>=20
>+	DBG(bap, "PACS Sink Locations: 0x%08x", pacs->sink_loc_value);
>+
> 	/* Resume reading sinks if supported but for some reason is empty */
> 	if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
> 		uint16_t value_handle;
>@@ -4911,6 +4863,9 @@ static void read_pac_context(bool success, uint8_t =
att_ecode,
>=20
> 	pacs->sink_context_value =3D le16_to_cpu(ctx->snk);
> 	pacs->source_context_value =3D le16_to_cpu(ctx->src);
>+
>+	DBG(bap, "PACS Sink Context: 0x%04x", pacs->sink_context_value);
>+	DBG(bap, "PACS Source Context: 0x%04x", pacs->source_context_value);
> }
>=20
> static void read_pac_supported_context(bool success, uint8_t att_ecode,
>@@ -4934,6 +4889,11 @@ static void read_pac_supported_context(bool succes=
s, uint8_t att_ecode,
>=20
> 	pacs->supported_sink_context_value =3D le16_to_cpu(ctx->snk);
> 	pacs->supported_source_context_value =3D le16_to_cpu(ctx->src);
>+
>+	DBG(bap, "PACS Supported Sink Context: 0x%04x",
>+					pacs->supported_sink_context_value);
>+	DBG(bap, "PACS Supported Source Context: 0x%04x",
>+					pacs->supported_source_context_value);
> }
>=20
> static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user=
_data)
>@@ -6113,12 +6073,39 @@ static bool match_pac(struct bt_bap_pac *lpac, st=
ruct bt_bap_pac *rpac,
> 	return false;
> }
>=20
>-int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>-			int *count, bt_bap_pac_select_t func,
>-			void *user_data)
>+static void bap_pac_ltv_ch_counts(size_t i, uint8_t l, uint8_t t, uint8_=
t *v,
>+								void *user_data)
> {
>-	const struct queue_entry *lchan, *rchan;
>-	int selected =3D 0;
>+	uint8_t *mask =3D user_data;
>+
>+	if (v)
>+		*mask |=3D *v;
>+}
>+
>+static uint8_t bap_pac_ch_counts(struct bt_bap_pac *pac)
>+{
>+	uint8_t type =3D 0x03;
>+	uint8_t mask =3D 0;
>+
>+	if (!pac->data)
>+		return 0;
>+
>+	util_ltv_foreach(pac->data->iov_base, pac->data->iov_len, &type,
>+						bap_pac_ltv_ch_counts, &mask);
>+
>+	if (!mask)
>+		mask =3D 0x01;  /* default (BAP v1=2E0=2E1 Sec 4=2E3=2E1) */
>+
>+	return mask;
>+}
>+
>+int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>+			unsigned int max_channels, int *count,
>+			bt_bap_pac_select_t func, void *user_data)
>+{
>+	uint32_t locations;
>+	uint8_t ch_counts;
>+	unsigned int num_ase;
>=20
> 	if (!lpac || !rpac || !func)
> 		return -EINVAL;
>@@ -6126,66 +6113,58 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct=
 bt_bap_pac *rpac,
> 	if (!lpac->ops || !lpac->ops->select)
> 		return -EOPNOTSUPP;
>=20
>-	for (lchan =3D queue_get_entries(lpac->channels); lchan;
>-					lchan =3D lchan->next) {
>-		struct bt_bap_chan *lc =3D lchan->data;
>-		struct bt_bap_chan map =3D *lc;
>-		int i;
>+	if (!max_channels)
>+		max_channels =3D 2;  /* By default: don't go beyond BAP AC */
>=20
>-		for (i =3D 0, rchan =3D queue_get_entries(rpac->channels); rchan;
>-					rchan =3D rchan->next, i++) {
>-			struct bt_bap_chan *rc =3D rchan->data;
>+	ch_counts =3D bap_pac_ch_counts(lpac) & bap_pac_ch_counts(rpac);
>+	locations =3D bt_bap_pac_get_locations(rpac);
>=20
>-			/* Try matching the channel count */
>-			if (!(map=2Ecount & rc->count))
>-				break;
>+	if (rpac->type =3D=3D BT_BAP_SINK)
>+		num_ase =3D queue_length(rpac->bdb->sinks);
>+	else
>+		num_ase =3D queue_length(rpac->bdb->sources);

This is wrong, ASEs are in remote_eps=2E

-> v2

>=20
>-			/* Check if location was set otherwise attempt to
>-			 * assign one based on the number of channels it
>-			 * supports=2E
>-			 */
>-			if (!rc->location) {
>-				rc->location =3D bt_bap_pac_get_locations(rpac);
>-				/* If channel count is 1 use a single
>-				 * location
>-				 */
>-				if (rc->count =3D=3D 0x01)
>-					rc->location &=3D BIT(i);
>-			}
>+	/* Fallback to unspecified/mono allocation if nothing is matching */
>+	if (!locations || !ch_counts) {
>+		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
>+							lpac->user_data);
>+		if (count)
>+			(*count)++;
>+		return 0;
>+	}
>=20
>-			/* Try matching the channel location */
>-			if (!(map=2Elocation & rc->location))
>+	/* Allocate all locations to streams */
>+	while (num_ase) {
>+		uint32_t allocation =3D 0, alloc =3D 0;
>+		unsigned int i, n;
>+
>+		/* Put max number of channels per stream */
>+		for (i =3D 0, n =3D 0; i < 32 && n < 8; ++i) {
>+			uint32_t loc =3D (1LL << i);
>+
>+			if (!(locations & loc))
> 				continue;
>=20
>-			lpac->ops->select(lpac, rpac, map=2Elocation &
>-						rc->location, &rpac->qos,
>-						func, user_data,
>-						lpac->user_data);
>-			selected++;
>+			alloc |=3D loc;
>+			if ((BIT(n) & ch_counts) && n < max_channels)
>+				allocation =3D alloc;
>=20
>-			/* Check if there are any channels left to select */
>-			map=2Ecount &=3D ~(map=2Ecount & rc->count);
>-			/* Check if there are any locations left to select */
>-			map=2Elocation &=3D ~(map=2Elocation & rc->location);
>-
>-			if (!map=2Ecount || !map=2Elocation)
>-				break;
>-
>-			/* Check if device require AC*(i) settings */
>-			if (rc->count =3D=3D 0x01)
>-				map=2Ecount =3D map=2Ecount >> 1;
>+			++n;
> 		}
>-	}
>=20
>-	/* Fallback to no channel allocation since none could be matched=2E */
>-	if (!selected) {
>-		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
>-					lpac->user_data);
>-		selected++;
>-	}
>+		if (!allocation)
>+			break;
>=20
>-	if (count)
>-		*count +=3D selected;
>+		/* Configure stream */
>+		lpac->ops->select(lpac, rpac, allocation, &rpac->qos,
>+					func, user_data, lpac->user_data);
>+		if (count)
>+			(*count)++;
>+
>+		locations &=3D ~allocation;
>+		max_channels -=3D __builtin_popcount(allocation);
>+		num_ase--;
>+	}
>=20
> 	return 0;
> }
>diff --git a/src/shared/bap=2Eh b/src/shared/bap=2Eh
>index efeed604d=2E=2E7f2c491fc 100644
>--- a/src/shared/bap=2Eh
>+++ b/src/shared/bap=2Eh
>@@ -173,8 +173,8 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac=
);
>=20
> /* Stream related functions */
> int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>-			int *count, bt_bap_pac_select_t func,
>-			void *user_data);
>+			unsigned int max_channels, int *count,
>+			bt_bap_pac_select_t func, void *user_data);
>=20
> void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t f=
unc,
> 			void *user_data);

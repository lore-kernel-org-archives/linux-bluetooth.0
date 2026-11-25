Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613892;
	b=EQgpUjLyen5WvvzGgXeH0yuPIuP/C6Nk8hTlS7OozqZKfzJst5Kt1ScwzNZJnH0bS3vX
	 qzYbEuZ4lLsEriPNo+cMxvw717h5shEq3ynstiEAEK/QVP3UoM3W0ozqZnYBFam6DbrG6
	 7lturmkl559fj/jER2PoogCnjNblZDHw+AtU1IKJopLu9YFeTTJPJGi0L6i9SUh3Uy1KE
	 dyMdY+3lIHF8rQiEy0XY+SOV0EJ05V4z4I0P6xCKeu4037GdAXPDr0sunLxes9+SoCtaf
	 6Gxbp6vA4hunc221rqYb4oEbGnv4y9Zhvw1wpgp0uwc7LKw3Pt/ccl7/rYY4ATFJXYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613892;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2DXjMfHQjgXqhHR/7VyksYuqfvHCn4+cqZW08H/sm6c=;
	b=bltXswePoPyxtyUYDGI4xp08PQQRGYKJHzWQVyydeFcvirmdO9MQyKT5w60dJ/w2rBA3
	 qn9/sXDLS9pF7ycvVTkvpCa0MO7tq/7VFdIO9hzwZHKHj9TeI1lWMiYK4zVvVKPyQXw7d
	 98VJj26nqLl9b7e9hS7CuqG2JkwPjFKdvfku1X8JjwimSGdc2RuPQ/aaXInkfChFNXGWI
	 3tji+ikYl8oDRvKbjERqsuqYSkAREiBKklvM7lWwfUdL3S6TK7aZTyN1lZrRP8d4iWP3B
	 WL14nZ77J7mJ4yBMBvbTppKg8vSo08XutfuztAn9JpKUlm3NWrBRWai2FNMRSuqfbJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nRc5091X;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AF606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687AF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nRc5091X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613889;
	bh=P3xKLBmJYy67bnJzbYWVZep7r56njBD/axHyxj9uOKw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nRc5091XPdODmPlU+03f2IM4g0RMzZA2Mxc7xIGfthjL9g1lfQ2I5aAHq0HnkfDj8
	 FXUzyhogDnOE6CsDh0BzD8p/aVEhCRpCjDQkJ5OCvRnO9wR7hfo5sRCXnSts0WOqED
	 45yCsdCRI81DgXDTih8cMphBc8ET+l7FCa8o7KE72n3MRbZg+XhJR29EvcuzamOeW+
	 jwMSXM1GTKsU3GiqbjTOQDrF3GVw0YSVGPr7c866NuwIOZKuoTkT68WNJCZa4RLg7u
	 ms0tDaUpT4Mv3ZSO6OsYsinw/28xTeTufSQDyduUVfLVJN8agAmfPGYITszvCKVRSH
	 2nLv6GZxARfFQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D2AD17E0DCD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:09 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 5/6] monitor: Fix RFCOMM UIH frame length and credit-only handling
Date: Wed, 25 Nov 2026 14:37:55 +0100
Message-ID: <20261125133756.551659-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125133756.551659-1-frederic.danis@collabora.com>
References: <20261125133756.551659-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

rfcomm_packet() consumed the trailing 1-byte FCS via a separate
tmp_frame view over the same bytes, but never trimmed it from
l2cap_frame itself, so the FCS byte was still included in the
payload handed to uih_frame()/mcc_frame(). For OBEX traffic this
showed up as a spurious trailing byte once the OBEX decoder started
enforcing PDU lengths strictly; drop the byte from l2cap_frame->size
right after it is read.

uih_frame() also handed credit-only UIH frames (an RFCOMM credit flow
control update carrying no information payload, size 0 once the
optional credits octet is consumed) to the OBEX channel check and
decoder, which could misdecode them as a 0-length OBEX PDU. Skip
decoding entirely when no payload bytes remain.

rfcomm_packet() parsed the UIH frame's own declared hdr.length but
never bounded the payload by it, so an L2CAP PDU carrying more than
one multiplexed RFCOMM frame would feed the next frame's trailing
bytes into this frame's payload. Clamp l2cap_frame->size to
hdr.length (plus the leading credit octet, when present) instead.

Assisted-by: Claude:claude-sonnet-5
---
v2-v3: New in v3.
v4->v5:
  - Bound rfcomm_packet()'s payload by the UIH frame's own declared
    hdr.length (plus the leading credit octet, when present), instead
    of handing uih_frame()/mcc_frame() the whole remaining L2CAP PDU,
    so an L2CAP PDU carrying more than one multiplexed RFCOMM frame
    doesn't leak the next frame's bytes into this frame's payload.

 monitor/rfcomm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index d830684a9..90ddc3596 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -404,6 +404,12 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		print_field("%*cCredits: %d", indent, ' ', hdr->credits);
 	}
 
+	/* A credit-only UIH frame (credit-based flow control update)
+	 * carries no information payload; nothing to decode.
+	 */
+	if (!frame->size)
+		return true;
+
 	if (obex_channel(frame->index, frame->handle, channel, NULL))
 		obex_packet(frame, channel, frame->size);
 	else
@@ -434,6 +440,7 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 	struct rfcomm_frame rfcomm_frame;
 	struct rfcomm_lhdr hdr;
 	const struct rfcomm_data *rfcomm_data = NULL;
+	uint32_t max_size;
 	int i;
 
 	l2cap_frame_pull(&rfcomm_frame.l2cap_frame, frame, 0);
@@ -467,9 +474,31 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 	if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
 		goto fail;
 
+	/* The trailing FCS byte just consumed via tmp_frame is still
+	 * included in l2cap_frame's size (tmp_frame is a separate view
+	 * over the same bytes). Drop it so the information payload
+	 * handed to uih_frame()/mcc_frame() doesn't include it.
+	 */
+	l2cap_frame->size -= 1;
+
 	/* Decoding frame type */
 	ctype = RFCOMM_GET_TYPE(hdr.control);
 
+	/* An L2CAP PDU may legally carry more than one RFCOMM frame
+	 * back-to-back; bound the information payload to this frame's
+	 * own declared length so trailing bytes belonging to the next
+	 * multiplexed frame aren't mistaken for part of it. A UIH frame
+	 * with the P/F bit set carries a leading credit octet ahead of
+	 * the information field, which isn't covered by hdr.length.
+	 */
+	if (ctype == 0xef && GET_PF(hdr.control))
+		max_size = (uint32_t) hdr.length + 1;
+	else
+		max_size = hdr.length;
+
+	if (l2cap_frame->size > max_size)
+		l2cap_frame->size = max_size;
+
 	for (i = 0; rfcomm_table[i].str; i++) {
 		if (rfcomm_table[i].frame == ctype) {
 			rfcomm_data = &rfcomm_table[i];
-- 
2.43.0


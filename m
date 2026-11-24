Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532227;
	b=JpwGXvoIc1dc2mZPDfiS58RljJkuo41Sebe2Gn1zkhgDZMdJtbmvquzmpD0Cj4NKCkKe
	 6kEKB+YbX80QMNJ61jZy1GP2ZhWWOgXFcnIj3NnmG78Vx74I+nWIL2kllTDGyAl7kurIB
	 3OFDlzMjKO6f2IZwiIYIXn+8ozr19jZjthpInUk7Ck0nO7ctjJWqPtNZcrU/eRWBD7Oae
	 Sell3Y5WMeF7S0nL5mE84epajYRx9miYnpXz5kmiLqg/yHKHxDOXBqh9VtBQ1rW68rMVs
	 /zTHro12d7zdSahcpnfWfXsq6JNfzU4Nz0cTV+dMtfe7ZmDptK10//vPwIPs6BkbMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532227;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GMZVuekZekmuYWcCb7S8LK+CV3gRZCFMzDkJ4OsqeOk=;
	b=BxHVL5L1sD/1Q8ILzHhBg+IZN4lhXZGduBKFeWQX4delPqFvT5/MmSsb+j/oHhDnvnI9
	 gD2IwNDZd6wkYgxVlV9FiKg3WP8LVMRevADeWCgQUIyOBjw/MLtS0G6TPDqAEJNNEY2oD
	 njfPy82dLippQV21ckvDtnKi677V1ylOR1um7SlqW0zYmRyyZh38hlVhL9+jQB/gAgs/9
	 O7iXmIglPRazq0BpAe9iWWiOyaR4gzfBiSOpV8cPVRode7uKXYwfVCMiZ23VXG6F3bgC/
	 GsJOTOxgWrvtWIzXg2CsbjBWd9617RIj8Fhyz+wAd1xFihZJa8X9UzULwHEYQkYJzrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WzOzIyJC;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A630606A33A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A630606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WzOzIyJC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795532224;
	bh=AS2v32ptGPPXQLxGGbYG9TpnNsYi1k019wxqY82wuNk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WzOzIyJCh+/8JCqmqV7WwLcCL/z1ohA7eE8lovFIAut3I87tTV2H90P7/e2aqLv+I
	 IW4M9tiEYOcpKgyhoeZssyNtVWf5mapN3QORaHRlHcePsFYSrFI8/G78xmlWI1Jr+9
	 l2PAkoYJvJdNiDcxguQs5eemUq6v6Pv23sgVyZG13/dhRtEOqhJxbVJAWnbYJli+jl
	 +rcr2uMn3XeL0ccLInaMdYpL3d/ND4dn9nWdjdvri00Osy3tX0pZqQ7tqr0LRyzhJK
	 6rkqVbG46voirDWn8IFIjUwYyjbdPjKOdb/Fu16Y+6rjFR4F2Tl6JbUdh/Txrwxghk
	 D5qPKPU0NGAMA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93E5317E0F76
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:57:04 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] monitor: Fix RFCOMM UIH frame length and credit-only handling
Date: Tue, 24 Nov 2026 15:56:51 +0100
Message-ID: <20261124145653.336273-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124145653.336273-1-frederic.danis@collabora.com>
References: <20261124145653.336273-1-frederic.danis@collabora.com>
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

Assisted-by: Claude:claude-sonnet-5
---
v2-v3: New in v3.

 monitor/rfcomm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index d830684a9..8a44a2199 100644
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
@@ -467,6 +473,13 @@ void rfcomm_packet(const struct l2cap_frame *frame)
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
 
-- 
2.43.0


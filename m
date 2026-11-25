Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613890;
	b=OMFfCB0LTAgsXUB+UKAinez7wZQd/2kR+Np/4zzvKJFXwojh8pJA17eylDsG/gNFJmFZ
	 j2e2zL8o5apGYwyR0sFyFiryygfR3uKqXAWa9yOiimL1wD6SPrgzIUyP11d2IBgfAnuJQ
	 /5LKDJHl79RaYAi54JOrF0LAgpmoFO82SOXi7eP6gODOitTsj8LSyWugTbpwOTSgnO9sh
	 kRfankjWFMr5HaKKu3tegzlV1Nas07aGXukH/LtfR+Gv+XjYC/J73n5Dymp5eIyWcmWlA
	 Ll8F4wEI3gavl61Xx/TW05ObsxAFILgs8afiiSj4pozYZ/LNckkuAr04EWKB3Fb7OSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613890;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=cqBPamtlpseOltt9YWWTu6xNS5Bp36lsqwqkrf6O8/Q=;
	b=ap89OOH7rucEi3DTKsvpPJxbq6NwAnpF4OKr9UDt0NPZrzp8EyGJc1lg+MYnL9IYmpFo
	 M3OdeSZXXXQB4SCQddVU+2hxjXJVXzYlzycE40TTyURgwtpe97/PXr4aC1d1K4Ne0l9d3
	 optU3N3MVnTIYnOB85NmvNjPn638ehhtAD/Yqums6/b12uHsFSnkSxbpSO6JQ4kWxPoZJ
	 VpEfPLK7+IHi7Nwitn1VEAjng/Wp8ajl+sk9G4G5jbLL5wJe9U1iecROIGJm51UJVOZl9
	 ifQMCz1TO3m+TCIpAqNWz+LF5V5/MTpnzY2yV0cziM+bjwIubZnrIP661SZxTkXppQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P0jCZbHE;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C5606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P0jCZbHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613888;
	bh=qp2HQ+nULEZ9SiG0XPvlCRiOzjVwQ1NLtaW1D8CgXPY=;
	h=From:To:Subject:Date:From;
	b=P0jCZbHECw3hl+W7JSLS87WDKzvwCe9kztq0gX9rJ9Om4otehL//7rUGcIe0sFkuW
	 unfVFs1s2MKC7EzMLL3y78cJHYqMy1KxHeF9Kh7d9KEDa9cAWGhcjg9iXUeIBWNXRm
	 E1+/5gkJa2eqrJUlBn+R5NBhsjP8xZiSsQXQC54MVU9Pet13q0JsOlWC7cf12jlfx5
	 RsaYKUnbJ8YPlKtfnCo+9nzXpqBvPX6gVOgvyF8/LL/BBmYC7zMT8/jM44liG2lq7Q
	 c0PnRYXvgN5h2XFSmsTWtw5XrryqUcrUIwBwtyPGSX87DLfn3C/l2q31WgjBvoNbkO
	 Fme6nDDQFhW6Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 403B017E005B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:08 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/6] monitor: Add an OBEX protocol decoder to btmon
Date: Wed, 25 Nov 2026 14:37:50 +0100
Message-ID: <20261125133756.551659-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

btmon currently hexdumps all OBEX traffic (RFCOMM and L2CAP GOEP), making
PBAP/MAP/BIP/OPP sessions hard to follow in a trace. This series adds a
dedicated OBEX dissector (monitor/obex.c) and wires it into the RFCOMM,
L2CAP and SDP monitors.

Patch 1 adds the core decoder: opcodes, response codes, CONNECT/SETPATH
fixed fields, all generic header IDs, BIP's IMG-Handle/IMG-Descriptor
extension headers, and Target/Who UUID recognition for the well known
OBEX profiles.
It tracks sessions on both RFCOMM (learned from SDP
ProtocolDescriptorList) and L2CAP (a dynamically negotiated PSM
learned from the GoepL2capPsm SDP attribute), keyed
direction-independently so CONNECT requests and responses are correctly
matched to the same session.

Patch 2 adds per-profile Application Parameters (Tag/Len/Value) decoding
for PBAP, MAP and BIP, replacing the generic 'Tag 0xNN len N' hexdump with
named, typed values, using the profile learned from each session's
Target/Who header.

Patch 3 adds SDU reassembly for L2CAP ERTM/Streaming mode, since OBEX PDUs
routinely span multiple SAR fragments; without it, any segmented PDU
failed to parse ('frame too short'). Reassembled PDUs are decoded once, on
the End fragment, while raw per-fragment hexdumps are kept for
Start/Continuation fragments so no bytes are lost from the trace.

Sample decode, a PBAP CONNECT followed by a GET with Application
Parameters:

OBEX: Connect (0x00) final 1 len 35
   Version: 1.0
   Flags: 0x00
   Max Packet Length: 8087
   Target: Phonebook Access (PBAP)
   Application Parameters: [len 6]
     Supported Features: 1023 (0x000003ff)
...
OBEX: Get (0x03) final 1 len 87
   Connection ID: 1 (0x00000001)
   Single Response Mode: 1 (0x01)
   Name: telecom/fav.vcf
   Type: x-bt/phonebook
   Application Parameters: [len 21]
     Format: 1 (0x01)
     Max List Count: 65535 (0xffff)
     Filter: 0x0000000018b111af
     List Start Offset: 0 (0x0000)

v1->v2: Fix commit title issue
v2->v3: Address review feedback:
  - Patch 2 (OBEX protocol decoder): fix a possible uint32_t overflow in
    the SDP element-length parsing, fix obex_de_uuid16() extracting the
    short value from the wrong half of a 32-bit UUID, and stop treating
    L2CAP PSM 0x1001 as always running OBEX.
  - Patch 3 (PBAP/MAP/BIP Application Parameters): clear the learned
    profile classification on session/channel/handle teardown and on a
    new CONNECT, so a later session can't inherit a stale profile.
  - Patch 4 (L2CAP SDU reassembly, retitled): track the expected TxSeq
    per direction to discard retransmitted/duplicate fragments and stop
    reassembling past a lost fragment, and fix l2cap_sdu_reassemble()
    reporting success on an End fragment with no buffered Start, which
    could free a borrowed packet buffer.
  - New patch 5: trim the trailing RFCOMM FCS byte from the payload
    handed to upper layer dissectors, and skip credit-only UIH frames.
  - New patch 6: reassemble OBEX PDUs split across several RFCOMM UIH
    frames, since the RFCOMM MTU is typically smaller than the maximum
    OBEX PDU length.
v3->v4: Address review feedback:
  - Patch 1 (L2CAP FCS): apply an FCS value requested by a Config
    Request on a successful, option-free Config Response too.
  - Patch 2 (OBEX protocol decoder): fix the disconnect handler's
    swapped SCID/DCID session resolution, stop obex_remove_channel()
    from dropping the SDP-learned channel mapping so a reconnect on
    the same ACL link doesn't need SDP repeated, validate 128-bit
    UUIDs against the Bluetooth Base UUID before treating them as
    16-bit assigned numbers, recognize OBEX running directly over a
    dedicated L2CAP PSM (e.g. BIP's AVRCP Cover Art), only trust a
    GOEP L2CAP PSM attribute once the record is confirmed to speak
    OBEX, and decode UTF-16 surrogate pairs correctly.
  - Patch 3 (PBAP/MAP/BIP Application Parameters): document why
    obex_remove_channel() keeps the channel mapping, and use a
    channel-zero check consistently to detect free profile slots.
  - Patch 6 (OBEX PDU reassembly over RFCOMM): free a handle's
    reassembly buffers when the ACL link itself is disconnected
    without a per-channel RFCOMM DISC/DM, and widen the reassembly
    length/position tracking to avoid truncating a malformed
    declared length's remaining byte count.
v4->v5: Address review feedback:
  - Patch 1 (L2CAP FCS): discard a pending requested FCS value when
    its Config Request is rejected with Unknown Options, so a later
    unrelated successful Config Response doesn't apply it.
  - Patch 2 (OBEX protocol decoder): use the processed frame's
    data/size, not the original pre-FCS-strip/pre-reassembly packet
    parameters, in the default-PSM hexdump fallback.
  - Patch 4 (L2CAP SDU reassembly): track the TxSeq of the Start
    fragment that began the in-progress SDU and compare a new Start
    fragment against it, so a retransmitted duplicate of that Start
    fragment doesn't needlessly discard the already-buffered
    Continuation fragments.
  - Patch 5 (RFCOMM UIH length/credit handling): bound the payload
    handed to uih_frame()/mcc_frame() by the UIH frame's own declared
    hdr.length, so an L2CAP PDU carrying more than one multiplexed
    RFCOMM frame doesn't leak the next frame's bytes into this
    frame's payload.
  - Patch 6 (OBEX PDU reassembly over RFCOMM): hexdump an
    incomplete, still-buffered PDU's own payload instead of showing
    nothing, key the reassembly buffer and OBEX session state on the
    full DLCI instead of just the server channel number, clear every
    data channel's OBEX state on a DLCI 0 (multiplexer) or RFCOMM
    L2CAP transport teardown, and bounds-check a chan_list[] index
    derived from an unresolved CID before dereferencing it.

Frédéric Danis (6):
  monitor: Strip trailing L2CAP FCS before upper layer dissectors
  monitor: Add OBEX protocol decoder
  monitor: Decode PBAP/MAP/BIP Application Parameters tags
  monitor: Reassemble L2CAP ERTM/Streaming SDUs
  monitor: Fix RFCOMM UIH frame length and credit-only handling
  monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames

 Makefile.tools   |    1 +
 monitor/l2cap.c  |  476 +++++++++++++-
 monitor/l2cap.h  |    2 +
 monitor/obex.c   | 1565 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/obex.h   |  121 ++++
 monitor/packet.c |    6 +-
 monitor/rfcomm.c |  246 +++++++-
 monitor/sdp.c    |   12 +-
 8 files changed, 2397 insertions(+), 32 deletions(-)
 create mode 100644 monitor/obex.c
 create mode 100644 monitor/obex.h

-- 
2.43.0


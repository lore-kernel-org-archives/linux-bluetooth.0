Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512180;
	b=Ki/Zn84hu/dukWAKdDZAcpJDuuWbiMYPlE5wiRkHy5RzDgIuwneWlTorYjCDj6vTftw8
	 79kvq3jBlYLvmUpwfe5SV6h8CAjk/YtiKD08olhfmvpcqcrIOgrKn3O3ljrmfmBZmMZK6
	 r9bcK8/s7I/+IMcymYLiQgy6CcP+HHYyO7oxgL5EkfcBY/VamDJotWchcbfUGL9FLHi4w
	 u1/HNGOKPb6f4uA3el3r/JzipH86YqzsOFSqpSRK6gWf1mlLX3nfPcUE0iaivZQjbvPGM
	 1FP++OkAEM1ER0SaqqQxq6iPebUhxT2rTnI6lwqtWE3DKAbfNqLjw8toerfb4zhSlAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512180;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=baiHsIwXHM/zn65UfCc6bxMRVspUnut0vMBwnf8sDXo=;
	b=dwIZwYdsjeGHQg2kG6mBguwdt51CCU75LkVBMIQWo5HhUoKn1BSmU+oyyWAJzsMY3yAP
	 k1t2NEATXiAghWLox3JuTQG+weOaoIfNRC4Vd5VsitzIqjothGkusW16A+J/M9nkwUvzd
	 B9kc7FVddR4BrjO5cVGVdUOTE21tZKOCp693eGa0Z7PVv4NObalMjlKFOyEYUTEisjikf
	 BcEE1hSPMRrRUvRM/WEirWxKKimyPz3hKunsvje6rZKcwkKq49QRs9Yr/Ym/ve2kJI69F
	 CexBR+qb9Ab2SGFN4Rwpcnm4v9MDl7wDDh9i2sleFhLjEiK2RzOQEJQ7q0bh1Cf2fyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=op1HLKrl;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E0606A332
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144E0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=op1HLKrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795512175;
	bh=HWJNtBcqPxPVeOldTUkHdH9sId8/Jm20uX6NQdpCdtY=;
	h=From:To:Subject:Date:From;
	b=op1HLKrleqVrOdMwAxAm48KGJht3cnZEczlsTFkgE3qXqNpZkPJ2r1tkRZ+u7KFD8
	 FQx++/sOdtCL0M9rM3maeSI9aEZyZJyba+qncIIBFR6Av3xo0pLew1bkLQJ4LzUGGS
	 cxvFD+UXp0qB2gbU8H0Q57lPOPDU+E/lEpa7HI/hSVc0knb5Y6IfelZk6+ba3/W4DT
	 sINTRlwByHNtprmNpBwnvh6IEIqRd6RZXhu+BE3thxMj2h5k08ONVxq4Xi21WRQZ/V
	 67RR7RJsCDRONnctptL3R8Q2UAsQWAInP1ihcxOWLNYl++kQthgTsKsZ93oCFz8hSX
	 ZkCZXMsNp3tYA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3898517E04DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:22:55 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/6] monitor: Add an OBEX protocol decoder to btmon
Date: Tue, 24 Nov 2026 10:22:41 +0100
Message-ID: <20261124092248.207565-1-frederic.danis@collabora.com>
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

Frédéric Danis (6):
  monitor: Strip trailing L2CAP FCS before upper layer dissectors
  monitor: Add OBEX protocol decoder
  monitor: Decode PBAP/MAP/BIP Application Parameters tags
  monitor: Reassemble L2CAP ERTM/Streaming SDUs
  monitor: Fix RFCOMM UIH frame length and credit-only handling
  monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames

 Makefile.tools   |    1 +
 monitor/l2cap.c  |  314 +++++++++-
 monitor/obex.c   | 1437 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/obex.h   |  119 ++++
 monitor/packet.c |    5 +-
 monitor/rfcomm.c |  165 +++++-
 monitor/sdp.c    |   12 +-
 7 files changed, 2023 insertions(+), 30 deletions(-)
 create mode 100644 monitor/obex.c
 create mode 100644 monitor/obex.h

-- 
2.43.0


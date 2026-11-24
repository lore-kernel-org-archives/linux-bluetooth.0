Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532225;
	b=ZtGi6v31yRmnVy7uTIqAFrKRTtPRIGHm3C+6LZk8pnF9gp0bdHSwS8kW5qq8EQmeDsuS
	 uHpyuA7Hj+nyhqP20Z3U1TqpxCqPInmcDFQQ1Gr7g8i6TVbkfgZjaO6+Igoast1Lhh0q5
	 wiqSkgfCIHO0WA3IBCok8r/kRSkqLMMqtL85w3I4BRGdTuM54kqXKmDbNj5Q5IVaD6zYT
	 x/q3od1Swhn2gjykJM7qJ+xnYeBIaDF2IrTPH0aahwqZ8NsCNtlUttiAZcFxjUH4YROAh
	 6ioSwE1S+5oFTOMBPeN1wZMXIyi2vJe/I60WuE292+/ynT6B6k8TzaOC/ok8PLgn6sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532225;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=CW3jqQcxDq+hgRzEPN4XIdltBMPz25ze4ju/xSwcbmQ=;
	b=Ow6GPY+w6XZxhmQZaKRWa0rav5ozuoPeQ1P5uSMzX+Q7cwMdHAxAHkAB9epcCqR92ql0
	 7wWLvXn3aWNzGIchzroRkl1geusnlyGIaEQQyE1+YliuBNiDNJ3AAyQWIy9XNvYccXDVu
	 PwYejMlV9e3bbJs2YlVptjSAu/LP9bhsEDyv0v1URX4TrrSJIIB5mPmMewfhlgOgOTJ6W
	 GPuOutTgW2HnUqCy4A0vlAtE8+/T4QfBfLIvUZabt3xtN7GO0ba7BkQhlYVOSgsR0ytzo
	 16KaqCn2CwuR+sJoJtjUb6AKEjxFcx0VPdMY+aDupVOgmPTP5B6SqkEFeA+ftArPgaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VCeG4Bpy;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E0606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 259E0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VCeG4Bpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795532223;
	bh=AGv/AJH9QZXtT6tyGnDJ36Eon6v383d//BdT9Ua+eB8=;
	h=From:To:Subject:Date:From;
	b=VCeG4Bpyc+ergrlH2r7uthfbFiRSzV+/BgczA/64jNBjRVZnm6TlgMtSht1VgVwDf
	 AWZU5LLXNWTdLu+a5QBlV+k43KAFaczNKSanw+EHxkSywBG3ufP2WQDgW2aDEdwb4g
	 nx2lKHEEl+LQvatKFVsS8gmJaXul90Q+tNVjyG/wq6QrfOTnHRc9pDD3iHfFCPrbn2
	 xF0A8CEIzV9/WPi8FZObncQ3qJZHyJz6/2RIMgx1/1xvxFHzMxjFUEnnx1sxsdThLk
	 uEL+NAW0+EMXiZyWlT0IiKES4uEVK5cHu5EwqE/71tjtG+D9dTMxWHWUey11QjlRAl
	 pZTmDplMKTEfw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AA1217E00E8
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:57:03 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/6] monitor: Add an OBEX protocol decoder to btmon
Date: Tue, 24 Nov 2026 15:56:46 +0100
Message-ID: <20261124145653.336273-1-frederic.danis@collabora.com>
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

Frédéric Danis (6):
  monitor: Strip trailing L2CAP FCS before upper layer dissectors
  monitor: Add OBEX protocol decoder
  monitor: Decode PBAP/MAP/BIP Application Parameters tags
  monitor: Reassemble L2CAP ERTM/Streaming SDUs
  monitor: Fix RFCOMM UIH frame length and credit-only handling
  monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames

 Makefile.tools   |    1 +
 monitor/l2cap.c  |  389 +++++++++++-
 monitor/l2cap.h  |    2 +
 monitor/obex.c   | 1512 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/obex.h   |  119 ++++
 monitor/packet.c |    6 +-
 monitor/rfcomm.c |  194 +++++-
 monitor/sdp.c    |   12 +-
 8 files changed, 2203 insertions(+), 32 deletions(-)
 create mode 100644 monitor/obex.c
 create mode 100644 monitor/obex.h

-- 
2.43.0


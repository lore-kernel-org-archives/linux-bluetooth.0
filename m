Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429558;
	b=TTqQjyG4Pr3LUIrug/vz8p99EFkmLmQCEl0AOLCiZrNHwMTyTEc6Qg/5z4zsdS20ore7
	 qxOKbptl1qDvtGPzjLI1hPoPgEc6S28B1cWCIuAEzkpzPi27Zo5yOPgFY2u/ucYlGds/l
	 dxHFR2n5U08ebKUevpbCdKR+GFNnXtraNs73yf3ksRrc4vY0nupVgJS1rYftO3H/B7ADC
	 /yPXESY7o5EvgTLm8Tp+zSBxE0IIzlw2WupYbtG7m7k0f32d3Sbw2fpBmkDqZ+p3aBCBX
	 SABiibBHQ0akFSPLkwANdpBzYkmmORXjxePjHtOSOeNKEjyn6dHhOKVOQere/7gqQkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429558;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=+9zjlDtD1XkkNu+oNjKjWMzdSvANPwTNAm8KUafG/D8=;
	b=hoyyD8Rp9Lcl1bCFs5GGSks8N3k0hayzZJAhU8yMsVWVIFJ1Ezk0e2StNc009Wp/zH8G
	 uBq/tlANdk1PN8zkPjlVOedYBvb04Z3qQrIgX5TKv3zOoChNVDPMxVhF40Y7+M1epwzIu
	 AxiK1RrWQAOWzMlC0WtlqTHVoWbASFpGufW79gUY70i9y0JaUbaAy3ft9WHCRLxNJy1Vz
	 /5o+YlmdNd1ohYFXRsO9e+t2P421albUlWHxBXX6L14r5c2p3uECcXdodwrpB1eUqKHWe
	 yIGD9ROLZvtd8O0Ca1wZGY0CI0vQp+7Z3t6BKc7pOg7GsgJ5ilrGYzCHffAMC+CpuHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BOatNFjB;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6D606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A6D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BOatNFjB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795429555;
	bh=iY9SIzOpKXwl8jHMny+HCtxElTPz+iG0paGYzkrfq3Q=;
	h=From:To:Subject:Date:From;
	b=BOatNFjB3qKxEnTf6+mOdyuC547tF/zpiReI9L6pRWWRgoQJ3xpg9YwG/Cew8Dil0
	 JDkaB5yrN0PmpB3Q8b7KJkYw3VU15LxfX7pM1+8NsdP+QeCE1AlqMzYMysNOiHo8D+
	 fUowFhLRRwOzAQmh/RZWqLQGkUaudlTN7s1mlWcAUxpxmf6FfGvc9x9Ggh5iMXAdRu
	 0Cb2N9Hy5Wa3bwhzUhqic6sqo9AKXiZ7vmHLFtdKGgX+q/le5Mv8UOPx8WYdv8hlbU
	 z9bkmTanmIBV9YbrQVrja1ppaP6wsw7p/hjq3Xxn/brUBe6bZz6vM/7UBINC38MkLw
	 7VRJrA+OS15Nw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66FC817E021B
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 11:25:55 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] monitor: Add an OBEX protocol decoder to btmon
Date: Mon, 23 Nov 2026 11:25:44 +0100
Message-ID: <20261123102548.61362-1-frederic.danis@collabora.com>
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

From: Frédéric Danis <frederic.danis.oss@gmail.com>

btmon currently hexdumps all OBEX traffic (RFCOMM and L2CAP GOEP), making
PBAP/MAP/BIP/OPP sessions hard to follow in a trace. This series adds a
dedicated OBEX dissector (monitor/obex.c) and wires it into the RFCOMM,
L2CAP and SDP monitors.

Patch 1 adds the core decoder: opcodes, response codes, CONNECT/SETPATH
fixed fields, all generic header IDs, BIP's IMG-Handle/IMG-Descriptor
extension headers, and Target/Who UUID recognition for the well known
OBEX profiles.
It tracks sessions on both RFCOMM (learned from SDP
ProtocolDescriptorList) and L2CAP (fixed PSM 0x1001 or a dynamically
negotiated one learned from the GoepL2capPsm SDP attribute), keyed
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

Frédéric Danis (4):
  monitor: Strip trailing L2CAP FCS before upper layer dissectors
  monitor: Add OBEX protocol decoder
  monitor: Decode PBAP/MAP/BIP Application Parameters tags
  monitor: Reassemble L2CAP ERTM/Streaming SAR fragments before
    dissecting

 Makefile.tools   |    1 +
 monitor/l2cap.c  |  246 +++++++-
 monitor/obex.c   | 1390 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/obex.h   |  119 ++++
 monitor/packet.c |    5 +-
 monitor/rfcomm.c |   20 +-
 monitor/sdp.c    |   12 +-
 7 files changed, 1768 insertions(+), 25 deletions(-)
 create mode 100644 monitor/obex.c
 create mode 100644 monitor/obex.h

-- 
2.43.0


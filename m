Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444262;
	b=hxJmKVcHtZiQa3fJWG9DNZL1s2RYAoyI5vfy0287ELnnW0cssSg4h4b6XrdOxPj+uyop
	 H8bqqn2sWqOh2HbDcEPYZyzSMDMpit6W/dQIjkpZwJutHICOT2P8/4LVaYbMQn6yaxNKu
	 WFvUnroDoZUR/YnTzn3NQZBO3wHvWEdxs7VA4g1UcgKXtme4rNzJ9gktj9P2DA5KbSAHg
	 KIx9n46KkpEBSa+5++obOmCUkUFduOuriAIVr0hYq7N6h9GVxT4In6HcjrgTMfq+md3Nv
	 Q8jrqhE2k9YDoVFNTWPNup7nqYvlhnaSiVv5KRsNd9RBG29CgaeiddXZHWQ149jFhrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444262;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWA3D6zFyJc1v6YJfft7itctp0zWyVbzZFOhkm0KH8s=;
	b=W++XkN1QlR8VRoZ0adbzJaSuSzjqZZDK/vUuxhZmL0a5BDat4/RefUjjNWp9WkxoMo15
	 4GQT0MU9nBiOHzR33H47h4R1wakulLihJcJs7NfItiHBbJpjvjnE5uIJ6vwsy6V34qA3W
	 wq1SljwqtmkeYQazYhV+Zdecc4+D5QI9p49LGoaWpCQ+LtIyNktxgloQoAWNTB1joWedn
	 JFIvHS0heAEgpuOiwB5RQwhahJfAiUY+lW/XFP8Cy4t5IubTROBvI7MEcPbcvkF5f1sgB
	 8JuUF1IvoA+7NO/fCCpY03e/SnIlM8ED/rL5cdFiQgLwb2C5S0RF9LnBTPs3tmJKdbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oRxHUS2T;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425B606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4425B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oRxHUS2T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795444259;
	bh=KOBbfPzYvIXbu+tdFWZjBmRo7ixiY9VdkY/O0/kyDv4=;
	h=From:To:Subject:Date:From;
	b=oRxHUS2TDJ52XvRiTmYwsRpAbsnGaQNYl1KwTbngoH28mHv2t7d5aktjZW4EJffTQ
	 If1YNfFsDxPfjiIpAJdOPTWdnMxkU+Jkn/DZgtKUyz7nEUuBRSUeZw6ZGsRjWxqgsv
	 cn8LfK0AqWK7u9Aa8eTpo9iTmipIskM2bdZfHCQ7fpL7Jcyf6Fc9p3uAgDqHoehVpq
	 9ItEpYsHd3O1uLZ3huiSsYXz9bKjNXkuTNsrPnuiWmzNmzj+gJs1aZDCoR6fwb0AWb
	 Afcz6EbiIQ7szO+ZesXl8Suq01ua81D1jrVqeyX+r0WUgj/D2h7jZJ4H/monw2GRy3
	 0ZJPT8FUXiaEA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A192A17E021B
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:30:59 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/4] monitor: Add an OBEX protocol decoder to btmon
Date: Mon, 23 Nov 2026 15:30:50 +0100
Message-ID: <20261123143054.116007-1-frederic.danis@collabora.com>
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

v1->v2: Fix commit title issue

Frédéric Danis (4):
  monitor: Strip trailing L2CAP FCS before upper layer dissectors
  monitor: Add OBEX protocol decoder
  monitor: Decode PBAP/MAP/BIP Application Parameters tags
  monitor: Reassemble L2CAP ERTM/Streaming fragments before dissecting

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


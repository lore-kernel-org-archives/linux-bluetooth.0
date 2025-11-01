Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325082C3262;
	Sat,  1 Nov 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998989; cv=pass; b=g4oHC0wsywU+OrTMEZKuqlWnv7BL+VigjC2VNGKphtUEseiCmbqhA7XYJeU8VGETsbJgY06o+9/G1wl22crr6/qlMmnwUE5lmPRP1rK669ylixgrlnZ+o7UOAhOEQ3xgo6YIx/HwsSGJnsN2B8ad3vbuXRFkXg/lhPM805DRbA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998989; c=relaxed/simple;
	bh=NcAlMqDdMRz/v2VxGUodZn5cxH+8ecfgWR8Uz40bwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLH8IPgeJSTI/Ze43ShA2kVi/CaGwYujz96YRM33VnkA/L9pKTfkeVCbhPi6mmrxfAdUOdCuaLLjXiETHSOq/w6Y0dEy6q581AyqVDkVWW8TFWUC8GndWwkEus/hmudVjFzYRVA/6MpB5SFI7j4w1LtLx46nldOCnGwvEZicuk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=J5OLF2yE; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=f4Utndre; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="J5OLF2yE";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="f4Utndre"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4czGqf1wlGz49Psw;
	Sat,  1 Nov 2025 14:09:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1761998974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBBNCKo9ePNephA/xZaTvsunYp5GceXJ6NgFpJmSExk=;
	b=J5OLF2yEEds46CbdBcXb6SkVSakBzPZM/lLE9Eatnvo/K4gtzhvhZQpYb19cmz1jGjhUhC
	AnBgF7Q3gsUHGNNNgBKr97xGhl+iTR6uwIvG8bI/FrmbhffUlhyEbt2slRowjLF7peC38S
	KWHorWNvnh7xNDAbmfXahPZSeCwNra63iS7WeD8bsH3rFUqhj1SWGSjW+Bnd/rcJfDRlNr
	UxFrpuMTdOXvROa8tC4vEwdSMzLgJ1c8AHjn88Xt7jlJAcFcoVj95V33KxoQokAUIWuHyi
	n2Jo3mMvLEGAKzkT9UgHQm5zLNTj6SjFV399P9t4ObTXwtCq5FBBdF4ZGXRTog==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGqQ5cWlzyYG;
	Sat,  1 Nov 2025 14:09:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761998964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBBNCKo9ePNephA/xZaTvsunYp5GceXJ6NgFpJmSExk=;
	b=f4UtndreOsIs5Yzbt9LFWmxTpy4tAeC95qj8V8ELDG5fnNa9meH2X/4MoaNDqnq/pWPC5P
	q8j2KgH5JcuGkWXgHOmva3SV4bYMdFeKKbCuqZu1gqLCgkZ7Q0UI6NE8X/Z9pTQxt6O1KR
	0W6mxdaTNNk8In0SGtmXiCg+2aTMb+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761998964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NBBNCKo9ePNephA/xZaTvsunYp5GceXJ6NgFpJmSExk=;
	b=e44ZNYu14WIDy9xBY9f22GrXFHxR2NGvgmhu4/p70hxSuXQGodk2LRii0zyV2dOHsT3irl
	NNpN22GdeU8p3wU5Y5hv6QzBA6RzCVCbWumq00Ji1IE9at115Dyu02rkaPD0EP+nGHZmB1
	8UL94AYuZaRas3kRlTZS4ly36PaVYZs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761998964; a=rsa-sha256; cv=none;
	b=a+wj+nlHi2/Lv8dDNI76VHPQiTcBJ/zKdN/eiWlniNNG3GrXLwKGcMUGblGJ9raYIqeDfu
	ayawQ9+953mVtgjenkZc2Bjt8bujcywM0ihRLMK/ZbYaWk9lKWLO80V3exaXo2s7IgfNvB
	ld2cvqVZHAN93N5eEHc1YZ5rLUthuow=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	jukka.rissanen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
Date: Sat,  1 Nov 2025 14:09:11 +0200
Message-ID: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth 6lowpan.c netdev has header_ops, so it must set link-local
header for RX skb, otherwise things crash, eg. with AF_PACKET SOCK_RAW

Add missing skb_reset_mac_header() for uncompressed ipv6 RX path.

For the compressed one, it is done in lowpan_header_decompress().

Log: (BlueZ 6lowpan-tester Client Recv Raw - Success)
------
kernel BUG at net/core/skbuff.c:212!
Call Trace:
<IRQ>
...
packet_rcv (net/packet/af_packet.c:2152)
...
<TASK>
__local_bh_enable_ip (kernel/softirq.c:407)
netif_rx (net/core/dev.c:5648)
chan_recv_cb (net/bluetooth/6lowpan.c:294 net/bluetooth/6lowpan.c:359)
------

Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/6lowpan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f0c862091bff..f1d29fa4b411 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -289,6 +289,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		local_skb->pkt_type = PACKET_HOST;
 		local_skb->dev = dev;
 
+		skb_reset_mac_header(local_skb);
 		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
 
 		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
-- 
2.51.1


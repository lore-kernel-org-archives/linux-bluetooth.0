Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5033191BE;
	Mon,  3 Nov 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194609; cv=pass; b=YMt+h3/rXlU4ecmWvZIohdIubMDMxbDIEWza43mPOlrvk7oM0PNGERIQ3ETfNBGXwYX8L+hDEeVGWlCs4fz9o9GbH76B8Ft29LMbAe7QIzRKzWR3YzRJjbe9Udj9V9A8Doa6fbZYaaiHz7taTcXhrsi3K3q8tckyzHJcbRN5ncw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194609; c=relaxed/simple;
	bh=zv0gKD/j2UCGGjns0g8GmhckBkJTGfzoNfR0PPE3+0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk0Z0XxOLM7oSBagHmDEEkvXNHs48n7f/KSpuL+1mGP9UNKYbq7PfI2rubQQFSAF4HO7XsKr6FaZblg5OnzrPzafRqS8vMe1R0/FBbw6s05t68N/pMa+sERQ4AljBnhT/B5Ry+WLsPBlfKNQxFp/5QCJ0dkss/bCIazpCUS+W4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hTpfaXXU; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hTpfaXXU"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d0g9b3b1QzyW3;
	Mon,  3 Nov 2025 20:29:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762194596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gOeRgg8+DiILvbZr6t4qjobZPBFwYKrN2a8qo0BZFMI=;
	b=hTpfaXXUaxrxQn2BC5tn+iX598cyQ0wJUjO16ada8qKLf/C3yVJH61BlmUzkWZEHW5LQHC
	mC3h4vv/C4tfCMgxGbIbqvr9A8r/yRzbHTXXp76HXRm0PxCXeFcosjl10ipQruCNquUdll
	fq+b65NZPuvmZDxvtyc4O1t7Fg1ompg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762194596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gOeRgg8+DiILvbZr6t4qjobZPBFwYKrN2a8qo0BZFMI=;
	b=x+M0tkstS2vWo0ci0rx/mF+chqRqD6KzpsP64udSITlwt98cxaQ4fzHpLf6XaHnsYYTMiL
	i8XqIhjmVzsC5gItIz2BQH9l8qC3yvRN9wYyPiIIfl/kZ1rkP01itDfWZHXu1QQ0NROk8G
	/rDEeYuBC+CXsrclfluZ3/yk1KzLChk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762194596; a=rsa-sha256; cv=none;
	b=HCrmmgtX+1UfToW57SgP2UoIXqUmnTWUp5Z5PltNKa4a2srX9uinhw5D7JdH+crKad2lTA
	hXhKurLS3mdKPwqYDR18N3wbsobszrvQXEf6daTEOP/E9m3YLwzokNQ3S9pBJ7lTTo+rpf
	TNgHoZxEKAxdPnfyp0tKUx+QMX8FEzk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 1/5] Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
Date: Mon,  3 Nov 2025 20:29:46 +0200
Message-ID: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no changes

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


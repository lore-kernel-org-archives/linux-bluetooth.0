Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED313526
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564696; cv=pass; b=GrwMFarG7yQ4+XoELJ8sSxy3j3IQQXZW3wj5sASt9XRas1UDixBdAOJa6rj54W0Y+9RxfSMib34eWtU8zkV0t3k8juLyPbey5nutHqjfVaPXknxcrLj9l0IcWdBiQMu1e2ViDn5+YJ+tVUeR0bPCE65cZy5nCkLAZvlo6Lqdr2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564696; c=relaxed/simple;
	bh=jpuw9iX+EZA6yUHJBZ7CjZaRSuZSqm+frEdEJA5XKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgzuJnopnPjy5sKt4sCANaTPBy46y+N/MRMZEVT5aqqpuXgr6/bdBwsbPHTIDifVieXQLKlNTXeP3mZ8PQHPv0Qyww9OLmFSl+jdY0v+VpthXH1lnElhkJXgqA41nwG5egOnx1jI7AuzGAkyrydM+NVVTRBEf5AuMD0JvamnCMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cDNNkwIg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cDNNkwIg"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVrlf0pT0z49QMJ;
	Mon, 22 Sep 2025 21:11:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758564686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VnyqrQQVB17l3OF2vl7cQZzHv6Zj/EhQElE0vYlv0AQ=;
	b=cDNNkwIg/wtWRCPudYhS64Uvd8mU61AWFGynT49YrAsw4wGuuk+m9ergyyxq4TFGmVi2rk
	rXumWWctfJuTxd4qGYPP9b2Bu6xr6a/q1RY2hO8xAAvLbiWEAOjDahKe1pkkv3Nz7Eq5F5
	T7GUoo3506RLF0jwuyD+tO9GfNhagebc412RX5KCtBdtCVfG5LAwDKvHFGFw6Zbe3slJqr
	n1ftCT7iGZ/o8I8z8DhRryhtxI58tUmBCrV1uyIdgDDR9mlUNECWZ2S8/ph0temdEBvdhc
	FQsSDu1gvR8F8FCtINCFW6uiJXO0CRRdO/2HFlozdIqhckoSAVVOrZ+QZaJ8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758564686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VnyqrQQVB17l3OF2vl7cQZzHv6Zj/EhQElE0vYlv0AQ=;
	b=W2pecwFHm7BJGQ0PyEAs63JOCm5hogN9J+6YFjDs/A5U+HMc6tzKhcOzXzWepQ9tdrqi6K
	Qw3kh7R+4PnYaUW537M4Bv01tRqNl0gHfFYlp0LUdYxm5bEgINRYkPGMR/QbY1BU/XNFAa
	OACFFrVVxGWExci7KkPjQJIOE+l/545zo2R/zIgL9JTdV8D12n5KcLR0JW6zAMZRcMv+zz
	OQgmqNAB1s7V/lOO9e3ZDFQcGTGHR0788B5Rlc8tuKEbn8jHWaOQeACLDB22V5Y8NdSWfn
	zMt3twi0gk8r1lMQ3HSAJIi+zWwd4ZkKLuihdSKB+cpOWIoriiFnevUNc4Y4wA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758564686; a=rsa-sha256;
	cv=none;
	b=rsiryBG+fPukYvVpZs/AW+YkoqCYJKCuYefjc/D+zQcEzJREc+4/m2y6cLKZk3sNo7ClKe
	ZozaF1+7xKeVoKU2bCZd33qkNnZwqV7N45BDm0PleHgvVlIG/CnH/UWes6X661vk7KOjCI
	48B2B+WKmkWRxpav7zY4x42S0S6qRbEueuEhWYZAxYmoBwXGBQJPrgVi/D368DTXhPlwSr
	eqztXaPMr0EM14L0G8JYpz/cJjW/gnAusC69gL06sKjJvPaeKRVnjEB6kf+xwHGGPA7y0G
	KSaAZJw4nT5CKw+eYgZA0nBuSygUQ0w5g6LRWDmASuDCS8nICnbtfoanh7dTDQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/2] Bluetooth: ISO: free rx_skb if not consumed
Date: Mon, 22 Sep 2025 21:11:21 +0300
Message-ID: <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758564480.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iso_conn is freed when RX is incomplete, free any leftover skb piece.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5c68c0ea7d97..d63d4d6f874c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -111,6 +111,8 @@ static void iso_conn_free(struct kref *ref)
 	/* Ensure no more work items will run since hci_conn has been dropped */
 	disable_delayed_work_sync(&conn->timeout_work);
 
+	kfree_skb(conn->rx_skb);
+
 	kfree(conn);
 }
 
-- 
2.51.0


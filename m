Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C5317712
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564699; cv=pass; b=oMjjzW7Cgp/DtP01u4Ncc2YbB/LANrfnSUoC0PtehuVka4WVnmqMMle4EaQesNmR+U6dSToDYqJArCJbfsLqI7YASSkMpOAT4ZYJS4h/zec2hDSb536U+n9w0rE8zK/Db4c2sDI4b4EiYZFsBLEYCA2N07fG6C0X2B98JVDTRG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564699; c=relaxed/simple;
	bh=Ez1oPeNZwLs2nokT9Oz1Pryz7GpoL2ZAw9SiN2cW8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aViXQoy6SUdfJbPk7ZMuIn1NSrU5Cvpk3wKlW+VxMV+Ag/giNThpt7hAQwtltLyjbR830/8qvQkERvHSgNLOEmsdwxidhC/F+re3XMVd4LWNpRDujoaJQZZXBXxcdmsRuwq79I4VCI6wOwxo42j8EVomJms8XeNKMCbyr+a0xjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=QOb2TeF9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="QOb2TeF9"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVrll2QTyz49QMh;
	Mon, 22 Sep 2025 21:11:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758564691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1/oO1dAiOR7l6TBKj1ymR7yCcH8SkT44VeHHiW//Lg=;
	b=QOb2TeF9QSkzj4xSL02L8pXW9ccxKhUk4G6MW7rEYR+8PuiiaLS5Oj5ZI50V8EUQQvYhhz
	ybd2v624OOuZWc9YkHc5eMf0WSsMDXOJClLsrjr/yseqkorT3jJIV0dNseQbYjwYIGIWQo
	2IkROnBGdmoUL9jeGW1IWsbD60r6ZU3gsFpMHR9qiC7d1/7gkwv8PBktmeBnjqa99mpuvO
	dAX45XlR2qHnrovvEclk8l5Wbo8SQzdKZ44vOTscdimDdc4Q1dB/LTj+9ICYzn3d65BHGr
	rA0znDRqX7ZCS48YGH0Eoate1WK5uZ6Zg7q6dvWTRS53EgrXERCvQVxwmp7kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758564691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1/oO1dAiOR7l6TBKj1ymR7yCcH8SkT44VeHHiW//Lg=;
	b=CMXa1uoZXa443BiAck0ERS38dieVlGStAIuwLI7n+bCMiKLe8FNtIpcI4c8OWNXnXUsdcJ
	bZGEUzPf+sknrKrAJ1yTE9y65arXYDMwjDFClRESVc5s0dqxmM3Mwt6V/LyRY7NDdUH6cb
	b/MRXtujJla/F72diAroSN9Ftm9pthP/RJvisq/yVqeqo1h+/3IsWMtcHuKRgiiAIq0mmg
	etPx5tcm7wjesbCGdD2f1Ae2jaHOsCoaJf/nBqgceTi/GP6FxKPrJc/BI3buIWTZYweOOE
	oI+gsBzlqCewBVcaD2xkg4WY0oxbvCdBFKFvJ/33/JWLHvVm3IX+e5PqeXNNXQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758564691; a=rsa-sha256;
	cv=none;
	b=MjLs26/Io5sGDPeDRIJN9P++RyaPBU3DbgjxvHrik8FTP4NOB7HONsq2UYN7FPQ3CBxOcf
	ItGIhOjKpQbhdZ5oL+GBAFpMOm2mK6lF27cEzbS+w+GnE0vWdrDsqRjcUV1FjVdJ5WREO0
	YknwXAJW7jfdiGZIWX8hGpeuIX3EUwba77ePKo5bKd3CjHtprQBvegEQqzmyY3eDYlQjWU
	wZMq7tv/Pa+sS24Yc1SjqYuPmugDYn8rUpsb3AjQzI3P25x4hW2HJjc/6oJo7dUu4/PNCG
	yY8w8//CXUbvx/XqALB7JioRvnSlrZzQMcDhMPpdphi7ziPZqN5wi2hS6AA/ew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/2] Bluetooth: ISO: don't leak skb in ISO_CONT RX
Date: Mon, 22 Sep 2025 21:11:22 +0300
Message-ID: <c898fec290b68d341f4b47232c69f2125f9c3f8d.1758564480.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758564480.git.pav@iki.fi>
References: <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758564480.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ISO_CONT RX, the data from skb is copied to conn->rx_skb, but the
skb is leaked.

Free skb after copying its data.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d63d4d6f874c..f5a9a13317df 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2420,7 +2420,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-		return;
+		break;
 
 	case ISO_END:
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
-- 
2.51.0


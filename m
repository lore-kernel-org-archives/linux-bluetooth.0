Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F4268C42
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482188; cv=pass; b=ejsfLXu2yvqgarMUdzOVF260RLmeuUZZRRMBIAD43ozNa+fU6/qBfNtdcgyniAdLzYb2UrkrxmtMs5gnvSqofi8RUyzNoMUauhzmH45gdEJHT363rPYiqs1B14GFghtm5r3NEcvWwx1dice813a4mcid3PBIMqhQcVIVQ86BvJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482188; c=relaxed/simple;
	bh=XBUNbQiu4SqDOiplkYb+brbsUBuvusq1/pHRwatB22E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psAWNup9j+Q5xNXtrp7vyyXA59KzNMx8wPtL+rBkuGtmHPPpBroysiaSO7ARYApyqy18yOG4gKkeRrxO4h7JXxBQwHYd/KywnD0Jpy2BXJrPwkBLNy43TgYDfPyvjEl9oGHfihbH/QzmTAnIKTCPfsx+JuynbnankIqTFf6td3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=O7s8ytXl; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="O7s8ytXl"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGDw1svgz49QJY;
	Sun, 21 Sep 2025 22:16:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8BLFayz8jAhyZ4yguOrjhRk9uQgtfduglr/R8JTMeU=;
	b=O7s8ytXlu3FwYeWzRsuW8x8zhO4LLxMcdq0zahxYV+BQ1CKa8VrA266EOwYySLKF+EtTxs
	LRv0qf3gbF9Ja6XLyBlXk34ZSNA4KPf1JKeLW7d/HXpzboYTKQzA7YluNbD5saonUOeX9T
	HqgO/nNPiX6PTAhyq+etJV17mOKniI0j/qtlXD4IqY1w8fVVindQsuS4rZ/fZNurUdNF2V
	RBgp/1+Tp/zEmAMzYoVwxs+UP/Btr5V5Huq4FVqNrafb6ZzOHw7wGiF2ffS6VlNdeW4jPG
	8bBRy7EGRbzMSKPkljqclXLj5fMq9m05UwPjMeMfZxuKY612Vc5z2wENuuyVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8BLFayz8jAhyZ4yguOrjhRk9uQgtfduglr/R8JTMeU=;
	b=LPHgyhQjhPdQb5epXI4dWKhRL6MxEdTaYFNI0YXf45IAIqYhTAYAqZv6ihVR3UnMlhfKse
	pff1ZmTxIXKjVduxo+78TRW7/6GMs19ZY/nrjpx1tmfMcmmJrEX9ojTmQO/OM6LtI49b2M
	yK/PkAL+L041G8UD0itv2PaRyKpyinvf1kYGuSpeGY0KWCeCu18SbUr0hH/GI6pxKPOpqT
	KGnNjRvT8OxeH9e0GgeSK7syrSwkFOzo+4Dp65SFBLJkcdc3Jkt1hnSQuFsyqZT442Im+B
	3x/lmI5Sg3a3zYKnpe3BH0SqiU9J+Te9JWe3GMBouebNqyL9iRRk7JD/49XDyA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482176; a=rsa-sha256;
	cv=none;
	b=KSEle5oHr4e2KHR3hi4f2u9vbvSuo9mHZUquNP8v0urlY78O624aErwgcKlUV1+9VuIg6z
	8arppIavVSzYUN2+kmeNid9WBReDK1lWKyCv09u+1HpkImh6YkLXHyPn0pqrkz38LktazZ
	l9JbNwX+Pl5rEOjK4KLMbfmloMhgCZO2UkeT66vth5gNEvixDIdEjzzfB35iK9bj6F4Hhb
	EteICvJjieuWKcnl8DyPcTFi5BbxFa8RETSvR8XvJK9TzXAAca7aaYK5rIKUEXy9p7XuNB
	R+pqIFQEqjTGY8M3kPRCaIZ4YKpy1bBzgBP+TsAyjiCeLt9xvt2M2xDl24A9cA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 16/24] Bluetooth: L2CAP: fix hci_conn_valid() usage
Date: Sun, 21 Sep 2025 22:16:00 +0300
Message-ID: <c35d10c737c3828fc0180d503665ea378818a1cd.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold RCU lock while queuing to ensure conn remains valid.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9370b7bd226a..9086c86adb2c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -949,10 +949,14 @@ static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
 			   u8 flags)
 {
 	/* Check if the hcon still valid before attempting to send */
+	rcu_read_lock();
+
 	if (hci_conn_valid(conn->hcon->hdev, conn->hcon))
 		hci_send_acl(conn->hchan, skb, flags);
 	else
 		kfree_skb(skb);
+
+	rcu_read_unlock();
 }
 
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
-- 
2.51.0


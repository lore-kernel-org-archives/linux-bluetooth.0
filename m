Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A61534F2
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168817; cv=pass; b=PySpO1XajbKhhzCnZyZ3Z0EP8A0K6QuyjbPbrlMX9/Lcym7wLkVD7HQHoXwDHgHfWXvwPQQTv2eGgep1jpIImVl2thM/n3Y1Lwr7lo+AAhXx6NtVOEB6XQT7PJ2BxXYUuwXReXUte5v72jBUT5l5FUM4IcUA6VSY8LDo14wfqGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168817; c=relaxed/simple;
	bh=pSoZnBzvRKVGEkj4oImim8hxTBAByeIooYeepWwvo5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/2/1sqh0dSXk2VZoGZHSLiu3miuAFz6uceE8NwTlx43MOpgYNdHukf1ib8wDB9YGXCsYtuPyFFBeQ4tnajy2gw8vXd4tcOh/D7JHXWyWJUSpn+yRRjwN9qPBMaSHbd43B+NW85FAFZdc+UrhqORa1EIYvyhsllTulxy7j6vG+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LgKxTRFW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LgKxTRFW"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWD1ZLsz49Q5s;
	Wed,  3 Apr 2024 21:26:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c988UEDGeh4GGPIv9hvKc2c5Fyqnpd4JgkJjtCU1PmA=;
	b=LgKxTRFW+5Zbeo04SvcjIfn26sGlC+Jl/xAAD8feK8CXcASfGdSiE+eSnoIeBaJPBZViiA
	q0jr4UsG1pxhJ+Yn4FCFls1t5SoPnVEoGVXKuVpEPUROTYN5lFYrQ0HehvKcvPKa1pYLmL
	c0F1i8VKzW5wHkfIsOM34TOgQ0Y4cYdYNOT2RYpn0wc75ZaEa0yX2ECddNdjYepMjqCD/G
	EyU7dh4bzUjuecmUH+ebCN5QX5cLE1iYv1iVvPs6Uyii2zV/dPEsUVV58AqRQyc9g9FYuG
	3WuvNV4RxDgdbIuA9XmUDpSi+H7U67XdZi4uqDh6AVtMBtU0HzubD6kkPe9G6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c988UEDGeh4GGPIv9hvKc2c5Fyqnpd4JgkJjtCU1PmA=;
	b=wA6r+1htDO6DrrGG9RmS1UaFCm2NWmWjp0oRCbd942PdHw0B0+C7TZXoEn/igsFIW0Rg2u
	4VYfIHdKyAP0JI5ZfVTvZR2cg8m/vy0KqcoDCXORPsFl6x7FVasJ6qhE8djVgNnBuLjIxc
	n7J83VWt8/GlaAxCb7tvJCP2tzjZAeAer+w6RVzZlFunec+Co8v5+exxwC1FlF+nsFrqJ3
	HesjUxEwYvGbYS5sdYDBKFosfcY7tjSLEgM9sYPgAyC3ju/V4fYVw5NXLwFF8V+52YcTk2
	p6f2sc4rnqEpCJtezHepsQNV7qE8vCw1eL4YCO7pBDeC6wL/ZJrS/s56/N/zRg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168808; a=rsa-sha256;
	cv=none;
	b=JZgIoNKzHjMb9tjJo+FNMuHdbDN0xWtbXXPbaoJqDdutPgzhyBeiZ9mv/XKpCQVBKsed75
	zwf10XRRGDUv4NaVkrscsiZAGn027B3ZS4umWRaNl9XV2ZIg5FmEaaZKdVsTVWKNSC9H4R
	c0DuZSCH6hilaGF2j1OSbmNNyqfiH2AqKEabTux8QAA2tpXx8qgTAHzIEFeIGPymgo0Nma
	jiDXAotA+TBn7x0Xt/QBivfPywTkdeZH1HvFmmfDKvxPWoHRh20S2PgQuFclObxcRO5JJk
	t5o8sJcp2jsSkOTwuvrOa2lYd5EUwoezeqI2gHl1pQ423+IQzRkzxCegqGjYew==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 4/7] btdev: set nonzero SCO mtu & max pkt
Date: Wed,  3 Apr 2024 21:26:34 +0300
Message-ID: <ff8f61b7a6009e87ce0b973f8752faebcda9c6fe.1712168788.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168788.git.pav@iki.fi>
References: <cover.1712168788.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set nonzero max pkt count, so that kernel can transmit data.
The request & accept/reject flow is not emulated yet.
---
 emulator/btdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d64827fc7..5752a2fb0 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -148,6 +148,8 @@ struct btdev {
 	uint8_t  feat_page_2[8];
 	uint16_t acl_mtu;
 	uint16_t acl_max_pkt;
+	uint16_t sco_mtu;
+	uint16_t sco_max_pkt;
 	uint16_t iso_mtu;
 	uint16_t iso_max_pkt;
 	uint8_t  country_code;
@@ -653,9 +655,9 @@ static int cmd_read_buffer_size(struct btdev *dev, const void *data,
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.acl_mtu = cpu_to_le16(dev->acl_mtu);
-	rsp.sco_mtu = 0;
+	rsp.sco_mtu = cpu_to_le16(dev->sco_mtu);
 	rsp.acl_max_pkt = cpu_to_le16(dev->acl_max_pkt);
-	rsp.sco_max_pkt = cpu_to_le16(0);
+	rsp.sco_max_pkt = cpu_to_le16(dev->sco_max_pkt);
 
 	cmd_complete(dev, BT_HCI_CMD_READ_BUFFER_SIZE, &rsp, sizeof(rsp));
 
@@ -2764,6 +2766,8 @@ static int cmd_enhanced_setup_sync_conn_complete(struct btdev *dev,
 		goto done;
 	}
 
+	/* TODO: HCI_Connection_Request connection flow */
+
 	cc.status = BT_HCI_ERR_SUCCESS;
 	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
 
@@ -7173,6 +7177,9 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->acl_mtu = 192;
 	btdev->acl_max_pkt = 1;
 
+	btdev->sco_mtu = 72;
+	btdev->sco_max_pkt = 1;
+
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
 	btdev->big_handle = 0xff;
-- 
2.44.0


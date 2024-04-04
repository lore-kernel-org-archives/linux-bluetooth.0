Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586312BEAB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247696; cv=pass; b=F7dM2+hjGtv8yH+vSk4lCTrx259zmW8ttvGbWfLJjua9hRDG5SJT8MIedLBTP4MHkLrfFtS5ZYCjXLkIeqJ8wKI3KatNFUx5JCbh6ZHTrQi9ji7KRRhXwJ7zqyUTKn2oDdiVxnzZx6bPgEKIsTsxOs93Z8T0eqzYOTRCjZedUZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247696; c=relaxed/simple;
	bh=pSoZnBzvRKVGEkj4oImim8hxTBAByeIooYeepWwvo5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjPmW0ZTDJs4Eizq4nX+mj9EJ2hSjvs071sxSBhnStU9ZE+mhveTE9GfO25ZVeBYhY52VbBvkqMUakoEgLvI6rS89XMjILcg+2RHpy6aqh6q/OUZ/CmiQRYe29PgjCNxk5l1YvrIrKOfP9EQNZYJISHciE21B/So21FNmFvpwY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nyoelnt1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nyoelnt1"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V9RhD5JfVz49Q6L;
	Thu,  4 Apr 2024 19:21:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712247693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c988UEDGeh4GGPIv9hvKc2c5Fyqnpd4JgkJjtCU1PmA=;
	b=nyoelnt1Lc5+OxDrqbWHCdwtTRcgvwfyRnxC2G1jUcnR7Sr0RLncIHxgcSsYR6CrT5FYUU
	sPIO6GqqvI8h9RWV0yQzdLYzaqFW30pNeGDqpteRqUbydT0L9am8gl2vtZnAxLwOlWOzhe
	g7fvhiJ6x7UhQPqKe+4C2pB0hKg2avNq1YXZPdcxT6luu/+tBjBYSNwxsjK0QFJ7jnDw5g
	jeCWHbbsAJmX6L+d6PXN5iuUyoHezYPiDZfFkAu0uvs23cUQa9ZsNtpDiI/RsppHhw34Hz
	irLOmfoxgNmQyOV7WAVcGv+aNFhdLCt62lj7m1gASZ97UHxJAx55qaaUYKmC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712247693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c988UEDGeh4GGPIv9hvKc2c5Fyqnpd4JgkJjtCU1PmA=;
	b=Zu3NuolRvRWiX1xT9u5yQRhWAR6p4JgT/Zcwk7vronTXZwXGhudeFm7SOZZH25qzY5rEBU
	SQjjuQCDKQx9fb45AqWsfxHwhV3J+RaS37SOLCbMT0AREPOvIPTZ2Wm1aBxmXoD90JlWlN
	uh6kSQK6RctByXBzb6q90Zklvh/SIDEvWm7gTD3dJBT1s8VG7XJY2Iz+lK+zVtyTlKZH8Z
	SjZM4ynraw6nKs8twgfhsn/JR48svGr6GuGfwnDuZMYdKlENxYoHkxiCL7DS2ffLKtO+k8
	bziNKqp0MWrFqHF/sq/ZWdPtwAFc9ulrTtubTBH6y7FtvyW+He0nHDybYKdT7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712247693; a=rsa-sha256;
	cv=none;
	b=NbO44M6Pthk6v+Iyj2g2KkkkTUiieFW0Vis8lFEPlNDnKPoDejqkbl0FS5zt5r/vy4BfC2
	Xd+wsYOsYnYFOqJc8Vuzsa3B036YsrstQdUzmeSuTYvCGl31mUIpusJMhPBNN4SvKRGxQi
	eDCs6soGaELC19Y9Ohmmd12hTSZSMAGMOf9ZA8njHrhG5bv+Ltz8WCoiuDTa11PQf4l+ee
	0DTHXW3zpdX99NAYVyu6pJgxG83EWfEew71MUiQRxcD6UfMC2rZake6pj6CiHxgI4ZxvrF
	0NxdPGpr+kj1SykcX8TOTQNO/Vo3FpKhzd6L1ZLTlA6prYX94EpihW4QKDV+Jw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 4/7] btdev: set nonzero SCO mtu & max pkt
Date: Thu,  4 Apr 2024 19:21:20 +0300
Message-ID: <ff8f61b7a6009e87ce0b973f8752faebcda9c6fe.1712243675.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712243675.git.pav@iki.fi>
References: <cover.1712243675.git.pav@iki.fi>
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


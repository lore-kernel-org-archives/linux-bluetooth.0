Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CA1B7F4
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162766; cv=pass; b=jf0f5NJL5L1o3EhzyKo148Y0EQo0nv2scV6KPrBec0Xf4Y4itFoYtfbD7PsGfjS0Iu+1SuyDgU0W173ka3OvWQTtz1MQ7NjH/Zpb+wvmWeZWHBh1EzZDJRZlMt7YZQtXxcPFBUfW5eWNXXzErMGG1z51jIPaxdwA1H4lfDsgGSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162766; c=relaxed/simple;
	bh=TY2fqdnHm/1qXm5oAZeAZQByaO0VJhMajIR2AvaXsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTFveZYkk3uqBlp/pk4w/4fx1LWM7FF9ofIHzzdOgpJhQfLLwaE82sbnuJsRgIpecBnTzTGFv58ATmOG1KsvA+KSxyZf11YE1Q6l0Bw0srC07XqXtyvKGcdEvNLLFc59EG2XO339CsUU45tiwVYW47r2/8KFh/ilA0o/a8pPnC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YK5mZeAF; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YK5mZeAF"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8rGy2vDxz49Q5c;
	Wed,  3 Apr 2024 19:46:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712162762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=YK5mZeAFXdbTFf3ZH7oKYXUqwAjImQQoLX65JXUbMsQ2kpsBbKW4Q4FxgF1PSr1YSPXFnh
	yCtSihbv31LsU0SV0czyC1PpNxwuGMRlOuN/GIBtTV7EfMlIsZnysEfRPbOdR6+HykBrcE
	dEhKK6mxdu2kFKjV1Av4loqVhUmta2THwTUJK0ByYNVodlj6YnDdyutLzmoLXQeuKYFWe4
	5aRpC3Yc+x+ZwXbAKo1v2LmIDEK3RBA8ODtPgaSxAzXWbUkT2wqdZdzvw1PutFqqIIU4Rd
	jjOos1JTRJKGa0UOC9VUjp0Pn00gcabCx0Jvvuxr+ILBRVZJLsxTKxbUOAHHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712162762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=gbCtSUTT1pfC+1KappVuMqghQsw6TXqI+EcR2Ye0czGcFeafz0tsniTdNm7vb38gCY0NiL
	PYSn/aBqyksY11PTQ502Z8ohhqIyomtvJVCq+/D5O2A3ER23+nz6aRImc1JmHgaFdSdtb8
	M70hMh1rXMG8PpPOFllJYHM5SYbuGVUg/N1WLSYmHyohs2Ugk8onlYGzVjWeAlnXhiF+Z5
	7WeAELweFPEzA/RgP/P3A6vZkcLpGvK365N1Us/IsiLCmxlWNH6JZl8M1z1WvO9TvhztPY
	ti1zJYD3Ro7EemuhoKgBrO0hn/9FG/RknLmwHYxgbWVqQcNsooSmcNkkOz+dCw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712162762; a=rsa-sha256;
	cv=none;
	b=OHU9zhDkAMdrTaOY8XtwuNuv47v8T0WTfRUn3xOPuDI3TVI2FpxUJ5dD1yrcgkfJjLmzKI
	+2zxgyEAa85xsbUwjP8uxmaAzmFpDYCmVWi610aWDAzvhLMBtl7OAVR0XngwQqnBXB8zeG
	Svqe312LnlFFDCC9si28RGRpCStWhueN1sTLLJm3VwuzcWCVWzrCJLnsJOO3hai2x41XS7
	qyS3b/WYuFoEECrcDAxwKmeXI7ThrJl6TY6Bo6Eo46sOcEQJyooSrheTXKv4hktI8fXHeM
	nq9rhSsLUHe01xLKmpwZX8XkXW+Da7sV2Wgw/5Kurx2ydaA1sBP/7ryWRNLsow==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 4/7] btdev: set nonzero SCO mtu & max pkt
Date: Wed,  3 Apr 2024 19:43:23 +0300
Message-ID: <6ade1b15ba0eb97a8cf8a06ce8830ed031e8e271.1712161649.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712161649.git.pav@iki.fi>
References: <cover.1712161649.git.pav@iki.fi>
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
index 0ad6b2793..a63136fad 100644
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


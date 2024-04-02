Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBA2AD1E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076197; cv=pass; b=iHnTHjQkBQ05t4MjRCp6GZHvHAr5thZikt0ZAmVeLeOft7/hYBxfHOIdMwk5aslw/Bzlqa80lvHP0MQixMf7RYFoPwilBwlGpJEiniJ84ZIv4SvXFNAHRFZq1CD7qf35RqDLiweGFGqAokFG9h/1IwGoehleO/u1k0BIFLeqBkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076197; c=relaxed/simple;
	bh=TY2fqdnHm/1qXm5oAZeAZQByaO0VJhMajIR2AvaXsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUYf0XZ+bNkIMRkp0nU+iTzNAV2GNVrNE3F91pN3rEfa/NIAcg1D8BHzAwhRJnvjcAIVor91Pp3pPz3x9/tUk7LRUVSxFr1+x0vrYSeif0aFU/MH56WxO+VC6BmA/Wwv8zizRH8NfVqJBGmNLlqTrcLzw5O25g1NutcAn6XUQ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nkUftqxr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nkUftqxr"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DG94WHsz106F;
	Tue,  2 Apr 2024 19:43:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=nkUftqxrrmKlKf+U0VSQRUrSQyZsiUmNAgYToMzXr3OEEMgdnRbLVA9S8wdG1lAJZ1V+8A
	A4yXmMFoMkmL4H5dae0YMfjRl3gBlW2+bJ+Bw+TXQnfH5R2DQHYs5SOqAO9fNJ0uycb3Ex
	DbZqnebcerwKOQ7iDKZs7yMTNRKsYfY=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076194; a=rsa-sha256; cv=none;
	b=A+3xwxGG1O9dDgt77O5EyRRvEi93g+DchPEmmVhmYnZ9TZT6zf4ZVwpFGA5mluvk1XS0Dd
	cu1GVv3Sx+Rq93hVWRx/FgFzHmPXkJlJxMGayMboIe5RJO5WYOhDuc4JK1p9QY8OXqJmUm
	1cM8qwr7neoUl3yo/Oq7LWPJ7qCJGF8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=pocCNu/BgOvLhwWa+HWCwyvjhtaRGuNuq3tAmZwJHmFLs08ZR7gbtP2h2PAWy5k3icewTF
	/xL2CMPpON0rgqmVjqHMcompzPeWnqxhiLd8trPIkfsSxnRu/fWOMmCgBzf6SuazHCN+xz
	m+qtSzpdzbcuTSp6ZuvMh8Kp7RG+2VE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 4/8] btdev: set nonzero SCO mtu & max pkt
Date: Tue,  2 Apr 2024 19:43:01 +0300
Message-ID: <8d177d78fb0aa7edcc2be9a849953f68c078591f.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712076170.git.pav@iki.fi>
References: <cover.1712076170.git.pav@iki.fi>
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


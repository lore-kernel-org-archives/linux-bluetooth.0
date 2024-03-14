Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3374C0F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440499; cv=pass; b=EpW+UKfr8OfCO0Ccr45BqRtryE9oskB8nZQGfoC/RJFCCrEDCY0/Tbzr4pF4RLkRquuYwG2Kq341g9sseEZarIf7Rtv1a8G5OOI80w4gD6AA7V5lTKlqoyI2qZW1O4/Ubud8H9KoFWywyuvt4Nc/fCAfDVIGO9he6qKn4AXB5i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440499; c=relaxed/simple;
	bh=TY2fqdnHm/1qXm5oAZeAZQByaO0VJhMajIR2AvaXsms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONf/ZHUDCRVbAw/enk0rZazhywnyMaWGL4uVpzH4yrKnsSaT3Kof91N0HUdrOmNRFldrhYzUMaxvFzJhkGQ+LygRIlgRIWaenngBlZbyP4Y3xVrjVyMvJBe2vC75/tgaTRXzMFPCd/9nJoc1O2ULbXFYQACsCUT1r4UdrW3ygkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VsKKpcBx; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VsKKpcBx"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLL0RTGz49PxK;
	Thu, 14 Mar 2024 20:21:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=VsKKpcBxj9rh4p1q4nYUe5M9ET+U5+R+GAYoaD4XCuDy1bEazU0VP0ZUzgnDtRkNsm3rF9
	XzmF5EobCmkBTLcL8k/SW2bMBu9a1hUSjvX+4DG7QkgztU2WGIwzxguO1+k0Acga4XyzG5
	2iBIcu2ynL1oJYwuFqOy6djVT3fIJVmfgU8Nz4LyOxa5AXajBEAvoxGrEoMRNXKcMtcgbx
	oJGnVoq4OtZXTerhaxjTfqnWj6BPAaz58FimHtQ6JYcVBiugqdk9YEKTxp0Kqh7xyOn8wr
	CSh3x60YvHLjXODZzMe0ZQkYbic7n2q832zZ6epULKaJrFSYiobux8uuOzHEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMCfKk9RH++FCunQyWDEpkYQewc5l2UzI2FcSnTVpG4=;
	b=Kw/e4tEeCOAwj1TscA4gM4mMeEFwux9UzlYJQ736MjZp/LSL9szGfEeUJZmHI1NHD+OhZ5
	klIrRVhuOQKVvMbHbZ/TpIx3lsP66vbPpJjND68HxbN0RhaV2VaDJW2J5aY8qY7Ep17w/e
	FDWgb22MtA1NA9nwNnMOjSVaC8oa1N/fFENK6gKm4dXvhbCcUHl7po+6YuZrLOFDgA/EYI
	NKF6QitlUYr8iEyEchpzNKv9oeNalijwSF2QVvVbaRYLoORNwYqfREDGgJzgssuz4s3uIe
	3DPUm88kTHgnAnKe75GtfKm0d/0bZ/MxzydAQuRPKaiMYoMV5Vs2BpMBsMofOQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440490; a=rsa-sha256;
	cv=none;
	b=eAHLrjMLrD/ef4V2MTXEQB8+X+fFABXK4lVig3l0edRKuZKF3i9twJ61h+fOu69/TAwjOh
	LwUC6iuCEEVZ7XIr0+H84Xr5glQ0yDmVo5KJh42dyuWONFjz/MVotgncaC5qYmUZblyTxL
	z4ThIjQ0ry7h+XGtXQ0g1oxHmo+xh4kxkbSzuxEtUJ89bhAyO8yptieNN7XsN+4oqmeLMs
	yyBXItBK/mNXdWeYv3u219MiyC/4Ax3ocghGPRkgk/u/C6umyvPJR00BSB3EEmLh0Tz9ol
	LFL25aqCs4KBY2ZVeSfURZgaGwdnBECJOqfASNqlFG17P9p9P1jRxAh+bizKCA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/9] btdev: set nonzero SCO mtu & max pkt
Date: Thu, 14 Mar 2024 20:21:13 +0200
Message-ID: <ff805dc6468162d0e319cc600dac349e20d34dc4.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
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


Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC342459C9
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750699; cv=pass; b=bYZ+fvhc2eW1lLja6GC54tDaCROxz69sxgnjzTivnfk/bpWuXPizNP8lYE3Ix6ukCuGUafrM/Pi6tKe8rF6/kEuB2WzTp5R3x/OcNeGC7VD6GepmGrB7oGRTpHZVf81YTpjS/TZFGTpT/kKCmgmgE5cYzkjhqV6HHG9WUdwd4vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750699; c=relaxed/simple;
	bh=dJ9BGXtlV0YqiN+XrFlGdYUL5iQQPsASWTX+kDuf4Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBSXJAFlpqG4Mbgv74uSGH59yUrD7rFD46j3w8wbPywzbfq1P5x+9msL19jYqdg+vcpR2QiFfqJiV9qjUmPWh8nJs+DVzESVVUGBpFYMsb9XuwBGqCDN2EilfOra1A/eTT9vo5sYCMyusTtmgTVIkigp69Aj4A5wo0CFrBnDv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ivqpq2Uh; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ivqpq2Uh"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zljrk0zM3z49QJv;
	Sun, 27 Apr 2025 13:44:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745750694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpPlndArWFqZeEqXmU0v8Ut53EzDd+QekLndD77nOb4=;
	b=ivqpq2UhS5UBUFLxviNa4JXjYduJ1lRSCDBgFxtI/IgmCasnO0PT2+0MNCamXRhFX32Idg
	uLFG9v1V1CqpzmetOmIIdkwCDI+4Xzz8MDAii10s6tKmcQx7Bw2kCs2ieX/qulLToc6BPJ
	8TlnlkdVNhay4/BWhZnIoEZz3WGgrqENnwXybMgM0Dgax7uXSNln+m3G4Bn2GTzS2ilra8
	colscFp16DK/mb2uAHrqg/137mDw+7W02DNwS8C8iiZp4D4I91Q2+rUITc1rjVMe6cXIHb
	hW847XEVOX6RTE9JDSAVyOycKpj2Zwx4Dm5roo4geFxuJ6YkhrV8rmxmJWeA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745750694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpPlndArWFqZeEqXmU0v8Ut53EzDd+QekLndD77nOb4=;
	b=k0xu01Q4lpDSm9cB3Zb2PV6ftuOR2Ska9fWPQegHSeBtP3ygne5Z4d20ELLHLDWNUhesYZ
	5z40qZsZjuhRHrBGtwpLEmjMwdIr3bgKi5iLzsfQ9bBxBGXPVjKxE0xJ1Y5tdIM4mI6L+I
	jb99X8Dfybfdi9/8WMnJ+7C17GB4BKAVjE24CkqcAVvdQBjTqlngMYV2EZ4MDiTOUgth9b
	p36e36UqYtsFTa845anUxi1BGQywXhWR0cJl55DMpZ3XIhRrr7KuazUJjvzFk9ECGBZpZV
	YRTnRPuXmq0uDtDPeCYZMiFGC1gbqoM48ALBr7kTCTpcS+ACp/2nh7rMqQqdzw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745750694; a=rsa-sha256;
	cv=none;
	b=SpGTjklKpwjauI4o0Ci6+a9Mdv0MenekyUvP9ZOqv9aLRkd4NREjjnZpudoMwxbiPA5nj8
	7QRUT9eoextMCR8axeKgNxvF56bpjR+QukMQUUVYAleL4e9dJ3LHBA7Jr+fokqxUpOHDlD
	FlRdEEADYliZSH6msmknGdmi3UA34X49cIbQhGThoxVxT+kcMyPgJigBplGy9kwCa7uYf1
	AmsZrfUoDXr9pLFARv2jlEdfG3eGxmwiyHy0ckzolWAQbqqTvNqQMzKkTwmWDrEdkueR9I
	LwUR//zF1V0RqV+8aKfy5P9v7lL+39/DBGywjJt3lEUfuRCzsxnr7hs6CU8qVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] bthost: support sending SCO packets
Date: Sun, 27 Apr 2025 13:44:38 +0300
Message-ID: <1a6c413e2d6d7d0e0f96b2e5d32079b1dad6fdf5.1745750626.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
References: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function to send SCO packets via bthost.
---
 emulator/bthost.c | 32 ++++++++++++++++++++++++++++++++
 emulator/bthost.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1ae33ba6b..214583cc5 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -40,6 +40,7 @@
 #define acl_flags(h)		(h >> 12)
 
 #define sco_flags_status(f)	(f & 0x03)
+#define sco_flags_pack(status)	(status & 0x03)
 
 #define iso_flags_pb(f)		(f & 0x0003)
 #define iso_flags_ts(f)		((f >> 2) & 0x0001)
@@ -878,6 +879,37 @@ void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	send_iov(bthost, handle, cid, iov, iovcnt);
 }
 
+void bthost_send_sco(struct bthost *bthost, uint16_t handle, uint8_t pkt_status,
+					const struct iovec *iov, int iovcnt)
+{
+	uint8_t pkt = BT_H4_SCO_PKT;
+	struct iovec pdu[2 + iovcnt];
+	struct bt_hci_sco_hdr sco_hdr;
+	struct btconn *conn;
+	int i, len = 0;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	for (i = 0; i < iovcnt; i++) {
+		pdu[2 + i].iov_base = iov[i].iov_base;
+		pdu[2 + i].iov_len = iov[i].iov_len;
+		len += iov[i].iov_len;
+	}
+
+	pdu[0].iov_base = &pkt;
+	pdu[0].iov_len = sizeof(pkt);
+
+	sco_hdr.handle = acl_handle_pack(handle, sco_flags_pack(pkt_status));
+	sco_hdr.dlen = len;
+
+	pdu[1].iov_base = &sco_hdr;
+	pdu[1].iov_len = sizeof(sco_hdr);
+
+	send_packet(bthost, pdu, 2 + iovcnt);
+}
+
 static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
 			const struct iovec *iov, int iovcnt)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 583a8b6df..db640daff 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -92,6 +92,8 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len);
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const struct iovec *iov, int iovcnt);
+void bthost_send_sco(struct bthost *bthost, uint16_t handle, uint8_t pkt_status,
+			const struct iovec *iov, int iovcnt);
 void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
 			const struct iovec *iov, int iovcnt);
-- 
2.49.0


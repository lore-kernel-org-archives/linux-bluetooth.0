Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474D2376E0
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750702; cv=pass; b=idngPWnGYKpu79CHlp5nFJ4tDKkTw6C40umhdrpAnpxFfEWP9zFo5ykHo0YJESNsEEjG0IJxVmI6S6tCUbTZ+XslwsxaFwBrHCtdQtzxf22dnurevbOlPVbMTBxugZIvvPYYQt+mNOYg5Lb3IPRdhapKa7tcvKfW757S6a69sWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750702; c=relaxed/simple;
	bh=oaMCX+83pfPECWEVDWwsqzVJrVPaqFLEa9zF3myEC0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K16MxqL65FPlNSaLvFSV4rAPjemSndRVBcwwma2KGQWwTM1E8nK8QjHqSj1JbCsGPMvjUGXW3gmflrvLtgPoVDWBs+742+adem6suImpfgVb2cf+SIxnVWjs4P2TjHTd60OCQvjMyFogaHtmvJ4pfbbTXIoKkM+J34hwn5tvDX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZRqWIkpj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZRqWIkpj"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zljrc17Xkz49QK4;
	Sun, 27 Apr 2025 13:44:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745750688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka87tBIY6uJ82bwf3XcmSTA1HqD87KSKUrdKoZawFi0=;
	b=ZRqWIkpj8HEd9zhCxvb8XzwJVr5Z+jcAncmnb8kRphmOL7mPhiexxnz7upp3ZFmdBXhVkW
	60g1VGUv1Y0u8djDlcpBPt0IYYfqHe/9sWJRl9xud/8zBzqoTUF8BivfxMukYOxyeVR/HZ
	rYwlyiHZWa3XuIO1ztJWmlQsSXjlyEGOdX1c1gDGrGX+Ct5RjIpaNa4vN2/t4tYc5wHPyw
	kKlyM0BCFtqTLXYudBpUGNbZdqqd5mymBGi+tp9fs06Lop6+zlFF1B1sHDK5iJ5/r8VWvw
	OWXaK327fJ1Hg1Rd9TepaZiSOupGc1ZFmk7jbWhF/WUf6bXV/bFDvvBe4HYfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745750688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka87tBIY6uJ82bwf3XcmSTA1HqD87KSKUrdKoZawFi0=;
	b=nj5dqFJJS/xb20C+uj/i3gHE37WVXQkdT0kapFWuS9T9iq3Fse+K50ZKIi0sEExdBxJzFO
	WBEV8rDJpLNKHLrHJEQzM/TUCNAnocTzd5XBtQCo8os4NzkKqFIrdqW/auE7ljfM4A7RbS
	r41zyTy0Ymc2B3ZHqJIBArQbkwpkiIdcCvS19stUKvvKaLDkfu/3d+n47IRdsR//s8Vbr5
	iUMJEDuaUCB/jJPt9c+Vx75q5CfTYDKXvdVBWSZ+UQ8XBhikCVP0MEw7H9ECFtzLI6PaB2
	ozWY8M82LsZmXeXYFORij7KGDX+64FNeYsJ4Ya6Q9SO2YQw2Jq9GyiiuZPVflg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745750688; a=rsa-sha256;
	cv=none;
	b=BtuVuZY7hD3SGBffVh2ETbRMsAO8eB2iifiP5l/N/pk95MNlQML9cbINOlijRHH5XKsuk8
	One6GBT19cTrhOeTiwOIUwVQAqhltrH5S7UBFPPASIRsx/fItLl1ifbn3n9YQwN+IaYxGf
	mqvaghH6zKfnz9GBELIxy2d/IuNFWbOK+bbXMk4Tl48Tw0odmKtdaK+/zPgz/izXZFec5a
	2fXzSkof7q0SjhcCtmVulnJSgktv66AkZdc+1Zb8/TnuyX3ivrx6kpM1QXO+6d8AfpbmLy
	Xsd2cq5FdKE3+QQJ0YeaZH269NlCzfOHD+/cWMosy+6+A+qKmTOc0gV8vEtjcA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] bthost: implement fragmenting to ACL MTU
Date: Sun, 27 Apr 2025 13:44:36 +0300
Message-ID: <71abcfee88f0f739b2c811e48151e0ee99212bb0.1745750626.git.pav@iki.fi>
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

Support fragmenting ACL packets to given ACL MTU.
---
 emulator/bthost.c | 94 +++++++++++++++++++++++++++++++++++++++--------
 emulator/bthost.h |  2 +
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 5db750aae..1ae33ba6b 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -255,6 +255,7 @@ struct bthost {
 	bthost_accept_conn_cb accept_iso_cb;
 	bthost_new_conn_cb new_iso_cb;
 	void *new_iso_data;
+	uint16_t acl_mtu;
 	struct rfcomm_connection_data *rfcomm_conn_data;
 	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	struct rfcomm_conn_cb_data *new_rfcomm_conn_data;
@@ -294,6 +295,7 @@ struct bthost *bthost_create(void)
 
 	/* Set defaults */
 	bthost->io_capability = 0x03;
+	bthost->acl_mtu = UINT16_MAX;
 
 	return bthost;
 }
@@ -572,6 +574,14 @@ void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 	bthost->send_data = user_data;
 }
 
+void bthost_set_acl_mtu(struct bthost *bthost, uint16_t mtu)
+{
+	if (!bthost)
+		return;
+
+	bthost->acl_mtu = mtu;
+}
+
 static void queue_command(struct bthost *bthost, const struct iovec *iov,
 								int iovlen)
 {
@@ -619,37 +629,89 @@ static void send_packet(struct bthost *bthost, const struct iovec *iov,
 	bthost->send_handler(iov, iovlen, bthost->send_data);
 }
 
+static void iov_pull_n(struct iovec *src, unsigned int *src_cnt,
+		struct iovec *dst, unsigned int *dst_cnt, unsigned int max_dst,
+		size_t len)
+{
+	unsigned int i;
+	size_t count;
+
+	*dst_cnt = 0;
+
+	while (len && *dst_cnt < max_dst && *src_cnt) {
+		count = len;
+		if (count > src[0].iov_len)
+			count = src[0].iov_len;
+
+		dst[*dst_cnt].iov_base = src[0].iov_base;
+		dst[*dst_cnt].iov_len = count;
+		*dst_cnt += 1;
+
+		util_iov_pull(&src[0], count);
+		len -= count;
+
+		if (!src[0].iov_len) {
+			for (i = 1; i < *src_cnt; ++i)
+				src[i - 1] = src[i];
+			*src_cnt -= 1;
+		}
+	}
+}
+
 static void send_iov(struct bthost *bthost, uint16_t handle, uint16_t cid,
-					const struct iovec *iov, int iovcnt)
+				const struct iovec *iov, unsigned int iovcnt)
 {
 	struct bt_hci_acl_hdr acl_hdr;
 	struct bt_l2cap_hdr l2_hdr;
 	uint8_t pkt = BT_H4_ACL_PKT;
 	struct iovec pdu[3 + iovcnt];
-	int i, len = 0;
+	struct iovec payload[1 + iovcnt];
+	size_t payload_mtu, len;
+	int flag;
+	unsigned int i;
 
+	len = 0;
 	for (i = 0; i < iovcnt; i++) {
-		pdu[3 + i].iov_base = iov[i].iov_base;
-		pdu[3 + i].iov_len = iov[i].iov_len;
+		payload[1 + i].iov_base = iov[i].iov_base;
+		payload[1 + i].iov_len = iov[i].iov_len;
 		len += iov[i].iov_len;
 	}
 
-	pdu[0].iov_base = &pkt;
-	pdu[0].iov_len = sizeof(pkt);
-
-	acl_hdr.handle = acl_handle_pack(handle, 0);
-	acl_hdr.dlen = cpu_to_le16(len + sizeof(l2_hdr));
-
-	pdu[1].iov_base = &acl_hdr;
-	pdu[1].iov_len = sizeof(acl_hdr);
-
 	l2_hdr.cid = cpu_to_le16(cid);
 	l2_hdr.len = cpu_to_le16(len);
+	payload[0].iov_base = &l2_hdr;
+	payload[0].iov_len = sizeof(l2_hdr);
 
-	pdu[2].iov_base = &l2_hdr;
-	pdu[2].iov_len = sizeof(l2_hdr);
+	len += sizeof(l2_hdr);
+	iovcnt++;
 
-	send_packet(bthost, pdu, 3 + iovcnt);
+	/* Fragment to ACL MTU */
+
+	payload_mtu = bthost->acl_mtu - pdu[0].iov_len - pdu[1].iov_len;
+
+	flag = 0x00;
+	do {
+		size_t count = (len > payload_mtu) ? payload_mtu : len;
+		unsigned int pdu_iovcnt;
+
+		pdu[0].iov_base = &pkt;
+		pdu[0].iov_len = sizeof(pkt);
+
+		acl_hdr.dlen = cpu_to_le16(count);
+		acl_hdr.handle = acl_handle_pack(handle, flag);
+
+		pdu[1].iov_base = &acl_hdr;
+		pdu[1].iov_len = sizeof(acl_hdr);
+
+		iov_pull_n(payload, &iovcnt, &pdu[2], &pdu_iovcnt,
+						ARRAY_SIZE(pdu) - 2, count);
+		pdu_iovcnt += 2;
+
+		send_packet(bthost, pdu, pdu_iovcnt);
+
+		len -= count;
+		flag = 0x01;
+	} while (len);
 }
 
 static void send_acl(struct bthost *bthost, uint16_t handle, uint16_t cid,
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 405d66bf0..583a8b6df 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -36,6 +36,8 @@ void bthost_debug(struct bthost *bthost, const char *format, ...)
 void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 							void *user_data);
 
+void bthost_set_acl_mtu(struct bthost *bthost, uint16_t mtu);
+
 void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len);
 
 typedef void (*bthost_cmd_complete_cb) (uint16_t opcode, uint8_t status,
-- 
2.49.0


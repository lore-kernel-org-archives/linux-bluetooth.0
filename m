Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC631E1DFC
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296097; cv=pass; b=kSFE/iDZf4HU+2ATy/OBRkqagzNGS2+clle62jt9sW1X0ePTc7eMzZbHUrWL/PKgx27URoJoNW+x/566wsUP/+bSfTZN1Wx1xseXbJptkjcHce26ZITeqEF/yOIB2TdLxCccPPF4w2v1o2dWvVx6Cv85WG90DlZNoJBe0kMXRmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296097; c=relaxed/simple;
	bh=I98Ecm96LoWw6vlbogRG0FfvVt18d9OyLLJcCgCMokY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsLmktTFyr8h+yn3LKfr8DKjJkCnYteebQUYPmZAMMxjoxZYjmVSOOJc4obqeMmbXfyLOjevTvkF5CD3sIzALUoU1h4Z1zDQipHwF0GP4RUpUIitFgCSSrr5slCE7wuhrS6iH0wHbo6lnFA+31o77UawnYgM+OFfxlRW55XYIMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SBEujwxz; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=yAbt/0kk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SBEujwxz";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="yAbt/0kk"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4bnN7X62Dqz49PsJ
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 21:33:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1753295624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FXZzbjCtzlm58xDg85sxWU/Pd0POWKvGKHrniCnZ/g=;
	b=SBEujwxzh+f/Xd7+v+Fx7Mevd2MDmZWXKb4dThtpeW5MWwj/eD/iwwpGUgBhf6jPO/M9ms
	OGjPzAzpCrR3npYMvhRDrXU5kkWp0xFvGtf32Ih5FTEo/KNzylye8MEoi8xDbzbgGu8J6M
	8p83UaILrwEW//NgkkiMoG9SyCsnOGCVCaEdHyRF2xt9ZGkFszNNUkdme/ehX3IrwFvuJe
	zL2fh6sW47/daPcE6UzVzfdbkBmqgaUsbDjoKGHw60ceeiYXQucy/3iwUUXt5YuGNDPjsr
	tKkiBkp2poMhWmhJzmvASxHtQ5ZSvl2xZnm7HPNwzDQGASyWtkVFVihReA9gaw==
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bnN7P0nhCzyTm;
	Wed, 23 Jul 2025 21:33:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1753295617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FXZzbjCtzlm58xDg85sxWU/Pd0POWKvGKHrniCnZ/g=;
	b=yAbt/0kkl0VuQ7g/I8S3XaSJ/EJOOLEn1uLOiYHGK3q/6pG1+dlJMwG8vghTobHPoqDWwC
	cd/rj/cUgkcZPSD2fhOy3nyZ+yRv7QQx9/HGVw+29qLQfuuEylhO/QJrA2Aq07UOpa8Oz9
	KsN6a99hmGFQMXXu5ok1ypgUxGp+OQI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1753295617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FXZzbjCtzlm58xDg85sxWU/Pd0POWKvGKHrniCnZ/g=;
	b=EgKdv+NQSUrPM6OCHU8Fmcl8mKHx3fxzh3A0Twwbtu+Ia3UTzwmBjI9DaCwbUMOzXNWmM5
	JM/ygfNGSIM0mye6AS3Tx8bU812FS46z/AA6Jw/+yNGkbNj+AfELFh6b4eBoHjzfacvIzU
	LmqyGrhNzzZNqta6iM/sOcueMn3YtRY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1753295617; a=rsa-sha256; cv=none;
	b=cb0+WMLDjWCjpWDSgwMYk08dz9nNLMuFl/E6HfVk4LndRNEiPL1h0YsNBy6wD0ao2X86dh
	T715q4N6wVy0rZcnwoffqPHJ9gsdlZJ89duDCQ25j9tBB44nPIeYdGJvQKaC+HIfX4di3t
	kXIbptt/NiWXYAkdvBK+lWkC5dFxU1g=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] bthost: fragment when sending ISO packets
Date: Wed, 23 Jul 2025 21:33:33 +0300
Message-ID: <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support fragmentation to controller MTU when sending ISO packets.
By default, fragment when exceeding btdev iso_mtu.
---
 emulator/bthost.c | 102 +++++++++++++++++++++++++++++++---------------
 emulator/bthost.h |   1 +
 emulator/hciemu.c |   7 ++--
 3 files changed, 75 insertions(+), 35 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 7ab4533d1..52c5b0bed 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -257,6 +257,7 @@ struct bthost {
 	bthost_new_conn_cb new_iso_cb;
 	void *new_iso_data;
 	uint16_t acl_mtu;
+	uint16_t iso_mtu;
 	struct rfcomm_connection_data *rfcomm_conn_data;
 	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	struct rfcomm_conn_cb_data *new_rfcomm_conn_data;
@@ -297,6 +298,7 @@ struct bthost *bthost_create(void)
 	/* Set defaults */
 	bthost->io_capability = 0x03;
 	bthost->acl_mtu = UINT16_MAX;
+	bthost->iso_mtu = UINT16_MAX;
 
 	return bthost;
 }
@@ -583,6 +585,14 @@ void bthost_set_acl_mtu(struct bthost *bthost, uint16_t mtu)
 	bthost->acl_mtu = mtu;
 }
 
+void bthost_set_iso_mtu(struct bthost *bthost, uint16_t mtu)
+{
+	if (!bthost)
+		return;
+
+	bthost->iso_mtu = mtu;
+}
+
 static void queue_command(struct bthost *bthost, const struct iovec *iov,
 								int iovlen)
 {
@@ -912,52 +922,80 @@ void bthost_send_sco(struct bthost *bthost, uint16_t handle, uint8_t pkt_status,
 
 static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
-			const struct iovec *iov, int iovcnt)
+			const struct iovec *iov, unsigned int iovcnt)
 {
 	struct bt_hci_iso_hdr iso_hdr;
 	struct bt_hci_iso_data_start data_hdr;
 	uint8_t pkt = BT_H4_ISO_PKT;
 	struct iovec pdu[4 + iovcnt];
-	uint16_t flags, dlen;
-	int i, len = 0;
+	struct iovec payload[2 + iovcnt];
+	uint16_t payload_mtu = bthost->iso_mtu - sizeof(iso_hdr);
+	int len = 0, packet = 0;
+	unsigned int i;
 
 	for (i = 0; i < iovcnt; i++) {
-		pdu[4 + i].iov_base = iov[i].iov_base;
-		pdu[4 + i].iov_len = iov[i].iov_len;
+		payload[2 + i].iov_base = iov[i].iov_base;
+		payload[2 + i].iov_len = iov[i].iov_len;
 		len += iov[i].iov_len;
 	}
 
-	pdu[0].iov_base = &pkt;
-	pdu[0].iov_len = sizeof(pkt);
-
-	flags = iso_flags_pack(0x02, ts);
-	dlen = len + sizeof(data_hdr);
-	if (ts)
-		dlen += sizeof(timestamp);
-
-	iso_hdr.handle = acl_handle_pack(handle, flags);
-	iso_hdr.dlen = cpu_to_le16(dlen);
-
-	pdu[1].iov_base = &iso_hdr;
-	pdu[1].iov_len = sizeof(iso_hdr);
-
-	if (ts) {
-		timestamp = cpu_to_le32(timestamp);
-
-		pdu[2].iov_base = &timestamp;
-		pdu[2].iov_len = sizeof(timestamp);
-	} else {
-		pdu[2].iov_base = NULL;
-		pdu[2].iov_len = 0;
-	}
-
 	data_hdr.sn = cpu_to_le16(sn);
 	data_hdr.slen = cpu_to_le16(iso_data_len_pack(len, pkt_status));
 
-	pdu[3].iov_base = &data_hdr;
-	pdu[3].iov_len = sizeof(data_hdr);
+	if (ts) {
+		timestamp = cpu_to_le32(timestamp);
 
-	send_packet(bthost, pdu, 4 + iovcnt);
+		payload[0].iov_base = &timestamp;
+		payload[0].iov_len = sizeof(timestamp);
+		len += sizeof(timestamp);
+	} else {
+		payload[0].iov_base = NULL;
+		payload[0].iov_len = 0;
+	}
+	iovcnt++;
+
+	payload[1].iov_base = &data_hdr;
+	payload[1].iov_len = sizeof(data_hdr);
+	len += sizeof(data_hdr);
+	iovcnt++;
+
+	/* ISO fragmentation */
+
+	do {
+		unsigned int pdu_iovcnt;
+		uint16_t iso_len, pb, flags;
+
+		if (packet == 0 && len <= payload_mtu)
+			pb = 0x02;
+		else if (packet == 0)
+			pb = 0x00;
+		else if (len <= payload_mtu)
+			pb = 0x03;
+		else
+			pb = 0x01;
+
+		flags = iso_flags_pack(pb, ts);
+		iso_len = len <= payload_mtu ? len : payload_mtu;
+
+		iso_hdr.handle = acl_handle_pack(handle, flags);
+		iso_hdr.dlen = cpu_to_le16(iso_len);
+
+		pdu[0].iov_base = &pkt;
+		pdu[0].iov_len = sizeof(pkt);
+
+		pdu[1].iov_base = &iso_hdr;
+		pdu[1].iov_len = sizeof(iso_hdr);
+
+		iov_pull_n(payload, &iovcnt, &pdu[2], &pdu_iovcnt,
+						ARRAY_SIZE(pdu) - 2, iso_len);
+		pdu_iovcnt += 2;
+
+		send_packet(bthost, pdu, pdu_iovcnt);
+
+		packet++;
+		ts = false;
+		len -= iso_len;
+	} while (len);
 }
 
 void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 456f631d5..0d8eca530 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -37,6 +37,7 @@ void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 							void *user_data);
 
 void bthost_set_acl_mtu(struct bthost *bthost, uint16_t mtu);
+void bthost_set_iso_mtu(struct bthost *bthost, uint16_t mtu);
 
 void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 8529caae8..a59773618 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -308,7 +308,7 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 {
 	struct hciemu_client *client;
 	int sv[2];
-	uint16_t mtu;
+	uint16_t acl_mtu, iso_mtu;
 
 	client = new0(struct hciemu_client, 1);
 	if (!client)
@@ -343,8 +343,9 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 	client->host_source = create_source_bthost(sv[1], client->host);
 	client->start_source = g_idle_add(start_host, client);
 
-	btdev_get_mtu(client->dev, &mtu, NULL, NULL);
-	bthost_set_acl_mtu(client->host, mtu);
+	btdev_get_mtu(client->dev, &acl_mtu, NULL, &iso_mtu);
+	bthost_set_acl_mtu(client->host, acl_mtu);
+	bthost_set_iso_mtu(client->host, iso_mtu);
 
 	return client;
 }
-- 
2.50.1


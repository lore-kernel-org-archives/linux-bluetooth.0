Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830865;
	b=F2519VDWmr2dyShzp1yXfvScgcoXj2rEJoH8LZwB99moCd2J0IojH2hbQa7K71ocEZhy
	 p6j/lLS8Zrsfo37qYkpVhUGbJV1oWdLxXqk4yUJaKrC0iPwFbgmn8rl2w7aNP7+eY8G4d
	 aT2Azq/pnCToGjqvInFvhxUfI0XhYivwZStXJAPKtAODsTK5RfrC9atxg7+w8qGKIRDus
	 R7ef0SGAWGqFJ5wex55NhUUmIP29J73ht4MbX64Kp3+AqBh8RgrjaQUsK0jtEd+qxQx4v
	 C+o0YxodKGpYwqOJGIWKuns+uzdw/9IOk00+2SQJwnHlXqfUJYHubVjcGJBDQf13FqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
	b=rs8b1DtPQY9AZstMqvxrAF1jHXoSi1uH97P2mr2CUEnzFRjQjDL6VdBgyEI1QxxAZ4it
	 yOiyqW1P1OuDHDWLsMe/IwhM/w7yYySTNXQ6NCQocwZPzgJATUePFfNy7kO+hBfg9ljh8
	 RPshuPBL3x5ZFpc4j/qD9MMLEL1Xmgii/6rdZ1MT7eTTnLjV18XkM7tmAGhqW3fT7gNqG
	 lKQjFfqJ9q81hAY55Entb5ecYP466pLvqS0v7A/LatJHmt9O/I08c8JemQOleinm0viTY
	 nIPJEKY+jipt5Nmz+h6h5hfb3/JIc/FqHDy2Bic7NeEYejNwmgc1M5Qh813Xrb27wYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayyuhMr7;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096D606D824
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C096D606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayyuhMr7
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cc013095d4so361997137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830863; x=1794435663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=ayyuhMr7tOxtFLl0IpufoN4sOQ5+4N27BtiwghQ/fHwo24mM8YCLl5+xLvQhCKmNPK
         2BDrBJkcnFImsAu1+7/eejkR9VKlla9xWFnlAiyDaHFheRD53TEQrUkW418cvW1CtCz3
         aD2xaq1gycWC+1AjiyyfFVLtBM36BY96uDtmDl54VoA6S6uLGR1ufCrEtJRra47U/6vL
         i1y5Zo3Wq9yj7ielACk8oHL0Z+9aEC3pTdCnZuHlFkRRg/hjF2j6sbfGL9yP6RWraQiH
         /1qLkL3G2vxuu15ZcAjr6bxMyMmXF0HA6l7UfqftBMFIIAqs4gkjuBySQ8nd4erOrFrN
         CZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830863; x=1794435663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aPA077KvVRxxvTAZgpfnMGyB9WG9NqdRyeK2f4Z8pd0=;
        b=N6+dz3V9MnLJVub7UIvWEu34Vdi3CpkD2pxDTGxMTPam2Qfdjref56BXyv7GD1lerK
         vIoEpPdYep2yiCAX7NWTRNzbVPFx746x0sRH/kKGEpLNAMIUXSgtArz1a9LhkPXXYAgG
         TbOhXwciU8elmP0H3q71xVusWUQQ/1OIbFAWYG+/cydG0xc+AOfHeh8VOO8tOjWDMjnB
         jBAZW7nnb1RVE04qaDyGy62n2T0WcxoIQE+h1onFktxAIblt9lrTDMmwighqrhNmnLpG
         wGy4yJtDBUXiTo3Na1v4yAUr7cW2p3/7J+QZdRxiXVx6zxpq4otO0Y0+YRuZSwuFDLGA
         szxw==
X-Gm-Message-State: APuU4Z8AI1oi5YyX53u/WRTP73BRNFX6JU57NFQsYFAnMFbd+id5YSnD
	+2O7q2ewbD1s7vSeZIJUVISHo7YDJWixDgxAiFn6SG5EP2fMfbvky+CVRz5ICw==
X-Gm-Gg: AYBFou3LbfX7zAXFzlmz2YAZonyfSmNekvG4fe6+RGnD8JRR4DHl/Pgcn1rbyeRHolC
	/eHqE/Tt1UV9L+Idpkgam7uOWD8YXw4Dunkr2oAPikoIBxj7SFTW4A9v0/RhkBVJTvb+cgyFk5Q
	6XFQaJMsNrC2d3WRavE4G+niLvNgiS57mhwKS+nNLRw7zX0jJd7tdjr7cySN7T49ME+lyjfdNhe
	kHKw+Yn37gHGsJUqhQPdfLny6p//mMsmR5svn9eYuy3zvONgnbzOoCU9K3V4MOPyvV7KnI0C8Rd
	FAD+8KZU1UYfxMUVeQRc6DaLz2mVghgl2ww8nmck+agXQ8eiZbH0WVlBimFGiVjoMGZ+dtLr5B9
	ilpzfIzqTDPwYqH4JzdHnojReDOVQ6xmgn0jhSxyEE4p6dbZ4aAnalb4/NZkyLoNH9St7N/wiC5
	AmRYQFDDlJpxQT2WYBQ/VQO0rTsKwOt4oeLg9IKC+cTpmYvsbBK/ujoWtN88rUPXUlpRmUFSUnY
	SG55UDLiE34F+vEYpu07IK9zYVOI0UbdfSPuGKw9RWR5fsMD7BByRbeOFGVu3ydGPnEzNgkB3lF
	FYGLo3mjRtMx+1FqQExx4lQoG1MUnOMNlR+EKgOcdE6R75zQ5u6gSGk9Qiva+OATwC1uyfwREha
	LaW0y5v2rUwJb/HA6Z11YTzrIsdhP41BGkbQRPsMhz5D23mHQ+ye0HAqVlogvlkBiinjEc5Fvnn
	VKRyM=
X-Received: by 2002:a05:6102:1481:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7d0727aa79fmr7180789137.1.1793830863354;
        Wed, 04 Nov 2026 14:21:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.21.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:21:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 06/10] emulator: Add HDT support to bthost
Date: Wed,  4 Nov 2026 17:20:50 -0500
Message-ID: <20261104222055.1207928-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104222055.1207928-1-luiz.dentz@gmail.com>
References: <20261104222055.1207928-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add helpers to set the PHY of a connection, including the HDT rates,
and to start encryption with a given MIC length through LE Enable
Encryption v2, so testers can exercise HDT and MIC length checks from
the remote side.
---
 emulator/bthost.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h | 14 +++++++
 2 files changed, 113 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2f05573786f8..afcf453be789 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -277,6 +277,10 @@ struct bthost {
 	bool conn_init;
 	bool le;
 	bool sc;
+	uint8_t mic_len;
+
+	bthost_encrypt_cb encrypt_cb;
+	void *encrypt_cb_data;
 
 	struct queue *le_ext_adv;
 
@@ -1605,6 +1609,9 @@ static void evt_encrypt_change(struct bthost *bthost, const void *data,
 
 	if (conn->smp_data)
 		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (ev->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
 }
 
 static void evt_io_cap_response(struct bthost *bthost, const void *data,
@@ -1946,6 +1953,17 @@ static void evt_le_big_info_adv_report(struct bthost *bthost,
 	send_command(bthost, BT_HCI_CMD_LE_BIG_CREATE_SYNC, &cmd, sizeof(cmd));
 }
 
+static void evt_le_cis_established_v3(struct bthost *bthost, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established_v3 *ev = data;
+
+	if (ev->status)
+		return;
+
+	init_iso(bthost, ev->conn_handle, BDADDR_ANY->b, BDADDR_LE_PUBLIC);
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1994,6 +2012,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_CONN_RATE_CHANGE:
 		evt_le_conn_rate_change(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED_V3:
+		evt_le_cis_established_v3(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -4030,6 +4051,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 {
 	struct bt_hci_cmd_le_start_encrypt cmd;
 
+	if (bthost->mic_len) {
+		bthost_le_start_encrypt_v2(bthost, handle, ltk,
+							bthost->mic_len);
+		return;
+	}
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = htobs(handle);
 	memcpy(cmd.ltk, ltk, 16);
@@ -4055,6 +4082,36 @@ void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_LE_CONN_RATE, &cmd, sizeof(cmd));
 }
 
+void bthost_le_start_encrypt_v2(struct bthost *bthost, uint16_t handle,
+					const uint8_t ltk[16], uint8_t mic_len)
+{
+	struct bt_hci_cmd_le_enable_encrypt_v2 cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = htobs(handle);
+	memcpy(cmd.ltk, ltk, 16);
+	cmd.mic_len = mic_len;
+
+	send_command(bthost, BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2, &cmd,
+							sizeof(cmd));
+}
+
+void bthost_le_reencrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t mic_len)
+{
+	struct btconn *conn;
+	uint8_t ltk[16];
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn || !conn->smp_data)
+		return;
+
+	if (smp_get_ltk(conn->smp_data, 0, 0, ltk) < 0)
+		return;
+
+	bthost_le_start_encrypt_v2(bthost, handle, ltk, mic_len);
+}
+
 uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
 {
 	struct btconn *conn;
@@ -4113,6 +4170,48 @@ void bthost_set_sc_support(struct bthost *bthost, bool enable)
 							&cmd, sizeof(cmd));
 }
 
+void bthost_set_mic_len(struct bthost *bthost, uint8_t mic_len)
+{
+	bthost->mic_len = mic_len;
+}
+
+uint8_t bthost_get_mic_len(struct bthost *bthost)
+{
+	return bthost->mic_len;
+}
+
+void bthost_set_default_phy(struct bthost *bthost, uint8_t tx_phys,
+							uint8_t rx_phys)
+{
+	struct bt_hci_cmd_le_set_default_phy cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.tx_phys = tx_phys;
+	cmd.rx_phys = rx_phys;
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_DEFAULT_PHY, &cmd, sizeof(cmd));
+}
+
+void bthost_le_set_phy(struct bthost *bthost, uint16_t handle,
+					uint8_t tx_phys, uint8_t rx_phys)
+{
+	struct bt_hci_cmd_le_set_phy cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = htobs(handle);
+	cmd.tx_phys = tx_phys;
+	cmd.rx_phys = rx_phys;
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_PHY, &cmd, sizeof(cmd));
+}
+
+void bthost_set_encrypt_cb(struct bthost *bthost, bthost_encrypt_cb cb,
+							void *user_data)
+{
+	bthost->encrypt_cb = cb;
+	bthost->encrypt_cb_data = user_data;
+}
+
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index ed924eb99630..b3e18114638a 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -169,6 +169,10 @@ void bthost_request_auth(struct bthost *bthost, uint16_t handle);
 
 void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
+void bthost_le_start_encrypt_v2(struct bthost *bthost, uint16_t handle,
+					const uint8_t ltk[16], uint8_t mic_len);
+void bthost_le_reencrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t mic_len);
 typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 							void *user_data);
 typedef void (*bthost_l2cap_disconnect_cb) (uint16_t handle, uint16_t cid,
@@ -185,6 +189,16 @@ void bthost_add_l2cap_server_custom(struct bthost *bthost, uint16_t psm,
 				void *user_data);
 
 void bthost_set_sc_support(struct bthost *bthost, bool enable);
+void bthost_set_mic_len(struct bthost *bthost, uint8_t mic_len);
+uint8_t bthost_get_mic_len(struct bthost *bthost);
+void bthost_set_default_phy(struct bthost *bthost, uint8_t tx_phys,
+							uint8_t rx_phys);
+void bthost_le_set_phy(struct bthost *bthost, uint16_t handle,
+					uint8_t tx_phys, uint8_t rx_phys);
+
+typedef void (*bthost_encrypt_cb)(uint16_t handle, void *user_data);
+void bthost_set_encrypt_cb(struct bthost *bthost, bthost_encrypt_cb cb,
+							void *user_data);
 
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len);
-- 
2.56.0


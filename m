Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414486;
	b=2cvzpAvL92e4F/0DhXLT9LxlRd6BxNsvZe3guy6z0kwcYkjIBvye1qYKVwi/uRQ7PT+R
	 Cry7LNs/53eKyu35X1bjwOrE4+E1j0/FD0Zism6Vg11X2sdxfERSyjHnNKux78EqjOfGt
	 8aj0rJP+oXDUxisdrPogqaN+7860lkWdxy6UFT5lGT2xcX+N7z80ew2zcVybtYw+Hzoy9
	 6hLgYKK4FSXw4yy9alDbovL9gIl+baE2ANhuQJ6D5wuyOmr1hH+i3ABdrOKFw9aJiufXq
	 fEYD5IFfWfMM1CyEHlrbvz0cOzS1pQZlikr+e8z0gYe+ItRbPoiwjwJmRBOCq/Jvbtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
	b=OQKSBp/rsl/A/FaJnVPSiPrTSM2NpUsYVPSUrkvvqjH9G505CjP9eLegOUrXhX/02I/H
	 U/AgpNy1D3gfhMWVMmLkGATPkqXQByU9T/QLzOOGg569TNNK5NXOr2coU3+kEKfK5vZi7
	 4wwjtxJqRnPaNHSKxZR9Zq7eC8pasTF584+gk6HOCTnM5pKrd3JXsVpZOYmxC4iCnl+1g
	 EyZOZdTrsjWPX7+HDHU7NC+ExNeGPddtC1HPGxZ4/dBh8/pIEnSNVQrJcuIHylx7QpbR+
	 D+aW0h0TuSQs3kd9/gO1qnAKraCPvzkoUcdNgkvlA06vGUX6muBN81qVP5SWw4GSUlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="E4/9Fv8H";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C942606A89B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C942606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4/9Fv8H
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec20398b05so1927658e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414485; x=1795019285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
        b=E4/9Fv8HGn1KQ1s0jyv2lkS/qqBDSwxy7AKz0vytGD3M1HJASgTGqNmpPukPYMVate
         sLibm0JgaY0Na5rBnSB6JO5+n0tjXcYdR3Q1Q7GvTNhra5IanHpvBpThLI8cAkBkoqQ1
         bDO33fJMsweiVcff6iIBBDdrZP9kK7bYyQTlALcLz4S4WRm0TLjYATutZoyQjbsVPIUr
         57q3AkP/GquXLO3ZiU8T/xRjZW0yBznC8O2Q7IRCTSjmPDTRR3oTRD2vwWB2ZH/MWjBo
         0GdYK/EtKpGA6Pr6TIAShN4/6UIQWMuYl30Nzj8kiIPM+ToZCPCG3WquIrEEmEDMO2nj
         1bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414485; x=1795019285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
        b=Qx7uktEZIPmj8MNcblZLSnBrFFvfDm9a7MooKwjR79FLTeFcODuL+L0Bc9WNfOGXAM
         KXwcRFCAfQ5+XgU+QMIB+A9Rxp9tTLCM6cRPTRTitHC6uCVPn85Ouqj5XwsR0f4WzdYG
         SHsyDFC/kE7TlOYd49mcrCGbQ51JfxOK77RxOh0Z/FnLj+pEfrCxIDduq/nurWYQ5Xgz
         LCuqlXruSCck9ZXM6na/okgWDsmza63wGn433RmgHUknSuiaIxMl8vkm5d4MAL6nJoYV
         VKJGpqco/AgRJrEl9M2qSg05aDn2SU+jbcMYjosYUeYJf7SrQKz6oXnZix1TQVuqZbAD
         uL3w==
X-Gm-Message-State: APuU4Z8FR/k1yjUG78OWGO48qcb3D/32o3t+QAnhjoPV7A3IQCb0ltq9
	3iv8mSkDgQZwRCVDgwf0SbU5eusKK/lbN7ojYuLACQ8ijOsJqHvTx7qWuQGLJw==
X-Gm-Gg: AYBFou0O/uNqSvoEG5COFHfL8KTwvUKW0g0XUUlTndcKrNWtE8o/HK6HO8Dlnt6u/a6
	ZCRhowi8zpI7lFd1HeOjtw8qR1tl1J1tPrH722vCRTGBq00aYs9OuJBq6VhEwr6m/aDRjXMOGUR
	luaF6pxVM3nX58/TDJ92L5x9sApdHIhHue/mQUFqIoAJIIkAU3QcX4li741a9VdMgwbfliFn/rq
	39w0HIZCU4JK7rSBS1AvVu552G9NqLqw9kNK4x9wMpK9Pfm+coNm7o+NqrqU04Zdd32AcdQvVbp
	j/HP6idok02YGMT0OAH2RPlo4z8kknU0oe7AU2XKeLqR2xVxBV//C6eB3LMW5Zp/j3Y9j3XFb35
	nHPczRZ3F/LNl/EHcC6NKjXLcvcsU8yoMdsu6+8a8NdjDDkML3XxBvURkj6gp7AetYEUM/duHGU
	pjLfsO7VE8BYiF/dl4ZRZ5OiLswWwS+OIwEaVnKTIvjhXvf6ZPj0kzNdEihrPjRdDy2o+g5Bnsp
	8j2Jl1E3wyIVet9AqHWEVRogfZ+TnynrAadpS8AXZCJNbWyxe0lzcxh/VgEIVvaUvVM7JlKAwVq
	1zCEFd1SdXAUKHjM7osxbe5IILs2m2UuhmFicpgbV0kuF0OjL0qsbMbMMYvQJB2ZyOb/nQ3470Y
	rgjBIN+CbxJEh99u9VnZ5/WBBvIyvX9OQOzAL8M8KeFJEp5nw4nBgCtNVpkceVQuniZ8A50ogWs
	3EETk=
X-Received: by 2002:a05:6122:20a8:b0:5ea:be1b:1b24 with SMTP id 71dfb90a1353d-5ee1c42fdbemr1040953e0c.13.1794414485176;
        Wed, 11 Nov 2026 08:28:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.28.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:28:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 07/11] emulator: Add HDT support to bthost
Date: Wed, 11 Nov 2026 11:27:50 -0500
Message-ID: <20261111162755.3506226-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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
 emulator/bthost.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  14 +++++
 emulator/smp.c    |  11 ++++
 3 files changed, 156 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 0c669f92efc4..e65d29faa989 100644
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
 
@@ -1605,6 +1609,34 @@ static void evt_encrypt_change(struct bthost *bthost, const void *data,
 
 	if (conn->smp_data)
 		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (ev->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
+}
+
+/* A key refresh, such as pairing over a link that is already encrypted,
+ * completes encryption with the new key as Encryption Change does.
+ */
+static void evt_key_refresh_complete(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_encrypt_key_refresh_complete *ev = data;
+	struct btconn *conn;
+	uint16_t handle;
+
+	if (len < sizeof(*ev))
+		return;
+
+	handle = acl_handle(le16_to_cpu(ev->handle));
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn || ev->status)
+		return;
+
+	if (conn->smp_data)
+		smp_conn_encrypted(conn->smp_data, conn->encr_mode);
+
+	if (conn->encr_mode && bthost->encrypt_cb)
+		bthost->encrypt_cb(handle, bthost->encrypt_cb_data);
 }
 
 static void evt_io_cap_response(struct bthost *bthost, const void *data,
@@ -1946,6 +1978,18 @@ static void evt_le_big_info_adv_report(struct bthost *bthost,
 	send_command(bthost, BT_HCI_CMD_LE_BIG_CREATE_SYNC, &cmd, sizeof(cmd));
 }
 
+static void evt_le_cis_established_v3(struct bthost *bthost, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established_v3 *ev = data;
+
+	if (size < sizeof(*ev) || ev->status)
+		return;
+
+	init_iso(bthost, le16_to_cpu(ev->conn_handle), BDADDR_ANY->b,
+							BDADDR_LE_PUBLIC);
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1994,6 +2038,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_CONN_RATE_CHANGE:
 		evt_le_conn_rate_change(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED_V3:
+		evt_le_cis_established_v3(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -2065,6 +2112,12 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 		evt_encrypt_change(bthost, param, hdr->plen);
 		break;
 
+	/* Both versions start with the fields used */
+	case BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE:
+	case BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2:
+		evt_key_refresh_complete(bthost, param, hdr->plen);
+		break;
+
 	case BT_HCI_EVT_IO_CAPABILITY_RESPONSE:
 		evt_io_cap_response(bthost, param, hdr->plen);
 		break;
@@ -4030,6 +4083,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
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
@@ -4055,6 +4114,36 @@ void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
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
@@ -4113,6 +4202,48 @@ void bthost_set_sc_support(struct bthost *bthost, bool enable)
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
diff --git a/emulator/smp.c b/emulator/smp.c
index 0b1733cc7e57..b0a6c1bba1b4 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -81,6 +81,7 @@ struct smp_conn {
 	uint8_t method;
 	uint8_t local_key_dist;
 	uint8_t remote_key_dist;
+	bool keys_distributed;
 	uint8_t ia[6];
 	uint8_t ia_type;
 	uint8_t ra[6];
@@ -380,6 +381,8 @@ static void distribute_keys(struct smp_conn *conn)
 {
 	uint8_t buf[16];
 
+	conn->keys_distributed = true;
+
 	if (conn->local_key_dist & DIST_ENC_KEY) {
 		memset(buf, 0, sizeof(buf));
 		smp_send(conn, BT_L2CAP_SMP_ENCRYPT_INFO, buf, sizeof(buf));
@@ -435,6 +438,7 @@ static void pairing_req(struct smp_conn *conn, const void *data, uint16_t len)
 
 	conn->local_key_dist	= rsp.resp_key_dist;
 	conn->remote_key_dist	= rsp.init_key_dist;
+	conn->keys_distributed	= false;
 
 	if (((conn->prsp[3] & 0x08) && (conn->preq[3] & 0x08)) ||
 					conn->addr_type == BDADDR_BREDR) {
@@ -458,6 +462,7 @@ static void pairing_rsp(struct smp_conn *conn, const void *data, uint16_t len)
 
 	conn->local_key_dist = conn->prsp[5];
 	conn->remote_key_dist = conn->prsp[6];
+	conn->keys_distributed = false;
 
 	if (conn->addr_type == BDADDR_BREDR) {
 		conn->local_key_dist &= ~SC_NO_DIST;
@@ -834,6 +839,12 @@ void smp_conn_encrypted(void *conn_data, uint8_t encrypt)
 	if (conn->out && conn->remote_key_dist)
 		return;
 
+	/* Encryption is also reported for a refresh of the key, such as with
+	 * a new MIC length, after the keys were distributed.
+	 */
+	if (conn->keys_distributed)
+		return;
+
 	distribute_keys(conn);
 }
 
-- 
2.56.0


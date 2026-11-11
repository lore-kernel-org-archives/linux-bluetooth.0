Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427638;
	b=kPrW5fxjzedShYeCjZgegx1dKsEscGEHaiJJhTaasjkhsKSGVMAbT3Z0ObPk0Xr8Sl2O
	 sWH3pvci9yFpTFraQBuXyK7DYp3GEzIzXc49G521+t5Z0GJ2yhVCjzEVHX8JhFKI2zv4D
	 ky17iM38hrxO7fM/vhu6DD83Uum2A0N3vQSSJ5ouOgXmHpQP41zynLeFVoCQvqdtJ7Xj/
	 c3O5tqs8fKAqb1XoRRoCBXGDm+a5+1Sifj7P976e4fuPkmtPjvZzUPM8ykpQaD4kJyJyV
	 tBkcJHUS2/b6+5EJ4UP2w7HMmkH/fBI2eDQoUSrA1P2/qH+BOLD2gCjGYfGMaxqD2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
	b=JYM4MBPUp6IsO0wLjTqJ+fQjlkrSrT9chNT6KUOp7wjS2/9PU3FZKP0Q3RLTY8lPKu8S
	 AbkoduXlDDEdLR6tUqs76p1GrKAq4SacC9fGKpcjPWKUrAWOUIiUIjzIMxZrozNyoCs6x
	 rvPSyRmcY2ugUr5QgolIDj0A90A5aGibgKHiKtIxacJCokXpNZWmpyw9K2QyRitibJIRe
	 VAWkOJQn98GSMgKJHgx0MT7biBxARw/Vf3S6EIR8jxUjdkxyDlchEV1m/wygmqBWSKngy
	 PyDsoCgPNHD8wMuJ7fZ4svGabTIAnvn22LObYp/u+n0DLKrovFVgS1uf2D4UaD3JA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEQ79XMd;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31C606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F31C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEQ79XMd
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc53938a8fso2332667137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427637; x=1795032437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
        b=VEQ79XMdTKvyhJ/uxCMvJfN3KuTO1NRxs7SO7SlUrTllPUgRCeGxUa63FVKqSNCPRU
         Ybmep0bPEIiE2LFuDcWRU2tAtdxAdvH6JNu85vWJTpe+1ubxbKWCtjkTsN/voJwLfHzI
         jYAKXDsuHK9vJJrgwM79K7FJ3axDo3lyuhUUzEgVOMAqfozaOfDHSZCplirCHVvRYQEA
         HkHRrFZBFfYM+ANCg1vH2LiLluvL/w1rdWfmGhtM4d+TJRq3rpDBUks25HQpXuGOO7ww
         iHlLxO335UdYfmptDuujFKz+kFy8LeMNM7ZW2zLFBeEHJHYXLCVpDILPnw6w9TveNNHB
         lUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427637; x=1795032437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cV8yOaP8OMs4R2fNLplsHk2cpYsLB6RE/A1bXhgMlXw=;
        b=qUBDGnxXQxF06/S1iVjksKlsiC7ZJsdEuQhzBt87SNCzUZClHgKV6ysU83XvQYumSq
         gDcbeGw5jAY5s/689madFkWaFLUk89L4HDrM8PS+M6Jw6qg8KIq3kjpIU3LorZDmWRfp
         BUKGKNpi/nD5lQuM8Zl7/ATDSU0DbHqTodD3FTxl7PwAcVK6LB+wh9QFxc8pTXa09Q72
         pmw9J4ZsoOPgKCTcVTz4h41CRS+gQxscY/6XeGt0Uyplu60Ll+8grASowfxfdBREU91g
         nmanHMYiAWksq12uz14UlKfxQhxQjvI+w61SKXNT6C5OxWchBfxTlOS0LqrB6a7F8rBT
         2+qg==
X-Gm-Message-State: APuU4Z+n3QL4hO/tgSbwbooycXafkWPbscT21BQNyOpPqe5B9Z171D+J
	XrGiMzqTG/ZuehCiyO6fnDI7ysbA+IBZA7iz4uaYjMFaeBTsdgGRwAX+YLkOZw==
X-Gm-Gg: AYBFou1jdbHAxdFcMVqyMilEdI5nvOi//Oeb06sxD5cN81uy2sbK7W+bdgp7l86uueH
	FamFr5PD5FoaMOtuHTnW3orzi09QgcenHieTbY5noE1zKspQHwrswG97dQXNdrkJVpPQa0QV75m
	0PN7z1Qs6FbtORB4j8Eo0hNq3a28q1wHKszp7ULvh8DewxWUdG3pHA1FUZ9keFuNXsfhBJtjxnh
	nvdJk7rJSOTab2HeSRdwMRLes5JhAdLt8YnImmlODHk6LJKuG0/XtajiWHigMPEfqL38dZoucAm
	dKYfeu9cwOUAD6tLY24gYWTtJJ27xXxKf5sNR366zUWL793WXqpKSgxdTO/lh/WIwj7LlXhGCuN
	ZZ407QmH3DdjrGa/JALxql3u6gHGS26SMqtZ/cbLCRwbb9BgZdcH9UZp1R46ACYPpWy0nc7Y1fa
	cqx9W12yGKzC+wABqV94ykIYpqo4KscYeWYSqphkXd+xdXHnUozrQq38InhFmoqOXNFNblCnD2Q
	9CLGEqa9G9bUz+69x0rzi4Ra0+VmmrbUk/8JHWaOCJU6SIZ7gaW0303PWRxljvhYzTHyUFala0k
	fKMCvFx2XEuIf0/+Qu/rzn0sgGh8Rh9AVQC47XDNihscaUtDXO8+VgW6SHfGDG7FR0zRM1694Os
	ckrJsuW0Y79Q8A9XctyNVyGnkxS6AImm+Y49m/Y/Ly7nxSYZ21I8YQyi67P2ZLLwvVOeaAHJN2G
	Sx0aI=
X-Received: by 2002:a67:e7c6:0:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d4eed5b7damr1634875137.1.1794427637131;
        Wed, 11 Nov 2026 12:07:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm4954449137.0.2026.11.11.12.07.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:07:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v10 07/11] emulator: Add HDT support to bthost
Date: Wed, 11 Nov 2026 15:07:00 -0500
Message-ID: <20261111200705.3802779-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
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


Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656404534B3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920368; cv=none; b=uNLRG8E1vPfIB4yjWUr6lcJmwDK9kQ69AeWyBV99neL5rd3Q5PyZrgK6sUM1d3SqAEILVrxiWWSbzcTc1aSF5PBI8r508oI1YCjcMh37L12YBFbQ+lgeceLrBmj6Tcn7WGrSTiVW9hwNjUZkk1G5MD0G5YHsvecgAvXzbAWiLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920368; c=relaxed/simple;
	bh=MLZjuYNZyqkx50VDdM339p4qhQugvZlIoak0udhySzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXuS8pNMrulb1aTJeJOGt4LZksERmXmp2hsH+7Nae8amDBX1/1d7MDinXZul4FqGIWXxJFUAMq4wsqZIs3eR0JPoXhIXPvH/AnmvVcgc9dIJ0GOuNK/O+ellgmfmGOI3Okzya1lZQsQ5kL0N2FyAOf+0ylGEQayeALX7RADLlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9juwkFC; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9juwkFC"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so383323137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920366; x=1785525166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LqRERl6cpZzj+460kff+Hz2XjdjVpFhaRa12TdicWj0=;
        b=d9juwkFCpR51vl+CNBa9lBkV38V894FzZ/J/gmYGrJOr/FQ88lOpYVCcIfLRjK+Lq/
         JIU94ATDDjK3LrB1dbsEL2Jerz0DsTBBFamAkzthbnjPRpcfIlkpOYvn29ytQ10TA9Rb
         1LTx3SfIuUtDJ9OAxBsYFgVn+fn6mO6K2o+6C0EffjF9Wa0JmYHAjQcyNUg2OvfDigS5
         BtsPdqojb8tv2FWw5Bn+0NnfbkoQTQd6V7UVlhTQP6+mj8bbi2GMUX+sHliu9pPyVfbq
         sYth7KayatNvYWL9tZXrsngSK9wqpzvonIfTruyLq0ZbQYvRVmZYwtTCUQ/jclu6Uz9e
         QyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920366; x=1785525166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LqRERl6cpZzj+460kff+Hz2XjdjVpFhaRa12TdicWj0=;
        b=s3Hu+ZGuMRMZqmGT3hNI0o+Eo4XgTrl+xJGgzhl6SIQ+KdtllQGIV78RZgpDwtNQOq
         yvCEMhriq1NhA2c8vBoUppsvJkyVYy0pMqpDN5NASq9/hBHs7KolElLPc1ICS/6bv/Nx
         tdq98OKE6sO3CbXbq2W8uI51SkEqseDqK9X2zMk8K6h5q6SQjB3qcDjf8mazoCOeIZG7
         LlsFuEBKa/JkN6Z7qg13JfTNidMtOmk6pc4r15AwlZ8uo62x7AclDRuxSvkx24mFlLAu
         TFHAaD+IUgG3uEfLHFUHq9ySEm/u5v7a8uxWUER/EXPKxDmzV1VA+zvratFZLri08xJr
         1w9w==
X-Gm-Message-State: AOJu0Yy3IOxuLdBHknuRUrMY6TETqzC+S9vMWeMzkAiguL60LKoNwkzz
	iwc4NP+25xpszxlFtVc+AGkoXcawrog9NOoPlsm0CtSRKYOX18u97oOFfGM2c1Ex
X-Gm-Gg: AR+sD10QIKlYReuQFFjF7fAfpyZJxELWymdkELUzWQEKNk7tnOLT0KAtEKURUFfSbWn
	H+DvJsOERdv6RRbFRsalwtvM9AGidtZVj6h/RfGIdL61iAc8L5t550edYVCTQRuUOv3f9soyYiO
	ROg2btX7lwQJ0xpdgUK3Y5QnL1R/XOwF8GN60LUcVVzs4KBfqWmLh6GdOEuqIbvpAgtQiBMKIOb
	NhFQudKoGAJqWOwjtCNqRkCTV/NMDeBkW9q5aRzyRPZaDRi7qE1GtzXLoqmp8IMeo6+/sMKl44G
	a/rKF160s0hU8H8fZrw+ZAwfhRRiJbJ7KLlF6BTnwUL9w80uPLDnLXrisK2BflPr2MDfcHznaxu
	ovowej0fmZzN84Im8+2sVnnP2kzu8bTAgIQoFn1JZWBpZT+O+FuLrXGr1RhJmpZC6IFGTitiHra
	EVUaDFolhSYud0fkJM2chpNX3bXBcZlEASOTcIDmWK7xP97UIakRWeaT3zYAVn+rT0OGQLXngG
X-Received: by 2002:a05:6102:5128:b0:631:ff40:22b5 with SMTP id ada2fe7eead31-74d602e61bbmr4966966137.21.1784920366279;
        Fri, 24 Jul 2026 12:12:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/12] emulator/bthost: Add LE Connection Rate Request support
Date: Fri, 24 Jul 2026 15:12:24 -0400
Message-ID: <20260724191225.1815634-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add bthost_le_conn_rate() to send the LE Connection Rate Request
(0x20a1) command for a given connection handle.

Also handle the LE Connection Rate Change event (0x37).

This allows testing a peripheral (server) handling of the Shorter
Connection Interval feature by having the emulated central initiate
the connection rate request on connect.
---
 emulator/bthost.c | 36 ++++++++++++++++++++++++++++++++++++
 emulator/bthost.h | 14 ++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2732b7f83f8b..46c6a52f5729 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1729,6 +1729,21 @@ static void evt_le_conn_update_complete(struct bthost *bthost, const void *data,
 		return;
 }
 
+static void evt_le_conn_rate_change(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_le_conn_rate_change *ev = data;
+
+	if (len < sizeof(*ev))
+		return;
+
+	if (ev->status)
+		return;
+
+	bthost_debug(bthost, "conn rate change: handle %u subrate %u",
+			le16_to_cpu(ev->handle), le16_to_cpu(ev->subrate));
+}
+
 static void evt_le_remote_features_complete(struct bthost *bthost,
 						const void *data, uint8_t len)
 {
@@ -1963,6 +1978,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT:
 		evt_le_big_info_adv_report(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CONN_RATE_CHANGE:
+		evt_le_conn_rate_change(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -3999,6 +4017,24 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 	send_command(bthost, BT_HCI_CMD_LE_START_ENCRYPT, &cmd, sizeof(cmd));
 }
 
+void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
+					const struct bthost_conn_rate *rate)
+{
+	struct bt_hci_cmd_le_conn_rate cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+	cmd.interval_min = cpu_to_le16(rate->interval_min);
+	cmd.interval_max = cpu_to_le16(rate->interval_max);
+	cmd.subrate_min = cpu_to_le16(rate->subrate_min);
+	cmd.subrate_max = cpu_to_le16(rate->subrate_max);
+	cmd.max_latency = cpu_to_le16(rate->max_latency);
+	cmd.cont_num = cpu_to_le16(rate->cont_num);
+	cmd.supv_timeout = cpu_to_le16(rate->supv_timeout);
+
+	send_command(bthost, BT_HCI_CMD_LE_CONN_RATE, &cmd, sizeof(cmd));
+}
+
 uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
 {
 	struct btconn *conn;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index c88ea0329a65..e104e68af782 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -66,6 +66,20 @@ void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
 
+struct bthost_conn_rate {
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+};
+
+/* Send LE Connection Rate Request for the given connection handle. */
+void bthost_le_conn_rate(struct bthost *bthost, uint16_t handle,
+					const struct bthost_conn_rate *rate);
+
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason);
 
-- 
2.54.0


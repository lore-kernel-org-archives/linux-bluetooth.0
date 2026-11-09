Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240970;
	b=gyLFrIvnzI6sb7Vks3qVsNG+fy7xwKQmRk31uFR0T6K8Wy1iwqc7A0+UjVy9SXN79P1d
	 hiJiYFMZmWaZvqjR/P96LIh2mL5PnxzI1FIQf4l+db/cAS/9MlMJet6hOS12gBzakR6zf
	 U19WPEOjraQ5m+bEOkSwjHgYpvEv/3ax4pJG0tZZ8bursFXXiD9Q2t08zL4td0TmknbSc
	 oqbje60V8IEmGmIHXi5bxOwceEtaiLaRKcs2gpEPPnQNOxV8DMmv3Z4/YAq9kMgxZIhob
	 JrCCgtyWJO5/mMpaGLtANlYbMekN4vZPWy7Qc6Epz7aidBOaABEiHRJYkztNxw02BeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+6W7eHv4VNyh54viLGAArNlXhahR/uqc6SCw6Cf4E0=;
	b=bWsQkGdONVSZT7s3q2h5IpABeuBIreBxFPzG1lJvQ0qBQ1EG4tT2C3lPHc50RZ7rZs2z
	 nMhofqCPnwU7BIqs8tMT3D0xKoDHgr5RO8hbsgZLgFQ5B6zklUpuMoHl2q41LhfTQ6TEg
	 gq3SaMYJHy2VXonEONjKFNIXCaLFp3FbM8epXmMQpUDq/frP7nnnJX2fw1ThEhr9grMjj
	 acn+PE2MsNxpQhEec161dYpOnbC9ff1ezpOkHMaz4P52m2QFXL2e3Vz63kqFn9THON90S
	 W9E/PL70H/bfAJ3QXTRtWmURH/9bIB/TTwwVanNQYmwhQFwCXuSYgWCCJOTANpv1I6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krWhVbq4;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B775606A331
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B775606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krWhVbq4
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso536679e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240969; x=1794845769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B+6W7eHv4VNyh54viLGAArNlXhahR/uqc6SCw6Cf4E0=;
        b=krWhVbq4soHDJ8PthWxWC3z2tx50q/I2JN9BpIFUmNbdQ/Z2USrBsF5IBLVUTHSxzz
         IaCkJzli5PBxStJBYR6aNWtMUrmHGTjZl331dx1NjtL9giZVDHsdJ9P7DMxt8Oi/9/xs
         ZhRZeUAztz9f0e/2aeO/VVzt6TS4HIoZDxL317P0VQE15X1vZ7p5rAFqw9sI1rluP/Qo
         uUmDkzLszbft7mN7kceD3YAkOST+nIo44LuyFb05ov1BKY8P0rrvusIz+UIIIfjIwQ+8
         SIcoAjO+On0QyWGvZNxaBzZBK9ONcVlD1kgx0RGmjYGmFrd4Ixf45kJgQdZ5vFqgem3G
         ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240969; x=1794845769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B+6W7eHv4VNyh54viLGAArNlXhahR/uqc6SCw6Cf4E0=;
        b=EbcglP0tcJOod6CVpARuR+ENr5MU7LeB7DabiqbPXjoLQAyhIr47MTNUblIiVDUrat
         JRS0gMQdWpW5UjP+rnskakXspbIH4UXOojmXirMExUpiV4BWl/BkjDW6Nw86ZrbUU4AI
         0YYaHlWzt6ywImzhRKAlmO33qvnV1H8o3mQy41LN8cNSbg872U+ISAJ66Gdu1ZIgjydG
         9VEgcDudUFSEQX5/lADycscIo3Qc5wP86zcAzqp7cNdxm/iR03vLyH+qUJtZTvLp1UNM
         zHu2HVUcDcQ2dTR+d3RKs5ZByuddibc9NyrIx604XsSyFzJXRfCuKUVk+NTpEBf7U2pt
         9rmA==
X-Gm-Message-State: APuU4Z9ECCDm2PG0KBmW4qEAjDP09GOiGXb1fPVmvkkFuBwET4T6Pd4G
	uxVs3vI6auv7NR2pV55IafzznXrgKzjb/8oT4nyv2Mfb5NQFah/p4jAOHnOLhA==
X-Gm-Gg: AYBFou17F8qMA0ff9c+AEtUEv8pgk4LEgdBYQe/P5rT2YTTnIl5YLfbasfYZuMhL4o8
	qIL82kZRwWVCfUzBXznsh7QxTLD6+sIM6rgHLv79z5fLoq85SKQY9mQX6wy4E8duzajLxpEPq0t
	fZhwEd0i5lxIfMu0Sq2HFHpgKyu5hfaXrDLfSYgF6mZkcAwVNd00E2l3a17g+aKdLgRCVWVw23y
	rVUGqOL7FIJrB/p2ld32Qt4fDubs4raAAk11KYDykHa2Zah9Gmsd1TgpK4OC6TW2fhXk9/uxJbo
	Oj1a0qIol4RBmXyTeZ1U7+fETR88RV+uLFX1CAQxEgmJgbQcdI9yZkMoYg8fMHOdounEZY12EE8
	cem/SSikltpjMhIARmeGKxXq2tCSkqlR7K/xidzBoLjyjyCivj4cpkgV9/Zu00Om5CeYzabBLdl
	QEsdJKLn1bXigf8OwKQ3MWoCt002zFP7JOV3hZ1V68sluEJ+x159CRI1XlvFv/rp9gZj8llY0n9
	k2YOo78V9qcUyQiet3zWUj6ZG1g77XcMa02rJG2Cer74qQX2DQ3AK5Zdm7AL6n0F8EDU402+4NF
	zTJYpN3Fh1KI0ZOhp9jJNmtj1FX7oVjEEX9TrZoPK5QHzsGXRll+zOtw5eQ9bnTWXtFaxsX+Rek
	UqUzV234AgG040XXAXCPkEgSm7Ec1DlOy0lGFUwfT8CmXanZQ3E1LTUjenzzLeS7tfoE5ofONPu
	3k9wA=
X-Received: by 2002:a05:6122:1d13:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ece7369d8fmr1625790e0c.21.1794240968672;
        Mon, 09 Nov 2026 08:16:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.16.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:16:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 08/11] shared/gatt: Add MIC length permission checks
Date: Mon,  9 Nov 2026 11:15:48 -0500
Message-ID: <20261109161553.1506041-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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

Add read and write MIC length permissions for 64-bit and 128-bit MICs,
take the MIC length of the link from the BT_SECURITY socket option, and
reject access with MIC Length Too Short when the link uses a shorter
one. Expose the permissions as GATT characteristic and descriptor flags
over D-Bus, and add bluetoothctl scripts exercising them.

A MIC length requirement implies the link is encrypted, so without
encryption the error is Insufficient Encryption, which lets the client
encrypt the link, and the minimum key size is checked before the MIC
length, as the spec orders them.
---
 client/scripts/gatt-mic-128.bt       |   5 +
 client/scripts/gatt-mic-64-128.bt    |   7 ++
 client/scripts/gatt-mic-64.bt        |   5 +
 doc/org.bluez.GattCharacteristic.rst |   4 +
 doc/org.bluez.GattDescriptor.rst     |   4 +
 src/gatt-database.c                  |  26 +++++
 src/shared/att-types.h               |  17 +++-
 src/shared/att.c                     |  39 ++++++++
 src/shared/att.h                     |   3 +
 src/shared/gatt-db.c                 |   9 ++
 src/shared/gatt-db.h                 |   3 +
 src/shared/gatt-server.c             |  60 +++++++++++-
 unit/test-gatt.c                     | 140 +++++++++++++++++++++++++++
 13 files changed, 317 insertions(+), 5 deletions(-)
 create mode 100644 client/scripts/gatt-mic-128.bt
 create mode 100644 client/scripts/gatt-mic-64-128.bt
 create mode 100644 client/scripts/gatt-mic-64.bt

diff --git a/client/scripts/gatt-mic-128.bt b/client/scripts/gatt-mic-128.bt
new file mode 100644
index 000000000000..9d566ae5bf9c
--- /dev/null
+++ b/client/scripts/gatt-mic-128.bt
@@ -0,0 +1,5 @@
+gatt.register-service 12345678-1234-5678-1234-56789abcdef0
+yes
+gatt.register-characteristic 12345678-1234-5678-1234-56789abcdef2 mic-128-read,mic-128-write
+01 02 03 04
+gatt.register-application
diff --git a/client/scripts/gatt-mic-64-128.bt b/client/scripts/gatt-mic-64-128.bt
new file mode 100644
index 000000000000..f4e595165e71
--- /dev/null
+++ b/client/scripts/gatt-mic-64-128.bt
@@ -0,0 +1,7 @@
+gatt.register-service 12345678-1234-5678-1234-56789abcdef0
+yes
+gatt.register-characteristic 12345678-1234-5678-1234-56789abcdef1 mic-64-read,mic-64-write
+01 02 03 04
+gatt.register-characteristic 12345678-1234-5678-1234-56789abcdef2 mic-128-read,mic-128-write
+05 06 07 08
+gatt.register-application
diff --git a/client/scripts/gatt-mic-64.bt b/client/scripts/gatt-mic-64.bt
new file mode 100644
index 000000000000..b79717ae2534
--- /dev/null
+++ b/client/scripts/gatt-mic-64.bt
@@ -0,0 +1,5 @@
+gatt.register-service 12345678-1234-5678-1234-56789abcdef0
+yes
+gatt.register-characteristic 12345678-1234-5678-1234-56789abcdef1 mic-64-read,mic-64-write
+01 02 03 04
+gatt.register-application
diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index 805f39593903..6dd5d44c04cf 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -382,6 +382,10 @@ Possible values:
 :"secure-write" (Server only):
 :"secure-notify" (Server only):
 :"secure-indicate" (Server only):
+:"mic-64-read" (Server only):
+:"mic-64-write" (Server only):
+:"mic-128-read" (Server only):
+:"mic-128-write" (Server only):
 :"authorize":
 
 uint16 Handle [read-only] (Client Only)
diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index 790a5482d080..425d9becf635 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -160,6 +160,10 @@ Possible values:
 :"encrypt-authenticated-write":
 :"secure-read" (Server Only):
 :"secure-write" (Server Only):
+:"mic-64-read" (Server Only):
+:"mic-64-write" (Server Only):
+:"mic-128-read" (Server Only):
+:"mic-128-write" (Server Only):
 :"authorize":
 
 uint16 Handle [read-only] (Client Only)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d8e45581a138..cbee49d59f55 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1799,6 +1799,21 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 		} else if (!strcmp("secure-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
+		} else if (!strcmp("mic-64-read", flag)) {
+			*props |= BT_GATT_CHRC_PROP_READ;
+			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_MIC_LEN_64;
+		} else if (!strcmp("mic-64-write", flag)) {
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+			*perm |= BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_MIC_LEN_64;
+		} else if (!strcmp("mic-128-read", flag)) {
+			*props |= BT_GATT_CHRC_PROP_READ;
+			*perm |= BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_MIC_LEN_128;
+		} else if (!strcmp("mic-128-write", flag)) {
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+			*perm |= BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_MIC_LEN_128;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
 		} else if (!strcmp("encrypt-notify", flag)) {
@@ -1860,6 +1875,17 @@ static bool parse_desc_flags(DBusMessageIter *array, uint32_t *perm,
 			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_SECURE;
 		else if (!strcmp("secure-write", flag))
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
+		else if (!strcmp("mic-64-read", flag))
+			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_MIC_LEN_64;
+		else if (!strcmp("mic-64-write", flag))
+			*perm |= BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_MIC_LEN_64;
+		else if (!strcmp("mic-128-read", flag))
+			*perm |= BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_MIC_LEN_128;
+		else if (!strcmp("mic-128-write", flag))
+			*perm |= BT_ATT_PERM_WRITE |
+						BT_ATT_PERM_WRITE_MIC_LEN_128;
 		else if (!strcmp("authorize", flag))
 			*req_prep_authorization = true;
 		else {
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 69f45b6aa6d7..687ebf66cafa 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -98,6 +98,7 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
 #define BT_ATT_ERROR_DB_OUT_OF_SYNC			0x12
 #define BT_ATT_ERROR_VALUE_NOT_ALLOWED			0x13
+#define BT_ATT_ERROR_MIC_LEN_TOO_SHORT			0x14
 
 /*
  * Common Profile and Service Error Code descriptions (see Supplement to the
@@ -131,14 +132,26 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_PERM_WRITE_SECURE	0x0200
 #define BT_ATT_PERM_SECURE		(BT_ATT_PERM_READ_SECURE | \
 					BT_ATT_PERM_WRITE_SECURE)
+#define BT_ATT_PERM_READ_MIC_LEN_64	0x0400
+#define BT_ATT_PERM_READ_MIC_LEN_128	0x0800
+#define BT_ATT_PERM_WRITE_MIC_LEN_64	0x1000
+#define BT_ATT_PERM_WRITE_MIC_LEN_128	0x2000
+#define BT_ATT_PERM_MIC_LEN_64		(BT_ATT_PERM_READ_MIC_LEN_64 | \
+					BT_ATT_PERM_WRITE_MIC_LEN_64)
+#define BT_ATT_PERM_MIC_LEN_128	(BT_ATT_PERM_READ_MIC_LEN_128 | \
+					BT_ATT_PERM_WRITE_MIC_LEN_128)
 #define BT_ATT_PERM_READ_MASK		(BT_ATT_PERM_READ | \
 					BT_ATT_PERM_READ_AUTHEN | \
 					BT_ATT_PERM_READ_ENCRYPT | \
-					BT_ATT_PERM_READ_SECURE)
+					BT_ATT_PERM_READ_SECURE | \
+					BT_ATT_PERM_READ_MIC_LEN_64 | \
+					BT_ATT_PERM_READ_MIC_LEN_128)
 #define BT_ATT_PERM_WRITE_MASK		(BT_ATT_PERM_WRITE | \
 					BT_ATT_PERM_WRITE_AUTHEN | \
 					BT_ATT_PERM_WRITE_ENCRYPT | \
-					BT_ATT_PERM_WRITE_SECURE)
+					BT_ATT_PERM_WRITE_SECURE | \
+					BT_ATT_PERM_WRITE_MIC_LEN_64 | \
+					BT_ATT_PERM_WRITE_MIC_LEN_128)
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
diff --git a/src/shared/att.c b/src/shared/att.c
index 80b415540ee6..1ab7497d83f8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -63,6 +63,7 @@ struct bt_att {
 	bool close_on_unref;
 	struct queue *chans;
 	uint8_t enc_size;
+	uint8_t mic_len;
 	uint16_t mtu;			/* Biggest possible MTU */
 
 	struct queue *notify_list;	/* List of registered callbacks */
@@ -2133,6 +2134,44 @@ void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size)
 	att->enc_size = enc_size;
 }
 
+static uint8_t bt_att_chan_get_mic_len(struct bt_att_chan *chan)
+{
+	struct bt_security sec;
+	socklen_t len;
+
+	if (chan->type == BT_ATT_LOCAL)
+		return chan->att->mic_len;
+
+	memset(&sec, 0, sizeof(sec));
+	len = sizeof(sec);
+	if (getsockopt(chan->fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
+		return 0;
+
+	return sec.mic_len;
+}
+
+uint8_t bt_att_get_mic_len(struct bt_att *att)
+{
+	struct bt_att_chan *chan;
+
+	if (!att)
+		return 0;
+
+	chan = queue_peek_tail(att->chans);
+	if (!chan)
+		return 0;
+
+	return bt_att_chan_get_mic_len(chan);
+}
+
+void bt_att_set_mic_len(struct bt_att *att, uint8_t mic_len)
+{
+	if (!att)
+		return;
+
+	att->mic_len = mic_len;
+}
+
 static bool sign_set_key(struct sign_info **sign, uint8_t key[16],
 				bt_att_counter_func_t func, void *user_data)
 {
diff --git a/src/shared/att.h b/src/shared/att.h
index 5b5cd4fbab2c..4bee694e4352 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -116,6 +116,9 @@ int bt_att_get_security(struct bt_att *att, uint8_t *enc_size);
 bool bt_att_set_security(struct bt_att *att, int level);
 void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size);
 
+uint8_t bt_att_get_mic_len(struct bt_att *att);
+void bt_att_set_mic_len(struct bt_att *att, uint8_t mic_len);
+
 bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
 bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 23c705bd9d16..2384c5fc8135 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -2180,6 +2180,15 @@ gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib)
 	return attrib->permissions;
 }
 
+void gatt_db_attribute_set_permissions(struct gatt_db_attribute *attrib,
+							uint32_t permissions)
+{
+	if (!attrib)
+		return;
+
+	attrib->permissions = permissions;
+}
+
 static bool read_timeout(void *user_data)
 {
 	struct pending_read *p = user_data;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 5e7e7203fcc3..8640768850fd 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -265,6 +265,9 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 uint32_t
 gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib);
 
+void gatt_db_attribute_set_permissions(struct gatt_db_attribute *attrib,
+							uint32_t permissions);
+
 bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
 						uint16_t len);
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 15944bd1478f..d589d0a5742f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -189,7 +189,11 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 	iov->iov_len = length;
 }
 
-static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
+static uint8_t check_permissions(struct bt_gatt_server *server,
+				struct gatt_db_attribute *attr, uint32_t mask);
+
+static bool encode_read_by_grp_type_rsp(struct bt_gatt_server *server,
+						struct queue *q,
 						struct bt_att *att,
 						uint16_t mtu, uint8_t *pdu,
 						uint16_t *len)
@@ -204,6 +208,21 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 	while (queue_peek_head(q)) {
 		struct gatt_db_attribute *attrib = queue_pop_head(q);
 
+		/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part F,
+		 * Section 3.4.4.9:
+		 *
+		 * If an attribute in the set of requested attributes would
+		 * cause an ATT_ERROR_RSP PDU then this attribute cannot be
+		 * included in an ATT_READ_BY_GROUP_TYPE_RSP PDU and the
+		 * attributes before this attribute shall be returned.
+		 *
+		 * So stop before a service the link does not have the
+		 * security to read, the caller reports it if it is the first
+		 * one.
+		 */
+		if (check_permissions(server, attrib, BT_ATT_PERM_READ_MASK))
+			break;
+
 		value.iov_base = NULL;
 		value.iov_len = 0;
 
@@ -320,13 +339,27 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part F,
+	 * Section 3.4.4.9:
+	 *
+	 * If the first attribute in the set of requested attributes would
+	 * cause an ATT_ERROR_RSP PDU then no other attributes in the
+	 * requested attributes can be considered.
+	 */
+	ecode = check_permissions(server, queue_peek_head(q),
+							BT_ATT_PERM_READ_MASK);
+	if (ecode) {
+		ehandle = gatt_db_attribute_get_handle(queue_peek_head(q));
+		goto error;
+	}
+
 	rsp_pdu = malloc(mtu);
 	if (!rsp_pdu) {
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
-	if (!encode_read_by_grp_type_rsp(server->db, q, server->att, mtu,
+	if (!encode_read_by_grp_type_rsp(server, q, server->att, mtu,
 							rsp_pdu, &rsp_len)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
@@ -452,7 +485,9 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
 	}
 
-	if (perm & BT_ATT_PERM_ENCRYPT) {
+	/* A MIC length requirement implies the link is encrypted, see below */
+	if (perm & (BT_ATT_PERM_ENCRYPT | BT_ATT_PERM_MIC_LEN_64 |
+						BT_ATT_PERM_MIC_LEN_128)) {
 		if (security < BT_ATT_SECURITY_MEDIUM)
 			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION;
 
@@ -460,6 +495,25 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part F,
+	 * Section 3.2.5:
+	 *
+	 * If access to a secure attribute requires an encrypted link, and
+	 * the link is encrypted with an encryption key size that is long
+	 * enough but a MIC length that is too short for the level of
+	 * security required, then an ATT_ERROR_RSP PDU shall be sent with
+	 * the Error Code parameter set to MIC Length Too Short (0x14).
+	 */
+	if (perm & (BT_ATT_PERM_READ_MIC_LEN_128 |
+					BT_ATT_PERM_WRITE_MIC_LEN_128)) {
+		if (bt_att_get_mic_len(server->att) < 0x02)
+			return BT_ATT_ERROR_MIC_LEN_TOO_SHORT;
+	} else if (perm & (BT_ATT_PERM_READ_MIC_LEN_64 |
+					BT_ATT_PERM_WRITE_MIC_LEN_64)) {
+		if (bt_att_get_mic_len(server->att) < 0x01)
+			return BT_ATT_ERROR_MIC_LEN_TOO_SHORT;
+	}
+
 	return 0;
 }
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 267bcc61802e..197890df4335 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2013,6 +2013,27 @@ static void test_server(gconstpointer data)
 	g_free(pdu.data);
 }
 
+/* The MIC length is only checked on an encrypted link with a long enough key,
+ * which the tests of the MIC length have to start with.
+ */
+static void test_server_encrypted(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+	ssize_t len;
+	const struct test_pdu pdu = SERVER_MTU_EXCHANGE_PDU;
+
+	g_assert(bt_att_set_security(context->att, BT_ATT_SECURITY_MEDIUM));
+	bt_att_set_enc_key_size(context->att, 16);
+
+	len = write(context->fd, pdu.data, pdu.size);
+
+	g_assert_cmpint(len, ==, pdu.size);
+
+	tester_monitor('<', 0x0004, 0x0000, pdu.data, len);
+
+	g_free(pdu.data);
+}
+
 static void test_search_primary(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -2657,10 +2678,46 @@ static void test_hash_db(gconstpointer data)
 	context_quit(context);
 }
 
+/*
+ * Test database for MIC length validation:
+ * Primary service at handle 0x0001 with 4 handles.
+ * Characteristic at handle 0x0003 (value handle) with read/write permissions
+ * requiring 128-bit MIC length.
+ * Service declaration also has MIC length permission for Read By Group Type.
+ */
+static struct gatt_db *make_mic_len_db(void)
+{
+	const struct att_handle_spec specs[] = {
+		PRIMARY_SERVICE(0x0001, GAP_UUID, 4),
+		CHARACTERISTIC(GATT_CHARAC_DEVICE_NAME,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE |
+				BT_ATT_PERM_READ_MIC_LEN_128 |
+				BT_ATT_PERM_WRITE_MIC_LEN_128,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_WRITE,
+				0x01, 0x02, 0x03),
+		{ }
+	};
+	struct gatt_db *db;
+	struct gatt_db_attribute *attr;
+
+	db = make_db(specs);
+
+	/* Set MIC length permission on the service declaration for
+	 * Read By Group Type test.
+	 */
+	attr = gatt_db_get_attribute(db, 0x0001);
+	gatt_db_attribute_set_permissions(attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_MIC_LEN_128);
+
+	return db;
+}
+
 int main(int argc, char *argv[])
 {
 	struct gatt_db *service_db_1, *service_db_2, *service_db_3;
 	struct gatt_db *ts_small_db, *ts_large_db_1, *ts_tail_db;
+	struct gatt_db *mic_len_db;
 
 	tester_init(&argc, &argv);
 
@@ -2670,6 +2727,7 @@ int main(int argc, char *argv[])
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
 	ts_tail_db = make_test_tail_db();
+	mic_len_db = make_mic_len_db();
 
 	/*
 	 * Server Configuration
@@ -4957,5 +5015,87 @@ int main(int argc, char *argv[])
 			test_hash_db, ts_tail_db, NULL,
 			{});
 
+	/*
+	 * MIC Length Too Short
+	 *
+	 * Verify that the server rejects requests with error 0x14
+	 * (MIC Length Too Short) when the connection MIC length is
+	 * insufficient for the attribute's requirement.
+	 */
+
+	/* Read By Type Request */
+	define_test_server("/robustness/mic-len/read-by-type",
+			test_server_encrypted,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x00, 0x2a),
+			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x14));
+
+	/* Read Request */
+	define_test_server("/robustness/mic-len/read",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x14));
+
+	/* Read Blob Request */
+	define_test_server("/robustness/mic-len/read-blob",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x14));
+
+	/* Read Multiple Request */
+	define_test_server("/robustness/mic-len/read-multiple",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x14));
+
+	/* Read Multiple Variable Request */
+	define_test_server("/robustness/mic-len/read-multiple-variable",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x20, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x20, 0x03, 0x00, 0x14));
+
+	/* Write Request */
+	define_test_server("/robustness/mic-len/write",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01),
+			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x14));
+
+	/* Prepare Write Request */
+	define_test_server("/robustness/mic-len/prepare-write",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01),
+			raw_pdu(0x01, 0x16, 0x03, 0x00, 0x14));
+
+	/* Read By Group Type Request */
+	define_test_server("/robustness/mic-len/read-by-group-type",
+			test_server_encrypted, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0x04, 0x00, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x14));
+
+	/*
+	 * A MIC length requirement implies the link is encrypted, so without
+	 * encryption the error is Insufficient Encryption (0x0f), which lets
+	 * the client encrypt the link, not MIC Length Too Short.
+	 */
+	define_test_server("/robustness/mic-len/read-unencrypted", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x0f));
+
+	define_test_server("/robustness/mic-len/write-unencrypted", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01),
+			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x0f));
+
 	return tester_run();
 }
-- 
2.56.0


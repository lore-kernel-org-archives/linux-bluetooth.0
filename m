Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898764;
	b=2hPKHjzqkkVgnsF6J0TOyj+0Gh0rT/F+F2Yk36PHGCFFq+WsarUPXadmyNo/F7+i1WyL
	 sY/YfrRmz34Vv35qc4d5P5KPfJ2AxKiKfxso5dsV3wqD2iyH/MYCB1jSxG2pkGCYmW9fg
	 5Xbww2XWYsYDxqaYdaQ9MPboTIxLI815pmzDIRoRc5VSU71ngpMcoyZpofI5tMPRt1TY+
	 VtwoHcuSl0KUSO1nohRxqNDRWTbCoc6DyvPfq0/wct5yQN7iwSLXZp2rZaMb4umRXkIKw
	 aPUMFAwzzCS8vD2seQ8XPcdE9IkFObO9vv02pvc+9uJqdHRJWdxAd4sqXIb2WZDGFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W6pndCRh6VT+caRvv24reZ7kLIUq9vNVipxzYTtwJbM=;
	b=zhSwmRyU6jmOIuoUpP4DOp+X4JdiosamL2vv7pLiMmFWrFqr2/sx5WmqgwTNC2FjKWQh
	 J6A4ynypSGUTvvasWzHIE3yf5+6gQY3l7sq22jGO3bCu+Abpkm/mvSdyzy2YxNSkdKVTH
	 brtGAX0Z9UR0PGo5gapE2TIJoymfemTqNK4GFsGURdZgSleiSoriPGS3FMSOM4ZJFIAML
	 uwn5QoKUkVrUDWkZtDQe5Hag7ELsmcIiXeBlh45tIkVExCk56IYEHa/TI8VIzj6kzNpDq
	 rNxVSr9DFyD8d/TEU6CzWMq8Inq2BXWKlB1w/VMwDAKUxRBoXEhSMIcxnfMY5U3JToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcuwc2j1;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4DC606D809
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA4DC606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcuwc2j1
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso683066137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898763; x=1794503563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W6pndCRh6VT+caRvv24reZ7kLIUq9vNVipxzYTtwJbM=;
        b=vcuwc2j1Ib4EjM9MtKQAJZR/Noj5KdTYYtoQ/q3XXghY+JjK2ugeLYWZdG6Luxps6G
         fVNjtc0jr/wEYZUv/QGZQ25xiImeB8ZDoe42FWoO40zz5QTxfOFQvayiBlYgj2dbb5+s
         cxPbHd85y1rDOdPtxNwCIci0oxVbvvFYgCSv8ltBBCxJRnM29zQRB4nnm91GucWycO1j
         zRaAs4+mDIZpEn9+1MvetJejuwzMxQg96JdvnpjtczyX1LQVqQ/hF9zO/D+NJ17G/GxP
         Oc2i0/ywigbQDE/RsIpt1VcZlrFqV/ZbWgkY8vQexnZ1ODOvryhjjdhsCwZZeuDeXi6L
         qdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898763; x=1794503563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W6pndCRh6VT+caRvv24reZ7kLIUq9vNVipxzYTtwJbM=;
        b=PNc06+FvgUrZrRqvxlsf2+7+4qr49iV+cBKqboJPiRWaP6xXKOXEjMBFcaCWMrkwZW
         IrI7ZoZa4ns6N18Zwr/DpyVTZ6ZFXuhI+EyB4n+XwKQ4lCHH6coCGEPgcf8MY+DUUBd3
         RX/j9P+k1mIgvGhlGLRzKgv2ryeT3OHUttnJ75jQWlbzOKPBgF3smcGSkQCdDEFIhrO4
         zjZBy/s5mF8vBN+5GC1bltk+vh+4JC7pXoyEO8AIE6JXwv6lFkKXlvFDm3VuP8tdxP0D
         q2CZ8MzvGmkSnQDdhmWzLh5z3Xo9vH/sA2lhmDqSJBR8eakvWYyOGlUKCZbaOaq4bZcN
         30VA==
X-Gm-Message-State: APuU4Z+dub9VU4eBb5Pgb8+3wzLwet/PddYm2/M1v1dTHbqQ5r4kVxPy
	G1qsthY43oy7feYiPKbT8EYmj6bl71oxhnbJ78zsZcN2Bm5BGMezywW8321DjA==
X-Gm-Gg: AYBFou1Jj1BqV9hjM5kk4/E/FdokQXqVCI3JVsmJN6YxULk0apKBWNPDtKdCndwgVNk
	h+JM1rjsKbbuwM6ac3R9R20bmOx8dXoUCMsRH0yyNOtQZaYrMNhfVIjRjCu82EfuLcnLoZt9115
	HeNBqpP/uWkwYqLKa/oYCc+wKDr/5D1j0+7yxhY4KnAIhAZ3XTBaEfQmZIGNb2+6DIZw/67t+QM
	c1l2rA2BqMJfZGbTIWeTuTWbZBrZBrcU79JrJLU291Tev20mbFlVfKXR/tprNte3+YJNnGiQiMC
	aFx2O00aOiy6s+Ye/FYia21GxFU5GmGRwGDkxNQWkmgp/V2m++rDlwIMFH6meYj5kR/sDnVUu3L
	jF0kXa9LVBcWyTVXNSyu9qaNZEUrAbvgkmB9tM7VGTCImXPbEKC9FisRtcMUBLZXEhmXOJ7w3F2
	WNs5n/ahR0axQNruRKxOfcbmMvXfVbLC1mapsU7W6V6XtjaBSGxFGYO7ecN/bkNJ6dePbOjd/yX
	yCVdkiLvszrVG/S420QqsEDBtRsqVbaoljJca/VYp+E6kzNm6MZl1mbBlcdguIGk7yHdI+0TxpY
	MZS9AoX80GZJ+HftMvE4h2HtgqzBnbhGYFizRsFePfC+J0HIMqrCioWJGZHeQHwQfN7YPB8+4zP
	HDwj68cVi2hNwDn/sVyBKI9xYReqPETZ4TB20viAwj4aZEXwZcx1ZvVEnjNB5ivpLgQJRuHlsz6
	l0MrVK2JT8fAu0jqkzsCKRx/tr
X-Received: by 2002:a05:6102:c46:b0:7d0:5688:f511 with SMTP id ada2fe7eead31-7d2a1593628mr161262137.16.1793898762461;
        Thu, 05 Nov 2026 09:12:42 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 08/11] shared/gatt: Add MIC length permission checks
Date: Thu,  5 Nov 2026 12:12:20 -0500
Message-ID: <20261105171229.2053802-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105171229.2053802-1-luiz.dentz@gmail.com>
References: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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
---
 client/scripts/gatt-mic-128.bt       |   5 ++
 client/scripts/gatt-mic-64-128.bt    |   7 ++
 client/scripts/gatt-mic-64.bt        |   5 ++
 doc/org.bluez.GattCharacteristic.rst |   4 ++
 doc/org.bluez.GattDescriptor.rst     |   4 ++
 src/gatt-database.c                  |  26 +++++++
 src/shared/att-types.h               |  17 ++++-
 src/shared/att.c                     |  39 +++++++++++
 src/shared/att.h                     |   3 +
 src/shared/gatt-db.c                 |   9 +++
 src/shared/gatt-db.h                 |   3 +
 src/shared/gatt-server.c             |  33 ++++++++-
 unit/test-gatt.c                     | 101 +++++++++++++++++++++++++++
 13 files changed, 252 insertions(+), 4 deletions(-)
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
index 279a750ae863..296e19014d70 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -63,6 +63,7 @@ struct bt_att {
 	bool close_on_unref;
 	struct queue *chans;
 	uint8_t enc_size;
+	uint8_t mic_len;
 	uint16_t mtu;			/* Biggest possible MTU */
 
 	struct queue *notify_list;	/* List of registered callbacks */
@@ -2130,6 +2131,44 @@ void bt_att_set_enc_key_size(struct bt_att *att, uint8_t enc_size)
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
index 15944bd1478f..84cfa094bfb0 100644
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
@@ -204,6 +208,12 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 	while (queue_peek_head(q)) {
 		struct gatt_db_attribute *attrib = queue_pop_head(q);
 
+		/* Stop before a service the link does not have the security
+		 * to read, the caller reports it if it is the first one.
+		 */
+		if (check_permissions(server, attrib, BT_ATT_PERM_READ_MASK))
+			break;
+
 		value.iov_base = NULL;
 		value.iov_len = 0;
 
@@ -320,13 +330,21 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}
 
+	/* Check permissions on the first attribute */
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
@@ -460,6 +478,17 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 			return BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE;
 	}
 
+	/* Check MIC length requirements */
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
index 6d6d0c73ed40..e9dd5eee2ee7 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2476,10 +2476,46 @@ static void test_hash_db(gconstpointer data)
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
 
@@ -2489,6 +2525,7 @@ int main(int argc, char *argv[])
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
 	ts_tail_db = make_test_tail_db();
+	mic_len_db = make_mic_len_db();
 
 	/*
 	 * Server Configuration
@@ -4658,5 +4695,69 @@ int main(int argc, char *argv[])
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
+	define_test_server("/robustness/mic-len/read-by-type", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x00, 0x2a),
+			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x14));
+
+	/* Read Request */
+	define_test_server("/robustness/mic-len/read", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x14));
+
+	/* Read Blob Request */
+	define_test_server("/robustness/mic-len/read-blob", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0x14));
+
+	/* Read Multiple Request */
+	define_test_server("/robustness/mic-len/read-multiple", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x14));
+
+	/* Read Multiple Variable Request */
+	define_test_server("/robustness/mic-len/read-multiple-variable",
+			test_server, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x20, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x20, 0x03, 0x00, 0x14));
+
+	/* Write Request */
+	define_test_server("/robustness/mic-len/write", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01),
+			raw_pdu(0x01, 0x12, 0x03, 0x00, 0x14));
+
+	/* Prepare Write Request */
+	define_test_server("/robustness/mic-len/prepare-write", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01),
+			raw_pdu(0x01, 0x16, 0x03, 0x00, 0x14));
+
+	/* Read By Group Type Request */
+	define_test_server("/robustness/mic-len/read-by-group-type",
+			test_server, mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0x04, 0x00, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x14));
+
 	return tester_run();
 }
-- 
2.56.0


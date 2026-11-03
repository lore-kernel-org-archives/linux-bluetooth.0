Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744399;
	b=SK/MX86SbDhpA+0ncBUMyYsiS1sqeewvd8tCWkkIbqv+FJEn6pi90OD+uSKLWoec6MYI
	 repR3iCZATrSe9RWFEsEMEt5sOT2jGRyYIvIsn5rZi07zAPSjfblft99xoXq8V6lPQVfB
	 CrEei3ZxWzo3O1J90SRPB7lhg+7aDhFDDtB6T95wjnJ6Rt+vnL1mSFDyPBE3JWrg4j+fW
	 zkI9pZzhaXOQ+7G7HviGHXEi7krCsOTGb3KsfgrDG3WjnJn5TERmChjPf4l1uFMQMWGpl
	 AWMaKc01CRJZHhjzS258EflSK946IZtx6i+9TVrIuMPVRz2dulx6X1ZtRFSKv8p7m5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wYrTWIS5Gpm9sZexiX6pu2aDTTawoiDF+RfykfWCTLw=;
	b=V7eUZW9BajnU/S5jn2FW5D8/HQLna4zgp59yLdK6RogxzX0r5GyzdmzoRwF2OYsSPz5G
	 P4MI3pEBUzE6xC0+bgh3aRtAev/GIxRnjQyQ8AtoINd0fDKd+4DMg6NzAMQR2nvHhV8WF
	 HWmIt6EuB1jlvqKoVPp5lwgrPb+9AmfEbfzJ1ceyySPn0Xed6ZFCNWjyYlF5rMagKkspz
	 Vb//kWaLlLFWyX3f1/zcLm4TXUZDXFT9IC5aXevfS3PKjg8iaaIWn6xmiBgwnVLknsTXq
	 gcYOFL9RWLVnYWrobPUq/NpYYI91XYkQiq9snxPkOCsQIkJYoV7Bda1Kf5V5u6Q6Stg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QcwPlQXr;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA5606A326
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFA5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QcwPlQXr
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eafb65e163so13070e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744398; x=1794349198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wYrTWIS5Gpm9sZexiX6pu2aDTTawoiDF+RfykfWCTLw=;
        b=QcwPlQXro77yGQWGaKcwgRZydAS13kr8K04vjSJfWx1kc37GXutsHHxTzlcXMCZIP9
         iMx3jkBykwkGogs7OG79SMNw1yow4xYiNOR6e4fLkx6YFF7Y84WKpJiskSyL9EKxmLyP
         IXV+fu6ux0qwxpN0e5bKlS5WB2MqD1w+bvozgTxSC6VJuqE7U76PoRe92r4IowHIl5Gv
         56fYY6O/fLxSHHCelmEQ0ZYIsmFhse8Vb666fDX5cvhnY0QS9208tPj235zO/nLnn5Mf
         Amv6KI7etrJCtuwq6pWSvsl9+GK1AUoSE0uI/FtBJdql9dDrjtiPKj319y0BYwItrYX9
         W7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744398; x=1794349198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wYrTWIS5Gpm9sZexiX6pu2aDTTawoiDF+RfykfWCTLw=;
        b=EaqOAkpaT95zoOObb8Dyy2dGuVQDbWYHRNDVbJ3ZXWsGAdvcv/ZfYrXrjQVwuK+pkV
         5icfnUhnjnmr6CPtSoLUUW3esmuD9ZaIiztZKxQmtduP6L0ZwefRW9oQTj+qigtuALC/
         eY/eSfl+pLjuojxiMpnWeMtP4Ll9EPDvMCM7SJFLF4WxbH0nBpzLsxgtApea/aS/AChi
         LqXxnl1fY3pbkYH7FX4Moq9waKiiyT+0O2a1OcLe9PjURhheNT+ZLCO5hVWr25roxtKs
         guSADza9VOkag63kopcGdtOcSRP2MrRpyykCkD5JWQqhn0UXN/5Gzeu424dM1UuLKESF
         aHQQ==
X-Gm-Message-State: APuU4Z/0md6GhadaD7x+UaUa3lHFvg02fyRY17Udd8UfGPa83YaSh+/x
	xtcnkD/b4DB6w1n0rxeZDHcSUTUyDKxHw1IcjXNE5Ce+ZiGexWeO4C86xphbOA==
X-Gm-Gg: AYBFou2x2u2lLzJ8QTX3jtt5b6elrkgWWb3951bfg2bHy0JHzSF1itc7oIuavknN2Wy
	sreOkAY+PLNR6Qc85z7wukWBp2fU2NX24bfnUDrSM6KrC/1dK/2+pzmtvN6hccNoFPND9DwQYGh
	7XCZqsExMuUAwlsfB5Kw+PGUkrXGotVK0FaDaiTTFvA8C+uNsL8uDVBbyyefZCYQn1+LRXXyL3Q
	7/xL/SeiLq4viDr5DtWYuyM270o05/MRGgeKcwvmtw1bTtrQfzy4blJ+gW3BQwEm9sAfOTqtWbK
	5s9qSTi7SBQwzPC6z/c+n1Kj4Hc7b6J604t+o4jzs8toYK6OcXDNUxyCQAE91NCjKM2lacabM5N
	+ORKZ1vXFPd6VMG8ZNn1B6lnAK0WqPmUIhImXOGUVIdroEH1fYWLT9QkRD0cDTsGcnpxTGk5QuI
	BMPrI2dXgsW1cXzDmfZz51RNP629+2RJaXuIZvupbo9C6525H51GeNnI7AXnZoxars48qDUO0Xq
	rJNRRoYUn3xtBjY8TY3jLGNwooSQdtFPVTiia7FRale8lwKdGLq13vyjnAPxMAedTy5dpSmmnoM
	vNBk5IWdrUZ2/tb2RDARoXSAzh3tza+CK0l2cjOyNPZyr3qVp4w621rgJvZQqxfX7zLnOwIJsQM
	oTGObsf762RD3baXRT+eMBl9wKZGvNebj6W8rG1JRwuOGQzg/RyAO+T3UqURyBUSsjcZnm07BMe
	a4tAA=
X-Received: by 2002:a05:6102:fa0:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d072c3bac2mr6226604137.18.1793744397504;
        Tue, 03 Nov 2026 14:19:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/9] shared/gatt: Add MIC length permission checks
Date: Tue,  3 Nov 2026 17:19:40 -0500
Message-ID: <20261103221944.4072041-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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
 src/shared/gatt-server.c             |  22 ++++++
 unit/test-gatt.c                     | 101 +++++++++++++++++++++++++++
 13 files changed, 243 insertions(+), 2 deletions(-)
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
index 69f45b6aa6d7..79c573238f16 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -98,6 +98,7 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
 #define BT_ATT_ERROR_DB_OUT_OF_SYNC			0x12
 #define BT_ATT_ERROR_VALUE_NOT_ALLOWED			0x13
+#define BT_ATT_ERROR_MIC_LEN_TOO_SHORT			0xDF
 
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
index 15944bd1478f..f09e4987194e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -189,6 +189,9 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 	iov->iov_len = length;
 }
 
+static uint8_t check_permissions(struct bt_gatt_server *server,
+				struct gatt_db_attribute *attr, uint32_t mask);
+
 static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 						struct bt_att *att,
 						uint16_t mtu, uint8_t *pdu,
@@ -320,6 +323,14 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
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
@@ -460,6 +471,17 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
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
index 6d6d0c73ed40..fd3a22684b99 100644
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
+			raw_pdu(0x01, 0x08, 0x03, 0x00, 0xdf));
+
+	/* Read Request */
+	define_test_server("/robustness/mic-len/read", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0xdf));
+
+	/* Read Blob Request */
+	define_test_server("/robustness/mic-len/read-blob", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0c, 0x03, 0x00, 0x00, 0x00),
+			raw_pdu(0x01, 0x0c, 0x03, 0x00, 0xdf));
+
+	/* Read Multiple Request */
+	define_test_server("/robustness/mic-len/read-multiple", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x0e, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0xdf));
+
+	/* Read Multiple Variable Request */
+	define_test_server("/robustness/mic-len/read-multiple-variable", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x20, 0x03, 0x00, 0x03, 0x00),
+			raw_pdu(0x01, 0x20, 0x03, 0x00, 0xdf));
+
+	/* Write Request */
+	define_test_server("/robustness/mic-len/write", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x03, 0x00, 0x01),
+			raw_pdu(0x01, 0x12, 0x03, 0x00, 0xdf));
+
+	/* Prepare Write Request */
+	define_test_server("/robustness/mic-len/prepare-write", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x03, 0x00, 0x00, 0x00, 0x01),
+			raw_pdu(0x01, 0x16, 0x03, 0x00, 0xdf));
+
+	/* Read By Group Type Request */
+	define_test_server("/robustness/mic-len/read-by-group-type", test_server,
+			mic_len_db, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0x04, 0x00, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0xdf));
+
 	return tester_run();
 }
-- 
2.56.0


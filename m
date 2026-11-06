Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989103;
	b=h2IQSPnissVbKdgr0joimUBWdrtdi9xeyMIX5LzKJeh336iiX5BU42YylKHO37N9ieyz
	 wgamRvoY0180Y13CuMJ1gph3XUQ0312zX3k9ARX6mPGDaVRZYWYS0xthgkalEzh8dadC8
	 5Gm4F+ZSfG2ZL303Ms19VMbEu7cVnKtPy/fbDZ4pmsRDgrbIHBLDG+mExAfsByb1/s4Al
	 OyOEO05jj5TJJ7m0I+4YSSCUOvaNpHkAC8rXADm95fWE0BaHFgcHV3k1snih3x/Wa/g88
	 uZzPptpwPeKkCyXtQq3k95rNF/fo0hHxSNv2rasRZuFpk9zQkainHl6BjHSIM2PQuwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s49vIavbpuLhQ02AqEh38zy0FCDS97uak1Qhazm2Kgk=;
	b=H3aSe18KTleOM3X6zm7GZ4qpMay7nIhAAFlh5d6KInkil9T4KDN1o+CK7XqXLhmZxwRv
	 BtuTfhlHDOOoux6Gprcw4ZW7fwL5OF7QXckcvp7Y7BylYHzrtYlm5qIKTtTTSP/Hrt95+
	 7EKsVUWzFJJcHcEV/TSLUosEDzNwmPV58I5zx9bezJsUF13BU0sePaESNzsBhaIVyh5Mw
	 LW6A+Y1E2NuPHXQ7LBrz0rHBSpUIERYrMS1VRB4kbBYfUHTlrYvkI8Ke2PobMke7ivWSw
	 itmbVZRlh2excbzps6MYstjog8GYziBR9ZemfOQqzGkt0JqpzvlfdqJ1dTP7y0n+33w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AHpK/Vsi";
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93780606A334
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93780606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHpK/Vsi
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso680823e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989102; x=1794593902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s49vIavbpuLhQ02AqEh38zy0FCDS97uak1Qhazm2Kgk=;
        b=AHpK/VsiPUHJT3SaW4UY4RtuN97p06trNPSJqaVLM1LNx+LMJrF3fRmrUymO2h/ZFt
         IJXGmO7Vuw9Ztjf+gG8H08/evJ1Ka7XUDL8MwiyC4vpzZOGQpsF1mhSpR/03TXHjCyNO
         0rSggNHkiSfqtAVhY5ARKeIJJvA2RUrbq50v/TkjGOzpNw++315Wmr11GZwT+Oe8OpVM
         2onib1YnJE4eYoy8EZcCRH/QEYgkbje8vMW0zP9nVILSw6Tm6PK45WDK7Tcgze84vMhL
         p/VkYbBqCnx3/UbeOQIO+C+K4ZVSb+xBXrAIC9Mt7IJreMPnnHX/ZUF4shsVnAE7DwAl
         UxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989102; x=1794593902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s49vIavbpuLhQ02AqEh38zy0FCDS97uak1Qhazm2Kgk=;
        b=xG6Nv0thzRQH4mxW2A2MNQnzCEEJcBnapBcNus3M5NSL6dMuF+WS+vUNuNrc+seVcK
         EWoHGza+U7WCVax4SdDS5wdIpxcujvXFavtW4I3CCqXELMT2GcGAkmHeMBeYf8UkLeCW
         TbooKxCdERf5b711dCrb6cgEDkont2RKbvISI3aUk2vxYilaNWqu3go/PNIiVoldnzYi
         AJgrItiSAXbBUKpNOXNZFOM0UlFaFV0WRYt7qQ/SGd+M2UehWi+LAU9Wyl7UHZopzoSW
         SblTWHU78o7uxqGlqsMVnc3Q/e3ZHYorDU1YpQTQanScXhgX1H04HPXoi62sYPNo/ECV
         BKwQ==
X-Gm-Message-State: APuU4Z+fkiqLaq4udHD2bX9gc1u0u5C+wDamASmJ3ygAYQ06bTGuyWU9
	MOpSs/M1KLMSVyUOsH7DcxZKDxsaEu4ljgfK04ArHQV48kRKzm0H1h02a+YOLQ==
X-Gm-Gg: AYBFou0lLE6RerJ/jvu1oqKxWw5IWDgK7Kd1spT4Z2shJZRVSd9veHupiaJrI0Jx7y9
	tofixr9wsrJuDLfZ39mwpC6F5m2lJdyhRPK/Th3XAJ795dfjiM+sSOkXEKt2PPSkdqnB22hGSZA
	YKeDYt9yjgjLE+rnvFhf6b8+AThzgl+nHGdMZNXODphwbHS+R5imuHi1tghb+3c/9wkK3MLYJMx
	jrV3Kc8lmpIut1LQ5wEhyRxWgDO/2QKEiJYxBURWblpB1+NFXDvrwxgNdKTfUritJAga1ks1V2H
	wI+lISgzevLO2k7wg/81Xku5vinxLpp/5BsBmYhafLoli1no9cD4qX1Swy98I4AdcaWJH12QTdu
	8ckRbL1mEuaze5H6KA8tcxfzlJiGdntPsU288u5yDrG1/rVP2e0nFwYd1O83zb/GTzrIxJto6cG
	XUFqyvPP0smWeTS1y2V1YUi1oRtWLuE0FOQ3EJYzydyh1wfTE1NnILGiJK4wB5mSfHg7UVrNlNj
	qYWJnFKZuumWXPuLxN6qW1lqBNNsFgSVc11DNztGQHFjz0otGQiklMZqqKznl1uaE4qYSvNZtSN
	UaFpeNWzRWKtSuqLGDfAXEYlsDBMMa2DiVcHOwQhiK6eT9WNY5PpTF0QsVELogJ5wmQd0tn09bL
	ksyrsd3HGfWPG7zDfcwP4ezeQDWfQpr0fAo98e6F+RKOtuEFm3M/pOrJ+auT7qf6zeevtMUQw/k
	APGl0=
X-Received: by 2002:a05:6122:8b85:b0:5ea:e179:326a with SMTP id 71dfb90a1353d-5ecc43d8b93mr1640899e0c.12.1793989101419;
        Fri, 06 Nov 2026 10:18:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 08/11] shared/gatt: Add MIC length permission checks
Date: Fri,  6 Nov 2026 13:18:05 -0500
Message-ID: <20261106181809.3134862-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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
index 2d654299852d..5e66b2ca0a01 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2615,10 +2615,46 @@ static void test_hash_db(gconstpointer data)
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
 
@@ -2628,6 +2664,7 @@ int main(int argc, char *argv[])
 	ts_small_db = make_test_spec_small_db();
 	ts_large_db_1 = make_test_spec_large_db_1();
 	ts_tail_db = make_test_tail_db();
+	mic_len_db = make_mic_len_db();
 
 	/*
 	 * Server Configuration
@@ -4908,5 +4945,69 @@ int main(int argc, char *argv[])
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


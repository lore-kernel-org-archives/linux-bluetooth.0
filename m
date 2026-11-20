Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193716;
	b=bZUn1su8cgvlYR6alDlkxqQoe8wBQCL3qPD0nnZWc6vIxuQM8/tE+ig/GRwfMaHr/czd
	 LMQ1dEbHiCAe7pf51/szNRHwB3rSdoLhgLQ+zmIsKF36G1661aZRfKymtkpIyjQhEtJk6
	 Q31BH1K5aDaymr+PicLb4std2+HQejd+EZ9JcQ/u1oCccN6naC9XlqMsiUh8BJCuKWQ4L
	 Hh8/PFK/swZrVgeZ/w3eJZQ4TORQw50ENHb8T5pD3omR/NvOyWVot6U2SeCtoaBc4/IwF
	 S7ai0/8MLvbeH0zyDbyskwmF1T3NRCRBc5tfigTQFcOf4QB66f6J0omDsIsMEkaTmZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
	b=nFT7iknDIamGnhfE04rljlfVEcz76DCtu9W3AuxwfozOIlZ6urt2/10nshWbjRkimJBs
	 KeFUDjCf7r3BoB32F27d4hCr8cJpTkJ/CM2ETcE94/6IVUvDJYfXuj0m6+nhWCFZ0f1xh
	 r3tKPlOHgFC1JIyPlnzPyYbEsXDsAR/240dbjzWWqzex9PuUyEuqVklEUyUwKfn58nFby
	 YyTfDZv7Rk6wCwizPpLx63YsbfUjsEDOqosD8h3VjqrN9QtWAo4soe437VGRDXELOVZD8
	 kPIRDi9G1+fPlduOR0hweoktqODbmR7Ov3+bVp3/QrZQ1oDe9j3V1pEurcrpttq82bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCXHrPJS;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762C606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4762C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCXHrPJS
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eae12762c9so427669e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193714; x=1795798514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=aCXHrPJSLEaZgoj6qQ7bRtU4bntf3CzOXQmnFaBGrVq5r56f5L+XnW4hLxNi65SA24
         SGyXhjTETRJJyxCmzoECGTmLohmQPLJcpynoI7vIftFi50revY9rDoLWE8QxCGhaXJTi
         vzWxN2ilNfGK3BP//K+FKUj+4d5+r72sL6mNe00AucxONJzioaJOSdBP9qzrxJa/jN52
         QfJnu7urdhM/he51A6JjE7vD5Oj+Ctp22Xzd0t50kRkicuODbqMLMELcYe/AdlxiheiR
         OQ2Sv40huRZd0D4wSbpUtwvthUIM7E2b7QhSI/lE17QVaLBCHJ0r/XhzVHV/Y3mR/su+
         bKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193714; x=1795798514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=BoXg1+oylWEThGKNpQ5AbYzK6Y6GT9dLnB65YPcnZMz5PK69ZxmqzGKaGxBkpECjdu
         CahXVcvXKsbUHaT7VH3UPDUqLXXbhXkn1wx37p2E3DTzEZAue77F2PfjjbsEQr0tUclq
         ggqkzTr3jdNKqK+nSbCsBTnzlL7AKiOrrbKSbPMAXSnJNYQtw1ElJKBBYo1BpKmYl9lE
         foIRhEzDe2/V3IMrxx8sjOV/iD0amKNe97fh/Kpta6thxf2IsuvEhW/OAdto5xcn//nu
         GgSQMr8rglwDiZLYgtdrsHNpAjAg6LfNUOux9YLAsHYdjEhG+phcI67HEn8ugsj/2jk6
         +W9g==
X-Gm-Message-State: APuU4Z8n2uXVldDxEfqw/SQjwNpvutGvS6QyzpbXAkEl+/VBO+KidzAI
	1cohhCEjsGiczzSyNdLZoppNHH8D5mUahcJTxv/X0Bku/4wtyr6GC6TD8irpUgzK
X-Gm-Gg: AZFdTZfG1X2Z3KHbPgMPl+PcNCF3GmpycqvfdQ7rh4QcUoXEO+pMyzTsZURzOzrg0Ph
	WnjByXqWqhYUonUs0dHNp3XJDJIS4z8jHTtPTZ759wcis5CDzrRsh+gQw7RugYEv/YF893nQ6ze
	gwdzIPb75xPPH7HaMKGqi5UgeTZdoUinj1QxttLusrGowbkK3UVT2ihMYB1UEEH2GJfJmRC/leW
	hKu7bBEjx1p0E89/rkvH+Tay36oLSTIyVd4PU7xoHpGmt8IrsrRSxBeNaOnMTyXzqy4yP8nf85S
	ipKiovvxuseVpxXpEHq3Yq24ibJOpCTMVZtn3kdPOEHvBz47KbAlGLuoVuFPij3vyccw8QyKXwX
	VaxnDNoO+lu48i34L3fQjxh+u4pzSk9ugCg8uh46mIpPHFzDXPfZ0n71IQAWH1YDyCSC9N4k0At
	KXg2F2qQ0J6B+n4zQmxdsPWVXbTwB6boSBt7Obgjqgrp+Jf5xB1eq8XMilN9I9gHaOJ7cjTcFWj
	rzRoY1gr4Kznve7CWQJMlzfD1j7FiL1PYTCQZcaXhOfhU+XcAtf4ZoqaEPtufOBVEhEo1hehhNo
	3mgPB1ECYwCkZeUeniua2VQOx/AaxY0LZRm46UPNKSLAddkT+xbdV6bkG/yD4cqiygaw2rwMTjR
	C0A8FRUoNVv35eHry+iFN0+/L5GUlzeSrC+al52ejv5aaVMfNSmRcHtwspfC6v9qTA4Qx5dvCIY
	6fjVU=
X-Received: by 2002:a05:6102:3713:b0:7ce:645a:13a4 with SMTP id ada2fe7eead31-7d7395a933amr1614315137.20.1795193714151;
        Fri, 20 Nov 2026 08:55:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 01/18] gatt-database: Drop stale device state for removed bonds
Date: Fri, 20 Nov 2026 11:54:51 -0500
Message-ID: <20261120165510.1858959-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

When a device is removed while disconnected, its cached CCC state
stays in the GATT database and is restored on the next connection.
Drop that state from device_remove() so a re-paired device starts
clean.

Assisted-by: Claude:claude-haiku-5-5
---
 src/device.c        |  3 +++
 src/gatt-database.c | 34 ++++++++++++++++++++++++++++++++++
 src/gatt-database.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/src/device.c b/src/device.c
index 36a980d1ea66..b4dd52e4f34e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5637,6 +5637,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 	DBG("Removing device %s", device->path);
 
+	btd_gatt_database_remove_device(
+			btd_adapter_get_database(device->adapter), device);
+
 	if (device->auth_retry_id) {
 		device->auth_retry_id = 0;
 		timeout_remove(device->auth_retry_id);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index cbee49d59f55..81a52492002d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -4277,6 +4277,40 @@ void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 	att_disconnected(0, state);
 }
 
+static void remove_device_state(struct btd_gatt_database *database,
+				const bdaddr_t *addr, uint8_t type)
+{
+	struct device_state *state;
+
+	state = find_device_state(database, addr, type);
+	if (!state)
+		return;
+
+	/* While connected, gatt_server_cleanup() still reaches the state
+	 * through the disconnect callback, so leave it alone here.
+	 */
+	if (state->disc_id)
+		return;
+
+	queue_foreach(state->ccc_states, clear_ccc_state, state->db);
+	queue_remove(database->device_states, state);
+	device_state_free(state);
+}
+
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device)
+{
+	const bdaddr_t *addr = device_get_address(device);
+
+	/* Adapters without LE support have no GATT database */
+	if (!database)
+		return;
+
+	/* A dual-mode device can have a state for each bearer */
+	remove_device_state(database, addr, device_get_le_address_type(device));
+	remove_device_state(database, addr, BDADDR_BREDR);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 998e3c452b16..94469a707184 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -20,6 +20,8 @@ btd_gatt_database_get_adapter(struct btd_gatt_database *database);
 
 void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 						struct btd_device *device);
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device);
 void btd_gatt_database_server_connected(struct btd_gatt_database *database,
 						struct bt_gatt_server *server);
 
-- 
2.56.0


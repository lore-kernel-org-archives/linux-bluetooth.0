Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534741;
	b=e30kJOawX9wYF6wGJjOoAhoj5RkemuEmgZn/UgcUgEyrVWd9CNmukZqhc1KKbCT3/twl
	 Qmnl2sjNinizP5mX4RO+czVrR/v3FU5aq0vZCpOlqIl8WMt2hN8uA1Jv7iA/EzSk5TarS
	 BvGsTvFIQPl7q5bXVgUG46BkEDKLcw0Uw61gVghDf4e5wmIfQ/AdtsgMWVWafgEk71xiw
	 wCcaXvHEOdSN8KAc5t3716zkgznr43u8wfAwfvd/MtluVuE4dJF5fXtuyER69NhldX0DQ
	 Uup4bj1Tjix27xnEgadOOpM+zK3PvlwLCHlO51W/RlCg+ZrcHl3t4npZ2Gs3FhrphXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
	b=Vpm7o+JJOcWatiWS4/lMqlHOxfMSkjHLyQmUNxnpbEWjO+HjSzpGVovofIKR9D+6PtKr
	 ScMdsIlW/rl2bv18NBtdB7txtzxZQumLDaT+ZV+j97ukwvrAZgbX2me/zhx5RPC7KGfST
	 T0YsFv7wVCLQ1eqaSYtKvSvSk8UR+ghQjmEvV1cQ/eWj2n6TwKnmlfOnUfiA4n7EYV596
	 u2RIN+N2IWB+lKayRZxHEyQV30WHdiwPqRwgTNqxTLTLXSztPp1nBl5ps4ziGeHLcQHct
	 kQdkhpDaYXb/kI09/TagX3qMKFeFkV9l5HRYMOHyfzLPeB79l9tY0A4r2PpXpceP32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LMlsB9hJ;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23EE606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23EE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LMlsB9hJ
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso1519557e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534740; x=1796139540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=LMlsB9hJVbsg2SC0mAbgkkboVC6w+SucV2dkNIVTEy0eMXe6rtfNCR4F0syDOfNm/B
         bfl8mgymGbgv/0woAD5gkrpfzOhpRJDib6icfB+SQa9zBRKYGclhqdUpvF837KQTMP/d
         ynwbiHJF+nyyVXrYjm5RWlRZY7bUS3N/wr0Eh0IHzyEyQPYnqPNuKHg9B4+oO9mBiPnP
         zBCA77K/mZ3NaFfuTZE65U1ZL4mBfKqI+N3eJO59SB7QA/AaFDI2wXBSaL30ptA12v94
         7/x4Mj8UnTiYLi9ArITFUchFip10STP6BHTH1HlZoe4RUKJb8eSqqs7CgV6R2shFAo/9
         +GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534740; x=1796139540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=DCtVe+JJL1WkXN4bIiC42k4741FaeXrmffqqmfruFvM8H27hQqTDP+Vw4XvC+AlJRk
         wWhKuhCgl7jnP8+jlCcv8YclPEVkvNlopM5CQPPXU3JGZ1YBbZYVQtp6dQv3bmf0nr5W
         sg0XT/s8eB+rRGTKRh4r2LxDtzvAJ18Rb9ACNdiSJ/MDXHzDUqjIAL93hWFprYEjbZsZ
         3yacP4YX8D9dgTT1Ya6Lym9A/06jgWr9AJDAi6Td5NmTEAHIBsuW06DJ64qty2L7+8+v
         pWSOv8W9skabAjp8UYFThQTIDTsTaeIwAhBo8iGvvf43wZM2tKQk64nXTYLXTAxmst/7
         ZUqA==
X-Gm-Message-State: APuU4Z/zaJTjdiHqHxlSOlVJ5swnbhsZVyA8ajUI7MO3kIcHuqgGEe4T
	9//m9jtder2OsPfKCNI66Tx+eugXsZ7E0JhQggk+lAiKjvctWJu6XC/7J4Sfyg==
X-Gm-Gg: AZFdTZcQJc4uo+juV5H2B2yXG0NH2UAtGMQB87k5AjTQLRuy3R8lx1dMMlbKREDs73Z
	8ApZ6lnHYvf+QzA+waJLY+AncgmgXdM3pelH4FbXtVv0l47UKOqZ5TE5nmojucUcTZ1D/1oo5Bf
	08iXunXFVKjaZsVa2P8DKrayJwEoiCLL3mKzm+EVcnjFc5FjJWCs2DfnaxSTu8dufMp1rmx5ukG
	owgSieGj0i60NrCvbmljxPFEyAjTAgjtatDi9EUK0GeUZtrKpdnn4v5e9MBPexol/AjlK8GgBu8
	E2VtMwxvvlie2wznEKB5NuL/IB4asT9l/JboQHA+EIZ1kiWWLzgepiPEBXKKdEPBf4D07lbNmkT
	HjNtY+Oo1DWR4V5yfq/nhM7eG8c70mpugkB4smL6+V3E09aoV9Imp2kz5pGvRNMAZ7fmDR6cZJG
	btPrkQu84MoM+ZLskEdkzII3pbUoXwr6OQ+Ms9E/CbyGTJ5x/WeJcmVfkRAdYEuk1T+O4I8yppo
	7zzyQhfMDfjFtAV+AOVm7cMUyntOO2SyHchBK/XUUPAfP4yrJluJl/9Q2FUiOlJSEWGTFKI7mZp
	2DD5LI/fuKBkB8BvRPFVVQCyYggcXz+TUAQoGg6aL1eCQoZdtIBXt84luOD7Io0q/OqC4TTztvV
	/18iLm4EJmdBwapjSjLP162doO9yaq5XLOwT+OhplhZUlJKNKhlPRpuIriuGryGDWGnyM3Gu6dw
	CW/P7YyYCCQozS4GIJC5sJ5GA5
X-Received: by 2002:a05:6122:3116:b0:5ec:4a13:8aae with SMTP id 71dfb90a1353d-5ee8af3116bmr7606934e0c.17.1795534739934;
        Tue, 24 Nov 2026 07:38:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:38:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 01/18] gatt-database: Drop stale device state for removed bonds
Date: Tue, 24 Nov 2026 10:38:38 -0500
Message-ID: <20261124153856.216054-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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


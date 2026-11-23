Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456289;
	b=gjmnXQUBDwNgk6ntNqCbZoJenqTZwfTejKTrARH0Q8vTlB2YeGU4RIwMs8vMUewHXrX4
	 8Dfma7/hFX07NUToVEyEVPfed2qAlmK2yv6JbE6qbYrjUDiWwjuEchwcLb4JrVHdaqXhs
	 o11XH1v+wA+VZMXegOeeSQvlv+78FkTPdjxVy59zsK3tvxo/8DzfGhU7Q9ZqUKHm1fJ2n
	 OpcqmR6fACoPz8tzTzyC5DX0Wnz0jGg8vgi+eGeGYpwmXawGBWvey156rnEn/cOExb9n4
	 Hfy6+ZmtO3y41LdELOBULXDTrOCrxX580tFd2fiHgb9fnmdjFdn/HhADwHuWbRmZnCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
	b=hwwsqswP9tTMr+hql2yzsiEMiAV/INEGThHfYECbj5epOQPPiqaB4P9i379VqeHlv3oe
	 htFPMsOh2Z9sRI7o6YbXZBJ4hW2NhngsnwoavmA3haLLGTbFG9QJujFzv8XKJyywkDBa1
	 a2bSUfbe37krGxBhJqzlEXWkZwNC8MscBDpHXTXdNFo5DqEfC/Uivc3JvSM0svWIB+UW5
	 0eMRqcR8/Miy9Dx76urDNAOXqKqzuvisDudXGI6ZabuZhc+NXM05ZKOBuRGKTD54yhhgC
	 ILwwH5osQDtjW5BGariAbLbNHbkOs9i7YzyCTGvz/UG+6PA7FIb1YWAOrqzOgYJ8h9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gx1mLSb8;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A2606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gx1mLSb8
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9905d61449cso917674241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456288; x=1796061088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=Gx1mLSb8hju+8oFR9fB2J4MbTqv2+PXUqb1btUTCVvNcRVflPcc1OoF1P8N9POQRfw
         W52F/ff5XinwgIRD9HnZ9K+h9G0GckBXgAtT/qEFPevzF2gU+wKgS/JCjx4L2tAJKqud
         6WhzfXKBPVsAyXWkmmHjxcZQYVwkz4VCB25Lq/xAnPfc7zjpEJMeoV4AFYIWav7+eC91
         O73chPpYw4fDpntNDL9nCe+3JaAjkpmJcId0FffeEfsD1LjhsYmMmozXsrvUJGyfeZEw
         /7yTaPWhl5oohfPIi4F8k34kxsXdK2speiI0KKZJ2FDJrixDlsVN/dSLh/EDRCXIgPaI
         Y4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456288; x=1796061088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=z3r8a7kYTiC/lvv+fG34WahD0tlwMpczpwutWJIzYMKzFrxFXHaWy1v1mbsRJ63pad
         3GM00BKDZpsHW2RZML1YN+ASku8fBfhXil5sc4v3qUkyG9mRgBVkocTMrsFiFp4ZgPlO
         Jzn+z/TZT4mSD5lzgAUZLhTSq3DhvzicGSuWWtUpdn4hMGYtyq+pLkdb6bVihBBtiTQm
         A6FMVTyaNjRJQ77wltCH5hJeWO9MiH+BC0Rf+I6ip9oPn2AB+VyBOobULesQG2uXh8Ih
         R4Q1mv/N/hl2opLCM7g3qt+7Xjz7C5rXDX5yQO/65FhBENE9DKp4vlFK5x2b8JK5IHZt
         YL0w==
X-Gm-Message-State: APuU4Z+QbF2HZGcOSxI/FGMae6i+3fgROFGDWTkJamhGo3qeROw4hrW8
	dtQYRhZM89KFG4P5j41Txdohf7I0dLk2amAOH4terru4NxBfdVmtnLXFC/f1Mw==
X-Gm-Gg: AZFdTZchqZVoZqKybQ4LeFN7BMkfi6zVyoC01a5bCUn3N6eg7lUXMQhm763fXhBOnPk
	xWBIxAJxsXWVnTFqARxiX94gB9YNe4ciDohVXKHdGnPq20IDlHITNWgTR2tKJqzzVF7m6ka91Tc
	iPnTk620BCboz46z+TcvGurX+Niou11bwjVpmvX2cY6pq+H6RfqmqFJM53jdByNokEl0P+xenDv
	YMk8++MyQeC5k/BPGZJSzQ/kvExPe/3xA3XHllepQig03w2nMfz6tuoeUDDee2YfAYchC49CNtQ
	n9wbtMsiTmfTjduBuApqhObzT1FPvw313mNM+AoFLa5UeRNdLHCxenWZIT/yc4d5d8l07qTwWf7
	toWo+00BxdZZcRmu5tZ1Y6/S1K8Nz3KVc8inLu9a0MdHhswNYUpBUGh2Eg8APAIGJtI3SvvauAN
	yZddT5vgfqPBwfIBRNp2HmyNIN6gmqgtrIo0f6tvOiL1oDFAeei6RJfjb7DjgQFK2PbYXmLAkG1
	hePZsgtVN9MXhPhf+E9B5QMPuzoCKirr3Ic+wflS2QzaxoZzTWwxBK3+BFA6i/i1PgP9NdkUE8w
	nCx0GL+tJHHCCc9c8hGXg/gHfbjE0f6/tsrbH8TcAuo6Rhp1h1VmxuwjocpYo989ZIQxx5eUPRJ
	IvBGHM1CERvFoeDse83+YkWLGe+zLQeAjZ/qhsuKMLlQjZVKMFLLuEvymBtpom2gwLln/ovTtpN
	FAPy0=
X-Received: by 2002:a67:e115:0:b0:7d2:a019:b42a with SMTP id ada2fe7eead31-7d73961ffc5mr4281810137.32.1795456287779;
        Mon, 23 Nov 2026 09:51:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 01/18] gatt-database: Drop stale device state for removed bonds
Date: Mon, 23 Nov 2026 12:51:04 -0500
Message-ID: <20261123175125.3642617-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108590;
	b=e0Ae77OaybAwZr6TvsK8O28BRlKwtzPxTonhi2ZhbP+LYDNT7nCcR0sGMc5x0aTrRlDG
	 DfKM/Knx/GDta65H55mUo/VtyZNpXpmEcgVYlGQBAfSrz7bm0vFFbTCGLv+jwgrUJwvZd
	 CO/4HOq2VaV/qt0CfbKYWhA1EciE0X8bzT/9grO1S682su+lL4Rnxq4mbjlGfMVS88y3+
	 HqQhKOSD2+Dhf8qc+LbhoooQIRcTVo9bcDv4d0CGV2liQnqQBl5krsNGLU4/GTgtl6cS1
	 uhwQWV/fvSzFpMGyN2K5uBuy1VCFcw0/qvyv6DoXwIU4jpjEqLL6WEnmZ62Kh+SiNSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
	b=2m/mayg2R5tL3x+lmZGG7E6pDIy2hBmZ4AkFckDWNK+/ST0BKo3E7Sg2TNHbnQo3tmVg
	 Z8JHCHrKMbw4fpVbeJBhf+sXvfqfIev0ceVdeaZRDRIP31oKCgwkBTBFPSFDypNg8MZwi
	 B13l84fStAS8Ry0d4miYeLGZhLyQPjiNEOtk27hc6lujdHKpxpTB7NsJ/kppcaDAcoyc3
	 DwFQ7my6rHdv/kYBYWOwWGVjBhuxyENIoHQy9r/ZxPwZ2gHZrOb8KULIi4wiqSGn6Lfd/
	 DPJsrhBO3cH0WYvaryhGFCP0BwcD0MzvPdIAhMafgQABsEuI0HSzYLba/8eNPl66JFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLAQmw8J;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E1606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 764E1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLAQmw8J
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5edf97136aaso1459518e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108589; x=1795713389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=VLAQmw8J2NGM4GQmyVQbX1eXoRvVuDHBKINceFCZlznPuGqH9OoARJtkkuLLbFguBr
         qdw8G4LUpwc+LBnomPjFE+zvJo9O+KjYB5fBNvealsRUsbPMtpu8ZisUQnd/wq6AjoEZ
         Y+JDwL3NGTb7aermtQ/FJBvvSbGedJEtFeie4eBov3SD7WnnJ2lUdtZTuCYIuENvdbxo
         MSpemvY46igBmzZ6Y12aAmMOI2dkZ0/LLLuDWRF+QB7DuX0Q25671psBYNBmEeQ0+CcN
         SkIGr3NZBLPW3Rv8Oipxe9f/0iXGgA/HyuRV8viobBCWkdxWzm8LTx6YV+0JgDi8GK0t
         DmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108589; x=1795713389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vq0mozm8bmwrCugrLLcQn4oqHWq9S+fcfXEP+8fmfRw=;
        b=jVDHPqcvMF7P3ri5LMeobSMS9ZtA6XG/sTPjiMcwI5TGTIrhxukbAt+0tnd2i6x4Dg
         e6ijnFgSfFnYfz48Zr/NtR0671IUO+JDMfEGqAF4rO3h+fGf7cBBSeKSbqHeag+jzF62
         cXsw1rXcmO7QS2hNrfDt1ijcggqTjkVc60dYXT/vJRC5SXiYspixjbMJhyc2r5y80XeD
         Nsn8PltYnAx/UzNCp2HSMu192EWnnmw/nVkhj9j3MqJaJzrO0Kt5HcwK1YcetKB6sI/1
         Oe/osDvqAorEOehm+NC5jUppKG5nBj+cu6FtAOqhI5KCM4I5Shk/wzS+atOQSTcR+o0u
         0IuQ==
X-Gm-Message-State: APuU4Z+V6hSQFg84wuJp/65x/imw5c4UEIOhHGMrWqj+euigsEJxuzSK
	A4B824/coeKLQ/rURXNOoeaBSr8gOnWbMMUGe5mEtMDDQa7r+ZKe+cxurTZSTnejofE=
X-Gm-Gg: AYBFou2Wxaulkgrj3mj9AEnKNO5CP/Gkvl+k5/5RqaEcHfARXj84a5+5mbj+RD0TvrZ
	ImFLmp+3K39ZgRicFcbqJbVHXRhyZmptBMk2DRjzkT15i+EsnNuFguU3Ikts78WSFRiJmilxoUF
	ABdGFFU3XAZsiZu38dZpRlxGgZkvHyRKLvyEf/ic3yeQ+MDnfIq+N99PPpysBnkh+2vh51eciWq
	v5991oajIS0rJ5XdMFZmtoxZGMwB/4zDBipGfaOvi1rgG0NOgUIydJKouvgp9hiNsjCPRpymfdo
	NZqHy8AzwNL2bGvFFhmivLQxwmYt86gDqPwGp4J3YZUQFlNXvDG8v/GYOCwqkDHe5g6a1jWBarX
	m+LU6Li0243ePZJhPt8blBkO1+XXjxvmdB4KtUIxZDB9hF1bUEa+jFyT9jcLmJNF6rxjQUtCBLZ
	S9YYDWw9N8xByYvKmlSGXLlMys7dTZrr93ZdTJ91B0SFmLttmt/1YYRhLkAIyn++vfkkro8Zuvn
	gew+TP/tMuLgxmTAjMxvXN8f6zblrCNKByaGCx3u6RQwSjKVcFNHjv5A/dZOuBlWir4K7U2rwND
	iAF8i9yeHRJe4hAV4g7mfihlPVOyWLIlWv+7dUCKMu2qRrWv+Ycyx+aBJO/dMqhspiCe+0Pb/4D
	L3/gb6srWU300bIWjbS5do6yaoDrZhRyQYP2bsYkjqD0TLjluJMZ2QnnEEQLgmCZAQrQFREmGMg
	NMNFg=
X-Received: by 2002:a05:6122:628b:b0:5ea:d18e:dca5 with SMTP id 71dfb90a1353d-5ee8af76532mr298091e0c.16.1795108589103;
        Thu, 19 Nov 2026 09:16:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 01/16] gatt-database: Drop stale device state for removed bonds
Date: Thu, 19 Nov 2026 12:16:09 -0500
Message-ID: <20261119171625.1014004-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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


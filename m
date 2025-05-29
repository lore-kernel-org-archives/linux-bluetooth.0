Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D6B67F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540635; cv=none; b=D9lJvtkKUJqly+dXDvnwV8LbnoPavIIoBXaDpxW1ocbH5ctqZ8kZBSh/t2fLgBQ/1EPIDsYKuDWs8je1RwMt8/6lPNjQt+Ot8n0UBS2JwVFOVev7xbOXneLzYCU94XJNkj+ZvnVPI8bKiQ3Ub67fUofiu7fRPVt1EAKGoYxJ0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540635; c=relaxed/simple;
	bh=N40gmw0QUTZ8jE+4DynqfF/ANR6DPYWl9m7/PStStO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Pf3fDoB5Co9yQIRVMGR1U3GcSPuaJISqTkw2KGKHNAbNaOqzU0N4m0v9/JhcYKlnq6VTvvF86RYt8P3Y73F/NJrD6pLgB18zJHNzUtTA69kaGiMiQBkJ6CNyOtgCnP4+1LUcGPmwYaVPaVHtzJYl2l3rZLHQu+sKKeAEB+XP6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWtpAF/i; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWtpAF/i"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4c4ecf86e8bso348906137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748540632; x=1749145432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIUzonX4smoR/N8dUFIME/b6c2aZwD5TKA88S95sE7U=;
        b=UWtpAF/i0KrtRDsJTkxNrjnFeZLxti0mEjRFPs3Dwc370estFtkvZf0LIlisnXziJl
         oG69RoP29Z29a2qB5o7HAom3HYpP7cwd0CwBFSmK2J+0RSCK2N62OnQElmpx4sqkhbe7
         5gHju+thC+dj3e2BAGpoNfQHLxj47btEW/Wshws6zw4KqFbeqZ/FaxCVr5NFlKIh+I62
         mxAHbKvJT0xXRwenZbn1VfQewK6xn3A04ziwqEGPAbYo4o9jLlVa4j4r/huPMSyAiKWu
         BGaYLalOdrk9TcaNx/kkzLmT9rSe9Pyrfzu7Q1NPsZUdi2/JC0d0RDX2FrU6cWulX3Mg
         chwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748540632; x=1749145432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIUzonX4smoR/N8dUFIME/b6c2aZwD5TKA88S95sE7U=;
        b=YFfwLB9m2lSNz9AgxzyWOytMlv9CIrmnwYs8+37hddRS+thIKqDUMV5HiU5sgSgiBy
         VNc4eXn4OeWjgQndYZZQ+9S5ALmA+dKj0RWiuDAPqtGvD+FtsVnsZbTFU/q0Jpm8aFeJ
         SD2rmvJKaLur64G1jooWUJ03G/Vels7ysHVJ5c0gpZyr8uZxtzQYCcOv3FMNp19Eq4w/
         uv0BnqbGu03gUnw7+UEEOzoWRVJnkyHS0y2MS7YDproIEzW/jaj6NojEbcNjUxUti0TI
         DpIUY7moUsjItrp9zwM7Kz5pjO5kZGU1+UjACvEyIZkXVHYnxcDnIeCCoqLsmUkT6CdI
         1N1g==
X-Gm-Message-State: AOJu0Yyh6fgKuVc9WCEEii/Bc7dlfwhtlgxU84f5DsArU4zaVuw2UTLi
	K4PadVfWDT/UpLyDeJN+NqqXNdshtzBSuGLtG6cwt49kLv2AciIu5rp/W2NdF+Lq
X-Gm-Gg: ASbGnctoI6O+syNZjFY2Ztai3Ag0hMo7DQ79n6/uW+XGyFdgY2JJTv5KQrER2ZsRVix
	ZFijYKeMDQvfvXQ4XSbbg/A4oo9dviGb1zAJqMmjJhimx0Fsr8yx9u90GiyDp2XBPMnwaAv87ct
	yuXmaY7Qw/O/zKtZazayC8Ta5cYzUpwbkI0NYHfaqWExHf1Lz9d2f6jr3/QjYC/GkQ3XB4YtJTC
	BZtfencR9EvgXY2HReQx6Tu6TnuL2wnJH3N221gZMmx8+ZjRpI5hFRRTRHbeeJDckPJca5qxi6y
	Wqx9FuIvWjE2HjDITbsKC+MudY8KC92AaWzj2MQ9ZyUrS/7OciCnJ0ocs0bpOijN9dsWSSG9UOW
	o3ZRKhYLLVAVCllEJ7Bpo
X-Google-Smtp-Source: AGHT+IE2sOecN+suHLTVXs+ZElqZf/jGK3RAus41Ikr+6/B7yVGQFc17CPk1s2jpGbGuOzkNqQC0Jw==
X-Received: by 2002:a05:6102:1625:b0:4e6:d784:3f7 with SMTP id ada2fe7eead31-4e6e40fce09mr676801137.15.1748540631681;
        Thu, 29 May 2025 10:43:51 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2c28d8sm1379732241.15.2025.05.29.10.43.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:43:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix not setting SID for assistant objects
Date: Thu, 29 May 2025 13:43:49 -0400
Message-ID: <20250529174349.197433-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The assistant objects shall contain the SID so it can properly be sent
with MediaAssistant.Push/BT_BASS_ADD_SRC.
---
 profiles/audio/bass.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 417b7b72ff9b..2d4a86619ed8 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -90,6 +90,7 @@ struct bass_assistant {
 	struct btd_device *device;	/* Broadcast source device */
 	struct bass_data *data;		/* BASS session with peer device */
 	uint8_t sgrp;
+	uint8_t sid;
 	uint8_t bis;
 	uint32_t bid;
 	struct bt_bap_qos qos;
@@ -913,6 +914,7 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 		params.addr_type = BT_BASS_ADDR_RANDOM;
 
 	bacpy(&params.addr, device_get_address(assistant->device));
+	params.sid = assistant->sid;
 	put_le24(assistant->bid, params.bid);
 	params.pa_sync = PA_SYNC_NO_PAST;
 	params.pa_interval = PA_INTERVAL_UNKNOWN;
@@ -1069,7 +1071,7 @@ static void src_ad_search_bid(void *data, void *user_data)
 
 static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 		struct btd_device *device, struct bass_data *data,
-		uint8_t sgrp, uint8_t bis, struct bt_bap_qos *qos,
+		uint8_t sgrp, uint8_t sid, uint8_t bis, struct bt_bap_qos *qos,
 		struct iovec *meta, struct iovec *caps)
 {
 	struct bass_assistant *assistant;
@@ -1085,6 +1087,7 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	assistant->device = device;
 	assistant->data = data;
 	assistant->sgrp = sgrp;
+	assistant->sid = sid;
 	assistant->bis = bis;
 	assistant->qos = *qos;
 
@@ -1100,8 +1103,8 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	ba2str(device_get_address(device), src_addr);
 	ba2str(device_get_address(data->device), dev_addr);
 
-	assistant->path = g_strdup_printf("%s/src_%s/dev_%s/bis%d",
-		adapter_get_path(adapter), src_addr, dev_addr, bis);
+	assistant->path = g_strdup_printf("%s/src_%s/dev_%s/sid%d/bis%d",
+		adapter_get_path(adapter), src_addr, dev_addr, sid, bis);
 
 	g_strdelimit(assistant->path, ":", '_');
 
@@ -1148,7 +1151,7 @@ static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
 		DBG("%s data %p BIS %d", addr, data, bis);
 
 		assistant = assistant_new(adapter, device, data, sgrp,
-							bis, qos, meta, caps);
+						sid, bis, qos, meta, caps);
 
 		if (g_dbus_register_interface(btd_get_dbus_connection(),
 						assistant->path,
-- 
2.49.0


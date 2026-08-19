Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC066332EC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172033; cv=none; b=EucecD56wXPbpKXf/sp0UYBKRmc8GMuk4pU8N9Vq69rRPqX2glFjwn3biKp252zZZ3vP6LDb2JmCqp0EhiYBmhQbEzPmLWjOw83ZIuyJ8meiY6iDN/qPG9/sHYGeLJrekTcoesu5sQ6eGcXcZPEB0JMsJPlIZLWg64BudFkdFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172033; c=relaxed/simple;
	bh=GS8iWW3KOYyueC9Xc0634j24G6thBfU/TCzgmHWE6Wo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBGVyNUV66iKJI+U42N3HjsvFj9G6yoKmHIFHshIr9sV0WWBskkGVyPyTcNONsc4RkMvUaVQhV846gxvKsVlNhBjBI/jJQMuCx1nFaq3pVXMoU9GDJ5VxDFxYfoQxN7Abmx1LZpmCuzBJcm2Wb7Ut9gQE/UJyQk+jXGEUZm04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOh3wBh6; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOh3wBh6"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso661069e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172031; x=1787776831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hShyAifQW1rgKFq0/zPmgbqhpK87cC6GpMRd+F7QsSM=;
        b=ZOh3wBh6OY7hXQOA/0AE38P1TOj8iMCqU4LCACGBPw7YVtP7xq0rpTSVhka7NdonuO
         yVCCdDP/YQtFtOFwg/MKE1Y07jBWA3YikSiFZcl36Iz0RZM2c/70Qa1g9QwjyG4//x6H
         VBQhc/1/Lm0SfowtZetq2RtdkDGiXHmKMG/RwIVf58qV7/JTGMQZm7ZqTz4+8DJwFjBI
         /nLC/hNiIfEinRmYfm60JrKiJksvwlEYUT4ZP3CbnZ5RVs7KHDwkAcgDFd9rMvBO8L6n
         dk9rRoyrseJ8W2K/tRbDpgkehThqVY8DpdSnEe4VTdYEVpqOZyC2QZsvvosH2L7ohj7J
         20jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172031; x=1787776831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hShyAifQW1rgKFq0/zPmgbqhpK87cC6GpMRd+F7QsSM=;
        b=O350ugeI1SPZ16q4JvGd4vkPLHNerFuIHBufVAKP13zk0OYM0eJkucjptE78v8Ox4z
         hzq5uAaz2K0uZ9hDpwfZtr0u8ZOKyvb+0bynCMFJppco8YcsjoAsX2H6BfNweFxjANEs
         m3TMWpkokgOqnkUwySS0ZH1IoLn+FEtFOa5fmsnw3Tg9eJu4xZyj4tjKvzZCGaqD5x4f
         qrnUVTdti/70rNvjb+gSUbLh3KLlylYSFUVeyhDo3K6oTKMaIXiSIQU+PSLU9/Lkq1qT
         EL6QAY+WueSm6c6Rk9E/FtC/01d+ZO0Ehf5lUE4+OsXY+NjQJBmXqd3bMQLQMUKis4cb
         sPlA==
X-Gm-Message-State: AOJu0YzOMacbGxgUuFbYHz1IFG8vNdMLyRICJcI5mjWB343PiZU6GoNq
	sUhDWX6Dad0ut2he5s/fMg7Z1A+9GRik+d4uaFuk62c0RxXhXi/BP/XO2OJ8GhXR81IpSQ==
X-Gm-Gg: AR+sD139sET61uBjcnDybWBXwDedReQ5rr6MVLioO3Yv8ZlJlNo+MkaSzpsUsJaUbag
	nx+jJt5L+hlN8xiCU/+bnsEmT5+jp/kbBu9BFvYLuWhnb6Jx0QKdR3fJlGxyteykenX1xN07ic2
	w4yZiKB02rrDzeRER57/ADjkE9zjMzxFZzTPUxrb+v4aLjf8ZT1vkD/h+7M9A6GnaLdaBnNMF2H
	+cyCVLjQGljdoH/yphSOyx15X4/Pw0dQsagl949A/ZZoGM/U8QxH892aFZQV72ccCV7iZFzMEgE
	G+lyzrigiw7KBpmoCLZCn6wadA8IzstBqv1c5jfnO+gOo4K5YAZSbUYEj39pe1H5E+lft9Jol1u
	SKmiI0LtpH/gtop7I4kdj467vgyX+dtual3OHUqd5OxbcgoYYTADCp56Kmm2YKcy2hfkbkqRXLJ
	r8dAWCFnUmNcFcN1w8Quwu26EJ2pt6TqxJjQcq/ILPRJ60AIkTi6JadvEV0xGu9HT+871EdhAm9
	IM+EE/E4vGmWsURgyXtiHAWg8El8Q80K9RBoZw9KZOIokystPHAQ10rP+TkXKiHNA==
X-Received: by 2002:a05:6122:8b84:b0:5c4:1f03:a1fe with SMTP id 71dfb90a1353d-5c5e3bb2d63mr2724856e0c.1.1787172030714;
        Wed, 19 Aug 2026 13:40:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/8] device: Rename btd_device_device_set_name to btd_device_set_name
Date: Wed, 19 Aug 2026 16:40:07 -0400
Message-ID: <20260819204008.2292225-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204008.2292225-1-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The "device" was in there twice.

Assisted-by: Claude:claude-opus-5
---
 plugins/neard.c    | 2 +-
 plugins/sixaxis.c  | 2 +-
 profiles/gap/gas.c | 2 +-
 src/adapter.c      | 4 ++--
 src/device.c       | 2 +-
 src/device.h       | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index edfc115373ef..1633dd576747 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -629,7 +629,7 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 
 	if (params->name) {
 		device_store_cached_name(device, params->name);
-		btd_device_device_set_name(device, params->name);
+		btd_device_set_name(device, params->name);
 	}
 
 	if (params->services)
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index a04a76d394eb..fc2b2a9d0156 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -362,7 +362,7 @@ static bool setup_device(int fd, const char *sysfs_path,
 
 	info("sixaxis: setting up new device");
 
-	btd_device_device_set_name(device, cp->name);
+	btd_device_set_name(device, cp->name);
 	btd_device_set_pnpid(device, cp->source, cp->vid, cp->pid, cp->version);
 	btd_device_set_temporary(device, true);
 
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 5184d74e8f07..495799e641d9 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -86,7 +86,7 @@ static void read_device_name_cb(bool success, uint8_t att_ecode,
 
 	DBG("GAP Device Name: %s", name);
 
-	btd_device_device_set_name(gas->device, name);
+	btd_device_set_name(gas->device, name);
 
 	free(name);
 }
diff --git a/src/adapter.c b/src/adapter.c
index c21b3e7fbcc2..cf59db4aa5a9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7628,7 +7628,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	name_known = device_name_known(dev);
 
 	if (eir_data.name && (eir_data.name_complete || !name_known))
-		btd_device_device_set_name(dev, eir_data.name);
+		btd_device_set_name(dev, eir_data.name);
 
 	if (eir_data.class != 0)
 		device_set_class(dev, eir_data.class);
@@ -9814,7 +9814,7 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	if (eir_data.name && (eir_data.name_complete || !name_known)) {
 		device_store_cached_name(device, eir_data.name);
-		btd_device_device_set_name(device, eir_data.name);
+		btd_device_set_name(device, eir_data.name);
 	}
 
 	if (eir_data.msd_list)
diff --git a/src/device.c b/src/device.c
index df607f718be1..9609a14f7883 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5101,7 +5101,7 @@ char *btd_device_get_storage_path(struct btd_device *device, const char *name)
 	return strdup(filename);
 }
 
-void btd_device_device_set_name(struct btd_device *device, const char *name)
+void btd_device_set_name(struct btd_device *device, const char *name)
 {
 	size_t len;
 
diff --git a/src/device.h b/src/device.h
index b890f23d4642..7683be82ee3f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -23,7 +23,7 @@ char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename);
 
 
-void btd_device_device_set_name(struct btd_device *device, const char *name);
+void btd_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
-- 
2.54.0


Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AE634E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192985; cv=none; b=maIjsP2FKdn7kMNDefgAwZW3sKM8G0MQ62dafjhAGAiv4Pw9ACf/XrVSv4KOHiKuKmoYYyAIfEGP0uJJO+Hch4UzluDd5Yz4o5zifJrnUcDW9JjaMibWuEV3MtYoQADAYMF6sfhl3Io+cnd1CSgzjZhWhaCmS4f+mSZoX+Fa2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192985; c=relaxed/simple;
	bh=aGcQl5YucAS7cfUthUZs2NS4a4pZSD8txWtQLm5FBK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiH/n1MqPNyuWeycv7COx0VreU4EoVom7QLsgtqEVgmoiPDAc2wwj3q/AycZItJyG5pPIQl8PwqC77/Qgh2OQ1tKwTbgqPCkQuMCN+1z1jvb5quJAylUfCS7MwFgsaBaiZSWaBU/r3FVdRpJeqKonh2jBGlesHjnbyyiNwA7rQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDhRXGo9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDhRXGo9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so555517a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192983; x=1706797783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMsr4C6WqfvlF846yaoxqKRE+wO5gFKn3y/R17Su3B4=;
        b=KDhRXGo9q6ql8XFFumwg7eh35q2qAX1RBsvPAo/7zOm7HCOClEuPuTZWTgao8fn5t3
         TqlTQE1zENdpKjnGbMji+OluNImTTr5x1O1uIOMxoqUlaOd2b7Xlxg/NlhM10cdM+2Pt
         e7z/fQdudv9XuGVZcf+UqBzBsXroFRJPMYgEFvl7wF6PhEblq9LXJwpolTW+d4TT78za
         Sv/uWY+3tZNoHgT/Vp3AkX+HGSEhqAj9Fm5T3aBPZrjwBRnZ+BlU7Mqw2PFHmkkWFg69
         l66LzgqUKA7fU2OmECt0cc1oWqc0fOiZdCzpcSaQ3SgiDEAMA+NN7Pz1uNQrUqJ/O2K6
         lpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192983; x=1706797783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMsr4C6WqfvlF846yaoxqKRE+wO5gFKn3y/R17Su3B4=;
        b=SSluDLPIlOnGx9O9ScQcghWR3wiBhDduLudZJh7UGpkwEp8rRVVB6uJDGj2CII2prD
         jEbkdFu4w45P5/Iug9cZNKgx2JsSIca+jX0fxKH0ZZOUBa/0HR7g9jABA+OcjaLCLU2L
         GtkZTzVS/r1ZbV896G7yl9dT/K5xfybiG2ETjSPYNl6Dmf8MlFjLAhPOEG/BIWmFaCvc
         g1OXdIw0KA5M60R9zGIiPM/jtVuPlyyylvWK30EZB28MHUCim6q/Y/ujCSRXq57NkChY
         fP74p9Wv6vxPg5msSK+VW96nsHS1IJuJonFeephZKZzfW5AkmIjV72796Lk2EbH37KuW
         y7Sw==
X-Gm-Message-State: AOJu0YwIEBGVmCfCxN6H4EGcMKoMmMfnEqKTbQ/tPAljqN3b661MCFEd
	Imc7PkRlzwpg1Z26pPoiFbsBU10VHogOqoPrWS0WzKPZHt6UMKEEJvw+FSmj
X-Google-Smtp-Source: AGHT+IFe0phz35e0ScZhvEV/jBB3bdOIquRHNFwjf1AH68B19bDQ5dAaRAPd5Sk6iVWe+pbGE9u62A==
X-Received: by 2002:a05:6a20:9585:b0:19c:75e6:c095 with SMTP id iu5-20020a056a20958500b0019c75e6c095mr1429071pzb.62.1706192982648;
        Thu, 25 Jan 2024 06:29:42 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x33-20020a631721000000b005ceac534e47sm13646143pgl.51.2024.01.25.06.29.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:29:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] device: Add btd_device_set_connectable
Date: Thu, 25 Jan 2024 09:29:35 -0500
Message-ID: <20240125142936.3373953-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125142936.3373953-1-luiz.dentz@gmail.com>
References: <20240125142936.3373953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of devices advertising BCAA, aka. Broadcast Source, it shall be
possible to connect to them using something LE Audio Broadcast
procedures so this introduces btd_device_set_connectable so driver can
inform the core when the device is connectable even when it is
advertising using GAP broadcaster role for example.
---
 src/device.c | 5 +++++
 src/device.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 17bcfbc499aa..afd073c6c2a5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4495,6 +4495,11 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
 	set_temporary_timer(device, btd_opts.tmpto);
 }
 
+void btd_device_set_connectable(struct btd_device *device, bool connectable)
+{
+	device_update_last_seen(device, device->bdaddr_type, connectable);
+}
+
 /* It is possible that we have two device objects for the same device in
  * case it has first been discovered over BR/EDR and has a private
  * address when discovered over LE for the first time. In such a case we
diff --git a/src/device.h b/src/device.h
index 8bb38669d457..96f41d47971d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -95,6 +95,7 @@ void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, bool temporary);
 void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
+void btd_device_set_connectable(struct btd_device *device, bool connectable);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
 void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
-- 
2.43.0


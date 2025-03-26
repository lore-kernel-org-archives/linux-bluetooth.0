Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AA254841
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017508; cv=none; b=jnxU+vfNDAIYmpEFfHBO5aALwLd5UtFHNdMTlAFlh+1KFli2k7W1EpVbNDQC2tfnvIO6pL75gn0woncr3jYcDEtz3x8K7ZYr0ThC//1HinsHv7rbKH1VVCRRy/1SB11C5POCb7tO/SGYDgZqepRKXj9vKRUhiDxaLwB7BjeOqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017508; c=relaxed/simple;
	bh=nb8o1+pwYN6p6PByhy8ZCrDYm6br8C1OtwXvmjyWa64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7Y0eKJFdsY+HiLbOwin03IcS0NJKze4uEx4hoNYkeiL4/8Ef7plYsqdtcCr+eazo2KlEBMgR7Nf0pRbZ+YzpqiW2p6HUfKWw6Qek/2yy+dlE+bgT9PcXHaexXR+rZz8kDt4Om2LrDrhwqSPhxhmkUkV6rK2yZQ1A2z2M9zD6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILSACgWQ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILSACgWQ"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1144863241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743017505; x=1743622305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtPK5mnFg/e6V37aqsMHx4SftU4CbHjXD29JzxP223o=;
        b=ILSACgWQI68a2wTyI0mqj9a1RkqESvz3ChcjPS652zQa/pJSb9uMmrYJ9jPbec/4pS
         UgV8vihlLaSiW323gudpSAZLuvWOBJz9n2IlnyjrB69/JenulzVJRl3/ofngpM/Xj71J
         Jez5jv05qcLp1rJEvaXwDF8w6YcKsq1obzx/MHyzsdxKcjUo2BPmqzgVWUXB+R6cYG1Y
         PVSGvSLiBM5y53XIcToYTGvGtyBvciGvNmMW+PKhZgrQtgpMbL0SC8jj8ZU5fxkiOmIs
         gA6Jbw+U39/nlvT8diV/vNE6T0LJeP26kNl/DWxqwT4HNZMvlUu25ytlZtcf6H2Q+ozz
         ZfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017505; x=1743622305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtPK5mnFg/e6V37aqsMHx4SftU4CbHjXD29JzxP223o=;
        b=vq1rKboB+p8jzt/2FewrKV5j/obiP2M50HjgQIH3GyhuDip8o5425i1o4GIPHjiHnV
         WzOX7UOYH7p4VNHrtOlU9ZZMO47XiPGlGtxQpC7EceunE7taGrDdpVjOD0XuvE0nOvtl
         Lr/iL94IkjqpVF5m5JIAUBDVsMQ3w1aKEsHzgc2Hyua8F+MdJwXzWoNSTo0BnHkAsTEJ
         Z0dOMEjKC5SsPU0Cnje72zB/qEZtsVsD1wpOPmxC0lxgUt+9+9ca6LJkbNH8uLDSd3kU
         MyiPQo5TxdYN2HW/DFu1mTCQNiCxQvxONk27zPGghmDtyU2MP27db7oRq8VutyEcRFcR
         9eww==
X-Gm-Message-State: AOJu0Yw214oN4f0yUaAUQ2gAh0J76PuPCsrlW9EcRozVVPMo0cKEcerd
	6zwE7dpi/tpREyaK6aie3O+wIQq7EJ+V/LdBAk7mfweA8CRVSDiFzH//6cQPP5Q=
X-Gm-Gg: ASbGncsEUiNU3VZyO2AdVys0OgZRi7DF4IIb9FNZuQUYlz+d37KzVrflS//76Svy+aD
	wrgVEKa3JicKOFnbQXqcZgvm4C2gczBh4OQc0G3zgrqUdbDS0Rg5NaHiFoq3fZGyWeK7krizbcC
	e/bCxuRQY7AmDbSy8ohJpiL/I7sVXIdeQK9F8TbdYK/BFFKfx6p/wrR/aAKE806k50vgfwEk0JT
	+dPmogKmff9kHwdbuCioNU/4ed/+wpXUqRqqu/Vq20E051enCyJsXT6SaZ/EdsINi5AQcotOHQd
	8nlcLHF1eFnyytIMsMdNKxbWZJW5ZQPE58Aq/f4ZpkvB7xV5RL/YdRbd1beSyj3OsAwIZQ5O3kx
	CyulYNcY1bYYXUw==
X-Google-Smtp-Source: AGHT+IHpgl/BNO4mv52eToQEgnBhRS+/uivZJ2YCCGSu1FzAtbKPYT9pBqxJCJw8Axwzfx3I35Knzw==
X-Received: by 2002:a67:e7c2:0:b0:4bd:39c7:804d with SMTP id ada2fe7eead31-4c586c813f5mr1279492137.0.1743017505356;
        Wed, 26 Mar 2025 12:31:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm2497804137.20.2025.03.26.12.31.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:31:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] device: Use btd_device_is_initiator instead of Connect message
Date: Wed, 26 Mar 2025 15:31:31 -0400
Message-ID: <20250326193133.2718934-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device.Connect message is not the only way to initiate a connection as
there is also the likes of Device.Pair which will initiate bonding, so
this incorporate the bonding check into btd_device_is_initiator and
replaces the checks of were Connect message was used to determine if
initiator to use btd_device_is_initiator.
---
 src/device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6a6c379fcbbf..034491b59d30 100644
--- a/src/device.c
+++ b/src/device.c
@@ -320,6 +320,8 @@ bool btd_device_is_initiator(struct btd_device *dev)
 		return dev->le_state.initiator;
 	else if (dev->bredr_state.connected)
 		return dev->bredr_state.initiator;
+	else if (dev->bonding)
+		return true;
 
 	return dev->att_io ? true : false;
 }
@@ -5780,11 +5782,12 @@ static void gatt_client_init(struct btd_device *device)
 
 	gatt_client_cleanup(device);
 
-	if (!device->connect && !btd_opts.reverse_discovery) {
+	if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
-	if (!device->connect && !btd_opts.gatt_client) {
+
+	if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
 		DBG("GATT client disabled: skipping GATT client");
 		return;
 	}
@@ -5834,7 +5837,7 @@ static void gatt_client_init(struct btd_device *device)
 	 * it shall be triggered only when ready to avoid possible clashes where
 	 * both sides attempt to connection at same time.
 	 */
-	if (device->connect)
+	if (btd_device_is_initiator(device))
 		btd_gatt_client_eatt_connect(device->client_dbus);
 }
 
-- 
2.48.1


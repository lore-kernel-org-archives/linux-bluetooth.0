Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BA4AB1A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065753; cv=none; b=AWQYrawIYMggD+KMWQ0ltgqnKl82Znh/d4HyZnG+Mnf6Pf0g6sZWTE47/gF3QBSVpsZPa2ar+38/zoHEg1U7U5y/mody1Y0UCSsrr1S2c4WR34dtfNezlKE4QmJOvdVvDthz3kV4rUH+bbE0fwQmWKW9yg1nxHxMHSW96XFv18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065753; c=relaxed/simple;
	bh=0qoObVxomy11sGG6ZnsFvHi5zQBfJ2xlKuAwRPJLFis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjWF+NG1iWz/x2PSXndkBAnjWb8ynAzSWEiNdxz5YGNenfeUD55QGj62dv7XMiCm8RlZwLNnuFXrn+mRwnCiPT2fOr7ICMI+f4pB/w8eLBmqtPYt0tUQe1lXS8i/BKrrstMHCJoLWuS1iXJIPBpu4RbYQ+Nt76WsGm5Lo3f3Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKHwvylv; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKHwvylv"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7bd056863so99380e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065749; x=1789670549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6j4giQ10S90p6Bt9mZ0WRoGPm4O2C/4wzn6we4vbb+w=;
        b=HKHwvylvkUA2r+m5F/K/bQAHQFcnlPCP6KlPYqQdwChC5FDy2Jvm6bFAA4i5Gv93as
         WWJ+YmITcbXkCjoaj1vFsDDUMZ2QfuG5BA0WYlogdZWh5P+U5hLrzK3bODUA0HFQqHNO
         gJB5OykUerowQBsZ8TOPdbvTHwP3i7e+DRujzMxJHFugfZA/nIqcJujrPBUL7WO1sCh8
         Hz42cPD2RInswbM/UujNOGmPL/OwX3cPDvj7S4Ma3UnS0qoU4idc8ha0lVgFfr31Pwv3
         BBMdtB+UZlTXQPuExB2mxIYj0YpKhGnBhywsngkxz7fX8lEqE1f+ZHnTKXmeGOfgHKH4
         rg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065749; x=1789670549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6j4giQ10S90p6Bt9mZ0WRoGPm4O2C/4wzn6we4vbb+w=;
        b=l9rX2Ym7sbit5nhozxCSnM/vSQvB/xu+pt5vj88C42OQQQ618Thy7Lk4gmAtEYdEUL
         BoI+rJTREi/z3Gf7jYqg20/XsdRmxpvVrmYHu+hmRmiG6Vu/U5k+75s8t6OAyruKX3Fo
         FtBs6J0P1pAZqqUwQuIKvoWBt7D5v9SgXlmzo7lWoWVZ/LbleloaHpQJsGlS1bV6oJzw
         8VjdgrwmxZN5NQTbB8gPP+c1P3235VyMYrm7GZmfSgx2dkTUevD5XJgXm7pF5oDIMxis
         ZR5lbzsSuC6k+N+gp6evJzTTt32uRAAZnqtAJcH32aGkYkh4Ezx0tyI5ZmoaNrrJ8lnC
         zdAw==
X-Gm-Message-State: AFuF++mLpMez7KhQh5Ccn10FY8pP6qjSPGnqE2SYJ6O+zaZtyDlOJwDH
	ahtSxV+W5a78C569BMBkvKxhJ5t6Gk9jfDMyXLft5GPKKw8qScr1ecB3zMsPbtyZ
X-Gm-Gg: AYBFou0KcnPft7jJlPWblVNm4PPlrLgnqK6MVaGGmeOmZPPAfEV052fqAIgH6RulnjR
	LXP6JrMkgysxYQKqJyKBr+Sz4f6//zT14CrdfPSgbTR4KI/foIWz9oCYdG0aGYk+3OLMeYCWhXe
	7oIVGK80cSenESB4jTwgs4R18ydKWk11v9xRrXQhXIa8RIfAN2aXqcHum7NP2L80tQ/clFi7EJw
	tl5LVIWHrH5vdgP6MusisFMxwfvZqQLAO6G3IR5sYX+mQRng2r511ec/oMaG9/F8DLBf8Y1XrWz
	IQmE7WLpyXYauAGX1HkbogIRPrUSTjLRdhWLEujpY//TI6aD22XMDFePZ+dWsP23XOJZO+aiRja
	IzfkvJB8gvEiICM7P+wiBZqO8AuevjsYDgC/BQ6wZcZ8oG2DNujlv4d8e03e2Jt7va1KJ86W2Jo
	2hVb12c93qTrH/fZPWLwGq1pGQshOEllZTLcHBCW+1GkZ4jhREYW084d98/webnvK4FzWET95kz
	ba8V+RgJsZqsa12E6cMXCEAtegGgNphhBAqaT74FXXgGd858ale1zLwls0zabmx2Q==
X-Received: by 2002:a05:6122:da0:b0:5bf:889f:e7da with SMTP id 71dfb90a1353d-5c846284248mr682259e0c.2.1789065749574;
        Thu, 10 Sep 2026 11:42:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470ae7dcsm222256e0c.4.2026.09.10.11.42.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:42:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] battery: Document the unknown sentinels and fix a stale name
Date: Thu, 10 Sep 2026 14:42:15 -0400
Message-ID: <20260910184216.1601639-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910184216.1601639-1-luiz.dentz@gmail.com>
References: <20260910184216.1601639-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_battery_update() treats UINT8_MAX and btd_battery_update_charging()
treats -1 as "unknown", invalidating the D-Bus property rather than
setting it. Neither was documented at the prototypes.

Also rename unregister_if_path_has_prefix() to
unregister_if_provider_matches(); it no longer compares path prefixes,
it compares the owning provider.

Assisted-by: opencode:claude-opus-5
---
 src/battery.c | 4 ++--
 src/battery.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/battery.c b/src/battery.c
index 181bf3846d52..dbfe56881259 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -664,7 +664,7 @@ static bool match_provider_path(const void *data, const void *user_data)
 	return strcmp(provider->path, path) == 0;
 }
 
-static void unregister_if_path_has_prefix(void *data, void *user_data)
+static void unregister_if_provider_matches(void *data, void *user_data)
 {
 	struct btd_battery *battery = data;
 	struct battery_provider *provider = user_data;
@@ -678,7 +678,7 @@ static void battery_provider_free(gpointer data)
 	struct battery_provider *provider = data;
 
 	/* Unregister batteries registered by this provider. */
-	queue_foreach(batteries, unregister_if_path_has_prefix, provider);
+	queue_foreach(batteries, unregister_if_provider_matches, provider);
 
 	if (provider->owner)
 		g_free(provider->owner);
diff --git a/src/battery.h b/src/battery.h
index 2b459809cba6..5990c8e0b87f 100644
--- a/src/battery.h
+++ b/src/battery.h
@@ -18,7 +18,15 @@ struct btd_battery *btd_battery_register_component(const char *device_path,
 					 const char *identifier,
 					 const char *source);
 bool btd_battery_unregister(struct btd_battery *battery);
+
+/* Pass UINT8_MAX as percentage to mark the level as unknown, which
+ * invalidates the Percentage property instead of setting it.
+ */
 bool btd_battery_update(struct btd_battery *battery, uint8_t percentage);
+
+/* charging is 0 or 1 when known, or -1 to mark the state as unknown, which
+ * invalidates the Charging property instead of setting it.
+ */
 bool btd_battery_update_charging(struct btd_battery *battery, int charging);
 
 struct btd_battery_provider_manager *
-- 
2.55.0


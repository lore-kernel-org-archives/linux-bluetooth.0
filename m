Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAE1BF32D
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584479; cv=none; b=COjxP6cSLN3JTjzYx/dA0+qTIhNPqUGzYL3eZsS/cqM+80Pmh0xl56Va01CeEa3xRmc8dbmvSOXcOFAMRho0ogJuxIIpvrKQ9BahSb8SeYtw2muXBUglM2WJJxCETuV7SuLm/xAG29DnW2xYVSvx05WU4sZa6J20aYNSpjfH9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584479; c=relaxed/simple;
	bh=fMZFZ4SGSQxcOUSIYYOLwFZxOsqlMxEP7zWe9E0XG4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feesU4kMzQOIeRYLA9UBkGWB0SHum8b6+iGcs88hN/i35tt3xk0gb93Jos5adu9yaT4O1GlgzgVQvWx0fyJ+CFnab/YWobmDqGl1gJJqS13HMYsh7bGM1PH7n4g2qoJJ3lwD+7lMMBk8eMd0NqFNBLUcrSe1PZEO5e136Bcg7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNhzkjzc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNhzkjzc"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8d0a00a35so604813a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719584477; x=1720189277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjFdzzq+qCCDquDoPp7hm7JIC9/jrQWFcKwCJrWETHM=;
        b=CNhzkjzc+QYWrgAI7X3ok7g9pNx+F/YAqGi1UzyvjO3N52V63wzI7KdF/gwvfKRFv5
         c+GKUoqP2mZBu4yzMwdkuX0GZL8+bePudWdDa6/0yaIB3PPiPkFc79zV/D3b5+KW6Gue
         PuZqIqgD8Aaw1EN03kOoHcF/6GvpoF6m/7cY3gg2uRxfY9Sx2xNx5gnCIiDC4dUwcuNu
         eH4VqjCuZT1w4s2lnCovOFsdXMljzEgaijDJdL9HmbKs8o7Jkg0kBy9clx3OCYMha6Cu
         1lmI+WO3V7uaw/fRtr7YBcm1WwHWseW+sUZUqBPg/ZEI/srkM9DPm3xL3WKTGn7atSHo
         /AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719584477; x=1720189277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjFdzzq+qCCDquDoPp7hm7JIC9/jrQWFcKwCJrWETHM=;
        b=qc7TY71SD+DKwwLrlylXmQd+X+eDarmoeZWEBNjTqIe8nXyvT83XTYlQLZHsLpYr11
         G/91C/NQuVNenFU5RQZ5jXo8XMwnPgxlrv8KGtjb76Sr1SPrvzdWSouQtN0tchc/jd+t
         LpvADzXp7Xk227N0TrfYu4lxZYrqksqhnRZ9l9kmTbST6MSw7vZkQioDpzGpJXFsZUbz
         JIUZWLzVoqs0t3b+NZKU5pc7XD1NzDKs7/Rrrhmn2WjQh8GZE9m4FAHz84cZGzfEJk3i
         +ak/4VtJT9Pf8rKvfFXlV1YP5f7b7a8u4fhNIwNCkPfM0DUNLjUeDWpTKQgd0OloCAsv
         hCEQ==
X-Gm-Message-State: AOJu0YyErbwe5P5kLQO17vbF8xZtr+wXPmuZm+VCVrhFP7d5Renka0al
	T2+aYDIQ6AwIbBuq6d2VNGPNSD6v2uteAnCTlRrRSTp+6HhyoBUk3yUxmg==
X-Google-Smtp-Source: AGHT+IHEIJtLDfvh1sn7mpyqFhNgJSRm5KT7DvRrLmcu0rhwTI5CJ/1tde6PKwWczA/lnWftqEIfBQ==
X-Received: by 2002:a05:6808:2222:b0:3d5:65b1:22a2 with SMTP id 5614622812f47-3d565b13617mr7723490b6e.32.1719584476660;
        Fri, 28 Jun 2024 07:21:16 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f29225aba4sm271599e0c.35.2024.06.28.07.21.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:21:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] advertising: Promote experimental properties to stable
Date: Fri, 28 Jun 2024 10:21:12 -0400
Message-ID: <20240628142112.575748-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628142112.575748-1-luiz.dentz@gmail.com>
References: <20240628142112.575748-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This promotes experimental properties to stable since they have been in
use for quite a while without any changes.
---
 src/advertising.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 5d373e0884b1..dce79bbb51c0 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1129,10 +1129,6 @@ static bool parse_min_interval(DBusMessageIter *iter,
 {
 	uint32_t min_interval_ms;
 
-	/* Only consider this property if experimental setting is applied */
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
-		return true;
-
 	if (!iter) {
 		client->min_interval = 0;
 		return false;
@@ -1162,10 +1158,6 @@ static bool parse_max_interval(DBusMessageIter *iter,
 {
 	uint32_t max_interval_ms;
 
-	/* Only consider this property if experimental setting is applied */
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
-		return true;
-
 	if (!iter) {
 		client->max_interval = 0;
 		return false;
@@ -1195,10 +1187,6 @@ static bool parse_tx_power(DBusMessageIter *iter,
 {
 	int16_t val;
 
-	/* Only consider this property if experimental setting is applied */
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
-		return true;
-
 	if (!iter) {
 		client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
 		return false;
@@ -1841,10 +1829,8 @@ static const GDBusPropertyTable properties[] = {
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
 							secondary_exists },
-	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
-	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
+	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL },
+	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL },
 	{ }
 };
 
@@ -1998,8 +1984,7 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	/* Query controller capabilities. This will be used to display valid
 	 * advertising tx power range to the client.
 	 */
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL &&
-			btd_has_kernel_features(KERNEL_HAS_CONTROLLER_CAP_CMD))
+	if (btd_has_kernel_features(KERNEL_HAS_CONTROLLER_CAP_CMD))
 		mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
 			manager->mgmt_index, 0, NULL,
 			read_controller_cap_complete, manager, NULL);
-- 
2.45.2


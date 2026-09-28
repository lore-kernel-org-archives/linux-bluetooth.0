Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1B4F68B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625672; cv=none; b=qz5LTWYbpPF0f2koR5FSypJ6X58/SsDLH3lKYPQRCywXq0QhWSqYmcj6zrXqJ/7cJbvS+CGUXxtvfPCkXbwCuahmq6ug2xAdSGRZ7Po8kapUGR+tQG5xsjCgkFBIW3SpnT1gSbE3baxomTNwczY5J8tRqT8cKACXfa47G3Jlrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625672; c=relaxed/simple;
	bh=OuiwB0lSxtgW87R4TTLpVG9QNtZMoA3IewOfNsG0j1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No7YDT/C45Ap/GCw92UqiTRPj5Crp+Eo9ujOX/K7YMf9udfUDwlvjzI8ML1hlhEnBXkZOJnwt+1kAKkMi/8oGR1lrJZvNO/RLVBhx/SX3ebPMhrbr6pfsFLIHVUN7Hr0opGCLDuHh9XYpm7EfnKdncw0kt6Vgsd3Sn3KXJjUEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr9HEaX5; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr9HEaX5"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cd1d9d66c9so1100712e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625670; x=1791230470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xqkey66/B/KX6XjD27NPqfzA8q9gmitvYfR5H1KPqwc=;
        b=fr9HEaX5iA9Pxo2ui+xYW3ywR9yjg0ZM1ImM/NaWd/jcaKd7qK+2mEWtOqxrBTvv9s
         qQew+2Z7TzEoxnrnK1qkQwCK4g9ncOjUKoY3T/kt0odWOlrRTIbQRSVUPlWpwGuf40+0
         MHjMemaMnL6tFdVYkDdp+wDzxpRylqY/dvAyGe7V6CBHISLa6B+RHW3UXMmmmXVqWNTC
         gGVWoW9X1nwMgjwWn3Cp5Rlh/yW94Rl8nsMoQ+Vjk1MdgvY3t5ErofvjLvIj1bTUcG+T
         PCYr/oxqQigDDDxJfqQlsoHR4uH9iolpAvpm0aT2EC6I8ygBtSJW/HdrRG1fhSWh7wVV
         wxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625670; x=1791230470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xqkey66/B/KX6XjD27NPqfzA8q9gmitvYfR5H1KPqwc=;
        b=nhpYauQDHDtCjrVBQ2letFDV9Owkb63+OicYe/kCu2LJfEElq3KdroT7AUS/LOunVr
         9NQbrovc8Jgct1LAmm+jHJHSKWdbpAL+AE+ZxGhX6Ees8LOyvAKSR7ILSBL84h8Ah3iB
         J4uoB4t7s+kkoM7vI4mFyVConwg+E/kHoHjCnByqjIoGjg4BooIeWVhdABx0gHLVrk7y
         UH/rwmrm9FHPb7Dgsk/WOPnqSoODCFDZrcnidtt09ktEGrTSsbzolNGV9Jrb1p2/kMAB
         NEGDaOOYLfnLJ6Sr9FxSi9JX4oDysoyghmiSsDOavKZLCwgdWQEzR9VHXVEU5Ls5zhe8
         uhiQ==
X-Gm-Message-State: AFq9FYJQxMYbtfmh5tap1F585RVM7oK+Ltofnzos25BAF0eCjcd85+u7
	ZkcnC6HF6tnMU8mQf/7NtesdRHtQto4Sj/8Dht/2rlzsSiEWgKLBaqR+yPZHskPXxaw=
X-Gm-Gg: AYBFou1z1Stj6rQ35n54dJvZZiti1KXIeELRCDcgKE8LbEphrqLYEXpY7Z/0qlNBKop
	jTuzTax5iQxk6JIWnr9pn1ICwlPu3xwCn4S9HstXD3wkJTaAP9UlTuxz4c9mwnrJq1D0LTBRvgd
	y/bF1YU6T84ms0qzXHifBhdmv7VF0LTvFcM9Q7BkfHvFtA1aHFEhtRpNdAQ5YwGzs4hbEXo+7uP
	Ap3Fz/0FObQqW/LFqddoRY3qUgVTjDT47P8x3IiW/7t5rshSgQAA5E5IxK/p0zHRgLpHxNR6jXm
	3BIehYedzUO1rqKDq4vKZ4mc8hDhPrMsTp4Wtkrnjj76WvDpfnpAwKpdds4VS6VKDyInDNPQfcJ
	N6yRHJ5X2xLHfZgm2chK3SMmOIc1sTfCBSkUgDJeX7wECc8vzBjJASSJrstohDl6sPEmbOJ0vGq
	BSbOvgYiPY6vY9kmgWzv4roKXaqaGLbsJqSTUiYkrXWo//vXMupMM16zcaSZCkI2vfU0CTWPhET
	oyjmFhX38xef0T1kjNRcZABSpyHouOAj4+IJK0Ce6RvZUzRKV0lbNPbrbRWYinDc10eVhEj2V8=
X-Received: by 2002:a05:6122:3d44:b0:5cf:5ba7:b3fe with SMTP id 71dfb90a1353d-5cf5ba7b808mr1813810e0c.14.1790625670003;
        Mon, 28 Sep 2026 13:01:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 14/23] shared/gatt-client: Add bt_gatt_client_is_idle
Date: Mon, 28 Sep 2026 16:00:20 -0400
Message-ID: <20260928200031.1209311-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add bt_gatt_client_is_idle to tell if there are no pending requests, so
it is known whether the callbacks registered with
bt_gatt_client_idle_register will be called.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 8 ++++++++
 src/shared/gatt-client.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5135283e4526..95f83fa3ee8c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2620,6 +2620,14 @@ bool bt_gatt_client_is_ready(struct bt_gatt_client *client)
 	return (client && client->ready);
 }
 
+/* Whether there are no pending requests, e.g. to know if the callbacks
+ * registered with bt_gatt_client_idle_register would be called.
+ */
+bool bt_gatt_client_is_idle(struct bt_gatt_client *client)
+{
+	return (client && queue_isempty(client->pending_requests));
+}
+
 unsigned int bt_gatt_client_ready_register(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 63cf99500e9e..ff90fd8eae38 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -46,6 +46,7 @@ typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
 							void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
+bool bt_gatt_client_is_idle(struct bt_gatt_client *client);
 unsigned int bt_gatt_client_ready_register(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
-- 
2.55.0


Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97C1C9ED9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593229; cv=none; b=ieCJGOzLGNiORb8EgqiouNrZGIFVFptHHMltko8Le3cH7A5cVxAstGAV1j57R0Zfo5nzmgVuxjEYPd+LlSj8Cs296NxGlvbIWojwX3pLb+kRORNt5d8CPD6yZYnZa51Gd5QCQkqCuqfkHWrTqQ8UtjsiCXapqoq68zVQ27NnIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593229; c=relaxed/simple;
	bh=fMZFZ4SGSQxcOUSIYYOLwFZxOsqlMxEP7zWe9E0XG4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3up+cBisUTZD01TYRmt8G2rm+2MevXL+pRjbn/ilaMr+SMFf/RGsvAelU2xMWS4IPCxJroqabGueIAvwsToM4+E5cvJapQYyoWGZT6qKQQwV53tPEtXxjfovDgsvLvwvyAN5iyJJMof2OIhDsXZBsOSdxkL13xFYKhrcOiTAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn6ivYk/; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn6ivYk/"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48f96299046so317683137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719593226; x=1720198026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjFdzzq+qCCDquDoPp7hm7JIC9/jrQWFcKwCJrWETHM=;
        b=hn6ivYk/iVGmUBk3ZiYrnP9Io126Pw4tN16RQYHqFDjUHdtLnIgrBX6qUx1es4SK5s
         nOjDisbaT8WXoagRpH+svb9k1aWlgzDXTZoMEqaMh2D6bqV3fBxrgx9Y3pNKV+Id3xAb
         +94YjA5e6NLDhA9OAP+HOCCFVIw+87xB4G1djyOliP9hjqa7IU5cykNACLRf7n021IWi
         7Z0KOEGhxDnpwwTiUYhO7JUazqSD+02Jh4jabn5RcVwR5Yli/PkCGoDs3o/R62R9/mQX
         dt803GLKHaOnhFGwMttj9dRhvXGmwFxAg2/cIw7dILrDmz5yE3i0gxQczGGDoyUCFQt6
         j+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719593226; x=1720198026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjFdzzq+qCCDquDoPp7hm7JIC9/jrQWFcKwCJrWETHM=;
        b=qoomW1TThEgADfIRBx3jYe2wfTgFXQWpg35FYJn+5OwskBx1d/T/71sq/bEsP1fap2
         aJEzeNzjgdVGi8CYEHFy0jNQ86Ws8TSaO0GKsh97jEq/1Qy2p5/0GXgnifYPg0KC9jzr
         GQLCF+gM5/HedcxXHPlHXeU74Lwd4vIOlfqwf2351KihkqEJjrX8Bt6jle8+tZLCV8TR
         0XsJ0USaq/TMsm3hY0V40DYuC/XVJrw+JZplSgTHkCqxCLS0qX8EVstr59JooZTm1/Fe
         EQ+Gslw7Zpsfz8SP+x8HHNtHfh4Zx/tsL0zKyKgm3ayFTRF4ISZ9mSTIy8zs0AVk8FNd
         qClA==
X-Gm-Message-State: AOJu0YyJlNqUroBcpVXS68gXhj0WnlWH4NTIcLy/3olDfkzLh4maGDbn
	Tsy9v91Ujlj6K95XUChcbTHBQUTwCCqC1apFZF91vk6MiQcWTXFymUS+sQ==
X-Google-Smtp-Source: AGHT+IGTosclt8FLQvUYcF6gbG6XrobYQe2Zw/8kODPGzpu+HtxZiMeLslRSGBhcyEJ0vF8/l53Ofg==
X-Received: by 2002:a05:6102:3557:b0:48f:9586:551 with SMTP id ada2fe7eead31-48f958607b7mr4987983137.4.1719593225622;
        Fri, 28 Jun 2024 09:47:05 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80fdda531b8sm273373241.16.2024.06.28.09.47.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:47:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] advertising: Promote experimental properties to stable
Date: Fri, 28 Jun 2024 12:47:01 -0400
Message-ID: <20240628164701.626148-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628164701.626148-1-luiz.dentz@gmail.com>
References: <20240628164701.626148-1-luiz.dentz@gmail.com>
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


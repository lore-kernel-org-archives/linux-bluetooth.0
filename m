Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447885;
	b=bNdrgKUiHCx49mjJhJaNLww8XyU6OL0WTpIZm0uWjsuiphGAz8tcMvPh4NOIzUBt7Xyr
	 3IEkKYmWXVtejdPPNJSQjypTpp/HG5BQrQkwU1kwequREL30c6rqpmdK6RB6aa7aoVNHX
	 5DrovSFcMhm0zmP5JkYAejnLzJSsQUK3bYpwi0PtIb2JGgN8kz+xZ9PVJbf6LEPOOZld2
	 HcnFbxgPzUHLJ3G6CGxBKSi9EzdRtuHSjfP2K0Yq9FBLSWANT071igiQ9b259BqRlk5sc
	 Uxe8KosCxpITrH/klUZVwyatZYjjjJqFxi+MYEEaZoXtG2MecmKHPRlPuMigXTrtyFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447885;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XWRIFCtJjyIcMO07++mozDD8oBt7g6SuK/7y6YZhvfg=;
	b=AGl1SxVAtYf+9NojHU6HJRJ9Mw2CMYgfHyPbbUYufuWkpJM3hcqTrfMSTxE63h03uB5F
	 xTYlibcGFmnUOzIeovYOYtkJS/odb57HOGwy4cqwL5f/g0NbAt3JikorT2llNp7therj/
	 FLW1L1ChK0RJJ9eGb1SrI66ILZaJA+xWL1qSkadh8WXNXzYvWn6NOkqOmIjOeoARehD1p
	 xJ9YckuRQq04+a5wO3dazJqLA8J5tUrg8h1WdnUCJkfXtI56gkqnyh6gYTfOvAMP0fQh/
	 3M+Vx8MAsi5zQFoahNQZFuJ5WjfTMSS8Q1CTxYztyGRxh5N/Iltg6lAiofIgBaDITKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cnoBEdGA;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3941606A321
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3941606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cnoBEdGA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795447883;
	bh=s+iwpyB5fD4hUIpP68Zc1/6yCs4uPDjtWxK2QNjNz0M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cnoBEdGA0McuxnmLf7V9GX/aLq44mpeWZ87Q81i26znilIC3hd5HxRAAzg949KtwG
	 lRsCNvXSr/UyM9EFgqMgxDiZYwr9/BzUK91x8MYhFUSQilc/3rpnyk6MOL5K+ARtV9
	 XGAU/lFVYSeZFxm+/DooILIUWCV/HwUpF0fcBddMjVw5elAar8slhPJkUu80jmddV4
	 UwXk2dxEV1Eoq2dqwoKrBCwIP7apTdeWFWTSJhasRhpsnyoWDla9kddvvEFQpquTC/
	 nKuYlc4FQ9vE8aX4/nshLxEBlC4m+4eScPTYmGDUe18vJlWviI2sAaxHy9zFSESSd2
	 PIvy1NbAQ76qw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 23A5917E05F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:31:23 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] device: Provide Security Level related props when supported by kernel
Date: Mon, 23 Nov 2026 16:31:15 +0100
Message-ID: <20261123153117.135583-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123153117.135583-1-frederic.danis@collabora.com>
References: <20261123153117.135583-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The SecurityLevel and EncryptionType properties should be available in
org.bluez.Device only when kernel supports MGMT_EV_SECURITY_LEVEL_CHANGED
events.
This allows applications to check those properties when they are
meaningful.
---
 src/adapter.c |  4 ++++
 src/adapter.h |  1 +
 src/device.c  | 13 +++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1439642cb..f78ea7301 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11398,6 +11398,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports suspend/resume events");
 			kernel_features |= KERNEL_HAS_RESUME_EVT;
 			break;
+		case MGMT_EV_SECURITY_LEVEL_CHANGED:
+			DBG("kernel supports security level events");
+			kernel_features |= KERNEL_HAS_SECURITY_LEVEL_EVT;
+			break;
 		}
 	}
 }
diff --git a/src/adapter.h b/src/adapter.h
index 18e6eaa78..633614c86 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -292,6 +292,7 @@ enum kernel_features {
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
 	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
 	KERNEL_HAS_CONTROLLER_CAP_CMD	= 1 << 6,
+	KERNEL_HAS_SECURITY_LEVEL_EVT	= 1 << 7,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
diff --git a/src/device.c b/src/device.c
index 36a980d1e..a21819419 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3785,6 +3785,13 @@ static gboolean dev_get_encryption_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean
+dev_security_level_exists(const GDBusPropertyTable *property,
+						void *data)
+{
+	return btd_has_kernel_features(KERNEL_HAS_SECURITY_LEVEL_EVT);
+}
+
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "AddressType", "s", property_get_address_type },
@@ -3830,9 +3837,11 @@ static const GDBusPropertyTable device_properties[] = {
 				dev_property_set_prefer_bearer,
 				dev_property_prefer_bearer_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "SecurityLevel", "y", dev_get_security_level, NULL, NULL,
+	{ "SecurityLevel", "y", dev_get_security_level, NULL,
+				dev_security_level_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "EncryptionType", "y", dev_get_encryption_type, NULL, NULL,
+	{ "EncryptionType", "y", dev_get_encryption_type, NULL,
+				dev_security_level_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
-- 
2.43.0


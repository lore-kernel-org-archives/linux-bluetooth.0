Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622426;
	b=DTaZUoEq/10Zht/iRFo+u+9xTknl+1kiK0yXhbrClI3Ineo1KGa3s8/3vIwWq+V7tYjV
	 gKxONuSOTYDuhP35flnhfBoIErVcJumjf+xINJVPxEnmYiai1mD0w3LMRHvgqRAmYwDY+
	 LWLgN92PphY0intTnTCwiiUaybpEO54ACTuXoeJD+diMSBUC30920hu/2lz+hXSnzemrP
	 9uw0vtxGD/gQS9wTmjVqGkIs9RbBtqV2HjOs11BwCPsWy8PJsp0JJa7rOB8W1xi8Wp2PD
	 XaUj4epzioetAvxKACKV6rDHVYOcZRJHUvzkd0uVarV4TPimkqmANvRBsXmuNBi6LjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622426;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TYBjK0sSpWbQr05ODTmrbKp0N9Z7DSsx3bpbHUeWwJc=;
	b=CXbh8BvP3/2V5L+yPFywS4YtgXl6BJKo0UuuKauUQ2JPWeOceglfNfEwjWNYp1AdtvS4
	 XMYMwDtHtJVd9JUql3JB2Jf3a24eG96IVWSH/fNXWyXKO5EBs15a9I25EIY0jBFHeCL7p
	 eiG8ZEmAXLK9IL0gobUAbE9QSpbvdLR97uiifpa6VBG6afA6TRUdPgkWRto/ojO5cb2FX
	 ZX4FUX1TuStgtOla7Az3jK9aVUPfv7/6wRlGMldE2zCMR/28bneY1NucuSiKUdzzdpbCN
	 +XvnTN+Cv8Jiz0eOztB67vkcC/bqA7HzyJdj8+vhsmNjg8cgW+ZpOPMHRPtfjYgD6lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BZ2SY9GT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772D606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9772D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BZ2SY9GT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795622423;
	bh=EPF6f6alhgQr/AI1kNC14tYR9zul7jcOqdNxhdYAw0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BZ2SY9GTCikMIkhLAr6Bb8uTZ3ecvWNSzm2QwvpKjhBFycG8GimW6B0H0wCgNI/tX
	 ToWjNfJ3+7NB/N1gnczTIP6cKUqbKB34wA2RW67VHH92NIVPaUvt7Euyzm4DChoOxh
	 X6R9OG9332gAihE1KhYQNyGLuajonUn6fpgqjzSwsGpKXN/37xoOPf7mPHtMmVEISt
	 Gkq9JU9uHXC45OdFFjq17+CmFhjNHF95uDfca6yaz6f7Mc+FfzC3QFdHeoB8z4CSiq
	 Ckb89iAxzfqFEG0jtS6U1AEsFxqm2myvoUu+C453wMEAdxSwdExeudlz/Q7tVO54q+
	 p4KKb3g6iSHeQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D2D4417E0CF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:00:23 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/3] device: Provide Security Level props when kernel supports them
Date: Wed, 25 Nov 2026 17:00:16 +0100
Message-ID: <20261125160018.590013-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125160018.590013-1-frederic.danis@collabora.com>
References: <20261125160018.590013-1-frederic.danis@collabora.com>
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
v1->v2: Retitled from "device: Provide Security Level related props when
  supported by kernel" (subject line was exceeding the mailing list's
  80-character limit with the series prefix).

 src/adapter.c |  4 ++++
 src/adapter.h |  1 +
 src/device.c  | 13 +++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 112312651..12d7e8246 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11409,6 +11409,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
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
index 63016c8e1..74e866108 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -294,6 +294,7 @@ enum kernel_features {
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


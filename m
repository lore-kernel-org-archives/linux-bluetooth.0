Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514450;
	b=tdnItxQBe+oiPnQCDXsvoRxOab+0HEUK9otX3vuzNRhGBGBDWwH+nKd2GWV4Blv2oBqR
	 JVRSeS5qERVIZCccm+yv7KvB3yg6xsoUdpawCeipyQQuMhGk3xe0Ktnc2qlDgoqDUqhtl
	 XgW3HBTyWHbeb8RjpbdBePyklPW/ycJN7z0W/gcjZ1I1DM6c4I0uCyPacGrm78tyO/QNc
	 H7i/E29QIfoFW5qGX+0tOrZh90k3sMpT8prSG1KlM96NkfJ6EritskztReRGLO89MIjzP
	 HxA74THYMrFh1xOnZLva+6RZ5uoz9AUAsGuIjeEPmj1QKNJSB2uthUBmCpJj/cR4IBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514450;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Oh8kALDVGvY+D8VC9KBOpFvoe9iq+8Lh68dePCmHLfw=;
	b=DuTAtQcj8lNIGTKvQFvU9MA07+pI7WDZKgGGBpyvEk6T/rKEQEW4ZX2/CjxkbYpLsrSa
	 FghaEWtStui4/rKz7mziR1p6SecGlWwk5gpYMkmcEpcSuREN9358XgSJsemFpfbzuXR1x
	 m0W8pxK8YKU1mzAO2hYGEz/vvAAzu6CkZXoJjYD/J+/zsHTa8kzL0X0G3TAPGwBC+Tb/1
	 4N9LitYO4bE+sxPE6Jxl8OE7q1mBX/Oaej0hPCzqY7P6NY9erDssUdtczmxqmIE+4L018
	 sppGblXC2Z4ZwgN79NPKbksZ/BlZY0sWczwvrUPUY0koga4B7nMSw/mnylLPTQXlVuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="Wal/BayR";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB7606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEB7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Wal/BayR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795514441;
	bh=5f7I/rs59dO/02bGTLF/ynNYRvEKFzPQTX3LuVuXCxc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wal/BayRphp5CPCXDsAi5PhU7zvQwrhDF+5dBoUecKZHeKHYRrqCXVa46Amo/o/pO
	 RNznD6Tf6EKcWjnk/iiLL3wcJsYeu3eZThbZbsJQAfW+YZ+4C1ew6GVyvxHYtl1xq/
	 Bqsnrykfi+i70m1foW7DgmoxhE/ehbgM/TiNAftW6tFGpu6kUV6Zl/+TOLFWXkgp1A
	 Z1EQIsDYsln/kbKHD+X8hairl7T+qG2NDcJ7yyTLO60Xva2Jl9EvUkJU4j4lZy3VKN
	 pKlOucAXidREHo0JLUP8hYHwcONM5Ez3edPW3+TNUNPIYw7kep0wywPdOs47obquuy
	 vpgAOcx5thrWQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4CA8217E09ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:00:41 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] device: Provide Security Level props when kernel supports them
Date: Tue, 24 Nov 2026 11:00:33 +0100
Message-ID: <20261124100035.245953-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124100035.245953-1-frederic.danis@collabora.com>
References: <20261124100035.245953-1-frederic.danis@collabora.com>
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


Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD75369D71
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480613; cv=none; b=ByR3GJMu22sZ0TEXEeetJ2jJvmghf5zC2tvzaOcyxgg4NsEYf2fmA2tljoMfeEctnBZAvbh/TK0JjBYtlByo10Zlm9dlSzbZoMUUSOq78RFMlY14FMSOahj7QCaQ1GAvBZQZ8g+mtm5bz/OcY8WV6DhHGd4udicWzkGG5enikHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480613; c=relaxed/simple;
	bh=d21FiCqLKamxIWRWYyMQDpxRCgqHxaR8WzonKJrV4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxjuCpOhbPNIv+tTCYADBiIQD08mqLkgYHPahyO3xWU9iyt9+hZ9NX/SQVvpswn1k9AZrbwTqfTbGeAzDZwFsmhv1RKdP7I9V2jTSJHg8DYJHHcfrRuAuaLBNXGZik/Xp0lAduMP1NG5JjtSku8oBaZkj3D3zVItBOODHu2Q/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=MWLRNtlk; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="MWLRNtlk"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2911427eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791480610; x=1792085410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L35wP0WkPyHLnL0l5gcSmULRno2ikdVqSpT5B0+inNo=;
        b=MWLRNtlk6gvNTBJ+c8q6OnSqbUGk8CDLXYjw0OBohT43MmE17NAWXW5fUb0bAR4J6q
         BBwmdWXWc1UztMvyM54h0p0dbtDxkX1UxLkunPNkuNacpkvP0QPcOHtPydS+zMbW6D02
         GvqcJSA3ol+AykUYJ2wCYfDI6ZJRRoufc8Y1TK2lMNJEvpsIPFYxC8AlILG6aUAL/9NC
         U0rCK7S81kRLuG+4JStav22hrEQm7Rgi/+DtWSWcBms12pUD6aaFpeM0Y4ieVmYElRRG
         XUFOE2N5TxzMULrodDhjUX17E6II9wv0sBNQndYgfyysDWTqSKEy1TKGaz4HDyT+IPcX
         dDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480610; x=1792085410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L35wP0WkPyHLnL0l5gcSmULRno2ikdVqSpT5B0+inNo=;
        b=r7w7vkb3Uv3pmzEcH2HlWxCsq3ssABrefu64ve3pofXaHaMB41KvhgegJmBeWyKlOI
         2gs0nk4pBAqazdTP8ql/RFGhNo+vZfSvbeQAyramMUcDvGEko5QDo3zHrYRpib/VZ3kr
         TwQKbGMMz/IIZYLy5PZyPCfBxsnAuY2sgG8rSHJmSBW6ibdDtVa8FpYmh5BqVUJTViF1
         xE3Qi5wjHbmXPA19sdUDQAROK/yCgP2F9IBduo9eAGBk/AUfYUgyM3zyULIQUDazNrKX
         12tbZaJRKuYrS/DCQwucDdyNp168Q7svcFpLniZipyy63Ww2gYpB6gO0lTilKJBH1u5b
         vfWQ==
X-Gm-Message-State: AFq9FYIcQgDz6Wxv0N/0PmXG672DBh/PZqbgzW3oQmo9S2iZW4IHE7KG
	0u+64Awn4Gzep/y6CU6n7siMLUBxJ+zPNDjSHcYYJO8K0+O5MFNDBrddprHFnQabT8APNMwbznM
	Sk5Q/
X-Gm-Gg: AYBFou2U5mGjm+4Aqo164GZ4SCdR6GZySGC/EyzsG5M0Mp820zSHhUxJ6E75Jls0+c7
	sQC7Dj1ZrVhH8X4LH09sDN6prUknhmvNWMDBKH1MI4K5+k1udTJNNC+hNkwL46WLqjT1tYWK7E3
	FS85JPfwI0swrlgNfiEnOQ/AzBXnNtMwU7OLf/FPlWx9cxZjpmkk11dPeqOXpw303ulN1tas8M1
	160Q2WofjhHhGynO6Md+caW2ZS3I0SXbitXdnT2GJZktpABDz0G57iw+aAf1VG+4OV4BIiApa3e
	u9nQ7CyepYH0sXSwPYOGyAM7sA6l9KaAdnTn+mTb43N+kWZzkLetUcPjS70pVm+6bWyIeZo8Mok
	Xl1GVIuyUqwIQ7A5fuLWwBdOSK+r+mIclpf0qqZduM7R6FgBhNyoq/0Zpmi90UiGGFaKtxTvtFm
	y3tnNfnAt8Q0vCXY2reSLA+qJ3IigvmWdWZqHoiWB8W15V1DlDGQS+RkNIbdzqJ3cpPSV/PHRDe
	kcFvQtmOI8uVVt9O5+cRyHz8lm+48OWHoMSBcQ8M+6rKhDp4JU7jQ0SqOG3qwTaJ2igJJXSGi1w
	g2ARsNFyUhc3Z6OKN50hTp3G0dwrcsVMe0e9rWka
X-Received: by 2002:a05:7300:dd06:b0:34c:8c69:529d with SMTP id 5a478bee46e88-3515df5edaamr7331822eec.26.1791480609945;
        Thu, 08 Oct 2026 10:30:09 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3535f385672sm41804eec.0.2026.10.08.10.30.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 10:30:09 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 2/3] bearer: Add Role property
Date: Thu,  8 Oct 2026 10:29:59 -0700
Message-ID: <20261008173000.3615-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173000.3615-1-kevin@simpleble.org>
References: <20261008173000.3615-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements Role property for the LE bearer using the initiator
flag of the Device Connected event, which the kernel sets when the
adapter created the connection as central, and emits PropertiesChanged
along with Connected.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/device.c |  5 +++++
 src/device.h |  1 +
 3 files changed, 48 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index f3b7a2337..25224dcc7 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -274,6 +274,34 @@ static gboolean bearer_connectable_exists(const GDBusPropertyTable *property,
 	return btd_device_bdaddr_type_seen(bearer->device, bearer->type);
 }
 
+static gboolean bearer_get_role(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_bearer *bearer = data;
+	const char *role;
+
+	/* The initiator of an LE connection is always the central */
+	if (btd_device_bdaddr_type_initiator(bearer->device, bearer->type))
+		role = "peripheral";
+	else
+		role = "central";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &role);
+
+	return TRUE;
+}
+
+static gboolean bearer_role_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_bearer *bearer = data;
+
+	if (bearer->type == BDADDR_BREDR)
+		return FALSE;
+
+	return btd_device_bdaddr_type_connected(bearer->device, bearer->type);
+}
+
 static const GDBusSignalTable bearer_signals[] = {
 	{ GDBUS_SIGNAL("Disconnected",
 			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
@@ -292,6 +320,8 @@ static const GDBusPropertyTable bearer_properties[] = {
 	{ "Connectable", "b", bearer_get_connectable, NULL,
 			bearer_connectable_exists,
 			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Role", "s", bearer_get_role, NULL, bearer_role_exists,
+			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{}
 };
 
@@ -416,6 +446,12 @@ void btd_bearer_connected(struct btd_bearer *bearer, int err)
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->path,
 					bearer_interface(bearer->type),
 					"Connected");
+
+	if (!err && bearer->type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					bearer->path,
+					bearer_interface(bearer->type),
+					"Role");
 }
 
 void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
@@ -444,6 +480,12 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
 					bearer_interface(bearer->type),
 					"Connected");
 
+	if (bearer->type != BDADDR_BREDR)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					bearer->path,
+					bearer_interface(bearer->type),
+					"Role");
+
 	switch (reason) {
 	case MGMT_DEV_DISCONN_UNKNOWN:
 		name = "org.bluez.Reason.Unknown";
diff --git a/src/device.c b/src/device.c
index 1ab4e5342..4ccafd15a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3869,6 +3869,11 @@ bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type)
 	return get_state(dev, type)->last_seen != 0;
 }
 
+bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type)
+{
+	return get_state(dev, type)->initiator;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index 756540056..5ead73958 100644
--- a/src/device.h
+++ b/src/device.h
@@ -129,6 +129,7 @@ bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type);
+bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.54.0 (Apple Git-157)


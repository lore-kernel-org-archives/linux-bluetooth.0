Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A673F0A8C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387258; cv=none; b=rZrU8PM0dYJGE90+gfVQXNpKuNFHpbh4qcmSaF1dBUZS42IZVIDYsLGEjRrPlaMsKJI6a+C8yTsxEl4PkK+mQMwnLCJwaQR4u7NrhusMu0stAo9mBsTSTW9XDXlZEySPF2uDpUlIzZVxKl2riIzCYyAhQyD45r1IuVC5TwvUF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387258; c=relaxed/simple;
	bh=kSLplDjiJeC9hydDPWWSlAbQuzNkls6UZ9tZ5ODFMtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh1Ys980kRna9DSQsIDb+qUEPaHh+zFK3JLEoe7KMs1rY+LmzJaTwd+NiwIcr10MIB0L9a/kJyzzdpNnJ/PcKDconMBSSgzpDcjkYHvZBafPZTfk3axfsa6Ol0iKW2RS72iQovU5lwUBITqgZOHgfpYg78vm9S7xKJdnoHJZY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f9D84SbR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f9D84SbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777387254;
	bh=kSLplDjiJeC9hydDPWWSlAbQuzNkls6UZ9tZ5ODFMtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9D84SbRhx495ST3IBOQroPrx4Va1l3/2MYfl1xW3fVvB+ZJ+Q/SqUSpLa1XZqarL
	 hZ746kxHlSqtOFzBd/1jZNDfN1YeL+MsP/To24FzXFgUrJjJENcWbyUMjUxtonwLW2
	 TrtUbAbO9sAfL/75yJ5kE6mwzpPsrDPAMIF1dHSfRg/+wAf4Z25hApcdcQhXV9w2oH
	 CMpmAuw1jfKQcrdDzpMTFeaHFxM6Xss1EK3PIc56WUywF4SCumvEGFOrL/wawdg4LJ
	 zUvciMn22vRFP1QLDMpV/Fd+ussaHRsDHpQdIeJTXvN+sbES5uJgczo/7w+tZ3CgCI
	 ey59aXhhhcMMQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4975517E0EB6;
	Tue, 28 Apr 2026 16:40:53 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v3 2/2] client: make advertise.name use public broadcast name
Date: Tue, 28 Apr 2026 20:10:08 +0530
Message-ID: <20260428144008.7487-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428144008.7487-1-raghavendra.rao@collabora.com>
References: <20260424141831.9172-3-raghavendra.rao@collabora.com>
 <20260428144008.7487-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

---
 client/advertising.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 8ffbb085b..98e3895c3 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -31,6 +31,7 @@
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 #define AD_PUBLIC_BROADCAST_UUID "0x1856"
+#define AD_TYPE_PUBLIC_BROADCAST_NAME 0x30
 #define AD_PUBLIC_BROADCAST_SQ BIT(1)
 #define AD_PUBLIC_BROADCAST_HQ BIT(2)
 
@@ -1016,6 +1017,62 @@ static bool ad_is_public_broadcast_uuid(const char *uuid)
 	return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);
 }
 
+static bool ad_broadcast_in_use(void)
+{
+	return ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid);
+}
+
+static bool ad_has_public_broadcast_name(void)
+{
+	return ad.data[AD_TYPE_AD].valid &&
+		ad.data[AD_TYPE_AD].type == AD_TYPE_PUBLIC_BROADCAST_NAME &&
+		ad.data[AD_TYPE_AD].data.len > 0;
+}
+
+static void ad_print_public_broadcast_name(void)
+{
+	if (!ad_has_public_broadcast_name()) {
+		bt_shell_printf("Public Broadcast Name not set\n");
+		return;
+	}
+
+	bt_shell_printf("Public Broadcast Name: %.*s\n",
+			(int) ad.data[AD_TYPE_AD].data.len,
+			(char *) ad.data[AD_TYPE_AD].data.data);
+}
+
+static bool ad_set_public_broadcast_name(DBusConnection *conn,
+						const char *name)
+{
+	struct ad_data data;
+	size_t len;
+
+	if (!name || !strlen(name)) {
+		bt_shell_printf("Public Broadcast Name cannot be empty\n");
+		return false;
+	}
+
+	len = strlen(name);
+	if (len > sizeof(data.data)) {
+		bt_shell_printf("Public Broadcast Name too long\n");
+		return false;
+	}
+
+	memset(&data, 0, sizeof(data));
+	memcpy(data.data, name, len);
+	data.len = len;
+
+	ad_clear_data(AD_TYPE_AD);
+	ad.data[AD_TYPE_AD].valid = true;
+	ad.data[AD_TYPE_AD].type = AD_TYPE_PUBLIC_BROADCAST_NAME;
+	ad.data[AD_TYPE_AD].data = data;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+					prop_names.data[AD_TYPE_AD]);
+
+	return true;
+}
+
 static const char *ad_public_broadcast_state(void)
 {
 	if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))
@@ -1202,6 +1259,23 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 
 void ad_advertise_local_name(DBusConnection *conn, const char *name)
 {
+	if (ad_broadcast_in_use()) {
+		if (!name) {
+			ad_print_public_broadcast_name();
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		}
+
+		if (ad_has_public_broadcast_name() &&
+		    ad.data[AD_TYPE_AD].data.len == strlen(name) &&
+		    !memcmp(ad.data[AD_TYPE_AD].data.data, name, strlen(name)))
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+		if (!ad_set_public_broadcast_name(conn, name))
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	if (!name) {
 		if (ad.local_name)
 			bt_shell_printf("LocalName: %s\n", ad.local_name);
-- 
2.43.0


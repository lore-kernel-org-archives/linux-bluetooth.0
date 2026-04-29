Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEA1A6836
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443074; cv=none; b=AT+AWT+zn0zBAKbGG0tDfUBacc8GE0CeslLGjkrNADRtM6QPXgxV2sJuJs5gda+C28vGA6XLU5j0Dut217+qnnqwQ3kfy2SPK8yAu5Hlrm7n+5ClTg4Xp/2HM3WG9LLuHZCRINZDp7QOMHriJuxtLH0Y7euvMS5q+Xz+/J7QEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443074; c=relaxed/simple;
	bh=kJIS6DUVtGKqt/Dh+8Pv9JSBrdM30xAUCAJEkFZaum4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaZg18JwGDbtijmmorlA1/w+Wi8y+gOyH4XBtQU+IsE0NgqyCPNFf8Qa81RjMWJjyxEVbZU3MAKNeLB2cxOTOmv8eg1lkADLxpHl3eQJSehub6epgyQ/VA1KZLCLvZaHcKq3nx5WjMl0xmMD1imRkTgdiCrgWdQ+T1QxYgmukZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c1ZW3QCD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c1ZW3QCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777443071;
	bh=kJIS6DUVtGKqt/Dh+8Pv9JSBrdM30xAUCAJEkFZaum4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1ZW3QCDuAkE5+SVCLq9O+SeH5EILGLKaxuAJ1NM2ONYq4S/N48U0qzbuVcGFasDp
	 CEwzU3Ji32AgkwycSDyPEDwcn0bnPm6mybIvH46zrxf6nLE/BU3ISuIlgfBgOWA1v0
	 IU5MaDGtCq7IGwtsZH2XEN73bIdRgUqWqf806yxFfrG9HJUe4xQ9nO6jpOXe/OwKGl
	 Ar8xlY1jKM9mKieobNaIDGxQ+DwxCQUiVb44NELExKivBJdtTJEhU/aKFOEstiRFRC
	 elCteiqqFJ47owXCk4O6hOdO+T6lqU2uSej4wNmKw+sIkCljueEDpqhiTYbRgbjgD+
	 BQK4B9O0nKMmQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 672B917E1227;
	Wed, 29 Apr 2026 08:11:10 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v4 2/2] client: make advertise.name use public broadcast name
Date: Wed, 29 Apr 2026 11:40:45 +0530
Message-ID: <20260429061045.9115-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429061045.9115-1-raghavendra.rao@collabora.com>
References: <20260428144008.7487-2-raghavendra.rao@collabora.com>
 <20260429061045.9115-1-raghavendra.rao@collabora.com>
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
index 2fc2ac9c6..5ca391635 100644
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
@@ -1203,6 +1260,23 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 
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


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F083BED11
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040346; cv=none; b=IwOxmqthmKufa3pzhOmSOtRJ3tZdR+mAULKXNVKl8rOs6mieQG4uJ90tuJkLuzJ1tLk/C82i+CMWgOFFEcUnYCPw3SOVWiBs6V5PiNt4AfP5zXIUzRgygkfLw/i9dkONeg+72Md5GTS2gMh1Um16Znppcb2/QjAoKgR7ODb+Qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040346; c=relaxed/simple;
	bh=wgpPWBB8Gz5/wkOI0wsYO8RseDLhg47JzFiPbaavEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xto3z8uV7pyZBjjnpcyYfxBWcYnYCB8lUp8iLWYq+CSsxF7bEpks3ZGXdDeQ1ZJAdrwFRWHeJIFwYd78CPtr/SIPMECZJzHglW7OEIpsrPHow8F04a6hjO5U7ICofPDSTuQhQlw5w7nw877Jk+aZ8uN/Bwwt6qXM2X9pYO3aJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fd8zrqJ5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fd8zrqJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777040343;
	bh=wgpPWBB8Gz5/wkOI0wsYO8RseDLhg47JzFiPbaavEy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fd8zrqJ5LQli3SYc9vX9oK5fPxb1YshUREjeEyi26jAqN3Sr0WZ4XbsXkUaLFAZfY
	 jmCw5KL3erVN7XxEIbcedOsSCLj5Zsg43TL3+W+gc8YYmuKmUp8c3TBHevSHg7zkkL
	 9FzP3Wp00bg0bp6dGWY7CQyaqPXJgpckqItQd9BuZlyzonIbrL2XZXPD4vky9QXnlJ
	 ej7KeUEaYv0D8yezzCnCVmzlZbSitSNI2kSko+flaEoSxyCoRYlo4mx+CzEXWiNVB0
	 k1nhn833s2W/HyNwR+8Sm/k6ZdkEY6xnjZHO05i3ewsNeadiJ5bN89pSSFldng8AJa
	 wPBFExr7lIyuw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7672417E107E;
	Fri, 24 Apr 2026 16:19:02 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH v2 2/2] client: make advertise.name use public broadcast name
Date: Fri, 24 Apr 2026 19:48:31 +0530
Message-ID: <20260424141831.9172-3-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424141831.9172-1-raghavendra.rao@collabora.com>
References: <20260317142645.6332-1-raghavendra.rao@collabora.com>
 <20260424141831.9172-1-raghavendra.rao@collabora.com>
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
index fc51f8193..6921bedec 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -31,6 +31,7 @@
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 #define AD_PUBLIC_BROADCAST_UUID "0x1856"
+#define AD_TYPE_PUBLIC_BROADCAST_NAME 0x30
 
 struct ad_data {
 	uint8_t data[245];
@@ -1014,6 +1015,62 @@ static bool ad_is_public_broadcast_uuid(const char *uuid)
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
@@ -1200,6 +1257,23 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 
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
2.53.0


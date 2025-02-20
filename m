Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628E15A85E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036297; cv=none; b=Y5KZC9B59lnrAIHGMSaqp26yOsBV5PRyse92YkfR6hdS/8dH+Km2pOTpQdV18NjAK4DIMBX2erVDHn6IFWmFZniPOwPIhIoU8KFdvihzzhdUaPGw4V8m6UffNWSLmGCb1nQ2Y4TwcBMgtrsZsdPYC3UfW66+JrWJ9hb1IQ38EuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036297; c=relaxed/simple;
	bh=NVM1StJa1UKiqlIJAYv2u35CH4SdfEwwoIx565awZmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZJXWlBecCdfSOOR8ZCfVC7fHL3BkdNSwFPIgSVF2lz9g1fcYxfN0xLrzBTJIWurysCXhIYZ4Sg5O8MLQBs24D/nLy2Qtwbob1hJAJKhfZeRisoEdFCfeg2Ii6EJ720pKn8wrLJJMfjTKQJwF4TApH2yTaZ/WFEFHso4Pt7RBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qhs0GiuW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qhs0GiuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740036294;
	bh=NVM1StJa1UKiqlIJAYv2u35CH4SdfEwwoIx565awZmI=;
	h=From:To:Subject:Date:From;
	b=qhs0GiuWV1vy1HVfkSHCtloTJvB6dFWPREm9LZnR89tyuppiHtmC+dEjgPR7H2Jsf
	 464+VQPfB4b98mTpkdXp9CJRiqFxNLCPclku73sRjvwvgCn5xEtNL+BmlpSd1m5ELc
	 wAFGQmI8+yoMTA6re0/QJPBuvSgq3yiX78vyWuhnbeGvL9V2smX53r0SFBjWYco+gr
	 75BwJbWNTfXRU/2lo4GYwzsN6+pk+GFqFt3Cu/kU1FYDtVHKTY5nIClYD/HKOM7cpx
	 Xg6wsH+HTnvNgwIiARAtHJnESDhlcTSzBz2MxHb7ZYeOwq8XocO1P9FKct5+Mj1IiN
	 jHgJJ2uZ3AJAA==
Received: from fdanis-XPS-13-9370.. (2A02-8428-aF44-1001-98Fd-0e9A-da79-5443.rev.sfr.net [IPv6:2a02:8428:af44:1001:98fd:e9a:da79:5443])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E823E17E1558
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:24:53 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] obexd/client/map: Add SupportedTypes property to MessageAccess1
Date: Thu, 20 Feb 2025 08:24:45 +0100
Message-ID: <20250220072446.190256-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This lists the message types supported the remote MSE.
Possible values are: EMAIL, SMS_GSM, SMS_CDMA, MMS and IM.

Those values can be used as message type when sending a message
using PushMessage method.
---
 obexd/client/map.c | 47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index b8820335b..7ca33cfe0 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -51,6 +51,12 @@
 #define CHARSET_NATIVE 0
 #define CHARSET_UTF8 1
 
+#define SDP_MESSAGE_TYPE_EMAIL		0x01
+#define SDP_MESSAGE_TYPE_SMS_GSM	0x02
+#define SDP_MESSAGE_TYPE_SMS_CDMA	0x04
+#define SDP_MESSAGE_TYPE_MMS		0x08
+#define SDP_MESSAGE_TYPE_IM		0x10
+
 static const char * const filter_list[] = {
 	"subject",
 	"timestamp",
@@ -1992,6 +1998,45 @@ static const GDBusMethodTable map_methods[] = {
 	{ }
 };
 
+static gboolean get_supported_types(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct map_data *map = user_data;
+	DBusMessageIter entry;
+	const char *str;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+	if (map->supported_message_types & SDP_MESSAGE_TYPE_EMAIL) {
+		str = "EMAIL";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+	if (map->supported_message_types & SDP_MESSAGE_TYPE_SMS_GSM) {
+		str = "SMS_GSM";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+	if (map->supported_message_types & SDP_MESSAGE_TYPE_SMS_CDMA) {
+		str = "SMS_CDMA";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+	if (map->supported_message_types & SDP_MESSAGE_TYPE_MMS) {
+		str = "MMS";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+	if (map->supported_message_types & SDP_MESSAGE_TYPE_IM) {
+		str = "IM";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable map_properties[] = {
+	{ "SupportedTypes", "as", get_supported_types },
+	{ }
+};
+
 static void map_msg_remove(void *data)
 {
 	struct map_msg *msg = data;
@@ -2201,7 +2246,7 @@ static int map_probe(struct obc_session *session)
 	set_notification_registration(map, true);
 
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
-					NULL, NULL, map, map_free)) {
+					NULL, map_properties, map, map_free)) {
 		map_free(map);
 
 		return -ENOMEM;
-- 
2.43.0


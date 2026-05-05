Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17F3C1969
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967645; cv=none; b=VIDvxG/tqO6zBS+96XdSkhRfYyNmUEA0+EGMQZkGP6vN1ziZoP4+tRH2OPBA3ONACyh0iUNo9JHg/HL4HE67kFWDFMBuAXC4Es2fsEnNaAfx69QL1Qu67+EifO4eGxTtf5vYUs0wGpQUNsFfp0QZ2gPJrVWCgfcTxr3Egkh7sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967645; c=relaxed/simple;
	bh=//WPB2VZafAYd2nUi06O50PH6n8N77CatXZJamYFyfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+aS6suNLP0khTSpKuv4isJ6fiqiBMgi/ccJStQNhdswMmRUuvdosIGjxkaxR2Q3W+uvygOhWg676dM3wtOab2HgFXUevLHmXaRHwCCaOFyQr0mmQy8THIqpkH6OLIU20v5hs3EEk/xHLoYCBnGbAbeNkqjI13ig3pHu35fMlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5C3D758178D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:30:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19E823ED38
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:30:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/2] mpris-proxy: Avoid session->obex dereference
Date: Tue,  5 May 2026 09:29:25 +0200
Message-ID: <20260505072958.2424004-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505072958.2424004-1-hadess@hadess.net>
References: <20260505072958.2424004-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGSdaQg5yVn+hkXwAA8aeo5fKxDOKO2FffoR5JhiL+V9poPHTHofuBuT3pkUQQyhZ0ns9UonxcJJv8cQEDafca04EZOlpiXyrv4yqvhXM0yT908XsKDkEB7teJbFDEXzShCLNiqN/YOJcjrNbjD1qiyqmge1cQgIruHiMDu+9yQbUkccXwCQ87cyWsRV1Md/H235aX4DAg22ah/qSpVfwc7S8NBglofPRbxOku2mlWqZzSDSVMDPGmSMCVtpR4BsHX28kiyrZ1jP5R9s2Eg+4GFJQYNsKSpi18ETG9CcSMxkJxB2XtzSLMz06avYc9Er2GG4axR7DUAiHxcWRqsJ4v1mrL6j+Oe0ODEAxxHiO2GC7JLhW/OFQwDAWnUM/aElB+6yYx1u9KyWEhmYCnfHGsCdgXg82FhFOrmVeL9Igy77tHxgX/yPKKTkzODAQCDmquZxgLiGCnAfTn7e6R5MjaJ518jtl4YGf9aZPfCgUkMod9VLFoUrE2dql4JvywEQuJoI02yKQ1/R5f2Jv5wlgJwsrvpl2l1Ao8SjvWiA+hVCNJot9FRI+b53HUJIO0dqwupO2ojLanIZL8hMOLtRVXDI97Vy27hXvNccdJSLi+ocZdgrtYOWMzjNHWTYVxocmxGNFDf3F53/RxRks+i+KaW53maZLFe4NL66FtJ8MEl1A
X-GND-State: clean

Protect against trying to access session->obex variable that might be
null after failure to create the session object.
---
 tools/mpris-proxy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 360b8ab34469..8c9b01044fe2 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1306,7 +1306,7 @@ static int parse_track_entry(DBusMessageIter *entry, const char *key,
 		const char *handle, *path;
 		char *filename, *uri;
 
-		if (!player || !player->obex)
+		if (!player || !player->obex || !player->obex->obex)
 			return -EINVAL;
 
 		path = g_dbus_proxy_get_path(player->obex->obex);
@@ -2614,9 +2614,13 @@ static void obex_get_image(struct player *player, const char *handle)
 	DBusMessage *msg;
 	DBusMessageIter iter, array;
 	struct obex_session *obex_session = player->obex;
-	const char *path = g_dbus_proxy_get_path(obex_session->obex);
+	const char *path;
 	char *filename;
 
+	if (!player->obex)
+		return;
+
+	path = g_dbus_proxy_get_path(obex_session->obex);
 	player->filename = g_strconcat(g_get_tmp_dir(), "/",
 				path + strlen(BLUEZ_OBEX_CLIENT_PATH "/"),
 				"-", handle, NULL);
@@ -2674,7 +2678,7 @@ static void device_property_changed(GDBusProxy *proxy, const char *name,
 			player->obex = NULL;
 	}
 
-	g_dbus_proxy_unref(session->obex);
+	g_clear_pointer(&session->obex, g_dbus_proxy_unref);
 	g_dbus_proxy_unref(session->device);
 	obex_sessions = g_slist_remove(obex_sessions, session);
 	g_free(session);
-- 
2.54.0


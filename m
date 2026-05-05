Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670E48032C
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978598; cv=none; b=i8DuXDwFnbP3U/k8A1iDNOAXt9owTOuq+20WQ9ifR5Bi0onVssyTPzKURxMR+Sflm8ma1UX8XLkTnlqynMPM5DZDt9QJEwqwtyn5ZOOjmctE92VvQNnIGlEawq5wVYMBLU53UH3uZ/z5euHfitR15WwczNDhOFtOXCv1r5LgUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978598; c=relaxed/simple;
	bh=1oy7d6kB6YrC71bjluy3gr2uXcNxQnP3qwJLpRRvnWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXbYFQbV0/ETQGCoy9ywtKv2ZDMYOr5XdyQ6SI1fJvEwpAw9kSzmphWM5Pw/HeOc+FdCxFuuMUxny14JOgKd7f94TFRjKt7hAE9d/k/Sry19eXyhdYQhxZs3Oykqtzj1uYYTyrWsLfOs3lsYwp5HOqR/VdtcSvxcvwLiDrK0A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 2FF91581906
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:49:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 301D23EC39
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:48:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 2/2] mpris-proxy: Avoid session->obex dereference
Date: Tue,  5 May 2026 12:48:18 +0200
Message-ID: <20260505104847.2550550-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505104847.2550550-1-hadess@hadess.net>
References: <20260505104847.2550550-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTESvVD/YaMWboFeuoLPOmNP9r036CCxDQBdyl8/CpGly0oVqGRnVjGuJHQE6gHbvlfohygZjZAxrS11qhGp5rKIPdcj59tYCHlph0UjknzV58AgZ+Wf9r2WjB91x/rvR77gaTqMRBF28USIaeUXRI41R9Ssw5wdNIUfNty0awgOOGjQm7eKxxcNq8/4j94/aKBOMoPyzR8SrySr8mdT9BP3tjEH1Xas28eQ4hE7Zyt5r7qXD6/YL43nGGY3Thx4qbdYONUPGreL6vXCMmVDla2WWu9OCoszShTvxv5kbrqC0L16wKvj/ZvZurXiB0EY77NHRyXPqCyBUVKhYYvsaDZxVGpDiR3l92gChvc6E5Gs8JCKVMdiPxFX169+VZfAlTX0QLKhBnYAjPtKBlfICsmq1zAD+TczeHaob1wq+CS4VeRXFYm0jwZUpOkKticik/d/6c2P1xkWEP7u1Y54mGoVeVjINvIeExj/qAx1VlQ5nhKCr1ZD3BvCE2+ZCOeIoXiqhHNpLLP+LvIcvUmiu6BrdSQaH/OCmXSKhIVhCWDD10saR+D5WjVvisAHnt7dbmHbMX8DpHDOkDrepvWJ1eOpXAmSYIjLQWtlm6kD3blkAauTJ12AgTaNZ2+ATp3HMQsQ2zjtaRPCAxx74Pnk08gS8Yqm3+VSh1x6Z2iBFYYuBA

Protect against trying to access session->obex variable that might be
null after failure to create the session object.
---
 tools/mpris-proxy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index eb607347aa32..b6fdf15da40b 100644
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


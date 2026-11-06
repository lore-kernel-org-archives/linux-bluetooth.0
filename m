Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952333;
	b=5jRm0ERK+EVFJJEyVqd8TuPWaj/dKyZPuyEBcTv/j8zHrH8PCYTCzZ5kgQDdxUf9j1YY
	 YErAPRuZm/wv2lYVT0L6zyVRNSkiWba+tqvz3qG8umBw99DwqSMnTZcGMM+CIO3mLtY8w
	 vdvQ3B3OxJYRfbi+QGFd253l+xkklkfnatFrOF3V5WgkwpKHj7KacDaeqyFzpUCGSkys1
	 57kqP11hFonUmFzv/W5FAtIG0O7Q4lMHEUOPpiJUm3vkDxlZD/rqn41j+diuXgo1xQ84c
	 JqdQHAmuxp7oE/tnROrD/T8b8aWx/Wofv2XB0x0sryruXADQJl+gCRdLAazg7Cux7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GcSzKvH8gVEA9FCc5KSRkeL72uWsLdhErmbfCH+rbt8=;
	b=Heamq/Fad088sK6dQzFCy4QkxdvzdO7KC7+9OdjLcJ95mSTsIrY5uXo+Anq7PvCcDeid
	 Aw70+RVr75e5S7RZAMSl4AKB6pD0RFPWppgJ+vYw5FaOmAEcm2zhgVD9T2eG0CiBn5Opc
	 aTjg27p+fp1MDZ5+hitJ4UIgl5Kz+oWkBtpcm7m6TouJPEyQFWJ10jEaPkuJYSxyKlXRv
	 0Tnkkq/RSxGEJPq4TldEoJaoBSyW0k8RkHS0lqyiGUSJb+7023eJFoa8ZNiC85W6LLXHW
	 XxeWyJBlfVg076RqPzkfs0YH1f/F7nXUUhlrwv73iQmvQdpGTb03iY35Ax+aRnaPFUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=A544tz6S;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A86606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 08:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A86606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=A544tz6S
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 467313FA7E
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793952325;
	bh=GcSzKvH8gVEA9FCc5KSRkeL72uWsLdhErmbfCH+rbt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=A544tz6SmrHoDtjRWarFrfbxglunxccI0kTWONbXSeJYI1kADt4frReO2cDKBrWo4
	 AA4Xjj7O5MJ5hciXP2W8S6G6HWRCONq4K5P+Ykwu2Oirh8BCTemOoB17rP0NYjd29F
	 zVgbh/MOprn88UAQAuCswrR3AxgAyHKN7lKV3X2Sg4y/sN4VrlYDmgCKAx/3AGMLLf
	 E7cxoKxatoMzOmBmSGnvrhurLAfKA0RiZRCYQfprmnyYPVqibpt7kDJclVQv0rp8Mt
	 QAemkrMNkPZwhs6oYAPH+XZIXRbbOpvWKmHstEnO3lL52pcYtSV8ROEuCS/sTs1qF5
	 lqldYqsDjZsaHSL7H2n84rt9fBAkNTO29t+DGDkkUBKuAGsVFWXfPAxQzMcoSs3/wX
	 bSimdUXsj+ajZlTeP4oDc0jGRc5ragW6SufM2BCKnehqFnokeOprY1ndZilcMYs0+6
	 lQMoMZM+7jTjQgr+xuuBiINozOHvKTt0mrS/zJNBzU6uudHVTmuXz0e6YRM08s3j8S
	 am6zLCy0Qgjfybi2snIBFM3x6tMhuEK9lXJqhOYsOj35Fe0mnYJ2jrSLoSN46BMLZB
	 7g0Uqg2ZLjGCm4FxlYyq+guzXL6uN6gCKQ+SdMf/kiafKHP+XZOVjk6xvyFn6SP9+i
	 NgyCQcSo2E4+bxRLMIr6u2RM=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so694691a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 00:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952323; x=1794557123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcSzKvH8gVEA9FCc5KSRkeL72uWsLdhErmbfCH+rbt8=;
        b=2xb8aDp2QSLJ0dMLeiyzdzsdUJf7ppvQyZZqAhusk2NWYA4ruhoGEvNn14jz476srL
         cg33QsnV/OEWHzzCVasDQXz2fQ6+ORc9/BUpfGdRUmROzK2LjVJhgXxDYQ08eUtw8yVu
         aRa88z7aRao+W1oPOJ55765s37GCjV7MSu9YZeY19I/hsz8Uzs36P35YSz0uU4Z8GfaN
         BeZJkBRvjqaLNc+CnhlwsCgfc+wjBbkfCqprEfKFcCBkdtBn+fi496/zARxIBpJVzuBG
         URzJNld3VuVxk4WZhj28zcQ/PA/16M+saCFGN54V0xgsuzAgURD0asSAqTLRo8iiEEg8
         d98w==
X-Gm-Message-State: APuU4Z9MAktfdRls/5Cw3JyDyi6oRGXCX1JO1pAL9Ae2auw8VA+TUa9T
	SUCQcVVPBcuLy1ojjPSyfpinw9DidJX+f+Tr7IbIqJKn+f7MMd3B6iRSCx+p6WjxA8NuBchf9zC
	moHMk2ocF0ffPsdXWe+bQwUg7MnYOowAUb+vUzKOShAll4Lbnuj7b/F0h+PiDtRRHBzzSjQerGH
	xQbkNLkjI+CLWovK0wnA==
X-Gm-Gg: AYBFou3jSui22PFbQXOdtwbl/cVUkL8cFNDMGakUcbFozZARXM9Gt0wGeoTsosg9qoi
	fsxk77h5edK4qDRQGCiSU66EQUZfy/LzUwGcLldrTDqEsbN8r6bFvMLRwNxAHd83gPxB+kZWxL6
	MsToJApbQzmxrqHH1OMf/EJDMc+bp4DEBdVFVMaHgmH0Bv/V3+OF/lRthMWHT/IadDy4TfAmfth
	g2owwo3vzzBZyHgpEu1M60R1qrYKESo3pFcXf0wH3gANgn4r+ppnEAErHuezip1BxWlOLczb428
	/b2FRosDLRzw+fj99J3Gv+Hnfhg6D9B9aWW9hTzEX3DAUPNSP+nUcFw1YqDfTH7BtZ9sBj1gJ/Y
	OqXrex0+oRIEsmZUpXy/IuuRS27CgWwwKZb57KugklVdfbid+ygxi39gLhkVzSrPTPR/XBSmpE0
	ltg1h/iLv8F3LzzKLgKK2l/ftiAQ==
X-Received: by 2002:a17:90b:52cc:b0:3ac:ffb8:183b with SMTP id 98e67ed59e1d1-3b0db6f90ddmr2025995a91.51.1793952323605;
        Fri, 06 Nov 2026 00:05:23 -0800 (PST)
X-Received: by 2002:a17:90b:52cc:b0:3ac:ffb8:183b with SMTP id 98e67ed59e1d1-3b0db6f90ddmr2025964a91.51.1793952322993;
        Fri, 06 Nov 2026 00:05:22 -0800 (PST)
Received: from 170a83c21f5f.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb766b156csm6022a12.6.2026.11.06.00.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:05:22 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 1/1] mpris-proxy: Fix possible crash on OBEX transfer
Date: Fri,  6 Nov 2026 08:05:15 +0000
Message-ID: <20261106080515.2296-2-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106080515.2296-1-kaichuan.hsieh@canonical.com>
References: <20261106080515.2296-1-kaichuan.hsieh@canonical.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_player_by_obex() and related helpers dereference player->obex and
its inner ->obex proxy without checking for NULL. A player legitimately
carries no OBEX session (player->obex == NULL) in three ordinary cases
and stays on the players list in each:

  - register_player(): the remote exposes no ObexPort (no AVRCP cover
    art);
  - device_property_changed(): the device disconnected;
  - obex_proxy_removed(): obexd went away.

find_player_by_obex() is reached from obex_property_changed() on every
Status change of any org.bluez.obex.Transfer1 object. Because
g_dbus_client_new() roots the OBEX client at "/", mpris-proxy proxies
all of obexd's objects, including the server-side transfers obexd
registers at /org/bluez/obex/server/sessionN/transferM for an incoming
push. Those paths never belong to a player; walking the list faults on
the first player whose session is NULL. So any peer pushing a file over
OBEX crashes mpris-proxy as soon as one registered player lacks a
cover-art session (the common configuration).

In addition, connect_obex_session() can leave session->obex NULL after a
failed CreateSession. In that state a Track change carrying an ImgHandle
reaches obex_get_image(), where g_dbus_proxy_get_path(NULL) returns NULL
and "path + strlen(...)" forms a garbage pointer passed to
g_strconcat(), crashing the process.

Guard all four player->obex / session->obex dereference sites, and use
g_clear_pointer() when releasing session->obex so a stale pointer cannot
be reused.

This folds together the fix originally proposed by Bastien Nocera in
https://github.com/bluez/bluez/pull/2098 and the additional inner-proxy
guard tracked in https://github.com/bluez/bluez/issues/2569 and
https://github.com/bluez/bluez/pull/2631, neither of which landed.

Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 tools/mpris-proxy.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e06b9ea..8547fa9 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1306,7 +1306,7 @@ static int parse_track_entry(DBusMessageIter *entry, const char *key,
 		const char *handle, *path;
 		char *filename, *uri;
 
-		if (!player || !player->obex)
+		if (!player || !player->obex || !player->obex->obex)
 			return -EINVAL;
 
 		path = g_dbus_proxy_get_path(player->obex->obex);
@@ -2614,9 +2614,14 @@ static void obex_get_image(struct player *player, const char *handle)
 	DBusMessage *msg;
 	DBusMessageIter iter, array;
 	struct obex_session *obex_session = player->obex;
-	const char *path = g_dbus_proxy_get_path(obex_session->obex);
+	const char *path;
 	char *filename;
 
+	if (!obex_session || !obex_session->obex)
+		return;
+
+	path = g_dbus_proxy_get_path(obex_session->obex);
+
 	player->filename = g_strconcat(g_get_tmp_dir(), "/",
 				path + strlen(BLUEZ_OBEX_CLIENT_PATH "/"),
 				"-", handle, NULL);
@@ -2674,7 +2679,7 @@ static void device_property_changed(GDBusProxy *proxy, const char *name,
 			player->obex = NULL;
 	}
 
-	g_dbus_proxy_unref(session->obex);
+	g_clear_pointer(&session->obex, g_dbus_proxy_unref);
 	g_dbus_proxy_unref(session->device);
 	obex_sessions = g_slist_remove(obex_sessions, session);
 	g_free(session);
@@ -2816,7 +2821,14 @@ static struct player *find_player_by_obex(const char *path)
 	for (l = players; l; l = l->next) {
 		struct player *player = l->data;
 		struct obex_session *session = player->obex;
-		const char *obex_path = g_dbus_proxy_get_path(session->obex);
+		const char *obex_path;
+
+		if (session == NULL || session->obex == NULL)
+			continue;
+
+		obex_path = g_dbus_proxy_get_path(session->obex);
+		if (obex_path == NULL)
+			continue;
 
 		if (g_str_has_prefix(path, obex_path))
 			return player;
-- 
2.43.0


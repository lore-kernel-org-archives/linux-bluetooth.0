Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675694;
	b=kiAQe231fX3o4RJ2hg6CAZhSR2NXaYHeYgAgWGQbOVP2T+HlWz4S+M4fxWrTzkKYqxq3
	 8CFazTR0ZRBJRchMCAT36fF9Vg1LUJQ1cNrgee2lGV7d93YGL2Ace48331CLdr/WiG1Jr
	 hv09bc8bZzBUwin8WRDa4Ojrld//6y/m36KnV9C4Ifzuvj9p+wQtomnKRNeGysPmJdVRZ
	 rX5gLuGIKob5M4eT6bfMNNnqtR/J+zUsfFW85fK3mnQX3TT25TF1mu+rlC4bn+DPgszRG
	 nJA9M/4pX1bUw0Cgl8+KYTxUs92Dp4z1g7ttPm+6WhGF3+kosB18eSbjIWCWOWOdgKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qdYH1K8w7WsDh2ghihjMdSuDb2TZ6+Qd4sMaL0SithI=;
	b=0cuMXT7Qn7xiKtlnAxZ3tBrg/AcK2YlWNoUgEmMZCQseDqE9kbTEn+GedK5B0J2ajNpy
	 1b/PtJqIDqkhfSmzPEdDuaneTemkRfhX2OxQqCpXoCrFRM1len0jpLtXBx7B3LLGRH+jU
	 9AURj2Y4uEj0nOD8CVJ+0Nu92X9RGy6xsKWgREmD/TZogGzKzojt5HdYUEPg5JWBRNBUg
	 S8j1Das3DG43GIXieh4S4fNDMyN7dcimy45e6AG3kMDCEqezI8sqlKTtHKIRAD0y73JCr
	 inb++r6P2rv2ChOlfh9eCGqBGQG1hoCf0ZNr0t4uAXHe20HXUFE/0cnD4SMbJatrE5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=BCQKX1O3;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B69606A685
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B69606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=BCQKX1O3
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6342D3F641
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795675692;
	bh=qdYH1K8w7WsDh2ghihjMdSuDb2TZ6+Qd4sMaL0SithI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=BCQKX1O3z8y9MUnsGS6tA4adp06i8zMGXlqArdp7uK3d36ppNyx4VykBfG3BvxNqD
	 QRU5S1GkHvLlEZ0ukogtDWHE7G70u1j/ZxPSY/v6A01XteEiTozoZ9wnNA03X7Pxtx
	 MT2GaBivQJRI57LWJYH1vOYxtxAH4GO42/dy8GPATohermxAnkeHX0FP3SFTARni5J
	 ROeRy4tLdVEui0xTAVZMR0he+sq02vL3sVYpy1SJgQQ38KTUyPqRhfiCHycYOnSD1U
	 IediwqAXyp8ET1DVZ2B5tA4OsJ2lz1w0mTh4fqT1WVUHPyK0CHH5gKdclLODaE7Wlh
	 MWztGEtXksteYj+edy+q+3ZG6FMtGi15R7+R9YGDs8QjJQh4Wo/Ozdjfe6qbcDVt15
	 0JlWBxOa6j2ee2A1OTkahbkHv4WiWLS2py7qOONxsrybRWKYpX8WPDSIax1DxmfCps
	 plqLtduOOCGGABz7V2fkXYIP02bgsNbE0NHtzKElOzPUJ/rWpuRqDXSxCIcz6tpbtA
	 LgDhhY0wkUapAl8pHBz8Rt/k7KqFX7T5Y6c8Pq36yOId0zdUNzAd2uhJi1Q/jtuZwN
	 hWaLXtF/HowS86735p+DMJ0+6TBPQVn+G/doIgERA/w9gZp37NifK3EpK8/Uc4GWM5
	 pr0zOPr1JWF9ejsfazAWjaqc=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3b4208826so4732708a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 22:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675691; x=1796280491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qdYH1K8w7WsDh2ghihjMdSuDb2TZ6+Qd4sMaL0SithI=;
        b=u1z117rAPZqNjhFr1+iiyE6CLvmL/JGR5AgiJNQY6vWDFqPkoVS4uCdzKg4rY5YvGN
         aKgGtyBiuz/aJ6bS9E1woCdK0YSHZYa51dbLCCy641iV7kqvGh6u+tlWClHBeexH+c2Q
         7i955RCsHUfbbO+k4kGECp6/lW/0qT51O+naRdg7/5RIkvstqJJkkx7Dz0+Qg++PjKJN
         Psoy356NyO/70hhtPmicLVQap8asfdYt1Ac8oeMH0xMAP/FQPKlGxjD//64qEgB1iWUL
         AUFTSPwILeb3WX0Sj/1d8bmxKHyCGnHgprLF+2jRC7P91Fmal2oQlKwyUD0VaXl2L3Wd
         l9tg==
X-Gm-Message-State: APuU4Z8SP5Mf1T6eFlhFd+EzjOv9dKVSkIEwB2JP2Na2AtWU54SkuKDc
	rPmYlHi7XQLbKwilxOi18kwxX5tecXB8cGt80YflIOtuSzAjHmwU6BIIbKHFgPKn1AU5Is3sYEt
	GdKwqGYFzTE68MbedBHC/DqDwypSpVFIuoK7XHbOmb06c/9+R3vRRyKbDonPNudRpNzKB0c6VSc
	y03xf+NxCLDbVh7aZRzQ9B
X-Gm-Gg: AZFdTZdCWhjDSBLbrvaV98qMdhZFGzAp4OsbBz46TdKwCVSjWX6TThtNJRXSpZUQMEv
	c8vA4jQwDQIDmj1f6DHCyQ0bTfEzDxurMYDeHztl1FvAWiL/tlt0sv2JVfXWAaCoX8bQJR6RJ5n
	EZsYO9Zq15A/HWjfldwz5PxVVGg9wB5bk6E+0fmRO0uagy65zB4+01BJEpFcIkGteQWD0UpczW3
	5HJfDiMdeEQVXg9Y0bJwISKOVOR9xqHbSsMhgpheA5iXaRRFEJ0IYEBJe/9w9o5/tIu/j/o+CN6
	zLgzdbiG5Os2mjJ8y/lbmZigINSlAT6P/adXdBqLtdcd+nFMiv5d7Ow+ApPR7sy/EjqKsiqToxj
	+k8+uwzYXRoLhcbJyXsDcu18FKOmAlBQYSBJqJOemY4G1Arn60+Rpd5vHq5TqbBjDUJdn7wyejF
	spG7Ol/XkbOxffHgh6S1eFaKRnSwbCrFibgw==
X-Received: by 2002:a17:90b:3cc7:b0:3b3:c6b1:2277 with SMTP id 98e67ed59e1d1-3b41c93cdc8mr13827843a91.32.1795675690810;
        Wed, 25 Nov 2026 22:48:10 -0800 (PST)
X-Received: by 2002:a17:90b:3cc7:b0:3b3:c6b1:2277 with SMTP id 98e67ed59e1d1-3b41c93cdc8mr13827835a91.32.1795675690384;
        Wed, 25 Nov 2026 22:48:10 -0800 (PST)
Received: from kchsieh-C1-X14-laptop (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm13787468a91.0.2026.11.25.22.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:48:10 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net
Subject: [PATCH BlueZ v2 2/3] mpris-proxy: Avoid session->obex dereference
Date: Thu, 26 Nov 2026 14:47:58 +0800
Message-ID: <20261126064759.95429-3-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
References: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
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

From: Bastien Nocera <hadess@hadess.net>

Protect against trying to access session->obex variable that might be
null after failure to create the session object.

Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 tools/mpris-proxy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 79cd52706..125bc85d4 100644
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
2.53.0


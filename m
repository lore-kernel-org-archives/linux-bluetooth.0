Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675698;
	b=jrYiwNUjjrTRnBBi9HQMFFAEb5CzF4CpeERI7cJjWyDPhl+wIH5iEhdlUmTe0fN/SqF1
	 AelEobsFXIu7GG1LqLjTHLUdy7PAcS/z1WuiJoQ6l86D3LW4By2/O5uVg5anhO3WNQmbU
	 mDDpI1OV/s4Jslxb7w61IXmLlxZdCm5lfQzgb2HlLyKrea+TmxehGZnYNi+Dc4rjnEZi4
	 qZ+J2ZpKVdtzdXE5TF9TcWybGCmHE7by9pQ9K/PVKOSQcoBT2NVopnz0twz+OGGvfUQ1Z
	 KSPYeLKxYcUPBMGP7xH1Beb2Zg77XUasP5r0tQPXJLM4HKB7E3wypJaf/K6oUadCykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675698;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JJIAUY2TWn2r0xsHgJmvcGao2tDlSK+Gzt1h9IE8acE=;
	b=LeQytsxmmcjkARm/jNAG4LaIiq3LIBKdM2G5kzmsj4Rex9mtAHck6DktXiLgpmb57OSe
	 JMBK4MxscMvL/3k69AF49ec3ijE7PpahyYZBqzPJthU+dSKFKZzqehUU3llg+rRs+e1Vg
	 JgUxFzmgU/h2wLLY5ybkjXv0jLiAAHttnovKH2m9xbynVMZscXR1s08g+cn0rjiAMb9+C
	 PGi1x191SisZaN3FULklqz+h0CC/KBJhZPF73FE0De81mY61jFmPjaR78G5IxFqKHkVI0
	 NB21hgWujS3ucNbqrAfHjr6OcVVf9nnDlElOqm933m9P/I0c8ORqcaBNI4ptsuB/qgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=k3MVnZbA;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFC606A6A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CFC606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=k3MVnZbA
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3765C3FE38
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795675694;
	bh=JJIAUY2TWn2r0xsHgJmvcGao2tDlSK+Gzt1h9IE8acE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=k3MVnZbApj3NzxjM4wq5LgC0i8CKyKnzvirQus49oyBygweqeqauYjmUeys6NBIgc
	 DTakKHrzbVvhMuc6eB0FipC2o7xl6TWQTcX68hJOEroKg08QkCcmvcwFfGqc9zzruu
	 +BywvbsZRWBy3f8+JmxNFPDokPWQ2mZHSEDgMk5xIYdz9Z6B9yDsR5K8kifzxpZQMI
	 vf//I3m5VL9kMXtfhjA8rRphrNjT4i2i6FBUevGjxk8v3qjj3i/8sIcIuQa6LfURCw
	 GgUo6q+IPIifrm+gtMnpqG94txNQZOOnPMGNn4tcIlAoeV0QK0xgOBpAvM1SQiyYFq
	 3NQOeJ2gjVm39nFQWTQrlHBL/iuFj008v+FG4hFURS/7+flMyp1vlcTaEHnsutMenz
	 saPJ3gNBgWAjYJku/pZGES1d4GUcKdx7a/0NHNMrqU88MhLGPfQz1FiZNGrBEl46PS
	 LxsvCN384leIGtoQk7jTqFuU7JOl7rqvhcMPWia8tYHN7dD0aRiWal8bTA+XE8/6Dl
	 QlodPIB0VlP1QiltvHi4c98Dags6nfFAmuMTSBIUYKWzLmxyu1mTbj+N9svcLiFhCM
	 tEoMEBxSMVYQaB+2FLOraAYPce18/CUiS0QvQ49EGVZscaLuZ8Ug+PkPONpORuT91a
	 oqShilA0Q+GnAM1KQ6UKFcV8=
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so1403441a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 22:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675692; x=1796280492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJIAUY2TWn2r0xsHgJmvcGao2tDlSK+Gzt1h9IE8acE=;
        b=pdYkfGm/IYGqcZfzhz6RsEB8RRzdTL16TB82RKPzSAmf2J9qt5taszLSjgHUGTurWE
         +xkucMqYe87vwwD3xS40SoA15wQTYzWGZCn/3Up0aUg8ni4w014pRMmJgqube9JHULc+
         oNhSxHkXZa1VUd6ZBE0JK2LagLAnpwQQDEAT2iQ73QUDwmRVl97hfsIlOpaIUzp9AQic
         yj+nj9dyQwKEir2WL5Hp9XNrG1bRrnvcknCwusWqtUW288tcuo9nnFD8Z4kJT0787dmR
         en1N3153NZww3F4OI0Fpmyjh/DM/kMpyh+p913E/MVVoq0wD+G23jQELSvxwnhv4QTcM
         z9VQ==
X-Gm-Message-State: APuU4Z+IXgZiEr1Yd0vg1CMgYF0N9Rvs9c4f/96QjXuIkRK0vfrw59Tg
	iNvk+tqQCkzDb1EkAWA8eZeVDS1fKnXauRJaAn31WyiLdClO2r+tgqBpKeQEJfXcx7fQjfm/VfC
	sfUcIaaVcSTKLNu9FVQTz6Sh+fU4HlQwvQhWUDcPWxB6vv7l8Pe4zuNmlKiIPA6rzKsUtAWfyxj
	TnQY8Nt8k0EFti+wV1d5Yp
X-Gm-Gg: AZFdTZdw5YBCl892TZfLtefYfVPXhlSeJdA3ZHX9q0jy9p3kVwmEpdbo1dombQrWwQe
	SJ5UcmNwtYQde9qpi6ECPYPy+BWjSdHsUcIJuaeeD32eAaEcGpnrE0L4XRFAi+2RadzSxCev94/
	1g3ZeMqaOYF6uJdIX6piT7UW+cVTkxVNP5rBJ792TO6h5ni29JK1TNNZ+9zZpkHlgpz3sjrfZQ8
	qk3d9eQ14m3sBNIByqF34LPRfWVYlNxvu8AWqHOBp/gat0kFnLbi68+ZejjNHt4npO5BbYgmq2K
	aIfhHG9otOeGqRUT7j/YRlTip47NMVgpsfMWzjSdaZkaDJ12GZro8DYz/7RPEVM/oI+/eMjP58W
	5jQiObpehqy+I50juWLWGSGB+lHCkWmIuPoAoJdvW48bbu+rkT1spUcPSmXRbpRaES3bAIRH0n/
	dK2WgQRXfxGBoQMcfVmp6hZZFnpkZg5QnT3g==
X-Received: by 2002:a17:90b:1b0d:b0:3b4:ab19:ae08 with SMTP id 98e67ed59e1d1-3b4ab19af42mr10630929a91.57.1795675692388;
        Wed, 25 Nov 2026 22:48:12 -0800 (PST)
X-Received: by 2002:a17:90b:1b0d:b0:3b4:ab19:ae08 with SMTP id 98e67ed59e1d1-3b4ab19af42mr10630918a91.57.1795675691891;
        Wed, 25 Nov 2026 22:48:11 -0800 (PST)
Received: from kchsieh-C1-X14-laptop (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm13787468a91.0.2026.11.25.22.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:48:11 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net
Subject: [PATCH BlueZ v2 3/3] mpris-proxy: Check OBEX session proxy before use
Date: Thu, 26 Nov 2026 14:47:59 +0800
Message-ID: <20261126064759.95429-4-kaichuan.hsieh@canonical.com>
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

connect_obex_session() can leave the inner OBEX proxy NULL, e.g. when
CreateSession fails, while the player keeps the session. A Track change
carrying an ImgHandle then passes a NULL proxy to
g_dbus_proxy_get_path() and the resulting NULL path is used in pointer
arithmetic, crashing the process. find_player_by_obex() likewise feeds
a NULL path to g_str_has_prefix().

Skip players whose OBEX session has no proxy and check the path before
use.

Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")
Closes: https://github.com/bluez/bluez/issues/2569
Link: https://github.com/bluez/bluez/pull/2631
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 tools/mpris-proxy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 125bc85d4..8547fa908 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2617,10 +2617,11 @@ static void obex_get_image(struct player *player, const char *handle)
 	const char *path;
 	char *filename;
 
-	if (!player->obex)
+	if (!obex_session || !obex_session->obex)
 		return;
 
 	path = g_dbus_proxy_get_path(obex_session->obex);
+
 	player->filename = g_strconcat(g_get_tmp_dir(), "/",
 				path + strlen(BLUEZ_OBEX_CLIENT_PATH "/"),
 				"-", handle, NULL);
@@ -2820,12 +2821,15 @@ static struct player *find_player_by_obex(const char *path)
 	for (l = players; l; l = l->next) {
 		struct player *player = l->data;
 		struct obex_session *session = player->obex;
-		const char *obex_path = NULL;
+		const char *obex_path;
 
-		if (session == NULL)
+		if (session == NULL || session->obex == NULL)
 			continue;
 
 		obex_path = g_dbus_proxy_get_path(session->obex);
+		if (obex_path == NULL)
+			continue;
+
 		if (g_str_has_prefix(path, obex_path))
 			return player;
 	}
-- 
2.53.0


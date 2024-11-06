Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC462EAE0
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908169; cv=none; b=XY46W/8wDpmtKvHeDQvUybeEalMEIwMQPJxFi1C1I6S2qpuVvaE3VP5il51RWe8wbGEX8Dg/sbfjSQ3d+dpni5KocDpcfMH8Hu+JGpxgxlWS4+KdQT7a2DGXtp5romEg1oAozaEo7h9qa3R3ApOIqT03Awj+kZWbAE0PVbJtJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908169; c=relaxed/simple;
	bh=aydDjS2ytWEgxG5Sp+fDbG/iYHmlX2G+fXz1XgVsSNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgIWDKJmZESGbbU0iv3jcm0eO4JpV4G/q4xNvLBXSakZDaAwFiGnRRmZApApPgK/9UfNph9yw8FEeJz2qihWRgnLYLLhmYzrNUpnZ6WjcMpw0M76v4sG3wzirskAXmMO/QSfUvd9n7g751q2x6m72JwOza4p/8HGqVVbTCSEAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THn6S33Y; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THn6S33Y"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d4213c5f6so2672326e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730908166; x=1731512966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XawhEC18HbAeFb7inIuwdGx5m71o26f+rYCxZL0nH1Q=;
        b=THn6S33Yzg1lYZfGaIY3fMmJC6GxLzaItRIn7a/dLar4fUqBh5LCuTDN6Ovrj9xBGV
         TWAbKI5/QFELT+YmacyhaqZDK/0miQLQU2Pg9Ba3Tm6nw0KVAA6bpGVbZ393zp1V2OWJ
         Ws4F8R8KszcuNpMssSnLsu2Buqir1QNP2oLM65v41xwbiSrbi9AcVoyaFFSzFckrbJoN
         RkkI6FPgEy7VeB3nqDEpuxNmgMjfl0uY2qF6AEz9t7rKDXCLZHqDLmuOHQLikYRjog4+
         Wriu4Y1AVffbOWkMBKWwGlAEFQAMr3AobQDsnmFNr/qlWdp34a1p7Or98jnTWela4PzN
         yZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908166; x=1731512966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XawhEC18HbAeFb7inIuwdGx5m71o26f+rYCxZL0nH1Q=;
        b=NDcZ3zD+nXmlmDEQJq3R4zSzJlpd1VvAEZdJaiTBvd9rrshcgEwSZQwixz9366oXQu
         VAjd094TO2LNhX+3Du1zuzDk+K8BuQ2p36KkPWwDH4vAUk83/zKRuKHW2Gz6FFxi/97g
         jzYp+8l+tW0UDH9B82GEWhEOki9ZOgxjaVXSZi3idtiDyicwUygKPN5kqAFJed+2iBzF
         fVFuPAzzHIsAlJkx1tg8MM7pZ4gGTGoIEozeXYumV96iXYU8h0tU1ofU6Rm09JrBb64M
         FmVSUH4QsK5JH2erS2TiUAkxVnO+2MGEFRe1L0x6LwTGjetfZmlgiR3SxIcElUAZCS88
         nZEg==
X-Gm-Message-State: AOJu0YyXvre8W1VXbPyM7r8Vl3BKC0DgcaN2ndSUgAALk+rqrTzX+8lC
	ly9dUmZSqYZqREN4Idp8HL77upwEw7vsDYeaWblcl5pDgIq7JURDEUoHcg==
X-Google-Smtp-Source: AGHT+IGkHBwaVbMYL0UD5KTdm2lMe2gNS8rYSa8awJgmWvdeF/m8nS25XTEMmAdBNVgdgh4GgLxusw==
X-Received: by 2002:a05:6122:31aa:b0:50d:5be4:c39d with SMTP id 71dfb90a1353d-5106ad573c6mr24030613e0c.0.1730908166302;
        Wed, 06 Nov 2024 07:49:26 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5106f2cb368sm2660558e0c.13.2024.11.06.07.49.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:49:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] a2dp: Don't wait to reconfigure
Date: Wed,  6 Nov 2024 10:49:17 -0500
Message-ID: <20241106154917.64459-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106154917.64459-1-luiz.dentz@gmail.com>
References: <20241106154917.64459-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream has been confirmed to be closed it should be safe to
attempt to send SetConfiguration without having to wait for a period
since the remote end can assume no new stream would be created it may
end up disconnecting the session.
---
 profiles/audio/a2dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 37332abcad57..c97bd6e89deb 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -58,7 +58,6 @@
 /* The duration that streams without users are allowed to stay in
  * STREAMING state. */
 #define SUSPEND_TIMEOUT 5
-#define RECONFIGURE_TIMEOUT 500
 
 #define AVDTP_PSM 25
 
@@ -1398,7 +1397,7 @@ static bool setup_reconfigure(struct a2dp_setup *setup)
 
 	DBG("%p", setup);
 
-	setup->id = g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+	setup->id = g_idle_add(a2dp_reconfigure, setup);
 
 	setup->reconfigure = FALSE;
 
-- 
2.47.0


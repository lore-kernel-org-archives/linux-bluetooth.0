Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56406DDCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045210; cv=none; b=KthqUSzDvaIw0G7tLUKRkbUZl43g6hSs/FV6qxohArvKS/A2ud/Fx1mDo8NAeQeHhpreWmZoPik9OJu4U1x4QE6LTdbwEofJUv68tHZ2TGtjxfd4DCWvDLeQzeNe1e5tjzHFRWHR1KeTzjQsfmNmeHujjP2XB/1AtMIN9pdSJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045210; c=relaxed/simple;
	bh=EZ+x99un9zLvQl1+5eXLsn58qpcw6y0M+DGJm16qZkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx4l7Y9+S7c67qSxw1u7MXk1d2ezTM27fARZQq7g75/V1WosJJaTyR5N2CYoe+z4E8HNagkpWXrO0e6tsdB+sBmO+y5RdAn/WdomlkqSZ4uMMk0eTMTuHTEee3lIyF8WQXGx/4vDqyvMKgsG62+KPc44OsWFMzFasxquotkzMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=pGKU407t; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="pGKU407t"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74068f95d9fso3841677b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747045207; x=1747650007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th+tx4YaPlMp+UOCccUDs5XF5RSNYLMlEf/RvS7xM+4=;
        b=pGKU407tH4ru0ljUXRTTQJdalqfzteqRgYi1H/NlOUQlo5ubha5g418MJLStO/YI0j
         VdHQPa1c3Muqfnt9MxSwKwo6qaxMWMRp1ddwpMjTEp9WcjDs8UJ6760ptsWSE/7fbEYg
         wF2Wx+B39en+ZhSiqk/S7irhtsMQ/BWHUfqKPs3zSJeFfhWAf96RVRy3hSD8kT4BpvQm
         kA4RxllGC97xbRMA3dnXurUYE+eA9FNFeoelnaV3miP+huv6BncSoBZNX9hZdDR4V+i3
         +1HkjsGnZh1R13dhhm4Vev1HWk2+y+JOt46Iwg4igvcQp9AjWHnS4zLCOey4AXRoJ7BE
         M70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747045207; x=1747650007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=th+tx4YaPlMp+UOCccUDs5XF5RSNYLMlEf/RvS7xM+4=;
        b=v0Y6iusomW/ydFbuAXj1ju/gK7kMq6wAGY4RbI8BKkoyoI5el5FL3bmx7D8Dexh1NF
         cOblXFjcdjqowPTB+wOvP8WxAQrgelpnxaatV6yhRDdvM+c9JuTU7WUaAAOgCOKpb3Rt
         xrA+wkx8qWVQW0oxl+Uqaxre6SuijVJus4YwOzEC4SAceWbm5FKs+2laEbQiFrWzBHU3
         +qPHxsp6XxDcZJ3MaZvjC8QTu5EIRm1tmevv9pwfrpl1Yqtu1dpP9c2EbYDJijgJ6BUq
         0ZElvJNrxDgzPzgQE5B2vuhvHn7g344LeBIrUz87Bj0H/yrc4sCwpEh114queFbU6hCK
         uU8g==
X-Gm-Message-State: AOJu0YwFJUW48WdVO27FSy7p/DJzP2yUYeuz71kvX/hOoysUyaXM1Zxc
	tQxLnpoLnOpy0HScv5O9+zHO8U2RN/YQ4Fibo+lL8GMGbE9rr7PA72Zwj0+9CDO6jS/+slyZ1XF
	C
X-Gm-Gg: ASbGncuRJD6F32Zj8xh5ye3MeWCCmb4klaNjGS4ryo/ryyXjgFqAjiZ68gXiPve9/Uv
	qBjUQ6I6I+GarpgTDGHn2ERNDIJ3NclveO93sRkBIE7pVAplZ9MjSJsgQV+MopCPgxlhuq1g4Ka
	tanFbPA7/yl0h8/Jnvp/CUj+wnMiKI24np4aUQpGzOn9erqYSuB0AadmR+31gnUQmCz/F/t8CMn
	fbzg3B4Rq2QK0hloVX4lk6Zmc6BUb6NhVlQxuQlfuXi71cKTBWNhUgYhsjAvxyClcKY7tRZahI0
	PocAT8ZujiukTRd8a6bFmETin3dqwkd+wvSVr2Bf2yTKj/4vmLuH+zcG
X-Google-Smtp-Source: AGHT+IFvXz5llvykreRAFJEX4CUjD3U9hKiBozBC88MTl0xQIKkd0eZw6qf6TbCtUSyOy0zijZ7nHw==
X-Received: by 2002:a05:6a20:94ca:b0:1f5:6e00:14c4 with SMTP id adf61e73a8af0-215abcf2aa4mr16753588637.42.1747045207249;
        Mon, 12 May 2025 03:20:07 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b235252b7e9sm4517224a12.77.2025.05.12.03.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:20:07 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ 2/2] transport: Create media request before calling suspend
Date: Mon, 12 May 2025 15:49:52 +0530
Message-ID: <20250512101952.70203-3-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512101952.70203-1-sanchayan@asymptotic.io>
References: <20250512101952.70203-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating the media request before suspend can result in
a situation where media_request_reply is not called as
the suspend action for a profile may not depend on the
callback of the stop operation.

This is the case for ASHA profile as devices are not
expected to acknowledge the receipt of a stop command.

Moving media_request_create before media_transport_suspend
should not change the behaviour of release.
---
 profiles/audio/transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c5ae3a71b..dc4f8fea0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -917,29 +917,29 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		if (g_str_equal(member, "Acquire")) {
 			media_request_reply(owner->pending, ECANCELED);
 			media_owner_remove(owner);
 		} else {
 			return btd_error_in_progress(msg);
 		}
 	}
 
 	transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
 
+	req = media_request_create(msg, id);
+	media_owner_add(owner, req);
+
 	id = media_transport_suspend(transport, owner);
 	if (id == 0) {
 		media_transport_remove_owner(transport);
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
-	req = media_request_create(msg, id);
-	media_owner_add(owner, req);
-
 	return NULL;
 }
 
 static gboolean get_device(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
 	const char *path;
 
 	if (transport->device)
-- 
2.49.0


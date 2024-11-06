Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972920606F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908167; cv=none; b=LJeu24ltR5H6JLqzMiyikrSWtQ9MyTN1aTUPsA20S1lqC3m1duUX6jYR9RDwP3ID9JATq48TAbFsFsB5zXiRlK90YFKMTRZc54ZCJkFu/CWTMF8VwG+x9Vq+7FhAaPEtTc3WpW7Kmh2FvWkxD9eQ6bdxcmWXvh4yUtCWipH2NqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908167; c=relaxed/simple;
	bh=WtmajaAKL7SCAGCJgufgT8gVMzgIGpSZCIOK/C3+2jA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNCNgjUdrtyWUH8gHSUuVMWM02ZxxhFTMBwenf+5WXnFjJXtUCgGOkXjxA8FyvmMuEyHY9JOyst07xZk/Ceje5K5uj3ElQ4Uw1S2xOef9jgC3MUPBOYmcbpbv6ET0W7Vid//tcSLZr70OwrgVX9Fi9+v8DlmvxGar4KmimJTDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFRjfFGW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFRjfFGW"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so2312974e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730908164; x=1731512964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uznjUIjgVvz5jSsKwX54td7wRj73PP+f+7l3xr4trQ=;
        b=PFRjfFGWtOCg5hNQSrXQ8JBZ+sfnEn9+CWsMWdUi9ML9d60mRe3FWhRksNZy3XbGJ0
         pgVcsV/5CpJIR0ZhuPRCxa2wbs6qDq7SVcWxiFoGAgOIBpBiMfhsnjO7QJ0empvnFg1M
         a0kl7+7EhBi8n1aUqJ1ln5bDeY7x0kSMrSG1hWbTDUiTwWobo4MSe7U/ZkYE0Tr2d0mP
         OWZgOBpy+75M6SjayIN0IdRDojodmSOdbBgFGraSoIr5V+qzcLb+pj49XxD4z2CLQPg0
         jTnM8n/diz1EWiWaNvRLW7Wx9HVf8nbn/q0XJgad/7jgD7nBUwPuvogziR4xIzUsrDLU
         l56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908164; x=1731512964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uznjUIjgVvz5jSsKwX54td7wRj73PP+f+7l3xr4trQ=;
        b=Izh3RvUTk7XscJ5vJm11ijlTww4L7GwzvzjQ47+SJdfrlULcBYrOtGkiGXzUVMs7pN
         zqPGfiQ/dsbe4PY7XwjRlXRyrEGixA6xuo42fl8zWjwi8KRYywrReih3j51v6z1406Tw
         MzXJOl8MSx0sQ8hg8tdgZIJ/kJQT1t0vRgzTynfj+jP2IUWdjXriop2/4wdZeDqsdzbE
         nmj3N9zey3OIfvAoUBsiKOxCxMJ6SjtpFwdYO9Xuol8xxjT2MLdM+U3M5TcXan+OgZEj
         CuyKpjYbREryt8lc71430kao7vF+J8/ogvlaG0gCqHRi8FG5OyZ7vdjf/f/huFsC4alt
         nhMw==
X-Gm-Message-State: AOJu0YyScUvu7nIgIPJJTvJ6BZvQlmnBidwck7SlyJDBHYxOTEv25KcA
	zIDeumEGJrC2frh2XCWXKfZV0iDTUFGPwETmetseLLczaEQXVFfvxlDCrg==
X-Google-Smtp-Source: AGHT+IFMdk06aK14mTIpFfSmM6I2FmFfqeA6867PSne5f+QLQBQO5wbZ8njYn8SUFIKHQ2K2NnxzqQ==
X-Received: by 2002:a05:6122:65aa:b0:50d:85d7:d94b with SMTP id 71dfb90a1353d-51015116a1dmr36224369e0c.11.1730908163812;
        Wed, 06 Nov 2024 07:49:23 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5106f2cb368sm2660558e0c.13.2024.11.06.07.49.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:49:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] source: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle
Date: Wed,  6 Nov 2024 10:49:16 -0500
Message-ID: <20241106154917.64459-2-luiz.dentz@gmail.com>
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

If the stream transition to AVDTP_STATE_IDLE it means the stream has
been disconnected, not the session, therefore
btd_service_disconnecting_complete shall not be called otherwise it may
trigger the policy plugin to disconnect AVRCP in cases like codec
reconfiguration.
---
 profiles/audio/source.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index db777e86d542..885e218bfc7c 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -107,6 +107,7 @@ static void avdtp_state_callback(struct btd_device *dev, struct avdtp *session,
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
 		source_set_state(source, SOURCE_STATE_DISCONNECTED);
+		btd_service_disconnecting_complete(source->service, 0);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
 		source_set_state(source, SOURCE_STATE_CONNECTING);
@@ -132,8 +133,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
-		btd_service_disconnecting_complete(source->service, 0);
-
 		if (source->connect_id > 0) {
 			a2dp_cancel(source->connect_id);
 			source->connect_id = 0;
-- 
2.47.0


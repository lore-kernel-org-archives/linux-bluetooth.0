Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE248B374
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031205; cv=none; b=XbSGuuu1amP2Hfgnsi/LCtkR3IU723seS8Yn7re5HHAGb0+KyKR807XRqJYaqIJ7ENyXvWQTsdjOMWWgE4A4RweQiGBBrGEfQj8bgSGW+GZO3ZLY59rVLlsjh+KpYSZk/6+vjVrwcwM1Ol/VGNWPfNgr24OkeE6juDmJu3dCIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031205; c=relaxed/simple;
	bh=C13DkkUfPWUnmvl6WYwiXwZfoosdazo4tVr1BkmHIp4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QZO5qdYolGO7a41K2QI2hOzjqTMln6RyhyzP4FGlW2lOIJOjvI4WmVgFKtsm+YntShw2GBqXEQSwJdOmzBD3NmibwMtcOaVded1CSX30HfRfnhOrwbOwRTMD1rH4YOte4H82K21Gb2s0abnn1SPdxbtY0b9nTILprvQpyLuKE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbTt/B/D; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbTt/B/D"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so2049247e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031203; x=1781636003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+F4Vc1bpALYMlfn9auFbApDZvGZvqnzSB21LkiyuQ4=;
        b=AbTt/B/DsNzU7R/hWRLZQBBizpQR1nrZpQ4gV0ZACQMAW67AkFVAefNaS+XF2amtDl
         bJ3/ZjNMrae0eRzE2MlsP5Pl55PpswABvBXXPcNt+RlBSKIV6SxQMkj1kJUC4fnKC0Yd
         FKCBYfFWhT/UaqppteP5QvehnOfuyEjbA4XfRlFhADo3wDyZ54hWhA50hfjfo+rK1RE+
         DWWdY0AfHHt6XPR1dQq3OSrICk3Zg+DI38WVKPpXoLmW89KRdRuDVlQwWYDdKhLvij3P
         M1H8oszZP9lj6AVvHMbqpNL6jKql40yILzmXlemxQNDbztk0Q+v9gX49+gYeFcIoJH3l
         Fq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031203; x=1781636003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+F4Vc1bpALYMlfn9auFbApDZvGZvqnzSB21LkiyuQ4=;
        b=qraq28hrKsxOsIAAnBFDxh5F/QSjc5kG0SnCwforU+3MDtmr0+8PR+pYzv8nH6v1+U
         dcTiLrwIy0H3MX7LGdI/FVfaDQT4qScDktoo9pJPuLM89YNtUQ3PvrivsXfktCTpsDM9
         8jQcwTkZSKGfzvgs2ZUrjlc2V+UHChvrTw/1V8vFhuRaYKjDLKIyGxk4v+XapbA+XaFB
         bjqMSO5M0dC/TjZkQpenju9dZQLtralr8okC8OcuLNJtLFgWgm/ojSgNXiCx1JqOZYz6
         ZqucO774K6jplcTBRwIJyaaPXBzL1IdoXuj8iqZmb/4n+9LpyoLQfnSNEwt7CczDbSBP
         fChg==
X-Gm-Message-State: AOJu0YyB5X0LtZktdoVJeTMypPihUwG37qX4YQfFow85dd/rfdva6R/G
	XFs1D61iuj+QYzvPIvpiYqywfnbMWhVe2RAT/31GLKZIZT9iWk/lCBIkz909mA==
X-Gm-Gg: Acq92OHmi0/NuJlkYJakX9blEDFBbAVw1wLE4w/cCFIItU6eN4OtbGH9AbpCBCZ9Zuj
	DEVy92vkLRhD65tRpQTGjI76xDs+Z8F0nOiL5q+6pusFQLUAcAIaZOteLPPGqCCif+6/W2pahbh
	I0JWC1wphwvXQzCSllZKhIXw0HViUH1cEkTL17E0BdqRp3teRI0IEjFlbzaOuo2UXCVgeTePEpF
	0yMxrtNU/KiOafa7THoAQwP3cV27M7TmF7XmF2/lfWUqnYm8xkX9QmTDO8hIE41BmnpvYfRUVKi
	h7VEphjkPA/RGKPvkiS0ARJca+0BzQ+TwieS1UNB1mQdtI1CeXjhAcF3+oKxMNA6o0hjorAjKfD
	WiGXFeMsRbZYtIQIKcS3ytLWIj7IRtJeLoshL2D+kZbBfxBhI4qbdlcFIOuYtXLY15c27CBF+QF
	NNc2hwEtynvjEA89XaFOofteG72jU8T9Yrz0TuzyD8j2svPQfLh3tI9QUSwzekTQdSLv3XNt2NN
	O8cVReSKzjS5xUUHQn7ESkeMKOK
X-Received: by 2002:a05:6122:608c:b0:577:51e4:ef1e with SMTP id 71dfb90a1353d-5ac5291be33mr12389442e0c.9.1781031203348;
        Tue, 09 Jun 2026 11:53:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm17772795e0c.0.2026.06.09.11.53.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:53:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] btio: Handle EOPNOTSUPP from accept() to prevent busy loop
Date: Tue,  9 Jun 2026 14:53:10 -0400
Message-ID: <20260609185313.155105-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
(e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
retrying will never succeed. Previously, only EBADFD was treated as
fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
remains readable, this creates an infinite busy loop that hangs
bluetoothd.

Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
GLib IO watch and stop the loop.
---
 btio/btio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 39d4411f790b..4c69d60350f8 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -274,7 +274,7 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 
 	cli_sock = accept(srv_sock, NULL, NULL);
 	if (cli_sock < 0) {
-		if (errno == EBADFD)
+		if (errno == EBADFD || errno == EOPNOTSUPP)
 			return FALSE;
 		return TRUE;
 	}
-- 
2.54.0


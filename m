Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4410EAC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353764; cv=none; b=AFYoGi63eP5TanUDc75dp4Li1d2eAzHWmhxYlTFTirgZH3NzpF35QIFwq1lmpVS0UzY3lx2ARWV+SlLaPKVcRzfHJnU5jZidML+lJbT+RXEjYX37cD+2cQNH2/CGim/edmS963wP7avZHT0GWt0MY4j3DY51huAXYkZzG1Y9WH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353764; c=relaxed/simple;
	bh=e5ylN8vQtbjw1aAsCYYD/mFgAeLAui0Dm4MbeX1XaS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/hnYqS/YuMmx5g8XO/F0Xls7GyWAQ7npPH7oAvXRJgvb9rHKi8TL43Me1dHyNi26VQbko9j75fSfPbdf3yXmFRMR+qBGagkYPPeXbs124F7FC0BEnoEf3DpP5FQFhQS6HxhhH2VSuvsKtXJLkyAJid9G1ooVf0n8YSpo0/aWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBnp9fFy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBnp9fFy"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792c7704e09so83990185a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715353761; x=1715958561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmN/QXiBT6Q7B5yL26We4foGBdMjdLBvDkyHwtuXyoA=;
        b=mBnp9fFy0xy9hXEwJNUjaSkiMgHeT9B53ZJ5NV3S4WxrJ504IcgRu4q90OlPx4n3Uu
         pAstspa0WsHcPpCiBJ2JbgJTmJL+8CgbR4YkAjTcnCBrMOaHmrZaizynrVukABKyTgyw
         4SXPQQfwToiviu+gIWKkkQw1IsY6SqB18LQtHvnpm1tUXkvf7Nq8kllE6nkdx3uicFFz
         /LEz6Sn2CZJm+niPSi11r00M7MWEfRa+RzqeQL65ABCoZbJC6vngceVTdURP4sb0Ke9F
         sd7Sy7yDd1ghMt6AM4uCYUkwLYSvMFxkTX7mcVxt5ZbIjRto+iEK4y+KoOrC3NX8Y0RH
         g7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353761; x=1715958561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmN/QXiBT6Q7B5yL26We4foGBdMjdLBvDkyHwtuXyoA=;
        b=w6JwZGn6vAbLEt8DDNll5AbRwKmjUFM4+lmB3KlcT73CpZDo1B81k6i+bxVzWHD/wb
         lH1G1n+Ptsw4TAvQrfO0/BL203FeW+CxArvbfo/DPYc8wuhtFh0VpEf289ZQRtFl1/Nw
         mNNR0K9YFhKWn/b0J5EoayFLgA/JBb/8q0cs7qK3/BCb3BIABP3IZaEjReFUXf3de08j
         y8le7gOzj8LcUMJb6cBtdOPpqMUP/hC9c/s7X4aAtbkg3He9LnxPrSsSpfnDCUmvtcUa
         GT6gheK8Ugh0oGifsPCr1mEFFlUGsD+fqEMwVA4CcPB74wxfIucNosjQ9E1TEUAnspIu
         4pmg==
X-Gm-Message-State: AOJu0Yzv/aiDjwNmqANB5+zB7rSsI7C3aJoUtIK4c9+JSn3TKrZ4Y1iH
	otLU2zJoUpjvvOFQtKO06do265Qh4u/0ksW5+yKxuvZhgTnbyuwVtUio5A==
X-Google-Smtp-Source: AGHT+IFZBaFG0pPKfLmsVmRGnZaNKxVxoCDk5xTwbWqckaYl7zO7r4pnDXh2+YVuMGn7fPCfG1UeEw==
X-Received: by 2002:ad4:522b:0:b0:6a0:e768:aa7d with SMTP id 6a1803df08f44-6a15cc7d637mr97676696d6.23.1715353761076;
        Fri, 10 May 2024 08:09:21 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7fae0a8c0c1sm260332241.34.2024.05.10.08.09.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:09:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/util: Fix build error on malloc0
Date: Fri, 10 May 2024 11:09:15 -0400
Message-ID: <20240510150919.1492039-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the parameter order of calloc which causes the following
error on recent gcc:

CC    client/mgmt.o
In file included from client/mgmt.c:43:
client/mgmt.c: In function ‘cmd_add_ext_adv_params’:
client/mgmt.c:5057:28: error: ‘calloc’ sizes specified with ‘sizeof’ in
the earlier argument and not in the later argument
[-Werror=calloc-transposed-args]
 5057 |     cp = malloc0(sizeof(*cp));
   |
---
 src/shared/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.h b/src/shared/util.h
index a8ba23499289..bd71577d60c0 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -85,7 +85,7 @@ do {						\
 	}))
 
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
-#define malloc0(n) (calloc((n), 1))
+#define malloc0(n) (calloc(1, (n)))
 
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
-- 
2.44.0


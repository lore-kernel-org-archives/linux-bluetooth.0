Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521815FCE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114653; cv=none; b=WZo/4FaI/I59rI/sFbVi6VSowzGsrSYQr255knoBZ9H2SxCLIyx9hF6+OSn0efaehTj6cSMA8iSq8OA14CIJy6XifKjLnoY+hYz18M2ZkO7xkjhcDJOgDG54wqa/CBgAkLXg79aGRmIFW2+9yrzywlTVwmJaRbOFTvUyLpXI9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114653; c=relaxed/simple;
	bh=e5ylN8vQtbjw1aAsCYYD/mFgAeLAui0Dm4MbeX1XaS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F077dN5qM4E8QXVoWaJ3GOQ2nbhFwD3QOxypwNXut6AFlAbKp/+kZAMrggWO3lfTGZFXaZE10ghVuprSfWq4YHAx9aJZKhVcJ/D1hsWEu2Znupb434VwfSV9H8SjbyS6WRE8Q0bAYCePa5O+W221mMUsD5m6cqDekhT42bfAftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/iG/tfH; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/iG/tfH"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df1e45461fso1139224e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715114650; x=1715719450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmN/QXiBT6Q7B5yL26We4foGBdMjdLBvDkyHwtuXyoA=;
        b=P/iG/tfHIhO8zn5QhsNzaDawB8uku7tXLrVol05S+ugJqKt9rCOF8jYtjJd9lH4QB0
         olMzupYgmd0hQQK0hkv/Bloeq+K9+hEJQs2YH7iSV/cYZELDPTC3UsFRTmU/4yrGPZlW
         lRQ2iDFUVDOr6kfO8j2youvAYBChxXNP6HPT3NMKZ5RibF9olrY1zoNfHpH2/EREhVZj
         tnL0Cc7Tz8IlogG2qQDQgbYc2IecpgCpujOfNZRgkOFbH4sDCeNphTEtnGPQ1RpvJSUn
         FnL8bEnYOkQUNT0qyc29+g9pAg0v4glJixzI1pUepKFDBWmEnGfVhsYWqDFg2L49hJe3
         rewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114650; x=1715719450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmN/QXiBT6Q7B5yL26We4foGBdMjdLBvDkyHwtuXyoA=;
        b=FEcyCO3Q8UfboT1c1D9XsWQ2st+XezOXGOVxDEh03xTYBtOuPBbHPgGlByQoZYumbS
         yrhRExup0/vgRdf3jt62u7KfqhHAdQf2gFaWEYM24W+UtrFP4rAHslcG1EWBKIfE4LjD
         5ljBKfBJkYAwTmVEvp+qr9YLQQrmhdcD3ixjOt1uQKysBoJBHGWQgL/albrqKKm003z8
         RScxySqQsQDrzbqXsF/JsEdjx00YfCLOVvLZiO45k45AblKS9M40cdLZw9Y2ObVlEIAc
         gGgcaD1gNd+jMOk214cEh9UVJsZeZBjkvut7CVmhhqHb6Sc6FGg4lBBiIdIvRBDkKhMG
         8piA==
X-Gm-Message-State: AOJu0Yz9aerj34Hgwj7jdORfGkjnOwb1DxxnjrdNjAifZBgb8xkZbgx4
	6Zj0gXvOH6kFjP/CxfDQLkyLO4n49Q5/yMoD2mIagW5EUuu6gcWCZQrttQ==
X-Google-Smtp-Source: AGHT+IEhZ4I6RrNdUg/Sn8wyQMle+RaeIN/iCBBeUID0e3PDRdTHvES/4r8TS59lUEscMF353Sqrag==
X-Received: by 2002:a05:6122:4685:b0:4df:18bc:848b with SMTP id 71dfb90a1353d-4df69454be6mr701082e0c.16.1715114649956;
        Tue, 07 May 2024 13:44:09 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id d28-20020ac5c55c000000b004d42ac6a92esm1411571vkl.16.2024.05.07.13.44.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:44:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/util: Fix build error on malloc0
Date: Tue,  7 May 2024 16:44:07 -0400
Message-ID: <20240507204407.653383-1-luiz.dentz@gmail.com>
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


Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A9256C70
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065742; cv=none; b=XsXwQk1lsg1XaFEUyFLLQKpIPXar3QSh24u7woX9HxA5gqiLKqqUa/CMovJRuY/K+Ku7X1zqkjkQ6+bhFQsSIjiOHB9CF8Pte1/+yI2r0ATJozdnc/+gigInr07Iz8Gnwh17XWp5A1xgtrHD5ffOKsoGdjsqlBdJiDnSxPS4yfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065742; c=relaxed/simple;
	bh=TaALAuDJ0TmpYlRGBRWMGYhozlxw8wMmArBCUrVfaSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLfLKqqfKeI4u8vNf2cRcCTjHQ/SeKPIDOmjQ5CCmk6SDL9KjC2KuUiEC7G+6RKRCjLNZdN+nl77Bm50eq0LCYmXvf3JSNLrRcXkQHrabX6R/mpQAJ3GsQE71Zvn7NuGokHPStlBNK43lgw3t5zAt4bjRtvPRWs/32e9ELzeq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huFSbYCq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huFSbYCq"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84537777d45so2843709b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782065740; x=1782670540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wihKiFvuTP2M/6FQn+pGmb07oXm+jqpEqGHMH6pjD1w=;
        b=huFSbYCqLWn67OfMRCHqPeurAj5t0t4CNpWPJ6MoTIjf2BQPfa53KtJfF0IOHOVWLh
         eMUCxzLHqO+YDZU6Vwu3M6P4pUeDW0mOdcyEn92JbPtCeophgw4y+982ZqOCqiVrkn6i
         6jjiA0tlW/a/iDM+FFiFxHHpVrnaSgCuei9esEPqN08z6ZU/5ig3Dc3ntfL/jfkOH2yy
         wNW4HACdkWoYIZyHzKJ7Ouh2Bvgg7YdmG6Qhrwa3bwD/F3clW8WME4gJwGVICpQhp/UB
         QMTKKzTUxJHQ87Xye5zKcWp0s2unHeIfY/5T2ORdevfON+By6Z7aJNqoLUMoET1NHkv+
         DpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782065740; x=1782670540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wihKiFvuTP2M/6FQn+pGmb07oXm+jqpEqGHMH6pjD1w=;
        b=blu6hakuYAABKA3DZ7m9fVx+zPPm1000DtEUZls12eMKnGJD+Sw3HEAM2WMp50qyuo
         b4UKKoQsmAo4NIJ7bhAZaGmL44eqj6Dq1GnJ2zuYdRQMCIyj+DHIHGf7rE84zNIAt2Ev
         dZG2A9ZbYtPkQ5VpIhg1NnzC9g+lAeMv41kRsZSUMwG5fL8y/cZ12PnL+zZW8L4Bhlwk
         JzGPSzlLnZN9F82PeeGajZ2f9yfgoQUSlnv6K+2LbD8rHr92vdC0zmHKenYwQL8E3wl7
         krw+8djBCA+uX5X8hKtVFzCjv5QJmgVPU14PyEuBND2nGqqGdmK87HeaqrX4FxDlno7e
         br7Q==
X-Gm-Message-State: AOJu0YzkyAK0flwcHAZ8LXqPtGagbfsDIggS+NXQd0Do/dxmkgSuhHAd
	KPvKc1FReYarQUCX9whFOZfd9Ifo2guO3VMFaPqQ/WbcDwipyBuUOcyiY2Js4Q==
X-Gm-Gg: AfdE7ckzyVeH+1ciwRLMq0AXf5gQoaUrKYxzTbGDAxumn0d8UzPW5LP0SHJQ0QIGnq8
	CApYdYTMRpHS+mVRtHGYYpcVrH0NVHqqlRwu6ws+IookULdgat1vcI0McH45exvzuP8xVvBYLiQ
	OONz5OfYEtcxxukvA7U5Gg21xr0WuqGXj+oE2tHRSz6nPWttyWkMrM3ZKwto10dK7KLEADH8LqQ
	3123DXQkJ9V2wShEAZ0Rrqj+24Uxg2XxGOQJ2MjNEmB4KBW0fsdc8kb1YN9y8v0ZzTYC9DGKyyh
	WXVUEdtqmzJ/eTWjve2tmGj9HPP1hv+XUElNxsVmIdd7LEYg21b/VqdcZkjR1YcTjhLjnPT4Jdk
	D+GXkB5+mbaClb2/Vy2K0bsw539DDNXBab+ioTN0/Wi6Oro66uv+l17gsiUT+C+STfhZvviBhsg
	yXEtyhXJHP2f7xJXY15R5A+5vkiFtGnC2/qN1IMXHTcFdW6cmf8Ve9JmulUUsknFyFbhv1eCrUI
	PvLwhrlNBwTv6ppxVxICZmfiWk+6EZpNs8crdE0YpGoTsEW+6ZiT2geuQ==
X-Received: by 2002:a05:6a00:4c81:b0:835:532a:3468 with SMTP id d2e1a72fcca58-845507edebemr13238521b3a.20.1782065740558;
        Sun, 21 Jun 2026 11:15:40 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d89dd8sm5162063b3a.15.2026.06.21.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:15:40 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] src: Remove dead assignments in batocomp
Date: Sun, 21 Jun 2026 23:45:34 +0530
Message-ID: <20260621181534.92005-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return values of udev_hwdb_unref() and udev_unref()
are assigned to local variables that are never read again.

Remove the unnecessary assignments.

Found by scan-build.
---
 src/oui.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/oui.c b/src/oui.c
index e20297b93..4d9c3c3e7 100644
--- a/src/oui.c
+++ b/src/oui.c
@@ -47,10 +47,10 @@ char *batocomp(const bdaddr_t *ba)
 		}
 	}
 
-	hwdb = udev_hwdb_unref(hwdb);
+	udev_hwdb_unref(hwdb);
 
 done:
-	udev = udev_unref(udev);
+	udev_unref(udev);
 
 	return comp;
 }
-- 
2.53.0


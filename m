Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1D3DE44F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059124; cv=none; b=bKDJta3pNanWX/nHWaqCcN1+fktnp59gRGBGJuGfUK5Siu60uN7C7l2U6Cj5dQKHEqRvGJEnaeixPtX5xqR20pMHNc4nustqXbdtI0khkb/wKK1J3vwHSuf3s6c7cRS3pbVadkRBwxNFoRybvExUHzwvJnP1+j4tM4A9aispWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059124; c=relaxed/simple;
	bh=hDOtj5Nf1/urz+vU6PahUXo7HAFlCMAwJn2MgWVuFbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8cdXvC7JhQuIzWEgu5xZWshD5VswDsM0Q+xSj+P63v/YZulaUJypQMUiowKCIGlxAsqn3igO8HSTVzxdxHCiFTVe/Mq7PrzhoE6McxmIGoF4oLYpp0cQreETOgzPnLIZUcC/bZP4xGWc/jKnLEsLSCUu04udNS3c/pVF32O1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B785B3EB8D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 3/5] doc: Recommend using _cleanup_ and friends
Date: Wed,  6 May 2026 11:14:24 +0200
Message-ID: <20260506091824.2920716-4-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506091824.2920716-1-hadess@hadess.net>
References: <20260506091824.2920716-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGW+5oYUz6IkFrcqLOmL5gVyzcxCcduo1OVNcG2/zCqO+ChB82V5yLRe6VDdwZdV4JyggnOX5OsGNefTaSo4HPar9h9espE02B+Y20GeUMtxudums1t94KA3KB1tok41dYIlzWnc8xGas8gOIvWbYNG2+XxBMyRxKbrHWNjWwVlBzMAC4kgcjg/TPW8pHjA7NKksY01g/ZFuBQHxDkL8m1q11p22eiUIoxr2egp4G2kWBdZLCURnohf9mPPRefyjpe7FXyP7KLrF4uHpA4e/cCVnpBTi5kH4FPjWPj4Z7wKUd8k29A1UVay8fqAqekgTe4F86btiQsnM29LsA4R3OiyOFdZxZwWNQnCOfw1sKGLyRSMkEfZmQA+7FfLhl4+joCl2w6nVoYvbN31+1IVyAKf2rxNDZ7gTyrjLGZ7cG52IUsaJ3W4fXtKThqmGIk7jwiDkW9Wu4UdM6LnVKMi0FNZpiWXv1WM+rxn8BDqLliWAveOHjx7jVphy0dDXRhj4AlwJjdCSDqapYjnS6lOQqGmheY+XhospDC9LHhN2MOT47OX0bWr29mjKd5Mef/60n2/Z7nlTIJiseDeh4fe2ZH6DstyS4eNgkv/PMf1sp+AjB43EUtH25hmGRTyB/YrdJlSnpvtloJX1RIp/vSZKY4o3RYs9zh48G7vKcOqXbPf0Q

---
 doc/maintainer-guidelines.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/maintainer-guidelines.rst b/doc/maintainer-guidelines.rst
index 44d3e258db6e..b67c6596f4c1 100644
--- a/doc/maintainer-guidelines.rst
+++ b/doc/maintainer-guidelines.rst
@@ -98,6 +98,9 @@ do this:
 
 The above assumes that a kernel tree resides in ``~/src/linux/``.
 
+Also make sure to use ``_cleanup_free_`` and ``_cleanup_(free_func)`` when
+possible. It makes your code much nicer to read (and shorter), and avoids
+common memory leaks on error paths.
 
 Rule 4: Pay extra attention to adding new files to the tree
 -----------------------------------------------------------
-- 
2.54.0


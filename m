Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C537B011
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205700; cv=none; b=WzLRtHU6lbaQk6B1VdGVVDGnb4FR+r1oMJwwtDbGaEEeUDjVCrTM+8yuTEsS0DNiIcEXOFaVOKBBM3sjSWASHfr86cN4l8K6DwHzIrLAgyuaEJk1Uby4ZPH13EmQ5WJffbwsgiNT6keCHjyFEES341t8wttJ04MKLB7EimW8yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205700; c=relaxed/simple;
	bh=QX0FtBkED2+IcrAnAon2nRD+t8UTeVWRMl/ypTm0kbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2t668gSai53Xry18rSlkpOFhy0h7LeeYeQy00WEOk394vdeGHpIQ3sp/5MiH3oFM7rpyo6oXLjG0avJ9+xmrCGtBQRHVR/2qDrQYIsHIVI/s1fZ5YRAZxAtPDrzhcSccM7/LMxnMeuTmRpChCjUeXvG5lcii6eUPS3+orYeiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83E633E98F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared: Remove unneeded glib includes
Date: Fri,  3 Apr 2026 10:40:57 +0200
Message-ID: <20260403084128.348931-4-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403084128.348931-1-hadess@hadess.net>
References: <20260403084128.348931-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF8wQdtWsTugDN7F0i8tNPfXw1dsz8/39mAsUvkFjzkGtsqDLKSGLBpXLWch1YuFvtIq378jm4dh5sh4S7Y6kMRAfOc+znNxo9cA41ZyKtRs0+pNez5Z623YM1nwXaHSuprObfH313wPDpmIUut4Qobt9bL0Z2R7W7TMASFjF3NKpqJ3ToF3R8DFL5KkqmMVgVyLmf1vznB7vyE6Xi/utU1nMpJomDs3LA78y/OyufD52xcbXVRtWIWA/kmCLjEOLktNXIm94TkDeaGtluyXYfvrDN6eZW9wGpeOeYmND6OfXxU4qczYir5eFYXuX58SZFfjt9/HNq5Vp0UVL+vrr4sW0dttGoo9jfhalP13dFKkN+tMvzSxjB/gMiXdC35Ch65qEPq4euOJ+tcc2rCeIIPJ0EknKfo22sWdnZfRCH1dkaZmQyy96g24kIpYbWN+xf+iH2GCNxPgTxKy8FKummvI1HyDYhIshcNY9C1xiGvf/JL09wQ0p8au4OSgFQizrC93U6Iqe0TpFStSyeJly2M3tCT488VRuYa9QlGedd+HHKt9KtByzkVeHRfOQKUiwQi3Lj71YQz3UZJCj5cTHcI1F1o370OFVzN+vRpqq9l4iH693gNKxi8sGpz8Ui1/mVf0sQ8V6igEA7aM+oWZR/3dAYFMRKSbIgcSpLz7UtXEQ

glib was included, but no glib functions or data types were being used,
so remove those includes.
---
 src/shared/csip.c | 2 --
 src/shared/rap.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index c5b77001a1aa..06b1606d9123 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -15,8 +15,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
 
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 39ef3f2783c4..ccf3e6f33793 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -12,7 +12,6 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
-- 
2.53.0


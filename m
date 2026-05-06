Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9222F0661
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059122; cv=none; b=mG3WysLmK/g3qtcVrFcbPCR0TXlOri+8/2h8Hi3OcyI0ZMJMDQxcfzDlGapVNnkm5OvHa0aGTEXjbK92Y12p9AubsoMy3ka79cgHGwqvUn3+UFCa+Vl2VOcASVT3lRgsiU+Fqpp2Os0hdv33ExCuvmcjIv5r5eysHAVRSkhomug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059122; c=relaxed/simple;
	bh=4TuDtuZwiBCq+uKu75OvHZE0VFfpR3cvd6b7paMVqwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8dg2i/QMD6CJwJKe2V1RlbjIcWsgKrKiSTFwwZqX+MNkPudLq1WNePdy2eQwbLGyP3P3+4feBcMmrt95sw6TiuVqIicfH5GEQn3Arn3Iyl2XMcAOP6gh9pVLHd389h7Qsh7X4aKn0G0LZ9iLs8IQ7V14CNbmEkyZYh9Tlskp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 498AD3EBD8
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:33 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/5] all: Remove more unneeded MIN/MAX macro definition
Date: Wed,  6 May 2026 11:14:22 +0200
Message-ID: <20260506091824.2920716-2-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGW+5oYUz6IkFrcqLOmL5gVyzcxCcduo1OVNcG2/zCqO+ChB82V5yLRe6VDdwZdV4JyggnOX5OsGNefTaSo4HPar9h9espE02B+Y20GeUMtxudums1t94KA3KB1tok41dYIlzWnc8xGas8gOIvWbYNG2+XxBMyRxKbrHWNjWwVlBzMAC4kgcjg/TPW8pHjA7NKksY01g/ZFuBQHxDkL8m1q11p22eiUIoxr2egp4G2kWBdZLCURnohf9mPPRefyjpe7FXyP7KLrF4uHpA4e/cCVnpBTi5kH4FPjWPj4Z7wKUd8k29A1UVay8fqAqekgTe4F86btiQsnM29LsA4R3Oiyb+tcg4A3e23LxbAugkWGyKezDqlGiozFLklH38VrRerl3PDRnKAnJvHipSvgz7r8d3ni8Ucv/euN3y51ZutMPGixAQr6ah1FP1xt+MXR+VpFKfTz9SUz6uyOmvz9tnqu8mX4n3jxuXPznozA7eankPc1+F8Yo/3jPL4DzTpdBFYr5tgdGcr+qW0FCI7lTz/y9x3rb8nb6qbFzztXVndvrYfht4DumKMf/Zmb7V/VnUasijRnSrv91Mcne2LU453J4/II1OH2DJxgUdMlQLm3yc+yNFBQJGa8Q92SePUifbWtj3E/1UVk5AFOWv25QNY4JlNB/ZeNen+FJNMiawskZg

---
 lib/bluetooth/hci.c      | 4 ----
 src/main.c               | 4 ----
 src/shared/gatt-server.c | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index 44eea054b0ac..f50a30c610be 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -33,10 +33,6 @@
 #include "hci.h"
 #include "hci_lib.h"
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 typedef struct {
 	char *str;
 	unsigned int val;
diff --git a/src/main.c b/src/main.c
index 9a3d2da25d4d..8aa19a3e3346 100644
--- a/src/main.c
+++ b/src/main.c
@@ -205,10 +205,6 @@ static const struct group_table {
 	{ }
 };
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 static int8_t check_sirk_alpha_numeric(char *str)
 {
 	int8_t val = 0;
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 6273899965c0..709a8f94bb6a 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -26,14 +26,6 @@
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * TODO: This is an arbitrary limit. Come up with something reasonable or
  * perhaps an API to set this value if there is a use case for it.
-- 
2.54.0


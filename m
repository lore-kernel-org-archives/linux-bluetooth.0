Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553B234964
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205700; cv=none; b=ehhCpxzd4nAAE56MNV0mAWSz9FSdx94mSX7Yt0ryFKMHBMQClEj+U7E+R5A2im2WX7E/JZ/oL4IEsk1LMYgea0WPNrGRo0Vh5cU4UHEtDS4PRFiA5gTzkuIH78z42LtkOABgRoJbT1QLsXxLECiVJADNRYJDrgZ1gVtJZ1vppGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205700; c=relaxed/simple;
	bh=nY3vUv5maUp+CVulFp7WWdOGuJBih3mhOSJiemSGdIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGaw5TeNUNGVi2K+Cg5WGv/dgA26quygG/7CyCwDjtErGoml92hELYL1cbg28QQTC56tbbs5JlKV6vjbVKNL0105iIm33cNcTYK8u7+7Ua9ir2GQJg6jqMOazm+UfYDcC3QF/MwVJhrBcJEEHyGokbqob+UCQ+0MCMvEZ6otLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 471333E97C
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:41:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/queue: Fix warning when compiling ad.c
Date: Fri,  3 Apr 2026 10:40:56 +0200
Message-ID: <20260403084128.348931-3-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF8wQdtWsTugDN7F0i8tNPfXw1dsz8/39mAsUvkFjzkGtsqDLKSGLBpXLWch1YuFvtIq378jm4dh5sh4S7Y6kMRAfOc+znNxo9cA41ZyKtRs0+pNez5Z623YM1nwXaHSuprObfH313wPDpmIUut4Qobt9bL0Z2R7W7TMASFjF3NKpqJ3ToF3R8DFL5KkqmMVgVyLmf1vznB7vyE6Xi/utU1nMpJomDs3LA78y/OyufD52xcbXVRtWIWA/kmCLjEOLktNXIm94TkDeaGtluyXYfvrDN6eZW9wGpeOeYmND6OfXxU4qczYir5eFYXuX58SZFfjt9/HNq5Vp0UVL+vrr4sfCxNltkaQOjpON/zv2ML8YN9n6zUewlMatWlqGNEzS3UShyu4oNpU1uu7bQiW+8k8qAqMfirPaHS1eTsVrIoMSK2spBW0JSD+0L2kx1ODvkWVDyU1om6ZOMC82b5bq0Ayevvv8hrK5yPzGwIUscXSBRYZHUFvRnVYGwGXPsFRcxOgfuXs5J/s94AFBBtbpe2gy4lI4lJ2iisPP6WyBDGzFVueRfXwltcNr7uOQ6Y0mHb/Ztt8dIy2iBDnwIQO6G0bf0mEkcgq8y0/sJqTgU2Le2kXL0sEAW+KlNNAbuqOb3cYAwau7cvnwhTdl1pXg2Eb4lzLeEoyvWCept+53qP+Q

Both ad.c and eir.h include queue.h as both use the struct declared in
this header. Quiet the warnings with a stanza that means it will be
ignored second time around.
---
 src/shared/queue.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/queue.h b/src/shared/queue.h
index 5ea7ce4fd768..3a2dc407d91b 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -8,6 +8,8 @@
  *
  */
 
+#pragma once
+
 #include <stdbool.h>
 
 typedef void (*queue_destroy_func_t)(void *data);
-- 
2.53.0


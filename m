Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A22E266C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144735; cv=none; b=YsqXmtqCrezWfmw1CXdat4LRMPGwiWka89o0MCBC07rXLFlBjNy2JkJTCbw1LVdrhdPCNROFeFjtFoSPNnyzgoNLUmdYE5Qyr15KW8U4N/9X79KFLgxH4zxmv+CK2Xa5FCkrutAUqX8n7t0iWbCSIyitqOG1D7OaYb2vW3pdPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144735; c=relaxed/simple;
	bh=QX0FtBkED2+IcrAnAon2nRD+t8UTeVWRMl/ypTm0kbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSjY+Jnx/uXq91WVW89/WHlgqYDWDrmGGdAJj5asbFv56G2p4XEk7Fxwgo3E26p27u8N0fvnzLV1w2JQgKVnZNet16AfOSb3IyJfPSQkryfXEoedkRzvYsIhoZXf3TZF6hpc/d7P5VwPrr3uSKlAIk0CwWM/kmZ9h2gLhYVW9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68BA43EC31
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared: Remove unneeded glib includes
Date: Thu,  2 Apr 2026 17:44:43 +0200
Message-ID: <20260402154520.48939-3-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402154520.48939-1-hadess@hadess.net>
References: <20260402154520.48939-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGLDtWxhiUUE2qUmONOm1ERJXdAGJcNjFvK0Usq6tRTLPb26z3rnhS+DzchMoH2GKzQScg/bSL+UuSiBdPtlir1opXLGEJwLWp90gzZhfSeVYOea4uenIm9DYz2TH6weXZVVwXOzQ6LhLf/qHhzt5vZDMyF6atNGO50tzpQS2iicYLw7EszsQYa37omp0WzjErnHLXd6UhfqfST//8xZlAMIwrny6iq6frWMaT7zmZ+/T1M3CAvTd37/tF72mkd5Ikgs3mfvU+jN4gBWS8UVHw98Af8MLpWVgRn8DnqwxSuH+H7msDHYzpQ4dBnBe2NZwI5QN0sr/1rE34j8L2eAZcdZk1ccYwXPeQQadQ/8W+XIoIx73JgvWjU0GSzWiHzGR6FbtMTqgeXpZSe74Y1KnRs/RWDP+N15ohlO503MJhfjlSTswxsmkK5IS9MV4xu/GScbu3YStsEAGyLMpaNtobPN/zRlvIiAIwqRtHy5YyR1U4SDDFPZ64TjBorJBnLd6yaCosDZoJ8+lKeH+mP3JF7L9uZHGDxhAM1IKurprREIBU3TLvHQYUiceM/bWQluLpzAgTQmEc5uSKAm5P9HPLi5yTwVKV9njb/fkuvLSYRN0RPtdMvWo0Tny+AMz1GmmSiJRJB98rwrJfSCppEkCufCL/oqMywx9VgLQdII7Inug

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


Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AA480DCB
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077959; cv=none; b=toy5GiYGUNj68LhBPeq2Iy3XO8hVqu/sjEj+BnASU3YTgEZaqmcDDGoBnf0eoXz/UxuTMYY5sk4x97L7u289ShTBFw4jB8AG5DVxDJQPr4cuWUBICBv0N7YtFw4wCBYB05vOrHwqRdoxnVVzvLrDO6oWiRC+kLvUX2Aeoa7bqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077959; c=relaxed/simple;
	bh=4TuDtuZwiBCq+uKu75OvHZE0VFfpR3cvd6b7paMVqwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3dGuEkm1/RGj3T+8l4GVHmTl+Dp1KkFANtDdPGWzbTsq47Fes3GpoH48WsQolvq2b3qE6qXHClpUt3DgQxgJuHkezF6J9q5QW2jcZ0zHi72SXDNr0DZtmY9kln/KKEAMPyWmtHWSP4N+0Y6lAOx+UUHxrme688ihAnj1WV27no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F37E13EC95
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 1/5] all: Remove more unneeded MIN/MAX macro definition
Date: Wed,  6 May 2026 16:30:55 +0200
Message-ID: <20260506143220.3076135-2-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506143220.3076135-1-hadess@hadess.net>
References: <20260506143220.3076135-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEI3AiONlbGM76ajCdWYrpcp9I6rJ9J97keVCFlxgrQebY1wUG8XyLcf9m53KsqlN5m87sMS30eaRzKqJAt4LdVXCXXRWGjxi8Ua3NsWXct4eL71mbffWBBLR8onzmsb6rHZSotDsEnliEkVA0ER3FYUKGLqHvB9V5uo0cgN5cengH7nPlqwfvRZtX4BXHGQvPpLYOaq9i4gwULKQPJYYzKNHfIJFdRnT03n2O24fCkSrCFbXus8J5aNRLoMa5WSnLr0YvzkOZaMHPwCLPAmjH9KkEuOKIoOA2HbpxtmAt3Ds4WXFGndtL4bgW+YTwIFkXPdeLQWMFXljLbwr5JBkV1uD/vwDbrf5txB1x6/bqTUD7WkPtg6Zrx4sap8MWhixGFx/e7TDD2JbpvlDpjR/UAshykzBGBOhhjYheMLvU+bq7iAReTskDWpLO1Jwk08uLETODZJ4PqOMghY4g/p+MwRuxCr5lv3Jn+nu586jubVfUJfUQZwRbtvOe+3tcY9URILEAdF3ch7LrQhF7YWOfYXbvqucAFSfMA0yVoDRmUUKFNTFcSDeqByDLyKAQMLKybqHEN7fTnllxM7eY6iFq4tnLBfmaRcFvGipuoTDf3b8puD+Cd9yFGYgEI5us9SB4xf1DPM+WYelRyNMUYpL+1zaJTp+yZK2jIslGHzFVPfA

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


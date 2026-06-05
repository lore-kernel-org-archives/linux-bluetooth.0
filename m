Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11633B71C6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652173; cv=none; b=rNKps008YbgYCNmS49/g1ukXKuF5nlit4fO4lHvG7+mjfJ2NhsM75sQc4KrMRiJ8VD3MAvGYA7HvMLBH0FAF5uotBPbxvOYwAuFc42Wjaap3GApSU7jv5dljhFYxi4rIaE3oBeBe0KMOh1VpynB3PWbCJHQGax+z23sMybNAZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652173; c=relaxed/simple;
	bh=H2cyrs8APPxwV1CeckHitbELLWU1zNcMOrkiGRuNVlI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nalA+GyQA5nfFR1jM7q+5+di8dR/nEOUWO1HFf6uvFL5FFW3S9c+g8bl3o+jiLXotWvaz2pIQFR0YXGk/i8TUwrPg1Ot0MUJHSnlktmN6lHy+mv8A8E4G8ncILAmCDsVEJDz87HHho16wL5YN1giQhPNYwYoTajgxt9N4/5LwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A0A03EC0A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:36:04 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] test-mesh-crypto: Fix retval for skipped test
Date: Fri,  5 Jun 2026 11:35:53 +0200
Message-ID: <20260605093555.1969171-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
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
X-GND-Cause: dmFkZTEfRkrJH4zX44vyNxDwviqUMEk5fI1XJYz02LKWmqJn9143CWUbgeQHfj6Mj+MBN4sv5U3FXR5yzBZPnqyu/o9VwZF0AM9nYCnbwOReff7D9U8mMPtGNPdWxdVf/yO6GHPgkz/37SRRlPL0nucoNEmpvhqMeS1RM5wWjwif444she1mvThlvh3tI0wsVHwLHiD37uVjIonuWve79H9Goc+kUSudRu+ncllU+fJxbUOC+i/V83VVm8KtJw0I4vQkBNvMvkndH6GYWFzLgwEKkHcACcPhJR30Zm8VesqiqEVXbwOCvnmrcmMuBrXeOUVhYVvl9ZtACfIlDHRUGxs+qenHrBons8ZME33WyOO0qjCu9xoMbvVEp1xM/IHr0Lp7RIa9wovBIiD6B7QiKsoeG5Nw8dlVzDXckWFKn1tpEmxH40gD+LPJ9kx/4NDrGRRlyGr/peadehzTWwJfH5RWBhYKiGsehFs+lY0R1feOSV0ufxAZDpwMx6FEInADwF2HPu2jUtge4j+J7EAgyjAHHBOfan3yH1pQSB0xyFspKmFFmJxSNJvPa8A7eQgjUC2anOd5QeDI3dt7wYW8tDRAiE24KHB4Kx9cWOdz5+0CUshA4vrOQal91HDfm2qer9kxLOpGY52m+9JOSCTeeBZJGXe9avVYFplAwexFFwnVQZjn/Q

Skipped tests should return 77, so they will be marked as skipped in
reports:
  $ make check
  make --no-print-directory check-TESTS
  [...]
  PASS: unit/test-gatt
  SKIP: unit/test-mesh-crypto
  [...]
  ============================================================================
  Testsuite summary for bluez 5.86
  ============================================================================
  # TOTAL: 39
  # PASS:  38
  # SKIP:  1
  [...]
  ============================================================================
---
 unit/test-mesh-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 24fbbba33298..95d17e1d81c8 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -2133,7 +2133,7 @@ int main(int argc, char *argv[])
 	l_log_set_stderr();
 
 	if (!mesh_crypto_check_avail())
-		return 0;
+		return 77;
 
 	/* Section 8.1 Sample Data Tests */
 	check_s1(&s8_1_1);
-- 
2.54.0


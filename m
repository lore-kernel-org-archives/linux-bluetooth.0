Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD69165EFC
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097609; cv=pass; b=tpJOBn5tv4ngiAsTWFyhrlA22rmrYCcAnchWMgL2iLDzTwJO+Tjh1QqDOfEE0e3QmHgB3PiedQuiSAuEtsXsI3DhJx09bZOg1YZ1to6VR0tbXdC5HLiNOgyXiJF6EvRN13Harkx1NzyfzPKCfhxBZmMdLIp8PhDM4qcguNFU/eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097609; c=relaxed/simple;
	bh=DRXET7bl8LRxgvn86Z9hUQhMDZNj3T9bcx9ufBBOA5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R93lL2gysyRzRLs63mSF4Sb7CLH4Q1N+yP8NJS1dq3oGavFmaR5Z2VDO7skyTVxNdThPpezSU+zt6pQgWK4Sp9o7vomydat6KyUbCPcecEX0ManqiG+pd2ryo4TVcGlppxAiXWADfD5h5Q9MUMhkknYgKRuT9h8UUTl17MheEpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hjJV30gJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hjJV30gJ"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPNj341nz49Q5l;
	Sun,  9 Feb 2025 12:40:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqiSfjY+jmPeMy12FlPWkUB6hSk3vxE+RqatU8sN+Hc=;
	b=hjJV30gJel6FqRSHbjRGfaX50K+2a+odF1bJ6BfsmE9Th2nrrS7ooAnNlpqRmenSzRr+me
	Mjg12p6/jAs1WN0eoKM2ubHNGS1fSJLJM6przLsoYQvGlfcF47CTt/zPlWxl5td1gxYTeL
	bJDBBs2ZSEaZ+6/t3TyebL/oISvQT3ut8DWhDglHItLg3OEzDkVGbd/iqEH9WfdVqX2QL6
	OWM/Dq/OTG0nbGC7+SwoU4BIAEJgp7tU1Tf0a/DuK4kbOAIzot6j6gA6niOlJ0kRl2mCTv
	kVb3/sidZARgNDNGSOCDRPvvUkb32abzVTeSYIlezOz2vBiTevSgWp+04VfaLg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097606; a=rsa-sha256;
	cv=none;
	b=A8FU+TFKnhdR7csprRzsVSwEWgswwbRMn7+DkcqPNWonug2die8G03Gpt8dz7WdLKpgXDh
	MXEmQlpQunSvIG3fiPRvmGr6L9a3BzW/F+z3xzpNhXEWaXlUanOZeDgftobW/Jw+Lr0awy
	GoFOD1x+aQXigi6Fxl7gUbkpkVNPJUfuXNSzvZkOJ3jaK5hvLhxO+BUiQ1QCwkoRZJJoPE
	X2Pd35Sr4RgntSnsxV0t62IqJGWrmFefm69+eTSlDplfQVtpVzMgU/NqFB7zy4yeiWVEfc
	LTqhUXCrdEsb16mkIWBUehl8zNwZKU/fUx7ABQSf7hygAlX+2R93Ek1FdZN6sA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqiSfjY+jmPeMy12FlPWkUB6hSk3vxE+RqatU8sN+Hc=;
	b=qIN4d8gvsPWPQXe08GAG/q7dVN5jhM9qyrIxlt4SIETWixdxRZ1RYhKtdo3drNAZcFKQAe
	Bhi4j8hZka7rc/RabPXf+ehESUpBCpvc8xpwbWILN6ZdmWa5L3vT75kI8+r8oYZeY4vo9H
	HZciQtTOcIk/D686YoFO7c9JVwBuh/9s4NtGNisrSjaRxg5aGCKbyOjAKUP3idi0Kq1MZn
	XYaQoJr16/12ZeRHK79BK5agoBvsJQzCCmW3UQ1pUCrNhfvcwVPE6iCGoS5O7TEFC3rYu6
	3KxELl13TTKR18S+ZawiEe1OJYML9MRaPC3mDesHKwNFjBX6lsotup6T2Y2Zpw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] tools/tester: enable TX timestamping tests by default
Date: Sun,  9 Feb 2025 12:39:57 +0200
Message-ID: <c30c8aac944bf4fb59a3d34351a859ebfc01e7bf.1739026302.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739026302.git.pav@iki.fi>
References: <cover.1739026302.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/iso-tester.c   | 2 +-
 tools/l2cap-tester.c | 6 ------
 tools/sco-tester.c   | 6 ------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index ad0738091..640692b77 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -691,7 +691,7 @@ static void test_pre_setup(const void *test_data)
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = test_data;
 
-	if (isodata && isodata->so_timestamping) {
+	if (isodata && isodata->no_poll_errqueue) {
 		if (tester_pre_setup_skip_by_default())
 			return;
 	}
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 395e76dbc..e56773d13 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -221,12 +221,6 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct l2cap_data *l2data = test_data;
-
-	if (l2data && l2data->so_timestamping) {
-		if (tester_pre_setup_skip_by_default())
-			return;
-	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index ae76b1ddd..1c07eec2d 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -197,12 +197,6 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct sco_client_data *scodata = test_data;
-
-	if (scodata && scodata->so_timestamping) {
-		if (tester_pre_setup_skip_by_default())
-			return;
-	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
-- 
2.48.1


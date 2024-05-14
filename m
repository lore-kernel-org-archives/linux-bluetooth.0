Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A23D69
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719320; cv=pass; b=auv5r0tC5V9Uhq8EyOU/hnYaryFwxC+6UvVO575y/10HJE1uA50T0o4fL/by6slytTSvLqN11U7OxOgK1eP5KcTOihShwiHa2ZZWv1fsSLR/JaYmn6s4oME2gSwXMsvxv2WMzd/fEDfolE5iUSIQlqVOWiuFkV+m2Z3TDvmOpVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719320; c=relaxed/simple;
	bh=smN4YFx3lN8TysEC1D7lSZu7UvDc7rfNaK8xnbkPPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFLBw+zLt3aYfprexVX0HLDcZobsLNTXmITpz2Ypi73nmTNYeIjzFCRV6HxcMuGkVq1ZJv/TxlMicyQpm0Hz4agVNyK6I9aZWcUuiYoFS0oDe5E7JcegvSeaVUCLWzqssriStwoosKVBevBOYlOkl+MIbZNVMcDxfzuZd67LoLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LOSyEO9U; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LOSyEO9U"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vf7ZC2jpzz49Q2Q;
	Tue, 14 May 2024 23:41:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715719316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqr216H90c1VZMKSKecVXtTYE+O2T0UB5R0wxqjVPoQ=;
	b=LOSyEO9Uj0e6zcKtWMSDf/CtNbwht548mKVF9SCLw7b22d0UpGWEVq2Q1un/vc8K80CSX3
	9rqfzCsPhC1/HM2VXiqx7j49fVzp5I50+2OQj4f2USuyYC2KWsZRLx6rSZ06Newwv6IvVK
	JNnZ+TSa5wJ/S/StIKKarxH9nfqd9DItXVv8pkZz9cXVNTmBf3Q5S/J/FGo74bL10C+x8X
	fwYRay1U1MIRGVPC3D1GQgPGSrqUyOH/iex6wYj+yalErFIaBRNkEV3Lado8mL5D19vlTE
	Xfbuj6igA4Rme2xH3F4CIEOUV1bkcyFWW9ecbY/g2UFHh5UFoJzZVykt8yaIhQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715719316; a=rsa-sha256;
	cv=none;
	b=iMhd/ZhmvXfxiFHu5q8fatD6z9JFlE+43ZlBbuud9j/WyzYk1gLDI+qawWPmeIteCJWvc+
	iO2LA+KqZahQAKeYg2bAo8FHNC33uShNFfQSxEMxo2xUMsq+xLH/OmR2Q464qYPSvJJy9Z
	jr95Wsoi779iJtItnPXJnO7MtGg+bck+g2xXiMrgSgOJCziBx7j20QVBwDLnbXphcJ9DCU
	z8kB+U9plfXERPF1dOwk+Kr5VoLgcknkRunhUYDGU1ObQ4oRAW3kCaO/JetqxOUuNedXln
	nA1t/IAgPkn87Zf1uc4mBm40bNlWVxb4aeY9avMU0i42KUQKQcD1bwvFBgL5JA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715719316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqr216H90c1VZMKSKecVXtTYE+O2T0UB5R0wxqjVPoQ=;
	b=Hte4Axw62e8yEdwk7O+ZoYsFwE9FYSaDR5Athhr4pNhFKM3GDR9ONTHIdVqGeMqKX9MAw5
	EFPClKWQgswO87qfW1bWm3Gbb3SkA7PcqwOpUaI2uy5qm6pUTX0QpNN3+Z/Vkxmm5n9Hk4
	yxpkNkntQClL3PiSArtwTDUxFstyS1Luqiq+GdcJgbmbSHngMnC5Ae2y/g76tGEhVIX+KI
	+8IkKFvp0R2oikkJzXcLtWJGRM54czVLx4lgFvQse1gQAmQ3naakD/AdY3PWvOJ+pPfOws
	aM1WYE1U+Q7mPQLRZGNn7tXcj8N70yUxrVjJa8SCqD+cmpGA65yyMAEw99q2Iw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] tools: disable running TX timestamping tests for now
Date: Tue, 14 May 2024 23:41:49 +0300
Message-ID: <2913ef3da3faabea047ff977c579329a873cbff4.1715719254.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
References: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the TX timestamping related tests for now, as the feature will
need some further work.
---
 tools/iso-tester.c   | 5 +++++
 tools/l2cap-tester.c | 6 ++++++
 tools/sco-tester.c   | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d54fa56ec..e80c2159c 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -690,6 +690,11 @@ static void test_pre_setup(const void *test_data)
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = test_data;
 
+	if (isodata && isodata->so_timestamping) {
+		if (tester_pre_setup_skip_by_default())
+			return;
+	}
+
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
 		tester_warn("Failed to setup management interface");
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 02d1571d2..c34080654 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -214,6 +214,12 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = test_data;
+
+	if (l2data && l2data->so_timestamping) {
+		if (tester_pre_setup_skip_by_default())
+			return;
+	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index ff8a3613f..a56cb9153 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -197,6 +197,12 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = test_data;
+
+	if (scodata && scodata->so_timestamping) {
+		if (tester_pre_setup_skip_by_default())
+			return;
+	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
-- 
2.45.0


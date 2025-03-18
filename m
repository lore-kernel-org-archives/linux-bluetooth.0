Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C6214232
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324853; cv=pass; b=V+YM382mzVXKd50B9S9Jo0Vo1/sY6T76diy4jaV7LvX8dnaqF2n1jAJ0t8pJUcjzjXRohSMftjkqQFeDO9tMsvOujp+ENtRfYpzKzMTAI3owQhnVeaEG+tTw8zeoTf1z5y5o7gDF/JJO/N/+1LU79LvYvReOIHM8APiLj+qJFI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324853; c=relaxed/simple;
	bh=9HAU5lpq7cib34jibfg4Vh9+QjZYWqOpqAghT4OescE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf69MrzvlgVW53kdZ6eSfd5G+xw1pGDDg/Hhw02d6xP59ZiNF8vhj94OEt8gbl06OP38wF/cYkchfbbLvV7LG8fafB7EbEHYLpS+GzjMptdIBzrM8mx50ijNr4PjpWwQTqj2Psk8jgdTpwWg350Jwb10A4yT5jfCAgilMZQ9ksE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XGSXvQrz; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ujkR105y; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XGSXvQrz";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ujkR105y"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4ZHLv24QCPz49Q5Y
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 21:07:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYLxqNsO+xT5BocEODug8Sfge2D24HcyMm5XSIFka0c=;
	b=XGSXvQrzZjzht200xJf+hnL9cX9s0Duo9jIQDD2+5CGuM65GsiFqzMsJyagzZUoQwQ5oK/
	PlhdxfcarGrg8JQGANUhiOVVFV4OcTNrdhnJJyPyLVMYY3lgrXr5Nf6nrEMCb2mXIRBSMI
	8ltRuxoWY46tgJlp0it/nj8loB35wtX19A6XzOeg/w0VxPRIAiAi0XyvlSAYyHmS7+uJZc
	PlhnI+7JUOewRbs6DZyyNJThkhCRdjmaI93SWULfGOZbkJ9w5ILzsGf5GcZ1DvNJYSMfX+
	57T+2QKh7oiVXEFb1ctz2BPq9pD6nLSDEXNb8MR9bGKE16anmpsijiYmrfjLAw==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZHLtt10Rlzyhr;
	Tue, 18 Mar 2025 21:07:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1742324838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYLxqNsO+xT5BocEODug8Sfge2D24HcyMm5XSIFka0c=;
	b=ujkR105yLnfJhmwpfD5znps+QbHbUwQ/761Z0zjlTo1k64dBZ3m/N+ak7g+S1YCBE6mMH0
	Ead7PZT64sgFGc8s0yPtSB/K18FEl9FllxXZPoDbMVeX1NKm0S/4iEDtJ+YKUY5rGQNG6/
	KvIiAojL4+wzdTuNU9snL0N6xm34Pew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1742324838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYLxqNsO+xT5BocEODug8Sfge2D24HcyMm5XSIFka0c=;
	b=CFSGTLG2tURWTahTuNr/bY0PgA0XoHx+uZdom1q/2VYSdxt+p4U+2S9sopcF98y4jWD6Ug
	4HvDM0Wht6nSg9aZHLzHkrCFsA4JFC9BmM9XiqDSoJ12pqNGQ/cGABwMEYRPnsOt2f+peJ
	N556FTCznCuy89LCPFT3WtBfvR8xsl8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1742324838; a=rsa-sha256; cv=none;
	b=F5AMVYZmG7k2GKXO3fYn/JM/i5Pa02Rk3JWW/68HxvBOy1qaIzXuYASALSAlhJ1AG+NfC5
	oEjRfTIe+KTil1OJipDJZUi8GpOLGdd7TluLlvoez8qhUw/7Cu/F6swYTMnQO3yy9KG4dB
	Y6UN3QAF5h3v/hXs2t9L+LLKwPY6Dgw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/3] tools/tester: enable TX timestamping tests by default
Date: Tue, 18 Mar 2025 21:07:10 +0200
Message-ID: <172a8faa86f41e288b446beea9db37763eaccfc3.1742324646.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
References: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
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
index 145506321..650f8bab3 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -212,12 +212,6 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
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


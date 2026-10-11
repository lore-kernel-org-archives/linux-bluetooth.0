Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A045DF4B
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751233; cv=pass; b=im0eKl5AYOtGHmR686MuCXS9Aa3k6ZZjAP8lpZ4YAPKOgY5iWyKOBtlH1W/XuN7OwNvWVocD2DJn2slClL76X8AunorK10zYbkDhpZ2sVp/wM+S1ppTNVzcNFbTWGis/YOzpAljnZsSueD0qdSNldizBh49xqGBPjj04sPuAgBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751233; c=relaxed/simple;
	bh=uhpH6cT2G37OwRypF3VTv0ZN4+JSo/EA0Ykqt5iu91k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DooAnFM0rmZRnsxFu1wqQOoicmOnwI+YEzFMcxYXrbojQ2pSUwdHFPZTrSSLal1u2JzxXGtG0ZkLY7sPF3Dg2QsL4bdJ6JPJ7mJsNgbsfn+Umcsv9Kdyj0LVmX61Kt3vRbBpWy1bijnoT6Zis3nMRA3Bocc9dYsaLzvSQg4T5pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XosQy5v6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XosQy5v6"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2stL1hsGzyjt;
	Sun, 11 Oct 2026 23:40:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N61UkBw9gOCfzKzUGt9A5S/JGFr+sERJ5du595iQAAQ=;
	b=XosQy5v6rTXQBMmCePFqJSkJRR8fJU203wYglOUE0yXo5zvBVdEZntIiIz9iK1okriqyQI
	Bz1LeA9vuFYUJIC/T3HBq/Uj611xs08dwyd9hjwDZeHkvlti8JWVGauILXRYHvEdxrFZis
	6VDvP90soyNBquMIHvleGH4w+mGdBbo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751226;
	b=MXKnSHJrFVK4lbtFElvqrTCws4fwSfxyJjVRYRC/Q9Cf2xS2ZynhhijfPWV1UTkDy2s3Xy
	chdDvpuVtkFtfXN8fy6V/CA5pjP6k8kAadoYPAe8VgP1Zei+lSPihGsSJIJz1Bgvk1vQB1
	I89wjMzgoQiC50kQRmq0paueNc2ecok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N61UkBw9gOCfzKzUGt9A5S/JGFr+sERJ5du595iQAAQ=;
	b=yf9+ZO6kpphPSdcLFspwo1nOB5tI0tvnWd4YDOOA6GwySZgttM2teSoEMOF9XzZ6Z/39qw
	UF9nr8O/PnR7NmiKuZuZSxTpRl8jdbKRV3TnsiuC20RAOXruphcJnSDxA91NU0tkEDygpI
	3N7QIz+VRdxRY+/Y4IBS766WuxMen0Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] iso-tester: remove IO sources during teardown
Date: Sun, 11 Oct 2026 23:40:15 +0300
Message-ID: <22736ec1d4ec6288aaf4c62642c65910dba6c591.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750393.git.pav@iki.fi>
References: <cover.1791750393.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop watches / timers in test teardown, not after all tests have run.
Avoids leaking them to following tests.

Assisted-by: opencode:gpt-6.1-sol
---
 tools/iso-tester.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index fe27eaaf3..6fa1bd007 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -707,6 +707,15 @@ static void io_free(void *data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(data->io_id); i++) {
+		if (!data->io_id[i])
+			continue;
+
+		g_source_remove(data->io_id[i]);
+		data->io_id[i] = 0;
+	}
 
 	if (data->io_queue)
 		queue_remove_all(data->io_queue, NULL, NULL, io_free);
@@ -722,15 +731,10 @@ static void test_post_teardown(const void *test_data)
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
-	unsigned int i;
 
 	if (data->io_queue)
 		queue_destroy(data->io_queue, io_free);
 
-	for (i = 0; i < ARRAY_SIZE(data->io_id); ++i)
-		if (data->io_id[i] > 0)
-			g_source_remove(data->io_id[i]);
-
 	free(data);
 }
 
-- 
2.56.0


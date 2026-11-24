Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512527;
	b=GRlHZpGDqcX/tQg7BjAACQqa3XmEPLBrfWIqjv/owjuLeGqDrudC9Q86Q0A2fWUnDD9B
	 ek3dottGGGAzN7y4zpvaCuIj6ZtCTDfJK5+8XmzPXGpypGx7dOuB2JYlAQLi1Xu/LQvHT
	 ClRReYxoC61xpR+Di3pqit/RONvXtoN/lnvVHuMKS54rcgB8bewb8GY6Cxz4ZTq16S40N
	 EaFrOu7vWYxxtIqSJLpIPb0M+sSFAm4b0dumn1ejbztdeSZ2FFkWbAJpesBvhTwrTVIhb
	 sDh2P8d+czwMq5LQelGKI3RlB5Y/9z7SYxX88day/VRX6Pp82leh97+H9xEXPzGWNSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
	b=AzbIX1Gnq09IO/NvUqUMl8jAm4ETo/Cd+tobpO320cOPjYI9lCeBFi+yL0ajQhm+Qz40
	 q0PamTzJsYlx4lcBIi9QRQgjXcSjVUKWmmeLfKxp/iQwWXi4YyHQld4+MGmG2ALrIeRjo
	 0HrUvHqDafuQ6x8jWR2gI8+rErt5ejlltJoxN8hJcuv3vddmElMH3hk4nyUytvr3zkknV
	 k0F523L9jntHegGKitBV55qCh6BJkYHEDRqotiUCG5Mcvrhq9gZLl7ZvW5HQxNrZOW2/h
	 jIDr4BOYGuKsBISbcCUeaSGMPiM0706B8wMMnkY7T1B5KKAyeQeICUGMIWXpSqB8ORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=weOEVoR1;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E0606A683
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5E0606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=weOEVoR1
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e47347279so2492609f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512525; x=1796117325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
        b=weOEVoR1LeKhd5ld1Q4mCex90mmBP77m835l491QX9sAafQfcmLq3u16K8IuiyIIqF
         Dr0tNx2oBgZX1vpMaVK5euJzUtLUtQfjLQkASGZP4jbRnt578GCsEZOSNMrbuFtNXsOx
         v9hr1Zi8OA34FbfphkrnsCjyeVPURjoEK4ijU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512525; x=1796117325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
        b=RbF58ucdujDG4EBTCw5TvzqleJZkGgzGrEwwfCJhntiWBqizq4KzdhrDS4HxkfUfGT
         WSe0Dtv3tzgAbLi61zWNz3N7ui/9Rxyyw972rEKAa/Rmsgkw4yBBURSQEdAcbWQSFEV4
         2o2OkomTlLuiKUqhVQxE30N5/AahDcr/SKbbbMsQ1rmQmqBiuG6mULc70QG2g2bn5rGT
         wejVmO1pI4MM6cPjlVcId6F9gZzJ/lmT48h5Du4H2G0WW85TrzjrMuS7IaqIftkpYxM/
         +18iWtCe5fVQWTU8S2+36oGhYZWiw85cp4BPiRk8yRbsn565e/EBetwGfkk/+YbBnor9
         VxUw==
X-Gm-Message-State: APuU4Z/dQy+Os2VYAQVkDTYq2ezR3BwET8NYDWVt8ch/w0oTADXN4aku
	UP18Y4dpyOL2iHfZwNELhvtlORsJrn73xbZiegmb0mEKiQd64OSEPYPrZmkQh5dhLQQpREH1VC9
	51wy4
X-Gm-Gg: AZFdTZfSJNyX1JAQrWVgW6x1hYa6U7WHW7dNwgWptLWQagsfhCj0gTq2WxWgNjruDQo
	CJDxE7RpXlaDnKlZQZLIs3xtbZmElq1OnmxEwqbPEmlwKhMYbnOya4Y/l31bDB2tpf5LsO7u5Rn
	zgL+cYaHBhRaOHxzwizFJcu2ppgPyfYzlFGsmn6LG+2lTUFXEjGvWGtTm++PE66seKEQAPvfx/C
	4oIdzDUd1B7QZicphea5cWxCLOGYo1XZMUqJrwraEkUfg4dqSsWA7KP99XIyxh1NsSzbsc8QXha
	v1b4meuq5qMhtkc2pXMTlipiFtnME/MW6mEQN93rBfjlvsdSRloZxZYRkoyyI9vhhjU01cWLVbN
	x49JM7Zw/ZhvWQP3nUPP48P8xj2frWyhKktoOfNw+4qr4v2X3hayZWn0flTZI4fcZdpWqs3aYb/
	qfuHhNyBvYT4fqmHyCPbRE7DQISXb7eo46+ckfmepc6HbOBGpyvrZLKTMOyuCXXh3QyieAUrQbD
	jxXpTQCS56Ch+a4navuxwxp5S/T2UISABii+C6k3MM8EoK61ZEwV3J6l1hjIXrE1uXiSpI42Bw9
	mvbkbznmRD/jxPQm6G0/Ou7AjDNb1P1HeSOovUa93o09sa9u5A==
X-Received: by 2002:a05:6000:2383:b0:4a8:8004:5261 with SMTP id ffacd0b85a97d-4abb6d04250mr30971188f8f.44.1795512525519;
        Tue, 24 Nov 2026 01:28:45 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:45 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 09/10] unit/test-media-player: Add test for a stale NumberOfItems reply
Date: Tue, 24 Nov 2026 10:28:32 +0100
Message-ID: <20261124092833.1191053-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of items of a folder may be reported after the client has
moved to another folder. Check that it does not replace the number of
items of the current folder, while the current folder's own is still
taken.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-media-player.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-media-player.c b/unit/test-media-player.c
index ba10e5175..53dc6f69b 100644
--- a/unit/test-media-player.c
+++ b/unit/test-media-player.c
@@ -770,6 +770,33 @@ static void test_total_items_scope_change(const void *data)
 	g_assert(context->total_items_calls == 1);
 }
 
+/*
+ * The count of a folder that is no longer the scope must not replace the
+ * count of the current one.
+ */
+static void test_total_items_stale(const void *data)
+{
+	context = create_context();
+	if (context == NULL)
+		return;
+
+	g_assert(media_player_create_folder(context->mp, "/Filesystem",
+					PLAYER_FOLDER_TYPE_MIXED, 0) != NULL);
+	g_assert(media_player_create_folder(context->mp, "/Other",
+					PLAYER_FOLDER_TYPE_MIXED, 0) != NULL);
+
+	media_player_set_folder(context->mp, "/Filesystem", 0);
+	media_player_set_folder(context->mp, "/Other", 0);
+	media_player_set_folder(context->mp, "/Filesystem", 0);
+
+	media_player_total_items_complete(context->mp, "/Filesystem",
+								TOTAL_ITEMS);
+	media_player_total_items_complete(context->mp, "/Other",
+							TOTAL_ITEMS + 1);
+
+	call_get_number_of_items(&context->pending, number_of_items_reply);
+}
+
 /*
  * Search() shares the pending request slot with the other browsing
  * requests, so a busy Search() must report EBUSY like they do.
@@ -834,6 +861,10 @@ int main(int argc, char *argv[])
 					test_total_items_scope_change,
 					test_teardown);
 
+	tester_add("/media_player/total_items_stale", NULL, NULL,
+					test_total_items_stale,
+					test_teardown);
+
 	tester_add("/media_player/search_busy", NULL, NULL,
 					test_search_busy, test_teardown);
 
-- 
2.43.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C927467D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422790; cv=none; b=UpsMnzbVL1gOfp3xkNZmg2QmCeGUEomZKUaoChfy0tph71XABBcxOK++so3C0s+AWGiKEbvc5AIHNfSvIaAZl30+0ajeNtkTuSf8hi0spKTIZc8e4yIe3Ic9uo6Yu7WKsS/dzVSY5LVb/r3kRrm1n5vwfIdS3wtRG0/b05KClh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422790; c=relaxed/simple;
	bh=UnX5T5RsNV50G562/yY6lYz4fkhbbEWvwMZ9tE7hAGc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJyJSiJ5q6cejtbXqT5tKa1E+XmDe9u646KhctOWtCDHbnfNSV9Cvh1lPhFJ0mTHFj5brW+XzF128eiAgWydTBRjBBv4BfzRV22jeCtCPWqupxwYFRQOPvi1UBO45lbJWnbnfO5qpmCuvZ75/UyGP2yPPICgNzJQ3WDPUHzMlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P7hmKHdn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P7hmKHdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422779;
	bh=UnX5T5RsNV50G562/yY6lYz4fkhbbEWvwMZ9tE7hAGc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P7hmKHdnDcwMubKiG3+XdiFfQ5TqtZiAFG6rHWvi+qu3/jTGu9rcQCi8XZz/TfYsR
	 FvuDWTYCWkJjEaz2tAqToZpy9sK3E2sDEQ+bqGGDaME6BC6vT2QiAuyjBfHbPuvHQJ
	 Eehmwg2IRnu1uz2dZQekQHjw8WSWZCUD/ACbu8OCQR9feo5tgXs2OuUhGgHxiArBrN
	 WBCHmq59po9Htr57y6fLY+GemrAMuivyR6yJOEv/p3eYdiZieuEkOW1kpLogHiwIn2
	 gNlEyeA9MJzWAc/tyQluJ0WGwqbRz5YaBzwXId007f9hl6+kIGcGzO40tDcuVFpims
	 cp8UNC4CTVAIw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5863317E37C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 09/10] audio/hfp-hf: Remove call interface during profile disconnection
Date: Wed, 28 May 2025 10:59:29 +0200
Message-ID: <20250528085930.227816-10-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528085930.227816-1-frederic.danis@collabora.com>
References: <20250528085930.227816-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5737c60cf..f05e5d38f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1191,6 +1191,15 @@ static int hfp_connect(struct btd_service *service)
 	return telephony_register_interface(dev->telephony);
 }
 
+static void remove_calls(gpointer data, gpointer user_data)
+{
+	struct call *call = data;
+	struct hfp_device *dev = user_data;
+
+	dev->calls = g_slist_remove(dev->calls, call);
+	telephony_call_unregister_interface(call);
+}
+
 static int hfp_disconnect(struct btd_service *service)
 {
 	struct hfp_device *dev;
@@ -1199,6 +1208,8 @@ static int hfp_disconnect(struct btd_service *service)
 
 	dev = btd_service_get_user_data(service);
 
+	g_slist_foreach(dev->calls, remove_calls, dev);
+
 	if (dev->hf)
 		hfp_hf_disconnect(dev->hf);
 
-- 
2.43.0


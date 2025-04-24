Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4541A0B08
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506177; cv=none; b=OMmX+q5Lv+faMYAGWJ2C6YXXNkBvEjPTZyWEWZa0WnZ4AwbgWt/41DsEM4vxDKN2WYEzzNN1SapYSsqeZZb+PwAZMQLavPCZSee5AGlfvs7sU0NVoXkxYlZ1Z1A9x3sQmNTWeokV6Zp9Vksvu4HLNjwX/wY+KA0fAye23/Tkd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506177; c=relaxed/simple;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d95C9GUcU7o92yA/F7PtpYbFAG7otEHQjzaYOX5V25kEWU5ufFKZRovCY/st5itbobFcgYUjID/iYFkIHj0WAnn8wvukpDexUasWYB8hsi/Am7GJmDGPZCVg/nLMpV5nDrOgVJXZyGZO3bUJSevftVJOCAfYr2QD//jWn/D7Rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mjyuOxpl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mjyuOxpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506167;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjyuOxplFApxbxRxLHpaTktbk6AWVRfU9dsaBDfvzJPHFyX/YduG0KLd2n01jgE0z
	 Nvx+2LzCoHeF3fCvDCBhAU8hawELr+56zGyjKNVXxEquTtaxWxJYfsIFyFAGsVeSQf
	 Ah4z/JybmMLqfsCojCdry6cHk863Zc9BDk7eZI1nBBICv1WkXPa1PiIp9eF1Gcb3ZM
	 vvSMo0m3y5T/FpEmFlYliYwoep12LFWHtWShU3wDxsYsEtsUxaTqtQ8KoD4E+aqOnO
	 JlIISIHUAobxS4PXi9esuISsfDuFr3B4NJOVXqxTaiJGgP6JbnVnt6wdrmDHiACiv+
	 4kCaJSqfcDMEw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 72BA417E0F66;
	Thu, 24 Apr 2025 16:49:27 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 2/7] client: Print CablePairing property
Date: Thu, 24 Apr 2025 16:48:26 +0200
Message-ID: <20250424144831.95766-3-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424144831.95766-1-ludovico.denittis@collabora.com>
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the `info` command, include the new CablePairing value.
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 6039aa50c..a2d9d88bf 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1705,6 +1705,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Connected");
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
+	print_property(proxy, "CablePairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.49.0


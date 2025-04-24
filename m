Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0928BA9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512210; cv=none; b=iKejD3Ef+MWcaRVJOpk8nFJOPc9NppwSd0MGzT0WEnilkSaOzflBT4RH6e7f16DETlWgoDUiFpQmcKm1lmaHM3CyNVakhEtAkQsLXWrrrN6/Fddoeq5YEDPUIPIhuTmwHelWKWzFcFs45vbKv6V9Gr6sEYrOgcuXA0ypYKO2jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512210; c=relaxed/simple;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2q27n/KnxR4Lkwg84a4jjzAtEKAqnxfZVxlUIEW9rLlW1V/J8nd036aPB21gPQO+8ekyB3A6eQ9nSYSp6SHFKVZsDO0yvDqDkHGRDsRY4ZInJNShzf4ehM0eTzUfTnS1FBqasVVO1LOGe8HXAZdrh6pcZ9Xgs74GSDRPSt8raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fGMxFud/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fGMxFud/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745512206;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGMxFud/5p6Vfgb1UnMxA7hUos79G4d/2TjuEe85hSti0vWalPlyQhxjFGL/MCtuK
	 I+FUcOl61fXXLBhV6af2y4k+Y5j4t+u2EdIC1ChC8xDdfZzXjS6QWwbQQrA8e0yOyZ
	 /L4F5J37jzzIiDwhnrOehtuSXcjjYl2Na379F6ntH/uMzPqP1Tis2ZBbyJMdAQEEPo
	 K9bXjUkPckXRui3p8Mzjw7nqndff/Ocur7/gGoAka0t9o31gEcYKO3AiPVdd/ciO60
	 2oHk4mtVbXh0w37Ekrw4GpfDQBYQmhAZ9qfTbwW+tLcOkVG9EX+ev8W8CZetKensus
	 PtKFAVRQdSZ6A==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F64317E0DD0;
	Thu, 24 Apr 2025 18:30:06 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v5 2/6] client: Print CablePairing property
Date: Thu, 24 Apr 2025 18:29:29 +0200
Message-ID: <20250424162933.182103-3-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424162933.182103-1-ludovico.denittis@collabora.com>
References: <20250424162933.182103-1-ludovico.denittis@collabora.com>
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


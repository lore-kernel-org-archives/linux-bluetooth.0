Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E63199949
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510608; cv=none; b=IpzXJj1J4f4j1Vmfoa0VRXeRiWVYTbE4k09aip/QSMHuvLGHa66pHSWCKZlmxvRW1gFBbQcu7voFTtpgMdhdem9tz6MdIhhnv+nHGtjo2kLBa3ug+DF7YaAogut3ugBvlLgCAKnVEJvBQjecz8goY/WQr3LJiVkfqIbOXuSMWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510608; c=relaxed/simple;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIW7OqgsRLHLeWucykaaafgMfS2y9oJSl6PsGiRgWU43jfkU3PQhBk0C1CwwnjIeqmTmkSY60ExTg81DONt8JqaswSktGQEV/BxJ//Ut0tIuFLWX4OLW1iZ9FyD8fx/BfllWDUpH9yRLZVpdAGttfSOn5Eq1fS3Orc3nF6NdXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PT/dbc2j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PT/dbc2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745510605;
	bh=bzbxsFCYgrgxafRDANaBXMfZ86UQF2dBN1yjTIj/svQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT/dbc2jjgN/7kyQoTX92MXNu4pM4IMAFICXtnFb0/m5t7EecmsfS8KrP4Vmkst5d
	 BkM4MW5JA2Sz5FYlMBGeaSHWuCCnSy1GOoUZ+u1iPER18vn0576bi/QEKeewYaBlJv
	 degy59Euukf6xDe28RjsdQ4T5tsh61pgPfBrhE7v8claaa6rXVa/syUSYvgnu2ycnl
	 NE7Z6qrQInbheOppPsLAIFhTONhT2IuHAESLEbVwBZ/+3TOuj0/W1yX++XQIvY0eF4
	 97PtOGZZiUGlKr+ugtZcnP5NOvpkuq+p6IEr1CNtpZFoFMoFyv1EIM7iAr77S2EAaV
	 q6iHzuO4wCGyg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D6EDB17E0F66;
	Thu, 24 Apr 2025 18:03:24 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v4 2/6] client: Print CablePairing property
Date: Thu, 24 Apr 2025 18:02:32 +0200
Message-ID: <20250424160236.179982-3-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424160236.179982-1-ludovico.denittis@collabora.com>
References: <20250424160236.179982-1-ludovico.denittis@collabora.com>
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


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB5511195
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540839; cv=none; b=KjnQzc5VAw7RdjCfedD8xQpXJyB43yDsLaH8R373IS8OXHrQZsGB30pPis0xDmeAdwlGOB2PJBu6puvi4rjybsBNZND/9RiAAw2RpsYMwRmw5A18x9nCTpVSa2WGTQGi55l/RmPQIRxo6HiBiE60p7c75Q1cPcSuf5Al1ismmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540839; c=relaxed/simple;
	bh=OUqBm+KNQ5XGfXrmUhCk/W6ZzNJs1cL5RKo2d5IvaVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljy8rG/RRErVrsaNofv7Fw62Z7HyP0o2Sdbt8gzDhpovXd5SLxFRFULyCfOggwaxnVjl0HAf/sJG+0FDqX0AtX5eW9uXOAelsZVmpfCBRDfovnZZFHxoFxkckiwlBIayinXBo90M+7kbGVQeeHqPBPYJX0l9TWytEEeZnEmAIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lGtuzarj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lGtuzarj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788540836;
	bh=OUqBm+KNQ5XGfXrmUhCk/W6ZzNJs1cL5RKo2d5IvaVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGtuzarjSynQw7CWDjRkuLOS2bZ0iY6WY9tyZHoEWuUtZ70EbbfQATkSm25N25X+G
	 /9LHJv7ATBCBhmecOmweVaFwhwtbyO9Y8nJCPhGOuKB01IGoSWpIfzy7kj+Hirmnp8
	 HwlpBNFDTb9Cu18OmttdGS1E8h34oacQRgekXmrgQXbDJk2lipMDv2ODEGMFf3yIeP
	 2zFK4/zmcXNshFl5PCD5UsdasJQ4KWIBNNzmizULm8JncUuXhM+2rCyYPmZ7hmA4nS
	 NfaqGbn9f89ahceRoeQcl9cxMinru1D/h4sUwhZpkWEotxngVkyshj3Le/dexz8AMd
	 npIIhOTdmxqQQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7FC8217E092F;
	Fri, 04 Sep 2026 18:53:55 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH 3/4] shared/mcp: Notify unsupported RFU opcodes
Date: Fri,  4 Sep 2026 22:23:31 +0530
Message-ID: <20260904165332.42046-4-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904165332.42046-1-raghavendra.rao@collabora.com>
References: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
 <20260904165332.42046-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Use the ATT result to suppress responses for malformed writes while
allowing opcode 0x00 to report Operation Not Supported.

This is required by GMCS/SR/SPE/BI-01-C.
---
 src/shared/mcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index a954869b0..4ee14d156 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -370,7 +370,7 @@ respond:
 							ret, rsp.result);
 
 	gatt_db_attribute_write_result(attrib, id, ret);
-	if (!rsp.op)
+	if (ret)
 		return;
 
 	/* Make state transition immediately if command was successful and has
-- 
2.43.0


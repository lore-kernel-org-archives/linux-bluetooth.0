Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A467E110
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923801; cv=none; b=DJ/Z48Tuh+D4Oevx/QvemvCqpCx2obpvZOgyCoRsQNvK6FinTQ5/o2UEKnJOUM33cQ8iPUnnyldVY0iBoTRCWyjBWXU3dh9lbeYZAqoUz14tMvGmu7qblcUS9dEGT1xWKlSbzhz3oBVLvCEfP9YAjp1jFge5hYh0L+iG+7mjNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923801; c=relaxed/simple;
	bh=jwb/CuVyqajQ399rW5TmNaRTsO5csZ4/+5h225TlL1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7OnFnrgOI/uVVQUdD2rAmdO/QoAvc93lCmuRbi8fFLDm0eQSgEpaCrUEwBzvDH0BTNM5WdBo0UOxdjBHnbeiTeMJ5MBH7UkNsSNMSsAqaLEBLcn85Fq3yer3R1QwSV9505pe2PTNsDUijktOI71tXjyWy6BCPev+/cNHBz/aDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o2lLLpnS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o2lLLpnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742923797;
	bh=jwb/CuVyqajQ399rW5TmNaRTsO5csZ4/+5h225TlL1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2lLLpnSQ860eiY+HnUIDEOg2XbWyStr3agOE+87RFJCWFSubndawWaGE/YTVFHuV
	 f8Ox7+l6UKgdkL0BxkoNygDN67C+hSF9cJ90S7iojhwSCzgjsDT4BC+JDCIiI44i2Q
	 bFP9l/IynbQqOsMszGoWzDfOe8iK2C5RpI6mSoEGBU5RrF1OCKW/jXqR7QwxZy6Vxd
	 OUnv0YSglF1ZGv0Fe2y21haEyL7ER1KawzLGmRg9qViih6rQhrt9PcDmcz0xq/H84a
	 EpyEiJSb3ThLSoqe/p3zc9bP4valu34GsNa24uSIoGDsvteQdMGVksNjI9hRFI0kb+
	 q32pH+Oh/jr4g==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C1D717E0599;
	Tue, 25 Mar 2025 18:29:57 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 1/3] adapter: Preserve pending flags when setting the Device Privacy Mode
Date: Tue, 25 Mar 2025 18:28:44 +0100
Message-ID: <20250325172846.139431-2-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325172846.139431-1-ludovico.denittis@collabora.com>
References: <20250325172846.139431-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are already flags that are pending to be applied, we should
keep them to avoid overwriting them.
At that point we only want to add the Device Privacy Mode on top of the
existing flags.
---
 src/adapter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5d4117a49..d4e42eed8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5630,8 +5630,11 @@ static void add_device_complete(uint8_t status, uint16_t length,
 	if (btd_opts.device_privacy) {
 		uint32_t flags = btd_device_get_current_flags(dev);
 
-		/* Set Device Privacy Mode has not set the flag yet. */
+		/* Set Device Privacy Mode if it has not set the flag yet. */
 		if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
+			/* Include the pending flags, or they may get overwritten. */
+			flags |= btd_device_get_pending_flags(dev);
+
 			adapter_set_device_flags(adapter, dev, flags |
 						DEVICE_FLAG_DEVICE_PRIVACY,
 						set_device_privacy_complete,
-- 
2.49.0


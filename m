Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1A14600D
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=NNSUs+Gy1+sicwXEo0vI5yk4m8MmF0LzPQC407fOo4FOU4zRIM7SjZ4vc4A1x07fyrg2Z8XSM8bP4GINQiN0dIELDnf1kArQf60WvQNcY2YNLq8U9sbS0iG+ZSocMMYcRAsuaCf1CWqCaBeOoAMDzIHdKXXjQzYt8z69eOJ6dU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=N4pEx5sWh9VmjRl91OoGtPCKaGhZxguLOuuAogGpyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI/hBqvuEprA4/Kgya4ybyuZvL0AaQ97SqvWLFw6MnTTLh9leu4ga8EohnoOzalNsiWSndJ9y6JpcFSkI6qkMvTCl3dIemCts6vg3fSMcI+jcfc4MNWABNEIow4NlXzEY4YeoMi32bf3GC2dqSkOIHjhsseLdyW936Dg+TWfNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E11260010;
	Fri,  5 Jul 2024 08:59:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 06/11] sdp: Fix mismatched int casting
Date: Fri,  5 Jul 2024 10:57:34 +0200
Message-ID: <20240705085935.1255725-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

---
 lib/sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index e260a5a9663e..411a95b8a7d3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -506,7 +506,7 @@ sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int *length,
 
 	for (i = 0; i < len; i++) {
 		sdp_data_t *data;
-		int8_t dtd = *(uint8_t *) dtds[i];
+		uint8_t dtd = *(uint8_t *) dtds[i];
 
 		if (dtd >= SDP_SEQ8 && dtd <= SDP_ALT32)
 			data = (sdp_data_t *) values[i];
-- 
2.45.2


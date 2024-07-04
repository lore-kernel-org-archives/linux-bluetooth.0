Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A41ABC25
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088784; cv=none; b=e3VEaXqhm3zmrzySdKZb80wRf2QTf9BdAjAMxBqaSJb7N2+jaIq/Rcp4zembSCV9eOzZcQZL3Y/ZKMSHvGc2IoPPMSAZ8wsyhA8GrH74e2U3TnP4QubDb/9AMZFgiz8hbWGMbMgRYs6e757pWRjbQpq7fP52cAq96gahaFx0DXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088784; c=relaxed/simple;
	bh=N4pEx5sWh9VmjRl91OoGtPCKaGhZxguLOuuAogGpyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV2CIRn8FXVL645izS0iod7FK1Z7N7EsnLy04ry0gbHQvzcIxjxM4OMV8lWT1Pk/tqhrLaa73HOUJgUv64ocPnqkh/v9rDlGeY0Gjvrkl3Qgrx1Q/aIPl8TW8F/pyX4XRj1+9CH4NuN6T5R9O/6xgKwOmia0deQ49bEqFoy2B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93DC024000D;
	Thu,  4 Jul 2024 10:26:21 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 07/12] sdp: Fix mismatched int casting
Date: Thu,  4 Jul 2024 12:24:38 +0200
Message-ID: <20240704102617.1132337-8-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
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


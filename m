Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286A142E8C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=TK55/zsPmrwuhHqd045TKIBBp81u93eDrECUgnILHNIqm7V2in0b3eucSiYWB7X8/p+F+pE7QgCE14n6rGfhibSYZYrcnMMy+Puhng3aKnMlDbQhEFeRfoNZ4EU7XoG4W2y7mxj/c6k5oKD7iPomVG9KeSuSUlth651uIGo2S6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=nJD3hKR3Np3JLEdiyiWo5d5x/H0q+Tf7XAmtKd6Lob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr8mI/wUbTCgO8YrU80E/RsTDDYQTdUT4ZM/veGx2OrqWl2/pv18fE9RrKRFzaAFxaFmasbdEpSZRQaJfsaOoMw9JXGTrMOy/0espVgnnbWRewettQHnZ0SHb8kCVCqL6hl8dharjaD6TS6jjHTtIr4ChfIXoPrX7ERAiYip+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB7611C000F;
	Thu, 16 May 2024 09:03:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 03/15] shared/gatt-client: Fix uninitialised variable usage
Date: Thu, 16 May 2024 11:03:07 +0200
Message-ID: <20240516090340.61417-4-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: UNINIT (CWE-457): [#def44] [important]
bluez-5.75/src/shared/gatt-client.c:1669:2: var_decl: Declaring variable "value" without initializer.
bluez-5.75/src/shared/gatt-client.c:1686:2: uninit_use_in_call: Using uninitialized value "value" when calling "bt_gatt_client_write_value".
1684|		}
1685|
1686|->		att_id = bt_gatt_client_write_value(notify_data->client,
1687|							notify_data->chrc->ccc_handle,
1688|							(void *)&value, sizeof(value),
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index dcf6f0211a67..8e4ae7e5e230 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1666,7 +1666,7 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 					bt_gatt_client_callback_t callback)
 {
 	unsigned int att_id;
-	uint16_t value;
+	uint16_t value = 0x0000;
 	uint16_t properties = notify_data->chrc->properties;
 
 	assert(notify_data->chrc->ccc_handle);
-- 
2.44.0


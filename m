Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C892F3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530325; cv=none; b=iKs6A/Fm3MSEk/GS8a2nRnyss6l2KDZhVUf2ysPNYIBb0G4rlGePvyTyOTb3vD6bBsOn1wN4Iv4y94Bjub+bwp9pMbJefibRgbj7iGDDhijZEvfotCY6B6uqj0nNWRFILTO1M3qo8NYFwKmWR8ws1Vb/ElJplvTqfcUvw1KmKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530325; c=relaxed/simple;
	bh=QxjRXv5ZEL4hw/OV2yj4N1xe4ObbSm4cn0eZnE49u/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcWoruBNKKeu8FYkyNqkRuzqbLPgv6ZLXSioEJBFhwuXyRBEeMzTpQ3br0km4gdGa6UJcDA8TRStFyFJt+Xwe97My2TybeSARaKpYcFziwXNjefQru4i2G1z7+5dXhkatjuEUihtmCwOisrBJMFarh2+5qWeSQ1IigqEKrXi4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nR2rSOy/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nR2rSOy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736530320;
	bh=QxjRXv5ZEL4hw/OV2yj4N1xe4ObbSm4cn0eZnE49u/I=;
	h=From:To:Cc:Subject:Date:From;
	b=nR2rSOy/XF2mXpopFCezTu5ulmTlHvMgI4GGFv/4spUKvwa6S4MicaMOdGg2ntCr+
	 22n2mEshLLrHWpp3QwCzkZepXhxV6F41fyuaohBWMY9QjNWt2RlLkx0XY5ueoKeBSd
	 wdapyClG6pCm08GEmHVp0Zmt/dzby6/tj/lSUn+2MzZl7J1OYtNFAObVM+/H2raanl
	 pgWNVSMfJFRgrXE+hnK7/2T91q7SI1rnOFuARcbqgmOrrPEGgZtinSqVSfeY61HziP
	 Xo+x5tGlRhRA4O/T0AEr10R+P0y87HFRqQPJ+HV/vMQzoFI00zsyMwZG+OcYRtpMvF
	 MNh2Mt6sWOKJw==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8877D17E0801;
	Fri, 10 Jan 2025 18:32:00 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ] device: Clear pending_wake_allowed on error
Date: Fri, 10 Jan 2025 18:31:46 +0100
Message-ID: <20250110173146.309964-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If setting WakeAllowed fails, we should unset the `pending_wake_allowed`
property, or subsequent requests will be rejected due to another
"Property change in progress".

Fixes: https://github.com/bluez/bluez/issues/1047
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 24ef3d779..e8bff718c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1574,6 +1574,7 @@ static void set_wake_allowed_complete(uint8_t status, uint16_t length,
 						      mgmt_errstr(status));
 			dev->wake_id = -1U;
 		}
+		dev->pending_wake_allowed = FALSE;
 		return;
 	}
 
-- 
2.47.1


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88F382383;
	Fri, 24 Jul 2026 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924451; cv=pass; b=axw3NMngS6nGWYMpyROZSeVrj7zK6b2veX1VCl2x8gQmva47cO00qBEiZC8irYD6b6UiGo2AUzHqnpaljfYIJ9TFhRe2nkNYGOuBlkQ2eBVSFXSnRKjWqjiyAFsBWBaD0ltRF8m2qg3f5buBYRCRR5VQdBhSF2JYkiaD9usKM6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924451; c=relaxed/simple;
	bh=SHG/RO+SmJ77o4uRBtFwMTX1JEegiSW3yQvhyQiI7Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArR2Zeqw4wFY+Jkn/9cO4s1kJ3GFcxwgEBseTSELv8KfaM/bEHFKmEpxVW8XpPhT+zo5jntReiR7FpRS/gcQv/1UFjOYurqYflNARhRFfVOAOErbaYIH2R7z6QVu6qe4WeqfiCrry32X2PLHr2mM7lzoJfQG6PcJky0tE/k5la4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uFJrCWnJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uFJrCWnJ"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KB70m0gzybX;
	Fri, 24 Jul 2026 23:20:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/20aiEEiCKr0RFwSceTIF80aa4+pazXF3tL76TpT9ck=;
	b=uFJrCWnJSVZLq21Jn7RYUQgkVnY5+ppLHmlJ6whGgov3FAKxKt6FJJBk1db3Y3zRF2mS9a
	FS039oNLFXw/X3Z6jYxOp7vYoosBwEom4MRvwFjDwOq0qPjDwzJPhDAkrWngs6GqvntFwc
	MdUOgXRZcU68hwOZXMFuswTTC3N8Bp8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924448;
	b=vTv8j5GCRHvZxHpTBBe3qlaR17y3eRC6mMsjeNvO+709daQXdeSpKtNcDsqUsZMwcvu1cN
	oQaVdI84wfsdpR2oOuICijIYiQ4do3e5IM9ozxsolUmzkC2XiTlAZNb5FX7UU1f5Pa9okI
	ZrcSc5dYT5Dw4u0W6xqaQ3X8x9fD9mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/20aiEEiCKr0RFwSceTIF80aa4+pazXF3tL76TpT9ck=;
	b=uy8nTSDbtqgXPU3L4lRwRpVSEx4lcqe8yic8I8Th5JW623N/oA9EK7iapiU2TlczCtt5gR
	HlULrS1Ztv1hPqP5JlpTMp2nBpDFG32BgZ+lWzkTd/SdXycPvGHTgPdK90s6F7rw8bRMOp
	YbqBnrd37y1suhGGBYv6Eqa4dN9U/74=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
Date: Fri, 24 Jul 2026 23:20:27 +0300
Message-ID: <acdac7a0bc419eb8db959dc04c6fa426889e83d0.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iso.c check_bcast_qos(), missing bcast.timeout is not set to its
default value, and appears typoed as bcast.sync_timeout.

Fix the typo.

Fixes: b37cab587aa3 ("Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 651661833966..e51253e5c161 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1796,7 +1796,7 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 		return false;
 
 	if (!qos->bcast.timeout)
-		qos->bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+		qos->bcast.timeout = BT_ISO_SYNC_TIMEOUT;
 
 	if (qos->bcast.timeout < 0x000a || qos->bcast.timeout > 0x4000)
 		return false;
-- 
2.55.0


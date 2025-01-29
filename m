Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D21B4141
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171381; cv=none; b=I34d4a/zpz7xkmar5bzLUEBU1TpxdeN85+P5yqlW68pOCoZqy4GXvP6jOZcGHvb5rOGYagieu8/O1L/nPBdQHsHTXM3xRTPMVP4ubvjn6CS56s6IDUl2BFVXh6Zuyg7Tf1i31g5PblYRyX/9jSvki4ZHRy/DzNFFSUY3VzjdLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171381; c=relaxed/simple;
	bh=1MIdMBkmbPH9cM8IPwQvhSxh2vjMG54lwKeW1s/jXsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfAEI2YkOoWxS2Ecws8GSImHHt6M62AOZ8B0ZfpfzSc0iDJ9tKt5lCpq9hbLND94NTDZjq9WlEURBqxn81wu7fvPGUpJq+b98xBvZHrgbiIFRf5o9eqnP7iW7/81273IhA41lkYpwNFc6EYabMH81yTNao4Qyl9oHouSkcI0FDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l3g3WvCM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l3g3WvCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738171371;
	bh=1MIdMBkmbPH9cM8IPwQvhSxh2vjMG54lwKeW1s/jXsI=;
	h=From:To:Cc:Subject:Date:From;
	b=l3g3WvCMfRbM4Go0WwoHEPwoJ9gxWoY/dNlBGcnGM9/MScDlz1l36H0Bz9nb9uEBe
	 HJ5cBBUXnDUFGcSyOd4xvzBSPkJ/KUbqe13SsrB1aCbxg0uzw+UNYknd3ugiLJbR28
	 wJIoxiauJS066f+jW74Ps2g0bqTKHCVNzQJzJmJvjGhAkfd7XwEDbsFbPx4KZgiqu2
	 jIWQhlWIYHOTMOor6ArG8O3xCXRtvKzsQSvy/hciKiG2gQ1HhIK9+yeUOSDh6acYdT
	 t482PwrtdzIxwNDMC+8Afy+Rq3MxYwaBOj1onaoE7aiF3Xvv9FB5iveCEqPibmvnnX
	 fIi1pWjfZQZ+g==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 699B117E0848;
	Wed, 29 Jan 2025 18:22:51 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ] device: Clear only the pending flags that have been applied
Date: Wed, 29 Jan 2025 18:22:31 +0100
Message-ID: <20250129172231.329172-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing `btd_device_flags_changed()`, `dev->pending_flags` may
hold additional queued flag changes.

Instead of completely clearing out `dev->pending_flags`, we should only
remove the bits that have been actually applied and leaving the rest as
pending.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index e8bff718c..17d023a61 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7413,7 +7413,7 @@ void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 
 	dev->supported_flags = supported_flags;
 	dev->current_flags = current_flags;
-	dev->pending_flags = 0;
+	dev->pending_flags &= ~current_flags;
 
 	if (!changed_flags)
 		return;
-- 
2.48.1


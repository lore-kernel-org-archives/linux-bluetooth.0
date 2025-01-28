Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CD19CC29
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060153; cv=none; b=SQt1EsBBxltmvOQcEliewNnM88IEOyhAKxutqPcyB8wpL5js3WpnPah8WVUZTdcixAgBsHROBeCJ/mh69ogjQeIbD8MNk30NBSPpAQ69Z2Wb5OhRw7dXg0BLlF9lZZ36cE6bLP8Z18Z8nGX/SKfd7I4/wEOi6+kD5UdiFu75cvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060153; c=relaxed/simple;
	bh=sKufb+KLgZy6lfiel8Nub/Uj6KAIZtZspgc8r5D8p3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFoVEaQF9FJnkjrAaMRhsxlTIVIPPsvqVtu7pJ0ZoQEGHlZgwQgMwvR79s3cS+Zmg7e7Lca/2BdeuQSdneBPFjOWVX5AcJ0Y7xThjvB8MkLKuqrick9Y7ogUzjBl3jDzlXuEFpeErFWSXEA432nSPXWWZy6S6AtZoHeoVHKQ0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oswZPgGF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oswZPgGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738060144;
	bh=sKufb+KLgZy6lfiel8Nub/Uj6KAIZtZspgc8r5D8p3A=;
	h=From:To:Cc:Subject:Date:From;
	b=oswZPgGFozeDiyfl0TTVnXX/aJGTKMn2CThz1MvZU4JE1gkuhEIt1dplUGj/R3xCy
	 ijN9ZnWWIXvaXBkZZD1tWKbQBCZKg2mmK1Z7/PkkWbt1vaalKKWnn16OP6nNrvfCYR
	 DhM81YjOXwgnZOS9qOqVKUkrHjFMJaMPrCgTYtdXqMSklyH7X4XIJMmqux547hkr0r
	 L8x9BEyejM4YGedCf3xbt8FtUH0iubmPIaNR/thDVO6jL+LTP7oTTmfTXfJTRilKJR
	 4dUAHTcN/AuknDWZlyiZILXWnKFx7fO1Q7gLktcvQa0BvNQAjimNV2kVH7PTLCl3hw
	 BA8mpKPiQEFEA==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4438717E0FCA;
	Tue, 28 Jan 2025 11:29:04 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ] device: Clear pending_flags on error
Date: Tue, 28 Jan 2025 11:28:28 +0100
Message-ID: <20250128102828.16087-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If setting WakeAllowed, or the device privacy, fails, we may end up in a
situation where `pending_flags` is still set to some `DEVICE_FLAG_*`
values, for example from `device_set_wake_allowed()` or
`adapter_set_device_flags()`.

This can confuse further requests because they'll assume that there is
still a pending request in progress.
---
 src/adapter.c | 1 +
 src/device.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 5d4117a49..749662586 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5580,6 +5580,7 @@ static void set_device_privacy_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS) {
 		error("Set device flags return status: %s",
 					mgmt_errstr(status));
+		dev->pending_flags = 0;
 		return;
 	}
 
diff --git a/src/device.c b/src/device.c
index e8bff718c..3c2337198 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1575,6 +1575,7 @@ static void set_wake_allowed_complete(uint8_t status, uint16_t length,
 			dev->wake_id = -1U;
 		}
 		dev->pending_wake_allowed = FALSE;
+		dev->pending_flags = 0;
 		return;
 	}
 
-- 
2.48.1


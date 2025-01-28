Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFA199E8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065444; cv=none; b=EFUmrpCUKDO+hVflf5JDU7Ewm8iHfU0YVKeLXg5uvuL8q9gtzmndeHK8w2D/okDjuxIFHKMjXU8jPbT2pJmaC/5D0Kpx2SDS1bEpDJ0r9WEakkU/cSZ/TduJd/WnT9d3IdnzqANGsjPwcDdUNZWdNMUI4FnA5WKgvSrI3nitImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065444; c=relaxed/simple;
	bh=G03+MBAwS+Mrqq7oG7OqFT3gUEL7uxFUmiiaCzHvccc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUQhLg8tZv8TD03Xg75BiTQ43ZhC0D28a8+uNv6j4x10r74DUKjtmaQxckixq6VJzLdlmRD8rDUSegCNVTXq694OaVjg26os8FrfaRjcXMK/iE/QtvM6IMF6qA/FFbsbjj585mQCcMOqGxhU5q2eYaIGCOBJnI4vylPKLQIpYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qwGpPdk0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qwGpPdk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738065440;
	bh=G03+MBAwS+Mrqq7oG7OqFT3gUEL7uxFUmiiaCzHvccc=;
	h=From:To:Cc:Subject:Date:From;
	b=qwGpPdk0s2M24FliiOotMfo3vz1gMOjNNy/UfTLMEjMgwwx/umRbesk4fckIYGMD1
	 ND0V6QNE40BrDRgGIDh8Kw/X3DO2SUwtP3B6UGlSLfQo+8LUFAaIuOA9H9QH1y1f2l
	 e2aJW1qxfzaF1CoEKKAstjm7/0Jfq+UAo1sBs9uWTV0BFvJJYnYZxwAvgd0fswBm3D
	 XUuJHiqVTBxPx/JFXx+m8W3YfQSLpohwFBWp4IMBNOkFuSZCKUNkJa9EbrVFbNdz2/
	 Bac50oscmb85HoMB1+wB3mIimQpMH4YKnAijuzLd/HPhSwiElGfI4nB338xfoVv/NI
	 bAa7qDzx4S3Ng==
Received: from localhost.localdomain (unknown [81.56.123.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F0E617E0801;
	Tue, 28 Jan 2025 12:57:20 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2] device: Clear pending_flags on error
Date: Tue, 28 Jan 2025 12:56:59 +0100
Message-ID: <20250128115659.23655-1-ludovico.denittis@collabora.com>
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
index 5d4117a49..3eb343cbc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5580,6 +5580,7 @@ static void set_device_privacy_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS) {
 		error("Set device flags return status: %s",
 					mgmt_errstr(status));
+		btd_device_set_pending_flags(dev, 0);
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


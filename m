Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8B203706
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923804; cv=none; b=EvUv/qtHK8W3aM7WiEdtJFu7nZt4mtLTtUHFjzwxAox0clivmV9npB4kd0lsr/sz8XfAhbJNbtypPEG6dmOltmBIasxMWWQxp+tilLhItBi5ggi3YMSzu+v1E58xo8kgF7/vubUdxhBI6zk+LOxqn1xBsOtdr80ewoL/txgeViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923804; c=relaxed/simple;
	bh=UXInSgiudcVIHyzQzgokiw1Fgmg65Tw9+F1DZF3wkls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJFOCP62/7RkN10P/USxmKApmjisL5t75S9KS9Ee9C8NOWaLRZfZzdQ63+jfH+SmfdkRhyQfYn8+56t4hmphQDwRYo88fjfQqXD1DIv1/MBt60jJrFsTwrkY+ISPwsOco29mHRJxmVqv3qa9z+kqzeeZQYSk8dHoK6qdufIDNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N8N1hAcf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N8N1hAcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742923801;
	bh=UXInSgiudcVIHyzQzgokiw1Fgmg65Tw9+F1DZF3wkls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8N1hAcfyZ46JQnM8EXD/lCcq3y5I3Q9TQ21HS0BXMUz2nKZv1TV5Jxlsp+DHvs6C
	 D/tFWQpPTK6HDUv0OjaLH4jHrJEo2sNkWYny81BvcNUG4pMzZB7mEjZhhc6yj8qrS/
	 /m5hYS0fCkYeH2CJXUI8VDn2hxVNbT959X/QNzBRJuC/xn+kWXJK2BB3anAcCIY6mz
	 kxoIKqgT5OsDu28tCsO4r5KgwwBe+onUSeAzdRTTD8CTA5mrC66JPmlzK5lVeaJ5Gg
	 +ozo3im/+z5A++4LlLGjQDMXr1dOD6UygzJPrGDLo7QqKHbMHRM0c0s/5lPKRRNYIm
	 RygJTu4XwDrDg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED83D17E0607;
	Tue, 25 Mar 2025 18:30:00 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 2/3] device: Preserve pending flags when setting the wake allowed
Date: Tue, 25 Mar 2025 18:28:45 +0100
Message-ID: <20250325172846.139431-3-ludovico.denittis@collabora.com>
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
In device_set_wake_allowed() we only want to either add or remove the
remote wakeup flag, while keeping the existing flags as-is.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index e8bff718c..474ec5763 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1605,6 +1605,10 @@ void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 	device->pending_wake_allowed = wake_allowed;
 
 	flags = device->current_flags;
+
+	/* Include the pending flags, or they may get overwritten. */
+	flags |= device->pending_flags;
+
 	if (wake_allowed)
 		flags |= DEVICE_FLAG_REMOTE_WAKEUP;
 	else
-- 
2.49.0


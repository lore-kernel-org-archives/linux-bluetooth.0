Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6218352013
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785010756; cv=none; b=t/sW997yGrZTqQggTtUklwnFKX7USyyyIm3KHEqV3OMMPJhLaXOlIeg5n2o4QBphl18I2Vv+fDR+lZoP63aEJLQ0btcvisrv/3LZGlRYQfQCbVjzPhyNWSoRUosI8wTbvgrs/hzoXBGnva3d+RC4k/XkuqWLXZ+c/Fs3GBJcMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785010756; c=relaxed/simple;
	bh=foc2AHYmh7sBWzZcQOqCXfDdQlI4qFkmNEP46LTwitM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4ncYquwqYY3TwDQeB7/UlYuTO5rjBFfm0UIr/BFzpgpP7jp8hFBnfFMtCVhgMkq5iyKvfS3ivVdbQk3GV8Kr/EvMlow8euDDIM3NrPWTD+hd8hAnxWJhpqK/JO4c0+Hl3/fsz81e66e1WSnIQ636hy6cj8BK8wAYDjpOnv1HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQxtniAk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQxtniAk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785010752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYfVUQERU92g7cxAw+M7zjSn05nUQzxKBtk7Yt5H8fk=;
	b=VQxtniAkeQmLUjpAMt5LlsEu1g/L8tpaqtdndDsOGnJv1IHGnBIFdsPEKIDCQYzwZ0PHma
	+ss8y7MsK8EfM8BtJycZdk0aCr2YJ8YUOKDk0KHrdIR4i+vtmT9M4nCkvnNDkWIJ4/rfuz
	I6A7+Dt7shKQjqdC1lPUbxwAiQH9DHA=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH BlueZ 2/3] device: Hide WakeAllowed when adapter cannot wake
Date: Sat, 25 Jul 2026 13:18:55 -0700
Message-ID: <20260725201856.2142333-3-matthew.schwartz@linux.dev>
In-Reply-To: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
References: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dev_property_wake_allowed_exist() only checks whether the device has a
profile that supports wake configuration (HID/HoG), so WakeAllowed is
exposed on every input device even when the host controller cannot or
will not wake the system.

Gate the property on btd_adapter_may_wake() as well. The remote
wakeup device flag itself remains settable through mgmt and is still
stored. The kernel independently ignores it during suspend when the
controller may not wake the host, and the stored preference reapplies
once wakeup is enabled again. No PropertiesChanged signal is emitted
when the sysfs attribute changes, so clients observe the state that
is current at the time they query the property.

Assisted-by: Claude:claude-fable-5
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56..697baf628 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1839,7 +1839,10 @@ static gboolean dev_property_wake_allowed_exist(
 {
 	struct btd_device *device = data;
 
-	return device_get_wake_support(device);
+	if (!device_get_wake_support(device))
+		return FALSE;
+
+	return btd_adapter_may_wake(device->adapter);
 }
 
 static void append_set(void *data, void *user_data)
-- 
2.55.0


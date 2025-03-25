Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706A2627E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923810; cv=none; b=p2AMI2ZlvNYRZt8Vv6VYq4w+nfWi1Cv6bFzcl98RoJHQxx6gd/XZy7KNvnablqcf4Z8832KDhDlskvBAzwqDoHG34MlL3xx76aEHCYb6n6sQh4nIVioGw8vmILawO++p3JdLIsf3dMBFo5OKvdJpLPaj1hjZMyt5ljaH4X5Upqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923810; c=relaxed/simple;
	bh=JsRPNgZrgpEMZQniwu9kf7Xq9Z9HlL/Q/H01JGa2K6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTZDyTWsE3hpPZpQ65HkSbdvuyDIJYZaZl3aAamrHkk8toXEeuXTYRmldJLl73nGjLwihK4LLO6066FLHFHuRJKDaPlnmpoEgqWHzwYNNBn/RWkDb6RBMjekv8k1d7Hq4LYSg/Iy5P3UgTYOT40WIF4EFE/pldlrM6M3vxeZmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FYMqS9vA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FYMqS9vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742923806;
	bh=JsRPNgZrgpEMZQniwu9kf7Xq9Z9HlL/Q/H01JGa2K6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYMqS9vAX6pE4mkxuJsM6dB9QlGrI5AasC+9T7nRwFeOKbuRqAeIpJ7I9NAFep8ZL
	 YSigY3NnS3uCAHDpufm4HIB4t6KX30vk4dCnIO5VCrVPaSuG4PwxwBqCR+VCTaAIrU
	 1TC5O2pZqZjpI3SfIJjwmxjP9qKWq+Ywff/cv0/CQjbhfZQLM5YYg1bFLui+zqDigK
	 AXLCNZDHHPrJdIbDVoN4GD/ux3y7x3fDYeqjg/J4TEZjnQ+8ZHQrDiaEUA80/zvF/L
	 AioYDs7CQBwibF7tI8H/PmkIHusjap+DM3asbmOR4UsGggDFZeO8KJhAeXrA450NzI
	 P6OF911KpDtZA==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A79D17E0599;
	Tue, 25 Mar 2025 18:30:06 +0100 (CET)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 3/3] device: Try to set the wake_allowed property only for bonded devices
Date: Tue, 25 Mar 2025 18:28:46 +0100
Message-ID: <20250325172846.139431-4-ludovico.denittis@collabora.com>
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

When the function `device_set_wake_support()` is called, we don't have
the guarantees for the device to be already bonded.

For example, that function gets called by `hog_probe()`, that is also
triggered when bluez scans for new devices. In that instance, we don't
want to try setting the `wake_allowed` property, because those devices
are only in range of the host and are not connected, paired or bonded
yet.

This fixes the following Bluez error when we scan for new devices and a
new hog or hid is in range:
```
src/device.c:set_wake_allowed_complete() Set device flags return status:
Invalid Parameters
```

Additionally, because that initial `device_set_allowed()` call can fail,
this commit fixes the issue of hog and hid devices that, after the first
pairing, were unexpectedly showing `WakeAllowed: no`. And it required a
reboot to let that property be set to the expected `WakeAllowed: yes` by
default.
---
 src/device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 474ec5763..727b668af 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1526,10 +1526,13 @@ void device_set_wake_support(struct btd_device *device, bool wake_support)
 	if (device->wake_override == WAKE_FLAG_DEFAULT)
 		device_set_wake_override(device, wake_support);
 
-	/* Set wake_allowed according to the override value. */
-	device_set_wake_allowed(device,
-				device->wake_override == WAKE_FLAG_ENABLED,
-				-1U);
+	/* Set wake_allowed according to the override value.
+	 * Limit this to bonded device to avoid trying to set it
+	 * to new devices that are simply in range. */
+	if (device_is_bonded(device, device->bdaddr_type))
+		device_set_wake_allowed(device,
+					device->wake_override == WAKE_FLAG_ENABLED,
+					-1U);
 }
 
 static bool device_get_wake_allowed(struct btd_device *device)
@@ -6561,6 +6564,10 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	device_auth_req_free(device);
 
+	/* Enable the wake_allowed property if required */
+	if (device->wake_override == WAKE_FLAG_ENABLED)
+		device_set_wake_allowed(device, true, -1U);
+
 	/* If we're already paired nothing more is needed */
 	if (state->paired)
 		return;
-- 
2.49.0


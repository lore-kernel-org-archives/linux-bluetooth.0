Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FE1B21B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523265; cv=none; b=LIn1+DyIU85jJe1Wavf2dBaMS5imu72qNJ2zHqEVi7rwRic0OJBaDC3qxvQyZfXT+2dZNX4Dqez/c5UYg8P9s8W10JL+8gL4qX/Cmvjl5Jna/7YbX77bqwRcyZiUTziKVG2TTLhtXObWfBPQCQ1vwoIhEuFzyrpBdDiWDP3NECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523265; c=relaxed/simple;
	bh=poaqfkUzMZteBhA3p2wev2L5Jd8N4zmJsyXFhj09v/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RoYFVn0C3jEY6InXa+OMDz/8WMO1rKtsol2Ktof+K4CxzmclpnLrYgogHtkbma6/B3a0JpMTepBRY7z3ZuHotzoY32rZqnhu7v/me7ACNeDznb0su30MxY1062VSLDu9/nNPRBERwXAjKjXUdizHf6x4rbHCG6j6lSQADg3PH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikbJ5Mth; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikbJ5Mth"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso12017548a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 21:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737523263; x=1738128063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PX9yvCtr2TcNqeiJ4lqz63HCE5uIjiI2N7GzbWV/vdk=;
        b=ikbJ5MthB7uUNBZo1jWNfNYrHoJUzMS6xDgpg74pPbn4o7JTlqo10CE9OspW1Q/LgC
         /hTzDCfojLXfbDymNWxLlrz2VIK/p3Sf/6L8DVD9tf05fYFleJW5HhlQBOs6XXTylSyv
         BN9OdEBUm5q3YKz+g/FJGs9IOfbeSKQMvV9KWeGAxi80Q2nWm9gEzuCV2chqQd8xjAYA
         HgwWhzS3RG/523vMPO7P63/96VhW8MlXVY+xo3HvmcLCV0Gyb7nG5FE9TwzATl4mJs8W
         sgFGYpWnUIRvm+029UXb6n5rxuRb/hQEm1e4JjPkHZ/fpYVq4jlyaV12jkliBKBemGzf
         VFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737523263; x=1738128063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX9yvCtr2TcNqeiJ4lqz63HCE5uIjiI2N7GzbWV/vdk=;
        b=V4YTVfQLiv9LE9/wMU6iwZ1B2rIN9FbHIDffPFHxby7MN7kyhvhgd5poKP2kdUojO9
         1UoZDlY5O+FIdwe3sf6/H0hDgCDyBEZBwyBH/fiEZtDT+1GBm+9UH87Mdnl6rvw2pvQr
         fwWU3AKOIq7FzUF4HcL5lJV94EsoG2OimvcaCqQM9189eQVp3Au/Fr6yZzxntAVe/8fb
         0awPZjrytAO55VoYXLaaiSB47tq0s3GLSN4KQkHzJQKi9wYzPe0ILZaCi6ffZe/Eg9fz
         GY+OxgsOAOgLAN5DxjYhFkVV0C+xiZzEtPM9S2NfFI3vAi52Hx/46c70tZLdRKnEGMW1
         DQqw==
X-Gm-Message-State: AOJu0YyJQLuGDFptB+oOs0YU6WxCqVnGjLUOCPQfi6+T//X6yw1XA/gy
	UO5GURxcwc2hSAGnMnjPralOXntwjGkWoCvOo90nS0mAibrfJjxB82Ig1F647GY4ipvHt94PyN9
	I1a4/ivnpDRmx6RyGo6nTT4Mi773Yexh1XmNbOr/2RjPYwWWFyKSS+Mtc4RAfsQAbC1bWfY2y+4
	RGm21KFdR7jZ8T3bR9P3KI9Yxa6MjzcphBEM3zMzxw3yfFytYF3w==
X-Google-Smtp-Source: AGHT+IFfG4tEL3lbiYTMu0wVU1MvXopkr4Ek6RwDkFbI4cp+BVUOKM//0hEp9J9P/dM1bseC9zknIqgpCq0b
X-Received: from pfbcq19.prod.google.com ([2002:a05:6a00:3313:b0:728:c6d8:5683])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3487:b0:725:456e:76e
 with SMTP id d2e1a72fcca58-72daf94f68dmr27246422b3a.6.1737523263257; Tue, 21
 Jan 2025 21:21:03 -0800 (PST)
Date: Wed, 22 Jan 2025 13:19:27 +0800
In-Reply-To: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122052100.2410368-1-chharry@google.com>
Subject: [PATCH v2 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The functionality was completed in commit 5e5c3898ef49 ("Bluetooth: Fix
possible race with userspace of sysfs isoc_alt")

Fixes: 5e5c3898ef49 ("Bluetooth: Fix possible race with userspace of sysfs isoc_alt")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 Documentation/ABI/stable/sysfs-class-bluetooth | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
index 36be02471174..8cc5f3cfe133 100644
--- a/Documentation/ABI/stable/sysfs-class-bluetooth
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -7,3 +7,17 @@ Description: 	This write-only attribute allows users to trigger the vendor reset
 		The reset may or may not be done through the device transport
 		(e.g., UART/USB), and can also be done through an out-of-band
 		approach such as GPIO.
+
+What: 		/sys/class/bluetooth/hci<index>/isoc_alt
+Date:		22-Jan-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description: 	This attribute allows users to configure the USB Alternate setting
+		for the specific HCI device. Reading this attribute returns the
+		current setting, and writing any supported numbers would change
+		the setting. See the USB Alternate setting definition in Bluetooth
+		core spec 5, vol 4, part B, table 2.1.
+		If the HCI device doesn't support USB Alternate setting
+		configuration, the read/write fails with -ENODEV.
+		If the data is not a valid number, the write fails with -EINVAL.
+		The other failures are vendor specific.
-- 
2.48.1.262.g85cc9f2d1e-goog


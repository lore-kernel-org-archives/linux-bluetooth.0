Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EA2550CD
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205107; cv=none; b=ORkWD/WXST89AQn8iPCYRBYSZQ/GyhqtoUBDbuIN5wTZtAfeHQpOg39Ix36nXRScz74i3lKq6kpf4Zuxd/kWyaBcNmqvSe/ZDIOI5TOM+m+2ER+W+I3Zezyk5OiL8fz6i04U8zN0Onx9so08gc0NJu24PYW5NSyhw8/58qacl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205107; c=relaxed/simple;
	bh=JxfbPSjX1sSQidwd/C36UPYyz030B8Vf7d2A9Rk/hds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RPA3j62saijinVsnaRdReOCWwQf9cc1//gKKcNAEeBLHbJr/7kyethA2KjfhSmepnmuKVXfSSUyoAXvQSNCCXDYcBSgTldVo4RVigDIS+Uae2Op5GwOFiTtybUKnb+Unfa2LmRhh2SiXcurc2UFdyFmFpslKcNhl/QRkshSVmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTwvqI9n; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTwvqI9n"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4c315dd9252so1390334137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746205104; x=1746809904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xlm0kHmw7L9D6cork0kMctA4GhiQsZB2MFZVOT3bAY=;
        b=cTwvqI9niieYWfjQad1/aLReTyO5CHmG+kek8/nWd1uyAAKlkNj4/bYsfWXnAriGxh
         bsk0axbEGOwVz0FqFkl+vykB30ik54GgM2YzHKzaBbwPsPVXd+n5HuBNP7fSxPR5pxik
         qVwtBsMJP12mWHls6A1uWaKVHza3DRQ01bn3boHJfWlNowoTE+1NN0JFgIuPVdNWsQDC
         yCkoB4x/RE4agwGlCaXb7qOg7OxWFpsb5B9KGiOl8ej/H0vPG7+kWSPiVN438fc1mrjq
         DAXhDsG2PYK1S16N7MiUNBq+mh2gip8GidS12IXQAAkLPwD1uSXJFH0qRwlSPGhEaztK
         cjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205104; x=1746809904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xlm0kHmw7L9D6cork0kMctA4GhiQsZB2MFZVOT3bAY=;
        b=ZC4yTD85YkLhzpFKdA/+WQP4yq13T41RGNaFxEe3687efN4tAbH+UefYdyewYDyxAr
         NttletJSSyRkuKa4YyB0jHfzx6KGluIgY61qcJp6MNFCNELsxcqlXFbiGlfEJM3Wkmkl
         cDyj1tU6IMGEzbenlzQUYDXlqgxqf72Yjyw4x6AaQnNIuIxoqVsyPCSszaR5sy0GXPLR
         9j7DTPJ+m2nRb8bA9GFnABhTz34pKU60Q7EK3+jKSiR7mfKYovd7yGUK214KiArGieEg
         /dwoD9YmG5uRL2GLnNfyWncPkqT+tYyqWeeJIDrddvybGj7oZSC9tk21kNSI6R2epFPG
         Z7yw==
X-Gm-Message-State: AOJu0YzEG40Qh8CCwwafERpXwi99fVJkR9gyX9bVgWE+zgayfH0P7GWA
	RrDCahNCxgo6v6PvVqxeHq+KXiUUldaaboxxCHbE7xomXMcXkeUaei7yUUld0nU=
X-Gm-Gg: ASbGncuwcuPxWRzYBT4r1tTtY/Yc+cAii3HcrtcM7fjhDNsJWiBci+A1SHTKlIlGAIN
	lKv2IkpbIytA+DffoGeQMSZ89QgZBPdB4RK6YcomddbsMuS6MmMoWA4W/n4QFPTDkfzfNo7JhcP
	c2ba1TIs5Y/Lva0hqJ3uD+cd+LASMPEHcz2K3KtrSN20qUSqRX/fVhgiOJ+mYerEfweHWWR3A6Z
	NaMgtFfHRGY9kJrRvjtuv/bVW5A+j6PGXzwsys54jSMsot2Mbi8u5dxkhmBimjQQAnKFGRn4g8x
	qod6YLYeu2RFLVUoe0GZ/4iUwaNvG3HRozg5kZp4V+DHU26QfiS7l8i0yMTlYdAHE2yDiFTn49C
	BBdc6oSmv5w==
X-Google-Smtp-Source: AGHT+IHFPZofTbMFreZMx8zlW7cjJHCHrz59yiG7wXog0hNqV20+3M7H5gur1nkII7zKBQn+DmgRUg==
X-Received: by 2002:a05:6102:668:b0:4c3:243:331a with SMTP id ada2fe7eead31-4dae8a41a61mr4477593137.6.1746205103967;
        Fri, 02 May 2025 09:58:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780b09bc2fsm335860241.21.2025.05.02.09.58.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:58:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input/device: Fix not sending virtual cable unplug
Date: Fri,  2 May 2025 12:58:21 -0400
Message-ID: <20250502165821.2753353-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using udev HIDP_CTRL_VIRTUAL_CABLE_UNPLUG must be sent directly
since it is not handled internally like when utilizing kernel hidp
module.

Fixes: https://github.com/bluez/bluez/issues/1173
---
 profiles/input/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3642cc3267be..f21a69f57529 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1154,8 +1154,13 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		shutdown(sock, SHUT_WR);
 	}
 
-	if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
+	if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG)) {
 		idev->virtual_cable_unplug = true;
+		if (idev->uhid)
+			hidp_send_ctrl_message(idev, HIDP_TRANS_HID_CONTROL |
+						HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
+						NULL, 0);
+	}
 
 	if (idev->uhid)
 		return uhid_disconnect(idev, false);
-- 
2.49.0


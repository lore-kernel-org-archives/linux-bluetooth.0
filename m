Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B31267B05
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870221; cv=none; b=eHAYpQDSgUzHladtpzefEv60BAL1tc273SRHOrW5pv+9Qsvt8TwqKFJGuOoy7lIf6Jp857VG3XW2kmRY6Yg41kpfk8jD6hRu0KP1Hv4gKmdEKNMaXGkO76hF8JbeRGO4xcvwAqSGFKKHnPKK8gGk7zJn3NhItls+InhkdVW7o7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870221; c=relaxed/simple;
	bh=xOc9JNB9HmciJ/atYuReKrFK6ylV7+ZjU/ajhAqC73c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OyzLxiWYihGc6b9rs9NCeK+lziF+aaQkj0VuHzG7ATXWd4mJSd8dHW4HRdaktQn7Kp2UTgViak1T7LtXU1hiTA0wTD7bDAPytJkzXQH0cBqEjfzOh2RnLfGniHbOFDgESJxZbWkmsjbdvbF1/fKZdIC5EMzPB4TRY5QXVIK3VKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEYOFhZA; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEYOFhZA"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-612d8a59ca0so3588825137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870219; x=1777475019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nZ+ZQql7RvEE3ih1iio2oucETU7ct5yjgzZfWA5fZA=;
        b=dEYOFhZALDuDryBNgnvntMDmRrV25q8vbnQ5fNSY0WAeJo8vdVZz2JwjBVC08g374/
         f5UcN4GiMFpfO0yHW32ptwjNyaZnxC4I+/CArSS+gGHEqwzK5rcQBkGaDZde5CFLQ5F9
         JbgckHDnVrgDSQdm+f7V7cWFMGF7m+j9a95qX6I0RfgiEPPJqyKp1rdMNMgVWwSM8AsN
         b16GZUdiI2df/1u1uTXNQqGgE4dzswkfD35rjrid1/IKdvJEK6u2DV8ff6PW5iDClfHO
         HrLO5td8LWdHrtm8vLthgARBcG3/VXYBtq34ZXgq1tTJtW2rwZ723d1E9q/Dk+CfryKk
         vulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870219; x=1777475019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nZ+ZQql7RvEE3ih1iio2oucETU7ct5yjgzZfWA5fZA=;
        b=HS/Mb1vx8KQIFydDYc0rcjFXIRAt2BgpRlbRHNv/0NL3XjY7fNr12giOISsBpzc25v
         MOysbhsnqStkbjv9kllgnEpcbBcgvw234/44WKdkWFF8bmFapcbfBEHr9vbuktE4JdvC
         dxhv0eOl9FcxYmTKd68v7S+nHlE/Wl5povJSv+UnTVD6SZCDJh89D0vKIGwo/J8/SUfT
         NLN2NuhNTH2DJsSxkUoxLZFTIUYF+RYi8BACMyYSP567vp/n9lWLmUVp2GyTU5mKcKfT
         3HOSFGottswk9Yc74on9MaL3j4O04H7mG2E0E84MLT661l74fTjsWhTKXKUUCcpDyr2m
         wwTg==
X-Gm-Message-State: AOJu0YzaN1j3/PO8Q1kXOpykC8hpdONuZyVrrdoE+llj9G0CSBCvtocF
	F/VU7c1TBQAWI42AgoNNbp3HaABFBFJlFlwsJeLyBUO045gXfQOVr6IuCpbmi2ntJ30=
X-Gm-Gg: AeBDievQriUBpibQslXx6ljdy2vI9QAiib9UBiNNWj032VO6Y+blctpaeQvwocMugkx
	ofjgMP32UwGd9L5f8vHrElQ0GvfwQyZ3SqZGW1VwHqK8rTXjMcIn5sbS5tBSDh1msl9OQ50XReM
	hVzpF92dwgmLgiajfLObH8GVeHXP+x7oQ3KRXQtkacSbGwUc6C7xW//xDJEdgXC8+i29LfCGfuk
	XaZAL8g3VfH1u5cDchwq1arQ2V2q3xWBdzT45SFgl1fllN3aRmUaAzFnnnU6hBS8NtNnVA3K9lC
	TOWqVwrq2gW2jZLvx4Fjc1NtmDxcZbQ8FHylHTKRrKt1QIqFN6YJt7S06XP3CFhYXINhlEaE5ut
	Jtz2suCSXNXHvUtiK9Yb4ysEhbhf5g5cI5BATblOdOtnje9I9a2gZyY8cKPJJ2zOVBij8Ob9GKx
	ABHtHdTOg51yRycr9E/WBTp9j8v2IDpOjJI99yNZQpv1+l+8sF24LcBmD1eFWczXthw7COCFUjt
	ZnC/qQSUizWbniZNDCxWEg3jk1m
X-Received: by 2002:a05:6102:2926:b0:610:76c6:b74a with SMTP id ada2fe7eead31-616f67c64fdmr11877912137.14.1776870217526;
        Wed, 22 Apr 2026 08:03:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-61747cb52c9sm8254260137.9.2026.04.22.08.03.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:03:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input: Fix checking LE bonding on HIDP
Date: Wed, 22 Apr 2026 11:03:28 -0400
Message-ID: <20260422150328.2062359-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HIDP is classic only, LE uses HOG, so there is no point in checking the
bonding with the address type which in case the device supports
dual-mode will map to LE random/public address.

Fixes: https://github.com/bluez/bluez/issues/2034
---
 profiles/input/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6bdc5ee3aaf3..5b1be2b169f3 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -127,8 +127,8 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
 static bool input_device_bonded(struct input_device *idev)
 {
-	return device_is_bonded(idev->device,
-				btd_device_get_bdaddr_type(idev->device));
+	/* HIDP is classic only; so consider it bonded if BDADDR_BREDR is */
+	return device_is_bonded(idev->device, BDADDR_BREDR);
 }
 
 static void input_device_free(struct input_device *idev)
@@ -172,8 +172,8 @@ static void input_device_free(struct input_device *idev)
 
 static void virtual_cable_unplug(struct input_device *idev)
 {
-	device_remove_bonding(idev->device,
-				btd_device_get_bdaddr_type(idev->device));
+	/* HIDP is classic only; so only remove BDADDR_BREDR bonding */
+	device_remove_bonding(idev->device, BDADDR_BREDR);
 
 	idev->virtual_cable_unplug = false;
 }
-- 
2.53.0


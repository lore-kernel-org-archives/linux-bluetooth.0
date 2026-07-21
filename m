Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AF384223
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643448; cv=none; b=qrTs9yAJjlxB2JZ6ljs55G1Eou9KLVJQqPLUx31RGrgdNnI9TQGOowx1qk+r8GsxcD9V7mRVIivhMsqAJzt4RtRlPN6B7ATEQ6IYEqsFwsTQLFfzPARgyL6jLxXHDA9x0a92nS9lf7h64rKYeF/Xhcw7wG0DAO1hB42Nz4sHckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643448; c=relaxed/simple;
	bh=Y7mtcsZRD14JvWnXKHuuB7KbAY+XbTZSPOn2+28lq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NoTuMszMmWMobROWr/V1HMqIYjSVxgleZdgJwLFv7CxCCxhR1MzVKbSkbIBJGBziEQLt86mrlZ2mFA/BL/1zobg7m/rlwy4VKoUI72GJOpEvssgsJVsl/6EKVu8T+aRif5IvokuF71CsVBKSuUv3d2mUTFrrI8Q9e5jx5aNorq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvPe9OQL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvPe9OQL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f707e5d75so1714655f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784643445; x=1785248245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJSa+Sb3PDfqrXfBdEr2r8ZM79XlUMQ8qyVaVgPxVRE=;
        b=FvPe9OQL0w1Vcdovh2fHxl+eQtBNsEz5lUxQxDfvzfrrdY8KSXV31pytrPOZsND0sk
         GHsfVrU6FfQev1RVepLY20UGhkUuQn58wVa0CLxj+8TS7Ac2yOOxdkM7avjgSxjbWiK0
         al+6rwEk4oj9mBk9Z67DDrgmH2hQuB3lhalCXi7ktQqSMBWEb/amKP+lInlHvMT9W8L4
         K0yRTDzw6CG3wbdKgioHftSt/11uibI7F9uHMdCcXbz6ZuhwgtqT5VRxaCbFWYaEmqYt
         uMqs/f/NMnAEeN/yV47yF83TqeGB10NeyvEnak1re1AMOtA+E6kI8VlA3tpiDMu5GFC3
         CCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643445; x=1785248245;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IJSa+Sb3PDfqrXfBdEr2r8ZM79XlUMQ8qyVaVgPxVRE=;
        b=aqbhrdic67Cgf7k2WvalgrHNAlPCPuiNbSY8FIw2yCcKCxtGwFj3i67aDsJ/Ii03Yv
         DByMdiIyg/MQsWs/OgVZZSLr10CVQAFDuSRlIhC2MlC15HQKbmkzIImysq/QeKAFUwK6
         SDoe/ZOnEQCshpmonavhWwMcvR0YSYl3wKAKuHPA8ID5Ks7TDSfo/RvphFCHRUVzI7Zm
         5P+6TwIvg/pa1dMna/Q7uXr4xlaJsweYtSI7/l662Ty29b/ycIGCR/ZlbDcw0Er/uTos
         cah9djzuGSUdYeC4OuhgVVUZTh8C5RnWDPfIORE3RoBOVigVuGiZecMBMtVShdj/bQB3
         x4dw==
X-Gm-Message-State: AOJu0YzXjhGQbIbNZ+MhLjJKVrE9n9Iqaln4e37tHiPZIyIn4AULiHTi
	Cf9g4m8Zd6m0mZ1RmdoLRfbUY9OjC7B7K5Lxm4zY2E3mWDo7WhQKsnTKMWrU6KaKtpmwgQ==
X-Gm-Gg: AR+sD10enlKFpO3HW9E3GyGJb37S3Y+O3QuQa4bv57P8OC5gtXqTeqtrTajb23iovKi
	S5PhLJqC73+YD1jciOLkuCnOD+cPCik+koaRiJQajbaGpPurmrgezUGS4yQmrthaGsXabVeY/9p
	ugObneBegfM8TM1qJVpaIjHe165oCekrlEzxkvBgX/Gjfi64baQOWzMlZtafzW36hSvren77U7v
	zrATx8hYFYFrL1SAU7yCIHb8sEXrPIx6JSKaYFkVMDWkPmvlSWcucdxASPGJHw/7JB4hrfWLReL
	wPLdAbxD8UDRnTXX7brvj5klV/KKfczyg2tD52pGg5yNxvE1eXpXJag+p5wFBGWe/1DTDFb1Gg4
	LgM2y+a3M4wGV8PIC5Cqf9+rZpbZy/MokgDUiCHfQYp4/OjQNoMxliUd+a+iyp7AWJDIsJZygpI
	6r24TbNDBKNVfRWPY=
X-Received: by 2002:adf:e190:0:b0:473:d65d:49c1 with SMTP id ffacd0b85a97d-47f6232c53bmr22584373f8f.32.1784643444936;
        Tue, 21 Jul 2026 07:17:24 -0700 (PDT)
Received: from pakrohk.localdoman ([89.34.36.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm37898270f8f.6.2026.07.21.07.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:17:24 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Pakrohk <Pakrohk@users.noreply.github.com>
Subject: [PATCH BlueZ v2 0/3] Add HID gamepad quirk fallback for broken SDP records
Date: Tue, 21 Jul 2026 17:47:15 +0330
Message-ID: <cover.1753084800.git.Pakrohk@users.noreply.github.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pakrohk <Pakrohk@users.noreply.github.com>

This patch series adds a modular quirk system that provides HID report
descriptor fallbacks for third-party Bluetooth gamepads with incomplete
or malformed SDP records.

Problem:
Third-party Bluetooth HID gamepads (notably TG170W / DualShock 4 v2
clones, VID:PID 054c:09cc) expose incomplete HID SDP records. BlueZ's
extract_hid_record() fails with -ENOENT, preventing HIDP registration.
The Bluetooth link is active but no /dev/input/event* device is created.
Windows and Android handle this gracefully by falling back to known HID
descriptors. BlueZ does not.

Solution:
A two-tier quirk system that activates only when SDP parsing fails for a
specifically matched device. Does not globally weaken HID parsing.

  hidp_add_connection()
    -> extract_hid_record()           // normal SDP path
      -> FAILS (-ENOENT)
    -> gamepad_quirk_apply()          // check built-in + external quirks
      -> inject fallback HID descriptor
    -> continue HIDP setup normally

Patch [1] adds HMAC-SHA256 to the internal bt_crypto library using the
kernel AF_ALG interface, following the existing cmac(aes) pattern. This
replaces the previous openssl CLI dependency.

Patch [2] adds the core quirk system: built-in quirk for TG170W/DS4 v2,
external quirk profile loader with HMAC signature verification, and the
device.c integration point.

Patch [3] adds bluez-quirkctl, a CLI tool for managing external quirk
profiles (validate, install, list, remove).

External quirk profiles are JSON files installed to
/var/lib/bluez/quirks/ with HMAC-SHA256 signatures, loaded at bluetoothd
startup. This enables community-maintained gamepad support without BlueZ
source modifications.

Testing:
  - TG170W / DualShock 4 v2 (054c:09cc): buttons, sticks, touchpad
    verified via evtest
  - Kernel creates three input devices: Wireless Controller,
    Wireless Controller Motion Sensors, Wireless Controller Touchpad
  - External profile validation, installation, loading tested end-to-end
  - Tampered profiles rejected by signature verification

---
Patch 1: src: add HMAC-SHA256 to bt_crypto using kernel AF_ALG
Patch 2: input: add HID gamepad quirk fallback for broken SDP records
Patch 3: tools: add bluez-quirkctl for managing quirk profiles

-- 
2.49.0



Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9623C8AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710980; cv=none; b=j31ZtSjfT+A0z5cRyNG7zQqSn30TQxwfaITvbMNhy7LOqImMCdnwgGy1BD1MVvuW0y8ljz1+6eAcGJtFho7qDDTMZL+5ibLfyPx3URobvvq2wvEuepba11V5Jw5T3/b/Vtw+gyf+38iyMgULbdG4+Uo3MiwVhChZ7Qi6fRzdxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710980; c=relaxed/simple;
	bh=G2ietXSfNwWVcU0cuNL3LCv0JCuc3K9dheh/OkMhsdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBye5NPFfYD6dg+bgBx+qaAMluGzAFJBsbJF60ZPF4ax6Ze3dqvbCt95miGdRDhGCthu2OQ3Ogcl5aNTpglyK+riCqSe3MoECri8Ye8gUxYiU9qKezTgAzOGBfPtZDqlkskld6qRL9YKv+HkqKWcKg6ZVOz6E6jjeTxWZpcymcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf4GBMUJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf4GBMUJ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so2672343e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784710977; x=1785315777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRjIYe4N5qS7KSD23zLqXoVALBbgvhcQ54RY0q8JAGk=;
        b=Nf4GBMUJoZhPDsy2u3WGq6EFbaa+hHLWHbm6lRC3Yj+XWrgY+TMK8NDNqgkcqGAk43
         oXWCjqabKzr9m7t/oAupYVYfCok4qA9E513vNSzCb2VLDPZ96NYCOHYUeaD+P6p/jvE8
         V9bGKRgzc9IlceLHHDoBK7hCyiBvqiL2P/40ClEu6JBzprTJ4Ddc+aEPBxIzVLHZBu+B
         90XWryZMkhBt0mbah8T3DOg0QSv2VQElp1rGvYdsRBdwXC7lgmeZ63KdSH4rW15FBWSe
         fzF43GGP7HmRNcZrmC+kiu2uY8wO4Z8oMGcjaSJQcApGEmhYTro9K3p6KTwHa8TcQ2Iz
         AMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710977; x=1785315777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRjIYe4N5qS7KSD23zLqXoVALBbgvhcQ54RY0q8JAGk=;
        b=i6yT78jPvpu/tGAMCobxClPXytB7Ph30UIjLdIqEzR01m94k6nj67o7QxxNV9npl2q
         unhIba4BhNFFlECQOYKAjVjVy23isG1fVnpafxnYOL2aHKN6OWAA83hox8A973miQrPo
         OSrvYGbbuPKI91S3vOux8EssWoyPqFUggtnt41mjCCYk8GAsttKhMJkY7rHKhEFRQXgJ
         hIsADpyY4gsTW+AISf6uuyNmdNjHNQRPCq/KnGV3dU5/KPmmiiOO8HqI3OMZezpAP2k2
         fC08IoqtnlzvMz7RhLpm0CddPgeu3uH8Tb8NikbnfPl2Pp0kTS2Cptt5zEEt/wT6R8Yq
         XR5A==
X-Gm-Message-State: AOJu0Yzb3Ry7sstO4qbEQhQTOhZMLwQP39vhOkXR4C0NPWLOotJPqBSb
	Z7YUQRGKRscT067uGdLfaBChEctgiZ+fjIl89XcSD0PK25O4V6CFP6RwJM5ORe98JlwCY5tn
X-Gm-Gg: AR+sD11V8J/cG5XXCt2W/8tEkmMNUiIvMTD5IhVvJakq4sc/lpWRbJlS+D5HNCw11YV
	GIWvRaQvi8ZZLKC1KQTS4sia+ggv4AG4lJf7AVtSw5rz6SgyJyGo85TVZ82ykDIAXYwJugCGhJL
	86hihW1aBmNcY6BMxXCA2qRgbUUKMe5sYQRayRx1NN8GSJprCvR9PNwx1PCM4eR0sEBlEDZxVe7
	oS8vHeTenTyL4fyJ9a4elngsJZkzqQw68Naf5AmVydPvhc2gFqM1ZdIX5wsoszgIAJ7/jvV7om3
	1MTxMouQMjW/7NHt6V0i/NuU3F7jVg4WTOBkvluLc+2AQLH5Kr7SMWDKK13aYfo71GnfSftlCou
	+eTos6x/cXFV4Wy68w//RBDBUphVPrEt/bKPploBCKy8S1fhZmqtBabPdM+gtbi8wEPsafqm2R1
	VT/S4xNpBVXSw=
X-Received: by 2002:a05:6512:3583:b0:5b0:1be6:25b3 with SMTP id 2adb3069b0e04-5b28f9acb4cmr3305675e87.31.1784710976546;
        Wed, 22 Jul 2026 02:02:56 -0700 (PDT)
Received: from pakrohk.localdoman ([2a02:4540:10c:b64f:36e1:ca9b:678e:f489])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9bad8b5sm366899e87.33.2026.07.22.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:02:55 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pakrohk <rhpcir@gmail.com>
Subject: [PATCH BlueZ 0/1] input: HID gamepad quirk system for broken SDP records
Date: Wed, 22 Jul 2026 12:22:36 +0330
Message-ID: <20260722090246.212017-1-rhpcir@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Bluetooth gamepads (like DualShock 4 v2) have incomplete or malformed
HID SDP records, causing BlueZ to fail with -ENOENT. Windows and Android
handle this gracefully; Linux does not.

This patch adds a minimal quirk system that only activates for specifically
matched devices. When extract_hid_record() fails, the dispatcher tries
built-in quirks before giving up. The quirk injects the correct BT HID
report descriptor so the kernel's hid-playstation driver can create an
input device.

The patch includes one quirk (TG170W / DualShock 4 v2) as an example.
The system is modular -- new quirks can be added as separate files in
quirks/.

I previously included an external quirk profile system (JSON + HMAC
signatures) and a crypto extension to bt_crypto. Based on your feedback,
I've stripped those out. The core quirk system works without them.

Questions:
1. Is this approach acceptable for upstream?
2. For external quirk profiles (user-installable via JSON), what crypto
   approach does BlueZ prefer? The existing bt_crypto uses AF_ALG which
   is being deprecated. Should I wait for an upstream decision, use a
   different library, or skip signatures entirely?

Pakrohk (1):
  input: add HID gamepad quirk system for broken SDP records

 profiles/input/quirk.c         |  77 +++++++++++
 profiles/input/quirk.h         |  37 ++++++
 profiles/input/quirks/tg170w.c | 232 +++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 profiles/input/quirk.c
 create mode 100644 profiles/input/quirk.h
 create mode 100644 profiles/input/quirks/tg170w.c

-- 
2.54.0


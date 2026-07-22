Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C73AB466
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711085; cv=none; b=mgK/PxKbqwbQyYxrhZLbDu43Hhu9CeFnljikEUNXzEUiaCyFi2CYlpRvaEnh2PrI07vY31yeDCRExiS1HMrcT1fePRncSBahfFD4vZtw9Cz/IM98tibN96/ONKCmmvU8ouwiRViyt0b7M68zhD/HdTCb3lxAZnVhwJTBQ49IOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711085; c=relaxed/simple;
	bh=G2ietXSfNwWVcU0cuNL3LCv0JCuc3K9dheh/OkMhsdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkZZ6jxIF69yfWcm/vbpQsZdAu/LHAz/v3kwPFbAYjgGsqT/toikNxATe5T2j2AXyqgRj6+kco4TwkLg5RV6TPmaqZOT8Ml5ip6jqWs2hDb13rwNLFBM5WZGk4SK5UpOrCOgqGfIL/uwZgm2d6GH59mXEpT/FaskWJpVcAlxmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3pjJUH7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3pjJUH7"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39f00ce92d5so287301fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784711079; x=1785315879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRjIYe4N5qS7KSD23zLqXoVALBbgvhcQ54RY0q8JAGk=;
        b=Y3pjJUH7R9uJp3qJA75iP+un4Tc+m67MeP3LedLaTTZ+S96naS6lqE27Z3tQKofxaA
         ClIYS3+Il+p3C86OxUPJ90AdAjvhdoc5UKEY/KLpCh/obH9G9krR9tzidyaPVoc2x5MR
         qkGEvjdInNW9dQk+K6pmsISLNQXiCci++lSWIRszmoraPWB0h00mDu4FxlCxUaybsH3Z
         g1Do4TTHaXL/KvsXJjnlaQCXp891eXDykoSqHOjYQB/supW3EKVtgUXROel1Chn4xgQC
         Ex1Tgepyr5Ti/zCetxBc2kKoDGu6+K9vliIO56/k/if2dn/fAnN1Yg7y5T8WsTt/ufGR
         5KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711079; x=1785315879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRjIYe4N5qS7KSD23zLqXoVALBbgvhcQ54RY0q8JAGk=;
        b=LZ4NPPJgFAWq8J2qWq6HmZXZyRH/9c/kP72WomZFOLII6v4n4vCxvVOBtJPBdtM5sV
         5S7zhpVcLJkUIUWxgHA79xhP1+BcXHOTlq5FWyBZNeBftgeCdMhkr7cibXpMEu4eg1PA
         MBHx6Pc0blcqaLG9NiMJ6nTsv3Zy0Z2UurImodwOQBRgtMTmZ8X4m/9TD4wqDeDaxY0B
         h+kcwIrLCiqRmCPJf1hEGEq9F4U7+GKWG4qMmDg4Ufp0EmafnBz298ZgdAAQ34gbtWU2
         7wn/6NswbSmxHpz+ufZG2QMxQAOCB0aALdw53f4FPARr3rPEtUoZS7igs9hC9mBCkxGa
         SWYg==
X-Gm-Message-State: AOJu0Yx8F16yysDtOMAzc4GkSWRmbZAUmQ5BvVlnUM9PS/5HWbYTtySk
	swrb2DM6hUbx+vop2mqNYDtl/vUJKF7p4aGqaTuiIGzuQz4LpyZKWcLE1kue/GtuMZWqMxfc
X-Gm-Gg: AR+sD11rq1E+OK5p3Riwe9TOYxYTDQoKaNSrLYWiCcT9NNPC1ZCIPvJ3R2a/6fWUZH0
	D4GnUptgTHgjxNyA2JTgcTx7eS1/CnkoDm/xfAIQuBGS8VOjlaOms2HrbusvacMFk077Tr+I7x7
	3sSscfkOJNOkWEULgV/lQcTegXQHZbpO2lA4dCQsuEl2eyAf9Mdn7Trsfec1Csd6+FquE4eTkFu
	CLoyxD4QyGxfE5x5rXJZIoBhf1SdkgnuJkARw18+Pd+LrkVCoozlsMR27pk3s0hVamUB/rlU6KQ
	9cnfDy/IGDmNCVvFKXWeuDDDeUlD2RYNcCLh0tVFFcJQC1cdeTNZquREUjs1JHtOMt+hWkhWeck
	7qRLPVgS0xm4TQsVPv7rJOfFUKWTh3pzgiRoCZjuCLOcsKQFcHPovbXlrImDewIvjGF9/rOQl/f
	GhJ97bGIlsqgA=
X-Received: by 2002:a05:651c:2545:20b0:39d:b075:8789 with SMTP id 38308e7fff4ca-39eb27f2735mr30198851fa.15.1784711079317;
        Wed, 22 Jul 2026 02:04:39 -0700 (PDT)
Received: from pakrohk.localdoman ([2a02:4540:10c:b64f:36e1:ca9b:678e:f489])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef68883dbsm3579831fa.2.2026.07.22.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:04:37 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pakrohk <rhpcir@gmail.com>
Subject: [PATCH BlueZ 0/1] input: HID gamepad quirk system for broken SDP records
Date: Wed, 22 Jul 2026 12:33:30 +0330
Message-ID: <20260722090431.213889-1-rhpcir@gmail.com>
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


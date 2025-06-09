Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553F18A92D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466043; cv=none; b=dJP+dDJJr6lJK56f8fAoBsnZwjM7T8IriqzINkLRDRB/Lg5esGF+OcWY5NAIqcCfBrM57RNs8aKBjnS5PAmNHK8fSxIZHlnGJ3Avgy++yttutJC7XiRVfanynKiSckgyZYtm18VymZUdKC0JKhm/HNKWF+E/XswMAiNqla/3/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466043; c=relaxed/simple;
	bh=ZNqZDB8PhnWfLenYbqh8+jFrJFFD28VeBnxzFEpGMko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jp5F9GwTcaFh6R8Fg38Rp0taN6QZd1CVPVMs/WYur+7bskTv1IGBlJTTx5IZmzfUu4rg6pr+LWZvYnsHDhOEkBe4Q3obLRhjKxQJ5ImYYmiqo7xML28nLh8fnCwOhn7z4T/b21nous+wYVqjLn3zWdJwkSa7zczO+jKEbPgiaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=nSYEb26K; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="nSYEb26K"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so5029029a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1749466039; x=1750070839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upmBEwdtcqPxcnjPeRa4tmlvGKl7z5bvzOi2QsUZmoA=;
        b=nSYEb26K771JbAGKolvkKiUOjFzaVIsQutHOMIeoZwjAQiuuWBwqLucgCJl7I/gCpR
         oTwSWiSYht6tWcrXV0ZOwSpwXkOxB4tQHLq5nqHxZe5uTVXJqnQIAzIHJQoMkDXjs331
         r+7sosIe+881hvR0WSEGxZTOWXNFlq8UvK2CM6LY0DkGcteGme0IADushGE6OJNxTY5h
         GuxzONFVk35wV5Lu9IbVhBjNWpgcEI3x+9r1MkvjuIA5CiRtq6ixqF9y4qtS8N9e89fT
         RdxcnFD9mZlTjWK6VXfDWTvXWN3B2GVSpZ1E3fYFbqdFiZIDI1FpgL59qmprHDN14kqE
         NILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466039; x=1750070839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upmBEwdtcqPxcnjPeRa4tmlvGKl7z5bvzOi2QsUZmoA=;
        b=SHIUDlOruQx/lvqxGsmVMjgssyc85g9D93vfoylRpRmSNPFNePNtTo0U4lefvjTftk
         7WEczwlAJ8KBo3yIzuakDi0J9WXtT8nEZgJbkGJWGzbf2ejd4tey8qJI1kTCZ3wAWbtR
         gWQt8gmVujR8cc1kBUwCHLVoCzI5C8OQuQinYLh3Ul7Wg7bluqOQwadP+FdjMupONHyB
         frWff0wnU8Q1Qsgu5Q3J+k1bZuZq0Ys5kM6DO9MTZJ3yzHMI8d3T5dYBu4uBg0p4Xsre
         VZxMn7ZAxN9NmAoLxHwrq+3yCVBVCUZd74y3uwLfyLnEbvPM39XLIXthJOuj3acmjOOm
         HeFw==
X-Gm-Message-State: AOJu0YxARgfAnAAsJ77JN21BEx+cg9QT7G56zUSyesoF+dd8+8m2iOIL
	zwvaJWBo3uz6lTQFqmbVZm0z7MNd523Jxkz6gFWO4CWHKExFeKtj4pwI/AH32/MDi1J0YKdOLGZ
	SfLfnDK4=
X-Gm-Gg: ASbGnctSY1z5aye5N5T+M9Vyct2Qv8+xDHL+PU7giXhb3ckkCQZgYrQe1R+d4hoCGF8
	4h3Z7L9O91jfoyyCMJ8/eZHwv6jcN/GGhuygUFfYbLVR2OhuI4dMqwfSHf+DIu7TjJAqgHTkIle
	5l/SieBq3y+6HYfMAOSZxiQzxpfF39ihgLIK9rU/exJUfZP+tkAR3jHB99ocnkniKlXWTr3Wk+3
	S16axaxBE9mbBweQ45/1nFoX83bn3AnSssxzz9b77+IemF8UcL/jXivhiUNUYtE7MbL61mgYUYL
	XsZPbggxi3by10EhMpD2YLArsudsCJSchPuE+YrnlDrClAR0oLscSkjV1v6F0CJmEkexFk3uq3R
	10bT2MK0H
X-Google-Smtp-Source: AGHT+IFGpeF5V5fWYelmhOWZNAV83h2MYtHkOioNKeIv2RWs6Epz/oc27d9NOMTuco99G0Z26PLM2g==
X-Received: by 2002:a05:6402:40c5:b0:602:a0:1f2c with SMTP id 4fb4d7f45d1cf-60772b7027dmr11491171a12.9.1749466039021;
        Mon, 09 Jun 2025 03:47:19 -0700 (PDT)
Received: from ThinkPad-Ryzen7.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783dd3c5sm4472823a12.57.2025.06.09.03.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:47:18 -0700 (PDT)
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Subject: [PATCH BlueZ v3 0/1] monitor: Add support for decoding Channel Sounding
Date: Mon,  9 Jun 2025 12:47:15 +0200
Message-Id: <20250609104716.1814089-1-magdalena.kasenberg@codecoup.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch adds initial support for decoding commands and events of
Channel Sounding, a new feature introduced in Bluetooth Core
Specification Version 6.0 | Vol 1, Part A, Section 9 "Channel
Sounding Using Bluetooth Low Energy".

Testing:

To test the feature you need a hardware that supports Channel Sounding.
Channel Sounding can be tested using Nordic Semiconductor's sample
applications for the Initiator and Reflector roles, which are available
as part of the nRF Connect SDK and require an nRF54L15 development kit.

Initiator sample:
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_initiator/README.html

Reflector sample:
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_reflector/README.html

On Android, testing is also possible using the ChannelSoundingTestApp
available in beta builds on Pixel 9 devices:
https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Bluetooth/android/ChannelSoundingTestApp/

Additionally, Channel Sounding support is being developed for Apache
MyNewt NimBLE and tested using the nRF54L15.
https://github.com/apache/mynewt-nimble

Changes in v2:
- Updated commit message with instructions on how to test this feature
- Fixed parsing of Mode 2 result fields
- Applied a suggestion provided by GitHub Copilot
- Added parsing support for additional bitmap parameters

Changes in v3:
- Updated commit message with an example btmon output showing decoded
Channel Sounding results

Best regards,
Magda

Magdalena Kasenberg (1):
  monitor: Add support for decoding Channel Sounding

 monitor/bt.h     |  321 +++++++++++++
 monitor/packet.c | 1200 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1521 insertions(+)

-- 
2.34.1


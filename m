Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E76442C
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139236; cv=none; b=rpdb1dAN4AxqgLgfYdcCAqn1Ojv64R/Oqxxng2EJJNlIZBcUYLA97wPSDQw/I1LSlB2dAlq6phL0VOSKiMDsM2G6CnVzp/ZnsRPKKW7aFCmB0k/D0W323az290sxOqJEzA2NUkbIc5VUa9lZjQjUXXaf9e4rWIbsluLu1A/higE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139236; c=relaxed/simple;
	bh=NOg7wsddRmLLRsICd2Lrj1qhvzgmQOHrRlfHUyzQVsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7Edlgqqa5137N4fO19brBhH0HX8Iy596cTfwbekvmyN0b02o9UFE+mqHLHuNTNj7QX12kNsgqHe5cQl2f6PynXsQGgHugTdcy8X62ke/FQV+ILZKmr89MHffiE7AO3OPglHbAcM4Eij3oV7vDRr9qCl9bXP8tsFADj4WbsghDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=WiHTWdQC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="WiHTWdQC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad89ee255easo201552066b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1749139232; x=1749744032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cquwdv0Jqr6sYMS+rQDTEnIj08C8GZptYkVygHzkLk=;
        b=WiHTWdQCovQiAURqnKCsoJk9z7xr/ve6L3mjIazqJpJERk2Gbu9uWGKM0BD6jPgmK7
         AayEi/zTKigbFCvl+lBjkZZWTc9ZkRCngPgUXuDQCqaZKjCkPBpW05n9WbYAzBNf4rAD
         aD7uurNxN2Bv7WKYbxfLGw1MROA53JU5FpoLfxlVhlxkS3QDu/MaarpOUgNWvYR88hey
         g0yOSWLhXPbeEwsUqEpRU85QC7tbtJOoTAyxrrRVxS2RMKH7ilvRTFxhBTg6pUMbJpE/
         M1qmCD9o/z+YpnPugz00P+bTT0scobGYn6R1umRiTvP6gyJdV9OSIR78ho/Sb2EomKCj
         8vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139232; x=1749744032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cquwdv0Jqr6sYMS+rQDTEnIj08C8GZptYkVygHzkLk=;
        b=OSlXOkg6LMta+1AZ5+SsfR+EnfgJe9UvJBqotke5cLksI4YHU7Vz1dfCf1618E0Qcu
         NWBHcG641HSt1gZli6RgBYcvBZ9yiN/isUEADueEl+2Vj2b5hTp/vn10QDhyfwnsKjit
         Cnzu9eDqUPNGEW/dlkLQqVn9Lgz2AurAHjXTGGV54+mF6RrE2BzeQkF2lAI4em7rQAPg
         OYpVkwS68l8zaszIXmICSxeOO4PwzljXnAmfNARhyyBRqeTkpVhfBCkYDVMJOYlZspGA
         81PU8UY4YXv96OqMZdbQVuHmDzVmW32UJdC40qWyM7M+wR8VxVx1hPKJzfs8uI8pf5+2
         RILg==
X-Gm-Message-State: AOJu0YzhqP8OJwLZzQihkstTju9EdAw16+ZlsJlgvyUdiH6SvVZUCEdx
	VHAHbAwU7RyYcfGnYJJ6CzgkNjTLWR6vqZKOEcpe09AWg68tsMMRoFUh+FRsptQXSB/9hwsoKNp
	cI37Hz5s=
X-Gm-Gg: ASbGncsSKPoJ6Jy/YJmvqRmzSImwoUxk7+wNwDpilhhx6MhI9mo+eS72zbTxCgVp1oO
	NaM5LAsqqdj5FmJkTl5uzi27fbKTO9ttKBWZVjK9NvB2AhVpBmorfq73xC4TNSGh1smUsFiQruV
	VaisTCOLGPer0OiSFQpcp5ZoLyu4fDHdUwPDV36e/B0kIkkHo9b3CCr1MOamcbZCq21F5Aa0ZdN
	NWJB3OMjDrIxsF9Njj5D31rAkjKcLQUeRg+3MxJjr5RTU30JS+LcijUPvF6lKN1UbggSTpHLTBp
	R4G0iPZ2Z61T0dXXaTgKCCR0KOIIx+jKZwgo8N6EJL5MLSWLF7m1e5R1qySNOBoCBksMiTVu4tj
	k5wvm1c2A
X-Google-Smtp-Source: AGHT+IEmIv5KKA4Ry6eolLW8eP5vauWwdJamuJcOV16aomcAjryBnNIG9GDNWRL/EyVnTYYr56CuPw==
X-Received: by 2002:a17:907:d1b:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-addf8fb2d1dmr664108666b.53.1749139232203;
        Thu, 05 Jun 2025 09:00:32 -0700 (PDT)
Received: from ThinkPad-Ryzen7.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb318db274sm1116034466b.162.2025.06.05.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:00:31 -0700 (PDT)
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Subject: [PATCH BlueZ v2 0/1] monitor: Add support for decoding Channel Sounding
Date: Thu,  5 Jun 2025 18:00:01 +0200
Message-Id: <20250605160002.1652091-1-magdalena.kasenberg@codecoup.pl>
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

Best regards,
Magda

Magdalena Kasenberg (1):
  monitor: Add support for decoding Channel Sounding

 monitor/bt.h     |  321 +++++++++++++
 monitor/packet.c | 1200 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1521 insertions(+)

-- 
2.34.1


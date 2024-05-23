Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686E13D53F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460180; cv=none; b=rPpU9x4DwpaO5t1NbfP+am1J+RDRxL2O0dPPIDuq8HmmnUVnc7d9Mj78kKAaggOJrhaCSzH39gy09TRpYxEVWB4NQwGBHNgszuwL5jtYDXeKiCzrTbRY/+rgIf6lxCH97ZCeZkBi7OQS5JBJccBeEs25tch26K/vseR1tIfQWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460180; c=relaxed/simple;
	bh=iLWPpyxQuPztOV1Z+9KtAWWTY9dB8zIxRFpeTj9k5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YApQTzhO8oRCCgxlJbJ/Z/9B4+0dXmx+axBVf/h+mjZxXEXr7Ze6nneRldKIyd2B5Rk+sTy4fI7RLntA0ct8CoQQeIhPfXX4BS1DiDYoMt4QWDE9Yu8CK4sN/b3M6VL9g4eto0BjgengQStU1mdayXAqqYIkYLy08AlPV3VFKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=FTpddFmj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="FTpddFmj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so997725866b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460176; x=1717064976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSQrTLcsvbXnGxzSAg0UCOImPQiFASqfgWH5lchEZU=;
        b=FTpddFmjJNri4pqBVYe+7a1K0tRFAtNuXesWxMTYQPbc+sD/SXfVnSoKdzz6CNtslP
         21nlWGHPZVNRtZ7kQBOw9BztHzSU/MQmUJZ5LaJB6wUwNOQAQ9qClcYcQHytxsRGcjMy
         6IJTFsfAAIwO+3wrVyh96oaufVtskcrbknFoPatux/YODSH1Sb2RSk2m9lu92do2jpPt
         XdeWAGn3MPaM/iDVILdAtA53kINN1ccJM5k/y6eMhUsynW9aewqSStMEAx9/LXt1vr8/
         okvnqEmgyvYQ0RW7FjHe+DlWB6BZgarPHhh3/VHjAMB3Bub04SqovyMMFMOzUrX8aFRI
         VZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460176; x=1717064976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSQrTLcsvbXnGxzSAg0UCOImPQiFASqfgWH5lchEZU=;
        b=MKYCG6S1w1KCgB7eNjo4M7E3RLmkVkAoAhZlOQ/vz+17sPGi3mEYb4ZeZjiVOy4V7p
         Nplp9ENm7gUb9NbbnBMkIhB3MQWn2kfYPOHGXDTJwVMSmZmIrf5C66xdHdaauVsqFJT0
         PfbhVAmh9aqN3/H+ITtEMcu5pu/MI5uc2d740DN2ydT+WONOjFmnZ28jXYPcC6YptpbW
         L8LRpU6eviY7liT3AhBOjlxe+fmfhKpXYxJ+naGnr2Rsd9Mpb/T/4lkmwOdXvDXEPsSi
         BBOkFv/kQdpaa1746633sGFCIdXJRYOQVXlTO6DxNTjYlIYYQrtIUkE0XT/wA2T7naU+
         ASxg==
X-Gm-Message-State: AOJu0YyySqwaZPnFHwz1hDkw84ccj8FxcEQIKG0jtOXgwXw74e3GN9zA
	wjau3fAXstK9imlGNxUVLFCBLIEnXFqvJ/OV/+6U66VhmS8KfGM2Vxg6Y8uR1/VV1716gNv6xFE
	E
X-Google-Smtp-Source: AGHT+IFTNAKxifm0BeLdLpWVvs9Ju4oodvephnAuaNF7XKNi/laJGfBGwlpdEOmbbLANag/eXf22RQ==
X-Received: by 2002:a17:906:b202:b0:a59:c23d:85d2 with SMTP id a640c23a62f3a-a622814319bmr265991166b.55.1716460175703;
        Thu, 23 May 2024 03:29:35 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:35 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 0/6] ASHA plugin
Date: Thu, 23 May 2024 06:29:23 -0400
Message-ID: <20240523102929.37761-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again,
This is v7 of the ASHA plugin patchset:

  * src/shared code does not depend on any device/adapter bits, as
    requested. The fd connection code is still in there, but it's
    factored out into a separate step, so the caller can mock the fd
    setup if needed.
  * We've had testing by folks with various devices, which is great!
    Some minor bug fixes and additional logging as a result
  * The plugin now claims the GATT service, to avoid contention
  * Added an additional patch to use the new connection parameters API,
    avoids the need to change main.conf to make things work (has a
    kernel dependency[1])

[1] https://github.com/bluez/bluetooth-next/commit/831be422f3bbe9a766e110ec018e7fb29af060c6

Cheers,
Arun

Arun Raghavan (6):
  src/shared: Add initial implementation for an ASHA profile
  profiles/audio: Add an ASHA plugin
  test: Add a script to test ASHA
  gitignore: Add compile_commands.json
  gitignore: Add __pycache__
  profiles/asha: Use new btd connection parameters API

 .gitignore                 |   3 +
 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 347 ++++++++++++++++++++++++++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 204 ++++++++++++++-
 src/shared/asha.c          | 497 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h          |  75 ++++++
 test/simple-asha           | 166 +++++++++++++
 12 files changed, 1336 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.1


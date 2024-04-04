Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDF1391
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255461; cv=none; b=Kv+ud/t/yMHqdmJLlMPfl7Umdm14+IRZV73SRVTi/OUXf/9bC4Pug8QTh6Du5fGrA7bRypngaawQqWOtQwFjQi+NixtujYrp7eGn6CHRkb4sIIZUjeZ1Gc4vhzPCcP9osvMYtNrBiVToJJKUgsVdnKkqKOKuFk8t4Q89IwBh3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255461; c=relaxed/simple;
	bh=mHMFXYXsj4+975zwyeZY5l8PcTYXQb0rXKHN4STvjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzu6gocInm9kFiKk2B7KpffFFUBO+pfmhJLRqp4eQJdx1puZ1NVSNJStCKhc8haiA4Zjws0SGxPgULRdAtvvzrJ3weDleqCMOJk2uFmWthL5KnGd2T5Un0jUalWPSp6zfZ1K77t2fCvIrpDr2mo+w2Pzh/dMijOW6dFENbPNz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4DY/DF1; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4DY/DF1"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so1091041b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255459; x=1712860259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEz6tl45TOWGg44l9sA/cT0tP0jrGnrdW/bpq87LMvo=;
        b=M4DY/DF1d2m5XkYya9s63YGTp5LfwYhHmHg6KRB7uatk9oApjdKxAIzWlfks76nc4j
         74mN53pg+ulC3gc2n5+GO5NpbJusPgr9YxlNZlgAFOLpsX0PKOmcUGdVksmKDIX6RzEd
         d7ULhWyoQLLYezsl1qpNN1j5SYeruhrhA7xA4qKUBVBjOXnv/J2iQZn1Pv1ugdY5u4lN
         qmMBpAxTcogwe+/4Ark/zIZF0g1QHDRG5S5Cr6jV+4SeGvWi4QWsHV3wrQWSFjdwxWx3
         jQj7lFS/L6e9ZkYKg+f19O9fAoOs0EypMLJo0hlQeMggogGkzFO5J798huzhbApb/tVZ
         tDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255459; x=1712860259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEz6tl45TOWGg44l9sA/cT0tP0jrGnrdW/bpq87LMvo=;
        b=alKdkYNb7SQw30/QLfr1EyQ3Yha1j5gfjXNkvBMSA6kBSoRG+TgpIfkE1A6b/kFXOA
         BU8svVW06YubM8OggGmHPTtWHMFo/LIWb+B4BT7xJNxTv86486tyD4aUXnPN0vuKqla6
         1jyEWTeTFqqPBBICxV3wyiHauSNh5DClStFgGVcdmdGjow/eJZmm601s/6aYcQuoI3PH
         aJwOF/SSjOx1y6Z/esWvGQcUx3PXjlJF71NCOlr4Q88S0EwmWpMZixEUJSS6Ro+KDd0i
         zLkrQXAfCX6VatDm+BC4FUd/rvMqAKIGmVQ2BRoyvBF9Tvwlb6aeJK0Z0q7ZGgfBbogH
         0T6Q==
X-Gm-Message-State: AOJu0YwZLrXoknTGDz0zmMhmLgY0JIYPQIUBCRAe9kjUEgPysF+whN40
	z4r9C8DykcMYWmTBZ5L5cLbhqSw7eKOJiI6p+zcU4JGuzAaQjHC8wpJvk1on612jSvoe
X-Google-Smtp-Source: AGHT+IGjWdg5yW2shS8sbiiLDTWwZcK/D6TprA4EnlemN45Vy41IkMA4lpMoou4rDkYsv4splZ501Q==
X-Received: by 2002:a05:6a00:3d53:b0:6ec:dede:74dd with SMTP id lp19-20020a056a003d5300b006ecdede74ddmr3924368pfb.29.1712255458761;
        Thu, 04 Apr 2024 11:30:58 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id n12-20020a056a000d4c00b006ea8c030c1esm806239pfv.211.2024.04.04.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:30:58 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 0/1] V3: Fix busy loop when disabling BT
Date: Thu,  4 Apr 2024 11:30:49 -0700
Message-ID: <20240404183050.334414-1-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
References: <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splitting the service state test out of btd_device_is_connected
and using only the bearer-specific test from adapter_remove_connection.

This intends to fix a busy loop that happens when BT is disabled
from userspace with e.g. "rfkill block bluetooth":

1. Connect at least one device.
2. Run rfkill block bluetooth.
3. bluetoothd takes 100% CPU.

Bug reports:
https://github.com/bluez/bluez/issues/785
https://bugzilla.redhat.com/show_bug.cgi?id=2269516

Dimitris (1):
  refactor bearer connected test

 src/adapter.c | 2 +-
 src/device.c  | 7 ++++++-
 src/device.h  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.44.0


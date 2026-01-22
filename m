Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B337AA77
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107049; cv=none; b=If9rgs1WLTMx+Yc0VBGx8CtE/EUJ90nKThGAaqpbow5PCWPPIQRvS6YLfQKdmB4m7+QvqnbTe4wuZhdXo2/t0C42OuQjx3TH299PLIq8OBvA8DOekVD+vuSJVFLozMLuisEOz3VAEx8o+IXWu/gmyMhzkTvV449MIXniTlRPTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107049; c=relaxed/simple;
	bh=wm/RHjuswNCwmBvnkmo+iGq3fd3NCN9KTPdUzB6kpX0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dYJx5R0TqjiZRSUwlu/brOCaFZqAxG8BuYXNm/DB8Xc3y274U65mtBnKlTr8ionV6QsqDx0IEy9kg4L/vQxYHSaO+b9G4iubJMmQkFLQrpiCuS5LI18QQnFo7N4LIYg7TfTf9Y5NLe7/qYVg6xxqxu5VM0cnDYrbY0hMDhu2fDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4N6Wm92; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4N6Wm92"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79405f99b8eso25486477b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107040; x=1769711840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP48DsrAV6yhVQzMKRTRKuibNQZ+iRXBgot6LlmaTJc=;
        b=J4N6Wm92xGj4LVyx/LMwSjUsr0+suXgWk+7+f9x8fPNtg00BSowNOHRmNPWneT4Lba
         4i+7PZEN2B/d+EeXjD0KOs2UisQzfc/JLI3iON5kdtoH0xQ+naYBBJaCmHBS4mtfNJct
         iFJrV22I3M1L/wotlLVsuly/zilqdr2JTGvcVDBbaS0bY58+nsNmKs21xW8fIyQo5Z1Q
         aDKyBWxqUFS1DblcBnUfG5EzLL7rys2sSDigkrPsaX/qVS/MWEQIeGJ1ORrgtAlZwy1z
         yKboudJKAIzlwnE2bbNTWcxBZINVVlS2qO40p5xS0Y7mSzCzZjncUIVOpzTzQOe01jAM
         T1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107040; x=1769711840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP48DsrAV6yhVQzMKRTRKuibNQZ+iRXBgot6LlmaTJc=;
        b=LbwL+zz4p9TEcQeajECbUjhx/21Y1VmSlZHS6HXjJR/vTfrMUfSts6q253g7JilP7w
         yvFbzBF3SuzAnO37qD8li5Exr60nnFxOsuf6ZaVqdw5hcamgh6UHJ4uAAZoxWEQaSOYi
         kuHXRfztu1GqQJRbMO6fxZ9885avzmIRsQRev1Qg1QzjuOi0wpyV3HRp1I/14BryNVG5
         JoklGbqhg9G7mZqrnvKzOHYny9Lp0oSUPbunoo3e8jUAbPQVQ9aP9k7W9aja05pHs+Db
         5qdwwMSaAAf8qM52WeJ/EWSEkIhtQaw7BaRXOYk62dvHfSvUXyxV9HdE1JOZVksSBmDK
         oS/w==
X-Gm-Message-State: AOJu0YxhrGhYvQucGd7UAK1RCduY60IGXrxtxgnIAIGFW+Pa/uO6jBEy
	h9JV1rbH0/9v17M+LEW65cMwiXQD9y1rssSRd7CbXrelYvg7d1gXROXcZ7QOogne
X-Gm-Gg: AZuq6aIeES/im/BAYq3TbbwqfZtAWSjcqxGowQ89W/uNmQkPjq+rZdVTIfJcfRJppbW
	5wgXKatT3HIA6MmJsiV1z1a19pH3YKc6vY2GP26oTv5p0B8pESjDGDnSTQEpeLv2dpaKQb8Zs6F
	C9E/wzCxefM/MFgWmwGZ3y6DqZYuXVIhDDRlFWyTuypjl14hkR0uRaB4kkPhG7bQjOHdIfHRepO
	gGwUYylJAGp4gDb0QuaaxNEh733uqEDZNqkKiB1jucpXgOrBvB0GDj1y0Yr+3kH8Xco7jQKLUoo
	KnobRf3+FRBbkL6SIWaosKlVnr6mnXjY7/09pBugvrCFMolsWSrOgWdDsGk5w2bh+P5mWxzxw1g
	atEETKdFg54X//CFcGcp5Sc06x69ejkUDHEaCeciTXcdO4I1wD3LsWEGExbMQiJR4TdkQkI6DSS
	16v4EBXdrcWZZ41gY9ScUXZqxklJqIem2PB7QVqDQ+3RWqkhXwif2ZNEXCrHrlKw+D6CV6diPgT
	pu/wwYfFFGkjY8b
X-Received: by 2002:a05:690e:1885:b0:649:443d:87d9 with SMTP id 956f58d0204a3-6495138eea9mr3015934d50.40.1769107039914;
        Thu, 22 Jan 2026 10:37:19 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6495cec77cfsm2349d50.11.2026.01.22.10.37.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:37:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-01-22
Date: Thu, 22 Jan 2026 13:37:09 -0500
Message-ID: <20260122183709.2941364-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4a3dba48188208e4f66822800e042686784d29d1:

  Octeontx2-af: Add proper checks for fwdata (2026-01-22 08:09:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-01-22

for you to fetch changes up to 1b9c17fd0a7fdcbe69ec5d6fe8e50bc5ed7f01f2:

  Bluetooth: MGMT: Fix memory leak in set_ssp_complete (2026-01-22 13:26:53 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_uart: fix null-ptr-deref in hci_uart_write_work
 - MGMT: Fix memory leak in set_ssp_complete

----------------------------------------------------------------
Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

 drivers/bluetooth/hci_ldisc.c | 4 ++--
 net/bluetooth/mgmt.c          | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

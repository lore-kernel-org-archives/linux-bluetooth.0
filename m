Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BE401493
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045418; cv=none; b=VSxRK5nGEW2dFljqx4HffsLsxX9LMAZwAtgPJa89/m1UMQH4rUuOWbQYIR/d96giCSTBTnbLAt6GxYIo1DTPY37vUXhpST99VODdGhpPJhCkIzOBuciwvXh2ceQ8f3CsTckMESCwlqij5K2/fjPIeP+Xeu4r+WkKvEpMnRbvEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045418; c=relaxed/simple;
	bh=j7OkbH8E3Ca+WFfz+fsA4C2/zfM2P/gmWmr7Zf7xQbk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HUQE09vWyXAvZ77tTBJllxBRY3/wEZ45z9/Wg6zcBDWpU1+TYeH3W2mKiy+Yoo1+kYML2tQqJJ6u9hye/KZR3F6H9rP1/N+GZIjLsI6uRyNON5q1LJGOuMvBY858LkniFNujjPByEjeHOGgQNMZg+9jNP5DTmaLv49Hx9b+Koho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=elQgrl3l; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="elQgrl3l"
Received: from github.com (hubbernetes-node-4f38bd2.va3-iad.github.net [10.48.179.51])
	by smtp.github.com (Postfix) with ESMTPA id 749C0E0A39
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775045415;
	bh=Tv5LeR83vy87iEbRIfb/wmZ3F0rF6QcISIZhhMvpOVc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=elQgrl3lDh9zWqMDrZwv7eB27xIT7td8q9M9Lvqgn0ht/OCHjXvKP5HuS52NYcYDF
	 f4mB2dVIpR+vE0di5ein7zFSqDgHKe/XLrcHLFiZah2j5aHKJuu6yv51dxtH/IEOgu
	 qi8MfhjcG24ZdesopeaTvPS4MXYe6WbVOcJ+EOGE=
Date: Wed, 01 Apr 2026 05:10:15 -0700
From: Kirill Samburskiy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075804/000000-6a68f0@github.com>
Subject: [bluez/bluez] 6a68f0: audio/avrcp: Track TG and CT events separately
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1075804
  Home:   https://github.com/bluez/bluez
  Commit: 6a68f03ce8e605448ef262061e09afea2f319ed1
      https://github.com/bluez/bluez/commit/6a68f03ce8e605448ef262061e09afea2f319ed1
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Track TG and CT events separately

Since we support both target and controller AVRCP roles, we need to
track events for each role separately to avoid confusing events that we
registered for notification from remote TG, and events that remote CT
registered for notification from us. This change is only relevant if
both sides support both CT and TG roles.

Fixes: https://github.com/bluez/bluez/issues/1997



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

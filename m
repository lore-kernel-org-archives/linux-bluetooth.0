Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9FA944
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692351; cv=none; b=jon992+Y3ZkQxfZBDapg5SVRiEUlOSp/Js0688RTggfx3JtnmyO65iSWnZPc40GoJKrFbukoac7OPL6NGOeZdpbdbjajUcP0ILnmX+3ptu1YfzjQjA9HjuKoIzK58RH51MH+Kdjw37H6uQSydXC0E7A/yBoXe4OiYcyeelyZx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692351; c=relaxed/simple;
	bh=f9p7CzYo9NFNAeJi1FSwCRAjotLku+eyeCAWJKxWZxE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kLxk4McuNy+euKti3Z8XpZzTsHczGzHcOGhgkFAxLOm3FY9BLvyFH6kMrOJlJ8c77Aat54/rOETQHrQr4ItMc/FL3HPDO3WV5ehJkBvoGlNCvQPKwjz52HyEJjj/GNZv+JDS0MS24xJepMbfu4s+apyMcZIc0LDYOUhXeoCR3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ii2LH+eW; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ii2LH+eW"
Received: from github.com (hubbernetes-node-1c2c9f6.ac4-iad.github.net [10.52.138.38])
	by smtp.github.com (Postfix) with ESMTPA id A07AF203F5
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762692349;
	bh=0H/+5kfj952Kf62af4KBHqFgeMFw+kZ5ulRTnx84tK0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ii2LH+eWjn8k/xBklin5fwU5qqGK79kd9+1jVJORHvzaK74dB+rSjool7YEg1EO38
	 LAJ0KfLPuaG6OAYM7WJkPM2DJ2sT0nU6BsDrJfIEBiJ1IV7DrCLzZL1HLEZJL3765V
	 Q/tDk5ZazJiHs6CoK3RAKrL67ReC3mTVD1XLT9vs=
Date: Sun, 09 Nov 2025 04:45:49 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021294/000000-384d98@github.com>
Subject: [bluez/bluez] 384d98: shared/bap: fix keeping PAC caps <-> metadata
 corr...
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

  Branch: refs/heads/1021294
  Home:   https://github.com/bluez/bluez
  Commit: 384d98188a46cbb9716ebdac0b392fd730a90d1d
      https://github.com/bluez/bluez/commit/384d98188a46cbb9716ebdac0b392fd730a90d1d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-09 (Sun, 09 Nov 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix keeping PAC caps <-> metadata correspondence

In PACS, Metadata is associated with a specific PAC.  bap_pac_merge()
mixes up metadatas from different PACs if some PAC has no metadata.

Fix caps<->metadata correspondence by explicitly storing 0-length entry,
instead of skipping it altogether, if metadata (or caps) is missing.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

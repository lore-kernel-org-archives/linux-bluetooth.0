Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4B4F0552
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077550; cv=none; b=Pod3284RrS7BFzwwIGCFvOjcBuUiz5lzFxo0AAG2YTQTtB871OfgIlITfJ3XkwlQq5RLo7oRBmtq9EwcZwWwWfwHJ5iIrv+cKl7RPbhS/JIFCI1gEr8TMIxKBvOmMSwmGhhc4Bi/FOGzhfMW8356QzLCoL26ttcgLc4mgC461sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077550; c=relaxed/simple;
	bh=MKlc128wc7nBMVBsujrwzN3Mzf9vw5tMSyI6IR/Cbco=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iGTwdOHk8G989Z2dXwzzSev31PFEmQkJyrDHg4AkO47bRll9mKQZdN8hAiDvQIJvTjet4+MXygstnywvKlTrA1IPMU9cN7GQG1UKiWBZRvjwTz9h1AhH4v3kSlIOwFbacYkj3w66HIV/CXUurb71npgCyVOBtUjpTfolInIrqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VxZ0fyb0; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VxZ0fyb0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790077547;
	bh=udVn6EOMTYRqM1ltYaH7rer13xeSfGl8yDASfMxkUY4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VxZ0fyb0nsCdk9Mm+7F7Sn7P4i+FiOFbzDGlK0asrUgzdO7axBFxl/0VXiRdRWZub
	 r8FNbItOVeOJ8mYkmNn9VApcdDvN/Shz524vl7d2al2Eb1w+sVm7c/B6gIKoPYyZYW
	 8GIP/EqK2bITMzkxrinyxNTSfJI7VO4BvgcfyK7g=
Received: from github.com (hubbernetes-node-c330b29.ac4-iad.github.net [10.52.13.70])
	by smtp.github.com (Postfix) with ESMTPA id A58C332110E
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 04:45:47 -0700 (PDT)
Date: Tue, 22 Sep 2026 04:45:47 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1171262/000000-b6b0a7@github.com>
Subject: [bluez/bluez] b6b0a7: adapter: remove bondable mode hijacking when
 setti...
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

  Branch: refs/heads/1171262
  Home:   https://github.com/bluez/bluez
  Commit: b6b0a74998f14f16f62c2924cdb874d7f640b4e0
      https://github.com/bluez/bluez/commit/b6b0a74998f14f16f62c2924cdb874d7f640b4e0
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-09-22 (Tue, 22 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: remove bondable mode hijacking when setting IO capabilities

Setting IO capabilities could implicitly toggle bondable mode on or off.
This behavior was introduced by "core: Add AlwaysPairable to main.conf"
and creates unwanted side effects for external pairing handling,
specifically glitches in the Pairable property during BlueZ startup.
The unnecessary setting of MGMT_OP_SET_BONDABLE has no basis in the
Bluetooth specification and should be removed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DB3DEFFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139630; cv=none; b=UC3wy82inMo6LWEcIaEbo6rYjjTTi/vsOYeY3xtiqEUglexSOJFS2+bDbbTeR34tPLx8PaXPJZN19H9Ax/4LsuMOOuRo+rCvuHUXYwfMnRJgMEQNKA4VW6FYFht8r+UG1yHEKB/LG83IxJ7yags6OcfaNGqVXF+68b507q8wTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139630; c=relaxed/simple;
	bh=hSuQ0ppMCq5+U/gRpsZuipkXyNVGi+BmLfVkw39Ioag=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iQ1R4EQ27Im09JJS1iYbUBMUZCayMP1UflKklYz80r8y1yE5CGnyq1QQthQg8ENdZnZMlILzIyDazV3+EoaxsL+xptNmuKMu5nqxssPF7VoFcHxg/X/NKfkm1nyAvjUJduYnAIEzewrSbpbhd+JqvVL8K9oMfMFE5AnO1mDMzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mdFbLrGo; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mdFbLrGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785139628;
	bh=8IwdfYJGdzzGkTSCwH0Jejjv98O1spEUyfPOIxKABnE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mdFbLrGo4YNHC8Wgg76ywF3j/GRrpk2JK8q6uLBMkW7rwQvSKL1skXj/YdIzNEod3
	 uPDx7Tj13YZlum8ZGPrSG+Uvu+xN+x9t68GZx8IH8finxPZTXqUa61IAcsTPOeoZxU
	 oD7lUKDRR5vHnCxSDjBB8J+tuKtibShirdCqQdnM=
Received: from github.com (hubbernetes-node-ba6ab4c.ash1-iad.github.net [10.59.96.38])
	by smtp.github.com (Postfix) with ESMTPA id 5E3CE18040E
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 01:07:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 01:07:08 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134915/000000-fc8f42@github.com>
Subject: [bluez/bluez] 4220d4: rap: use session lookup for RAS operations
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

  Branch: refs/heads/1134915
  Home:   https://github.com/bluez/bluez
  Commit: 4220d4c2887d35355856ead1f7f3d0e73e47312c
      https://github.com/bluez/bluez/commit/4220d4c2887d35355856ead1f7f3d0e73e47312c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-27 (Mon, 27 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  rap: use session lookup for RAS operations

Store disconnect information in RAP state and
centralize attachment handling through dedicated helpers.
Add bt_rap_get_session() and use it from all RAS
GATT server callbacks


  Commit: fc8f4204232339d06db91f0a0b7dbf476b8ea1d0
      https://github.com/bluez/bluez/commit/fc8f4204232339d06db91f0a0b7dbf476b8ea1d0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-27 (Mon, 27 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: centralize reflector setup

Add a helper for reflector initialization and track D-Bus registration
state in rap_data. Simplify connection handling, move interface cleanup
to object destruction, and streamline removal logic.


Compare: https://github.com/bluez/bluez/compare/4220d4c2887d%5E...fc8f42042323

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

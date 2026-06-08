Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947325782A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918171; cv=none; b=Fa9+gnWj5StLFGoMPZfRitOrYYdHfDJoGi6TR+HJ4RVCinFYYavYViDXh7wFOgzJL9c5DKbvSGDZCjMPGJsGBvKSuEuKN7oWKykOeXbx7m+fUsZvTTaM49T4nc8tDQEaBrRF4sqLjRBdopZT0CNWLLbqa/ta3nwwek5MWq+C3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918171; c=relaxed/simple;
	bh=VfnbZpLIb5oe6iYec6v1Nj/llS0bDWApiIwUvNmTApE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nNZoCZ5dYo3kVHTS5aaxodg/hT1TsApUHoPL8yND/X4vCSEH0p0upOez5JfeXYZPw1fNmOw3PB2wIOXwcja9sA6kEntZ0Bjp6G+imGLGOfElne2+vndjnjRCswvM1g3Iq5qWAQVj6uhGsXpBPhmi6YaMgeAbSYq+8pc9mTft4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BDVYaK+2; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BDVYaK+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918169;
	bh=8BDnWGIF1+ryQ0+NKIZLFpI090X+MvGCklHiemYLqvE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BDVYaK+2bBvbzpriVASqS66KICg7twuVXOlm4NWFYK/B46pBtSUB2e06/hFlTGZ82
	 Oh0TCClU905d9pbFVMp32QFvXkkmYg2JCNz6cylrGi1vsGQqS2TVuwDdnyQGvKEJxV
	 B8mT1WC7L/yWjgwymKWP/H9mTbpmNdD18pMhRAz0=
Received: from github.com (hubbernetes-node-7309502.ac4-iad.github.net [10.52.154.32])
	by smtp.github.com (Postfix) with ESMTPA id CC2F5740E06
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:29 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:29 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107774/000000-fa023b@github.com>
Subject: [bluez/bluez] 51f28d: device: Refactor device_discover_services
 function
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

  Branch: refs/heads/1107774
  Home:   https://github.com/bluez/bluez
  Commit: 51f28d24f7c767616f5101050789e67a25789a5e
      https://github.com/bluez/bluez/commit/51f28d24f7c767616f5101050789e67a25789a5e
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/input/server.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Refactor device_discover_services function

After refactoring we can reuse function once more in function
void device_bonding_complete(...)


  Commit: 0967651164a2118729967a25d670eb3f249aa72f
      https://github.com/bluez/bluez/commit/0967651164a2118729967a25d670eb3f249aa72f
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Rename start_discovery function

Rename it to start_discovery_cb to indicate that it is callback function
from timer.


  Commit: fa023bc6417933847b1fcea23cb0da75fcc31eed
      https://github.com/bluez/bluez/commit/fa023bc6417933847b1fcea23cb0da75fcc31eed
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix returning discovery error for Device.Pair

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.


Compare: https://github.com/bluez/bluez/compare/51f28d24f7c7%5E...fa023bc64179

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

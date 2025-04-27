Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251755661
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745751182; cv=none; b=dguqIUeiZ+nJXXP22d5BOl79tegx0hVIsmPctjMJGlsbONKzh8EclDVrMeW+kdOsCDbETPLXO7Wsu7KNZQBs/nTRIt33OiN9+je9+zOuPR2HziD+Zk+goY1AxoIxA92G/9tqHEEkaeavIbmow9ZsQIFYqvlacwW+4rH81SZbuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745751182; c=relaxed/simple;
	bh=dxyC7cZ84F5GqwJBpoLSg/v2qn7WEZr+lZWb+4mScJM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uSPfS04HxC3l1s7uq+7knPxh+SoYOmXfjrmOusSAVu/PrIaEXVeEUJ0nZTwEayKJUyaO0tPZOQHVHWiV7kfFYZv8MUe9J47n6sW3pm1kI2f8QQW+mDaTLn2g2r6p1bKnktqDrurs/v2LAChOfiEaqhIr1PEcBQt8Sxd1D1L/RF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kWHl+D5j; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kWHl+D5j"
Received: from github.com (hubbernetes-node-53c49a8.ash1-iad.github.net [10.56.170.10])
	by smtp.github.com (Postfix) with ESMTPA id 1CFF4140CB5
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745751180;
	bh=n8qNc5PIgu/H8RFHjizB2tvFj0GJsVBv0CtFJvXwOVM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kWHl+D5jK7TtYjDzAn/52tkg+gReRnoUUDaGnxqZEMolNN5WAh5l7rJR8rO3y95zU
	 aA3GZ573TrJGDFG4zTUT/+c4WXllwrIxVXBAdsf0Rr3FucBsTWHpbYL0cs1n9mQVCA
	 Aa3BWWtCxGIvOgj2LdwH1hPoe5woGfXJWqX3wRQs=
Date: Sun, 27 Apr 2025 03:53:00 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957482/000000-eff3c7@github.com>
Subject: [bluez/bluez] d9a266: tools: add tests for RX timestamping
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

  Branch: refs/heads/957482
  Home:   https://github.com/bluez/bluez
  Commit: d9a26600b52b3fb012d2b1eda54fe1db7bfa7418
      https://github.com/bluez/bluez/commit/d9a26600b52b3fb012d2b1eda54fe1db7bfa7418
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools: add tests for RX timestamping

Add tests:

ISO Receive - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping 32k
L2CAP LE Client - RX Timestamping
L2CAP LE Client - RX Timestamping 32k


  Commit: 72da3846c41c23df6d02fc4d31314c2da36babba
      https://github.com/bluez/bluez/commit/72da3846c41c23df6d02fc4d31314c2da36babba
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: implement fragmenting to ACL MTU

Support fragmenting ACL packets to given ACL MTU.


  Commit: 8f227dda6069a9f7fedf18aaafec71f3c3ab5ccf
      https://github.com/bluez/bluez/commit/8f227dda6069a9f7fedf18aaafec71f3c3ab5ccf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: set bthost ACL MTU to match btdev

Set the bthost ACL MTU to avoid generating larger packets than the btdev
ACL MTU.

This tests RX timestamping on ACL fragmentation.


  Commit: d8ac337eeb457f37538cf1bdf944df6be895513e
      https://github.com/bluez/bluez/commit/d8ac337eeb457f37538cf1bdf944df6be895513e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: support sending SCO packets

Add function to send SCO packets via bthost.


  Commit: eff3c7120f7f206686826ba7784435f2025eaf45
      https://github.com/bluez/bluez/commit/eff3c7120f7f206686826ba7784435f2025eaf45
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add SCO receive and RX timestamping tests

Add tests:

SCO CVSD Recv - Success
SCO CVSD Recv - RX Timestamping


Compare: https://github.com/bluez/bluez/compare/d9a26600b52b%5E...eff3c7120f7f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

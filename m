Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C329408
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512340; cv=none; b=W57e7+T8Z3+qlEKvoW2DRCJZ5j9QI5J8npcdFut4K9u4m5aUmE7b3FA8k10jaAeF79NZr0mjwO6d0S37Vnc9zoA6OGxYoHvuTVTlJ+d0i3Coy4IDG4rsfY9LqF/HGzmRheVxIM7eM084eKo76XS2NkR59sns0tuN/zkP3gdEUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512340; c=relaxed/simple;
	bh=nMloIIixTn4TRek7oJVts51PhIJaQcp1f0bkhTAw3rI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Mqo7MpaqX4upUvo54YCuSaxvESK9hIapV8CuT2Oj9pR+XekINrLWPuJtT7A5tmAPrjxRx7nTb9wXyYWy3UQfIGyH7Nxw9bCgSHmY6GqyUiUE3nIsZMbegqjpZE/9fT0a4rokW36df7EKabF9f90UyFz6jgCyURSsMgfOjNsi/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mRfh60Hg; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mRfh60Hg"
Received: from github.com (hubbernetes-node-74f6c74.ac4-iad.github.net [10.52.184.43])
	by smtp.github.com (Postfix) with ESMTPA id 4C81D640798
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752512338;
	bh=iYRUn/sBBZoDy6KV6m+jAP8N15vFzwVB/6DMxnBgtGY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mRfh60Hgpapnljt5ubGcvm3FlTcPudbZYBzsKny9U77cqnAQ4ChfDyR1lp0dRoI6J
	 HMK52YcIB6p9ii50+FBXvnF61m40H1SUo+NVGrFB7Fd2K1DueY4IRWI1m/S2OvpAx9
	 pYmxpRgIt7TW4BeQ4McSLjtiRingyVYgH0MD4DYo=
Date: Mon, 14 Jul 2025 09:58:58 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982161/000000-f0a742@github.com>
Subject: [bluez/bluez] 1c86be: lib: tools: remove POLL_ERRQUEUE
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

  Branch: refs/heads/982161
  Home:   https://github.com/bluez/bluez
  Commit: 1c86beff96eefdaa02556ac66286b41523094a3a
      https://github.com/bluez/bluez/commit/1c86beff96eefdaa02556ac66286b41523094a3a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h
    M src/shared/util.c
    M tools/iso-tester.c

  Log Message:
  -----------
  lib: tools: remove POLL_ERRQUEUE

This experimental feature did not land to mainline kernel, and probably
would need to be done differently.

Remove defines and tests for it.


  Commit: 0a3c3671741026e6a61c315c78d583206585af04
      https://github.com/bluez/bluez/commit/0a3c3671741026e6a61c315c78d583206585af04
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM

Socket options and CMSG identifier for ISO packet sequence numbers.


  Commit: f0a742e65c576709ec598057877348e444210f46
      https://github.com/bluez/bluez/commit/f0a742e65c576709ec598057877348e444210f46
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: add tests for BT_PKT_SEQNUM

Add test

ISO Receive Packet Seqnum - Success


Compare: https://github.com/bluez/bluez/compare/1c86beff96ee%5E...f0a742e65c57

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

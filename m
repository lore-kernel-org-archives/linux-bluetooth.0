Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F33B42D1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469505; cv=none; b=iwXyzGQepoZ9rSBdpVORLbdZnoishuy05e8YP6mpAu4ighpnQ+tdQ+rQZHph2jjE16bW2/g9ldRZ1DIVa8JE9po7i0M99t+MUfDCpoeGZkG7JOAEj1c3cOgAdfkbM3RqxLTeUZjw+U75CU91mOxGvh0HFimb0ZyschVH0s+QALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469505; c=relaxed/simple;
	bh=NkyUrMryGzNG65fQqOkV2zAQiTzurl6XCzzWBIWZG/s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SsjBTxwTLMgvxyWcAOHSVOkESHedFPlIeLYe744ohH+q44ypa2WLOvWfitStc4LEn28hW79inaaDJosPmh6NJxY7IiIxuFnYQAbTvsxhq59koGZjzbEa4mbb1Vk5Ydn3k2ddPihEKDPDODn75VzJlULNWZLBqCl56PUZcDHAakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iL4Atgug; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iL4Atgug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788469500;
	bh=XyvbflR2jqCHy+bEzf9sQuVTAwHTTFYCpeFA2YVLRfk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iL4AtgugDzWm9/RNzZQhwhNhDYkbeOBwuIstOlRpSyrlT9UrbVaGAoMxM5u/FGcyf
	 MI29Y4r3lFQN5qAPMmlxczIw4PFqvoVQlka6dg+mgNd6DrRU3+WuFaJktOvC8soQMJ
	 FRVe5duFFk6CBSedwqwWNxkPSKge6yneM8iFuAlI=
Received: from github.com (hubbernetes-node-21de72b.ash1-iad.github.net [10.56.82.36])
	by smtp.github.com (Postfix) with ESMTPA id E422084074C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:05:00 -0700 (PDT)
Date: Thu, 03 Sep 2026 14:05:00 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157383/000000-ab6c9f@github.com>
Subject: [bluez/bluez] ab6c9f: emulator: btdev: fix inquiry_timeout() inquiry
 des...
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

  Branch: refs/heads/1157383
  Home:   https://github.com/bluez/bluez
  Commit: ab6c9f110d1d52a7b2f4cf5edc725b3b3ed876c2
      https://github.com/bluez/bluez/commit/ab6c9f110d1d52a7b2f4cf5edc725b3b3ed876c2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: btdev: fix inquiry_timeout() inquiry destroy

inquiry_timeout() removes inquiry_id callback, whose destroy removes
inquiry_timeout_id callback. Doing this from the callback itself frees
timeout-mainloop.c timeout data under it, leading to crash.

Fix by setting btdev->inquiry_timeout_id = 0 first to avoid the early
free.

Fixes ERROR: AddressSanitizer: heap-use-after-free
READ of size 4 at 0x7b9d9cfe0310 thread T0
    #0 0x00000049ebbe in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x00000049f270 in timeout_callback src/shared/mainloop.c:245
    #2 0x00000049fbbb in mainloop_run src/shared/mainloop.c:104
    #3 0x0000004a286f in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x000000402a66 in main emulator/main.c:261

freed by thread T0 here:
    #0 0x7f7a5e6ee4cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x00000049f591 in timeout_destroy src/shared/mainloop.c:226

previously allocated by thread T0 here:
    #0 0x7f7a5e6ef41f in malloc (/lib64/libasan.so.8+0xef41f)
    #1 0x00000049158a in util_malloc src/shared/util.c:46



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

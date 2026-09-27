Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1153BCD2F
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539869; cv=none; b=tM/SzAU7bzAwuSoLIqPq5S3L5gFCFyRTGArOUhgM8fOGsL0/ZA1C9yN5xti11upEaUTrc7ZMV4XCLwWNyyTkXm/YZpavyORU4jjFeQ4t/KvN4UZZFOJQbsLRIdt4UR7VA5Y12uo/KleMxxIFLowGeXX3Wn7qjjz10e7APL50Nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539869; c=relaxed/simple;
	bh=UxvnQTlWQ9iSKjG2jmWbBMkl/iXyfMr0b/hSwvMw2Pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qS5hkj8NzfQ4xUzmM8oa3gOcuYzUB8n82RyvqLytHj0AYQrHcQXtmqHf3WB/QnvedifLr+UiOjRZkrPI98OEKtWFgHE3VvzEksE2/XtbjtaZaqJ5jpcYLa1eRCbZjdaBHWoX0jR+UqzOazKO9hIKZByu75t8d7GzhCxB2ENgc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I1z4JAuX; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I1z4JAuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790539866;
	bh=cN29UjKSX9GwxERqazeOXNXrMBmOgjTMM7ImnlmjeBA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I1z4JAuXKfTOAXq6qZXJcVCrGmdzKOOHfR7fX1m52qM/U8HJkUZvt6To6+uCRr3Wk
	 HnFTGdtxBJxRTIhOpGMQQf1tm4B7urzNPHtr5mA5PtfbKyBQ1kvltmGoXX0F2Twm9c
	 cFdoBT18XtleFGQfLUnHhzoslmTZEIpzi9NRbWR4=
Received: from github.com (hubbernetes-node-6a25ad7.ac4-iad.github.net [10.52.168.46])
	by smtp.github.com (Postfix) with ESMTPA id 77ABC94085F
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 13:11:06 -0700 (PDT)
Date: Sun, 27 Sep 2026 13:11:06 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1174578/000000-8178da@github.com>
Subject: [bluez/bluez] 3e7f7a: shared: mainloop: Skip removed mainloop events
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

  Branch: refs/heads/1174578
  Home:   https://github.com/bluez/bluez
  Commit: 3e7f7a4d265fa3e7ef3f9224cd3acb9c22491f9b
      https://github.com/bluez/bluez/commit/3e7f7a4d265fa3e7ef3f9224cd3acb9c22491f9b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-27 (Sun, 27 Sep 2026)

  Changed paths:
    M src/shared/mainloop.c

  Log Message:
  -----------
  shared: mainloop: Skip removed mainloop events

mainloop_remove_fd() on an fd that occurs in the same epoll_wait batch
as the current callback, causes ASan crash.

Several callsites do this, crash is sporadic since it requires suitable
timing.

Fix by adding registration ID in each event and dispatching only if that
registration is still active.

Fixes random btvirt crashes.

Log:
ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7576be3f18
READ of size 8 at 0x7b7576be3f18 thread T0
    #0 0x5637f7b4014f in mainloop_run src/shared/mainloop.c:104
    #1 0x5637f7b41f79 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #2 0x5637f7aa598b in main emulator/main.c:310
freed by thread T0 here:
    #0 0x7f45788ee4cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x5637f7b40d05 in mainloop_remove_fd src/shared/mainloop.c:213
previously allocated by thread T0 here:
    #0 0x7f45788ef24f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x5637f7b4034b in mainloop_add_fd src/shared/mainloop.c:142

Assisted-by: opencode:gpt-6-sol


  Commit: 8178da05c017372532ee7ca1d47891bd747728e8
      https://github.com/bluez/bluez/commit/8178da05c017372532ee7ca1d47891bd747728e8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-27 (Sun, 27 Sep 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-mainloop.c

  Log Message:
  -----------
  unit: test-mainloop: add basic mainloop test

Exercise basic mainloop fd add / remove / modify and timeouts.

src/shared/tester.h depends on mainloop and cannot be used here, so
write tests without the framework.

Add tests:

Test Modify File Descriptor
Test Re-Add Other Callback
Test Timeout

Assisted-by: opencode:gpt-6-sol


Compare: https://github.com/bluez/bluez/compare/3e7f7a4d265f%5E...8178da05c017

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

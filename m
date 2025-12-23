Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C92E175F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498378; cv=none; b=BIDxNDdXqUYe52FSMt+EOI464dKqXfclYrE6W2UjWA/7c5lbgWEqSy0cl1iz6wk3thSGkhgQdUyhoBiFx/pHQGxyEp1khSuWL+4UEKq+lF7ecuKFO67dZoFAGDF7Rhf79wM2H4qAQtjdZyEFpjlychb/CHUo7dOzDM41v0XMrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498378; c=relaxed/simple;
	bh=Em6gU0GYaSATPCVW7wynSLKbCnptrt1cLymL9Rxn47U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=agGCNoxba/2Vd61PZpbpUe2yKoaDYfYJCMTB5eIn/8nBbRQtDpCbdIvlcx2SdUq+etWBI1XBJjIAnEf8Fy9/vzM/TqDAnE5MwBX+M5YMjFoya3uV48AGhkcyLjKRTcnTp5DgH9xQYSvZOHQUfzixA5z8Frk5+3kKc0xXoc1VwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eMgznJdv; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eMgznJdv"
Received: from github.com (hubbernetes-node-b4b63ee.va3-iad.github.net [10.48.201.67])
	by smtp.github.com (Postfix) with ESMTPA id 044C13C1099
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766498374;
	bh=I+aSPtOqj9OuZ64O+Jy0r+kl0060gYrTaM1bnFlH9kE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eMgznJdvEJq7b3zFcgVydxY3EOZLaA7AfffRIHp87pmQjtwGmqLwmp+mzUtptYMa/
	 3zriPkiyFh93IZYQcOscrUwEDOLZ5//g2NEIItq23C/UiR4EuzgCsM6SJ0CP2/Tdwa
	 I+2A4HvFEX82ugTLUGFSPHG1T+KKDba6UsCy1AwY=
Date: Tue, 23 Dec 2025 05:59:34 -0800
From: Sarveshwar Bajaj <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1036073/000000-c84809@github.com>
Subject: [bluez/bluez] c84809: profiles/audio/bap.c: Fix heap-use-after-free
 in s...
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

  Branch: refs/heads/1036073
  Home:   https://github.com/bluez/bluez
  Commit: c84809f5efa39bd041680d16ee7d1134d0abd183
      https://github.com/bluez/bluez/commit/c84809f5efa39bd041680d16ee7d1134d0abd183
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2025-12-23 (Tue, 23 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  profiles/audio/bap.c: Fix heap-use-after-free in setup_free()

Fix crash when removing or disconnecting a device with active broadcast
streams. AddressSanitizer reports a heap-use-after-free in
bt_bap_stream_get_state() called from release_stream() during
setup_free().

Detach frees BIS streams during teardown, but setup_free() still
unlocks and releases setup->stream afterwards, leaving a stale pointer
and triggering UAF. This can happen with multiple BIS streams since
each setup holds its own invalid reference.

Fix by skipping unlock/release in setup_free() and clearing
setup->stream to prevent further access.

Log:
ERROR: AddressSanitizer: heap-use-after-free on address
0x7c43a43e3458 at pc 0x572415a8603d bp 0x7ffcdef9b870 sp 0x7ffcdef9b860
READ of size 8 at 0x7c43a43e3458 thread T0
    #0 0x572415a8603c in bt_bap_stream_get_state src/shared/bap.c:6386
    #1 0x5724158f9d0a in release_stream profiles/audio/bap.c:951
    #2 0x5724158fa10e in setup_free profiles/audio/bap.c:1121
    #3 0x572415a293c1 in queue_remove_all src/shared/queue.c:341
    #4 0x572415a29440 in queue_destroy src/shared/queue.c:60
    #5 0x5724158f9464 in bap_data_free profiles/audio/bap.c:192
    #6 0x5724158f9464 in bap_data_remove profiles/audio/bap.c:211
    #7 0x5724159040e4 in bap_bcast_remove profiles/audio/bap.c:3821
    #8 0x5724159a7eb9 in service_remove src/service.c:239
    #9 0x5724159cfa49 in device_remove src/device.c:5489
    #10 0x572415999889 in btd_adapter_remove_device src/adapter.c:1458
    #11 0x5724159b99c7 in device_disappeared src/device.c:3854
    #12 0x572415abcea5 in timeout_callback src/shared/timeout-glib.c:25
    #13 0x7f63a58f9329 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68329)
    #14 0x7f63a58f7de1 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x66de1)
    #15 0x7f63a59691f7 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xd81f7)
    #16 0x7f63a58f9156 in g_main_loop_run
        (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68156)
    #17 0x572415abd18d in mainloop_run src/shared/mainloop-glib.c:65
    #18 0x572415abd9c4 in mainloop_run_with_signal
        src/shared/mainloop-notify.c:196
    #19 0x5724159ea378 in main src/main.c:1550
    #20 0x7f63a562a577 in __libc_start_call_main
        ../sysdeps/nptl/libc_start_call_main.h:58
    #21 0x7f63a562a63a in __libc_start_main_impl ../csu/libc-start.c:360
    #22 0x57241587d464 in _start
        (/home/workspace/bluez/src/bluetoothd+0x106464)
0x7c43a43e3458 is located 120 bytes inside of 160-byte region
[0x7c43a43e33e0,0x7c43a43e3480)
freed by thread T0 here:
    #0 0x7f63a5b212ab in free
        ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x572415a710f4 in bap_stream_free src/shared/bap.c:1254
    #2 0x572415a710f4 in bt_bap_stream_unref src/shared/bap.c:1337



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

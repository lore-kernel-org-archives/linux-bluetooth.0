Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B8517BDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557757; cv=none; b=e5jn6I93H9d3pbIxwg5/d87bmHeOxyeN6r/87Bfc3hBCct3XUwr6UyzZjs6YpHsTtl0UjgM4JFT61NhUhel4yUMg6E9Sz1zAbmlld3pNSScYrPnvtqifk+STRnz/YVKvwjLBxAM5v9WBOKNhkFCk/KZV17g1kmXCeNomXUWQj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557757; c=relaxed/simple;
	bh=YGdIq7/cf2zAsYVkXtXVJvgxfhzD79WJyZ8cftyz9tg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qoH/HJrRYhwAJRO29GZJTzJqqT+7v9qJu6kptYqHxnSIPyuavcVyyivVKpkJ78UGECvreFgriajlnoF3MzEleWCn4GEvbXU/MkJ3nLjdUTPqKHS0ARXeE9u4xtgAdBoshFGGDn2LXwzZNcdvFPcBfCHu6kYJ2ZdKb9aq9qdr2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mj2Yh2AU; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mj2Yh2AU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557754;
	bh=wQBBVAtXUDm+mC5kyRWztUD0C110KtFzftET5t5+wJI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mj2Yh2AUBcez3tvJPYMNh6jzQhZHCoOg0GzdtPFyouUzdIOa9ejsyrgpQvJMMwNnw
	 UxpU3Wr6etdB8EEN2XXUc2veuBu0Uv61qtriyuJQOmGljLPYG3lupci7YmlrWAyDYz
	 y5qFxJ9JAoPJOkMoll2lKlcMYjhvDwEafRxxMbDw=
Received: from github.com (hubbernetes-node-7207763.va3-iad.github.net [10.51.96.28])
	by smtp.github.com (Postfix) with ESMTPA id 477AD500DA2
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:35:54 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:35:54 -0700
From: Aaron Brice <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4b92dd-12f5eb@github.com>
Subject: [bluez/bluez] d13f18: profiles/audio: Support MCS track position
 writes
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d13f18c9a930bfa53570ec822d6f9ec52423ff40
      https://github.com/bluez/bluez/commit/d13f18c9a930bfa53570ec822d6f9ec52423ff40
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M profiles/audio/mcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  profiles/audio: Support MCS track position writes

Use MPRIS Seek to handle MCS Track Position writes.

This is required by PTS GMCS/SR/SP/BV-02-C test.


  Commit: f801cd34402bf13955859694d49f0c3bdc5fd362
      https://github.com/bluez/bluez/commit/f801cd34402bf13955859694d49f0c3bdc5fd362
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  profiles/audio: Support MCS fast seeking

Map Fast Rewind and Fast Forward to relative MPRIS Seek calls.

Report direction through Seeking Speed until Seeked restores player
state.

This is required by PTS tests GMCS/SR/MCP/BV-05-C to BV-08-C.


  Commit: 4e237b304e5bd045eed896c68921f0ede7f786a5
      https://github.com/bluez/bluez/commit/4e237b304e5bd045eed896c68921f0ede7f786a5
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: Notify unsupported RFU opcodes

Use the ATT result to suppress responses for malformed writes while
allowing opcode 0x00 to report Operation Not Supported.

This is required by GMCS/SR/SPE/BI-01-C.


  Commit: 36cc1305a8270d48535dd86d49c0dc9fec5d3f3f
      https://github.com/bluez/bluez/commit/36cc1305a8270d48535dd86d49c0dc9fec5d3f3f
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M unit/test-mcp.c

  Log Message:
  -----------
  unit/test-mcp: Test unsupported RFU opcode

Verify that GMCS/SR/SPE/BI-01-C opcode 0x00 produces an Operation Not
Supported notification.


  Commit: 7e3212fa233edbdcfd69f93e2a7418819172c599
      https://github.com/bluez/bluez/commit/7e3212fa233edbdcfd69f93e2a7418819172c599
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: clear discovery_found list before discovery_cleanup()

discovery_cleanup() tries to reset RSSI of devices in
adapter->discovery_found list.  When called from adapter_remove(), the
list contains only stale pointers as devices have been already freed,
leading to UAF.

Fix by freeing the discovery_found list in adapter_remove().

Fixes AddressSanitizer: heap-use-after-free
READ of size 1 at 0x7d5b585e033d thread T0
    #0 0x000000772b1a in device_set_rssi_with_delta src/device.c:7121
    #1 0x000000772daa in device_set_rssi src/device.c:7150
    #2 0x0000006aa808 in invalidate_rssi_and_tx_power src/adapter.c:1732
    #3 0x7feb5a35557f in g_slist_foreach (/lib64/libglib-2.0.so.0+0x6257f)
    #4 0x7feb5a355b56 in g_slist_free_full (/lib64/libglib-2.0.so.0+0x62b56)
    #5 0x0000006f67d2 in discovery_cleanup src/adapter.c:1747
    #6 0x0000006f904f in adapter_remove src/adapter.c:7219
    #7 0x0000006f9de2 in adapter_cleanup src/adapter.c:11165
    #8 0x000000418ca9 in main src/main.c:1719

freed by thread T0 here:
    #0 0x7feb5a5434cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x7feb5a337bb4 in g_free (/lib64/libglib-2.0.so.0+0x44bb4)
    #2 0x0000007519d7 in device_free src/device.c:963

previously allocated by thread T0 here:
    #0 0x7feb5a54424f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x000000751fee in device_new src/device.c:4963


  Commit: e271e0adae507c36ae20c71b7127df7d7ee12e15
      https://github.com/bluez/bluez/commit/e271e0adae507c36ae20c71b7127df7d7ee12e15
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: 12f5eb726c6e9674093223d139a3fadc4937df9f
      https://github.com/bluez/bluez/commit/12f5eb726c6e9674093223d139a3fadc4937df9f
  Author: Aaron Brice <aaron@embeddedts.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Update for glibc 2.42 compatibility

btattach is not setting the baud rate correctly on systems with newer
glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
constants changed value, B115200 was 0x1002 which was the struct
termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
accept arbitrary rates and not just the baud enum values, and B115200
was changed to the value 115200. This means you can no longer set the
speed with c_cflag |= B115200 and should use cfsetspeed() to be
compatible with both versions.


Compare: https://github.com/bluez/bluez/compare/4b92dddc8e54...12f5eb726c6e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

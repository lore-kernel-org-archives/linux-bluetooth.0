Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9586353
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998909; cv=none; b=E/eLKgSBQD7IR90JGO7N4O+ojL85f/wv7yAvvTMRL7ATgjblmTdv7MaTfCaiiUOGeZR5ked84S2QBfCm0TtNbZ6YUj+02SHO75dQBrJbUe/XZkY7WoC4ueQ7m8rZTauTFA7Aun8CGJhge++9ILN57xV0QsAItCzXhvWr7DV5OUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998909; c=relaxed/simple;
	bh=x+xvLCSLxYMeW/kkDMkmeK1tgDjswEsyGtUcMx435Pk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y9PrUq/FCkU+X2tUE2dKBflvaZ9k1QziVHA+8bHPKCU+Tl7EEpGnaaTPpm+vORPkZW7egbp3I1+j2NThxoIlCJucEOhZD+zDaqi/E6AGEXAumvAHgzyTGF/jMMD60lpPZUwqF56x+oh5SIdvOUdUb1Q9u1u0/fiyi5U72ooUlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xvc6zdvY; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xvc6zdvY"
Received: from github.com (hubbernetes-node-e23b856.ash1-iad.github.net [10.56.200.63])
	by smtp.github.com (Postfix) with ESMTPA id 12DB114021E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767998907;
	bh=oXo3Vgqh/Sn9eNJpFjpTJGWnlhQduTPUGvX/MeLTpMM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xvc6zdvY7ZgE73F854M3MMood295GcTGmhjWE7vLwvqg2I/pP4Y8tHw+OLncFvx6Y
	 fYxMs3rINkzsCV21tGKm9hpjW9QwvTh8nOtM3Phmvzmz1O+F4Vn12LvSgDBtfmMf7u
	 jy5SmcI2Q0IT6AiFh+zD1WQ5bUtvbCQhMnmKufg8=
Date: Fri, 09 Jan 2026 14:48:27 -0800
From: dalegaard <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1287ac-a94f99@github.com>
Subject: [bluez/bluez] 51d93a: unit: Speed up unit-avdtp test
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
  Commit: 51d93aca7afa5fe115f8aac3b569abf3014988d0
      https://github.com/bluez/bluez/commit/51d93aca7afa5fe115f8aac3b569abf3014988d0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-avdtp.c

  Log Message:
  -----------
  unit: Speed up unit-avdtp test

Speed up /TP/SIG/SMG/BI-02-C by reducing the timeout length from 1
second to 100 milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.


  Commit: 027e29c3422582b1eb60297b22ec34d2bde7bcca
      https://github.com/bluez/bluez/commit/027e29c3422582b1eb60297b22ec34d2bde7bcca
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-gobex-transfer.c

  Log Message:
  -----------
  unit: Speed up unit-gobex-transfer test

Speed up /gobex/test_packet_put_req_suspend_resume by reducing the
timeout length from seconds to hundreds of milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.


  Commit: 00e5c016145a8850641e0ca39d0c4339dce2d5c9
      https://github.com/bluez/bluez/commit/00e5c016145a8850641e0ca39d0c4339dce2d5c9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-ringbuf.c

  Log Message:
  -----------
  unit: Speed up unit-ringbuf test

Speed up /gobex/test_packet_put_req_suspend_resume by not printing
debug for each of the million of iterations of our test.

If we carry on printing this, then either the terminal's output speed,
or the debug capture from the test suite will throttle the test.

This reduces the runtime from 3.3 secs to 0.007 secs.


  Commit: 024b148d73aed0cc4357a8ee2fe0f21d830fef6c
      https://github.com/bluez/bluez/commit/024b148d73aed0cc4357a8ee2fe0f21d830fef6c
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix memory leak

device_add_eir_uuids creates a list of added UUIDs, but it was never
freed.

This was found with LeakSanitizer from the following backtrace:

==764182==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f3c7db20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x7f3c7d870afa in g_malloc (/usr/lib/libglib-2.0.so.0+0x65afa) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #2 0x7f3c7d88e31f in g_slist_append (/usr/lib/libglib-2.0.so.0+0x8331f) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #3 0x564fa6ad9153 in device_add_eir_uuids src/device.c:2451
    #4 0x564fa6a6b2ec in btd_adapter_device_found src/adapter.c:7481
    #5 0x564fa6a6c5cd in device_found_callback src/adapter.c:7607
    #6 0x564fa6b9b73d in notify_handler src/shared/mgmt.c:337
    #7 0x564fa6b91ad8 in queue_foreach src/shared/queue.c:207
    #8 0x564fa6b9ba3f in process_notify src/shared/mgmt.c:349
    #9 0x564fa6b9c899 in can_read_data src/shared/mgmt.c:409
    ...


  Commit: a94f994201a69a36753abda65cc51937de9cd3e3
      https://github.com/bluez/bluez/commit/a94f994201a69a36753abda65cc51937de9cd3e3
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: prevent use-after-free when clients disconnect

Clients with an acquired characteristic subscription would free the
client during disconnect. When notify_io_destroy then tries to remove
the client, it'll use-after-free.

Add another reference when allocating the notify_io and unref it again
in notify_io_destroy.

This was found with AddressSanitizer:

==766875==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7782a31df0 at pc 0x55d19ae87cf0 bp 0x7ffcc28ea0d0 sp 0x7ffcc28ea0c0
READ of size 8 at 0x7b7782a31df0 thread T0
    #0 0x55d19ae87cef in notify_io_destroy src/gatt-client.c:1567
    #1 0x55d19ae83462 in sock_io_destroy src/gatt-client.c:1171
    #2 0x55d19ae83a4b in destroy_sock src/gatt-client.c:1192
    #3 0x55d19ae83c52 in sock_hup src/gatt-client.c:1207
    ...

0x7b7782a31df0 is located 0 bytes inside of 32-byte region [0x7b7782a31df0,0x7b7782a31e10)
freed by thread T0 here:
    #0 0x7f4784d1f79d in free /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55d19ae85c57 in notify_client_free src/gatt-client.c:1360
    #2 0x55d19ae85dd5 in notify_client_unref src/gatt-client.c:1372
    #3 0x55d19ae86517 in notify_client_disconnect src/gatt-client.c:1418
    ...

previously allocated by thread T0 here:
    #0 0x7f4784d20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55d19af6154d in util_malloc src/shared/util.c:46
    #2 0x55d19ae86550 in notify_client_create src/gatt-client.c:1426
    #3 0x55d19ae880cd in characteristic_acquire_notify src/gatt-client.c:1593
    ...

Other avenues could also result in this use-after-free. The root issue
is that the client struct is put in to both the notify list, and the
notify_io struct, but without an extra reference increment.


Compare: https://github.com/bluez/bluez/compare/1287ac9068b7...a94f994201a6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

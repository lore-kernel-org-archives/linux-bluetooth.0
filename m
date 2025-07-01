Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458B28A407
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401139; cv=none; b=apYz6OrxvEZppyplujzrrZF6DIWoAVd2D9bVLsFQQwQsg5YbUv+2oZeBw/BEd2Byf9ll/jHu6S8J6R8CxkW7OySQC1yNREhy8P+Td+tNcMARH+l/3Rl5xMp7XAnBVsMNPQOgZDnlfIw4tp4UcZAkJiUHV8VNa76yxJJ1ELJ8ObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401139; c=relaxed/simple;
	bh=uKJi2asZrU8KhK5DqC0NZiS+Yn3yN8q4ts6pKbDDXGE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ayNrD2cafvJbIQ6vKsmmstihhZkqfNcWt40l7kyC+uDyT7LzDRT+qF/twoWRV/q+uhrxYkT5n/rd6BjzRRLqwbfkJyWB0YToE/wNgRxUIgaPHrHA+FfeGAOdzTZ8rVG/inBRAgGGp2gQSQeWkRpOXk9v6YBeL1TvC+2luXjxbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AEy9KJmv; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AEy9KJmv"
Received: from github.com (hubbernetes-node-1a06fa6.va3-iad.github.net [10.48.149.36])
	by smtp.github.com (Postfix) with ESMTPA id 4970D4E0C8F
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751401137;
	bh=8pXIon1R/YYIrjvdKJhHjlELEdarmjF9/xm4Xhj7iSQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AEy9KJmv+Ytv2WwXSl7dhlysv4ewrpoEssrtSUJC43DZcXh7bzgalz6wpWN5oqq2g
	 p2U69k8pw8C2jLUt/iGWeykceyUf5X6f8RczBJJ1YYb7AVdn1xGtCUG7QE3psQHKo0
	 uqvgkT18sArFtkhZmKySUy5sVguYq3x+TMPC6cS0=
Date: Tue, 01 Jul 2025 13:18:57 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/822037-55a676@github.com>
Subject: [bluez/bluez] 476ae8: gatt-client: avoid UAF after acquire notify
 failure
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
  Commit: 476ae809a27ef2a3e3cf4f448ea3e50dbaca41f3
      https://github.com/bluez/bluez/commit/476ae809a27ef2a3e3cf4f448ea3e50dbaca41f3
  Author: Andreas Kemnade <andreas@kemnade.info>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: avoid UAF after acquire notify failure

If a disconnect happens during AcquireNotify dbus calls, a lot of
debris is left over. Subsequent calls to AcquireNotify will return
NotPermitted and StopNotify leads to an UAF, crashing bluetoothd.

Fix that by also clean up the socket stuff on failure.

This was provoked by putting the device into some RF shielding bag
and open and close it quickly.

Valgrind output:

bluetoothd[26032]: [:1.126:method_call] > org.bluez.GattCharacteristic1.AcquireNotify [#145]
bluetoothd[26032]: [:1.126:error] < org.bluez.Error.NotPermitted [#145]
bluetoothd[26032]: [:1.74:method_call] > org.freedesktop.DBus.Properties.GetAll [#895]
bluetoothd[26032]: [:1.74:method_return] < [#895]
bluetoothd[26032]: [:1.74:method_call] > org.bluez.GattCharacteristic1.StopNotify [#896]
==26032== Invalid read of size 8
==26032==    at 0x1A5721: notify_io_destroy (gatt-client.c:1562)
==26032==    by 0x1A7290: sock_io_destroy (gatt-client.c:1171)
==26032==    by 0x1A7290: destroy_sock (gatt-client.c:1192)
==26032==    by 0x1A73D6: characteristic_stop_notify (gatt-client.c:1698)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==  Address 0x5a7a430 is 0 bytes inside a block of size 32 free'd
==26032==    at 0x484417B: free (vg_replace_malloc.c:872)
==26032==    by 0x1DEC0F: complete_notify_request (gatt-client.c:1663)
==26032==    by 0x1DEC0F: enable_ccc_callback (gatt-client.c:1735)
==26032==    by 0x1DB8FF: disc_att_send_op (att.c:464)
==26032==    by 0x1DB8FF: disconnect_cb (att.c:676)
==26032==    by 0x2017A4: watch_callback (io-glib.c:173)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==    by 0x12E60C: main (main.c:1535)
==26032==  Block was alloc'd at
==26032==    at 0x48417B4: malloc (vg_replace_malloc.c:381)
==26032==    by 0x1D2F4D: util_malloc (util.c:46)
==26032==    by 0x1A5DD3: notify_client_create (gatt-client.c:1426)
==26032==    by 0x1A5EFC: characteristic_acquire_notify (gatt-client.c:1588)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)


  Commit: 0ff45df8546775bb920a98a2b0ecd76b84ebc20a
      https://github.com/bluez/bluez/commit/0ff45df8546775bb920a98a2b0ecd76b84ebc20a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Rename device error helper to match retval

Rename the helper to show that it outputs a string, and not an error
DbusMessage as the other functions do.


  Commit: 33226a0ad9030a0b67b7fe5f49ef40000deae861
      https://github.com/bluez/bluez/commit/33226a0ad9030a0b67b7fe5f49ef40000deae861
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Add helper to return DbusMessage errors from errno

This will allow us to start adding more precise errors instead of
"Failed" with a string if we're parsing an errno.


  Commit: 74f3733e707b1463f21b720984e7421e8f8f008e
      https://github.com/bluez/bluez/commit/74f3733e707b1463f21b720984e7421e8f8f008e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Use new DbusMessage error helper


  Commit: 2d7f67d8b94de6293886af49a369dffb1d3f4d12
      https://github.com/bluez/bluez/commit/2d7f67d8b94de6293886af49a369dffb1d3f4d12
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Make errno to string helpers private

We're not using them outside the error code itself.


  Commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
      https://github.com/bluez/bluez/commit/55a6763cde8a2309fd23a96479ee4cf2fc23a442
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  device: Better error when no BR/EDR profiles can be connected to

Add a more precise error when there are no BR/EDR profiles to connect
to. This is useful when trying to connect to a particular device, and
there are no relevant profiles to connect to on the bearer.


Compare: https://github.com/bluez/bluez/compare/822037fe7450...55a6763cde8a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95822085
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888259; cv=none; b=rkEH6UH/KevNbfbL5hbeoJVT9roiFzZnBmzjNudFq+PhMZlkkqH0jq8MEyDWYNyxVkLNa8Vi9b7+UY/rkp/KkcvxbdqBpsup7TSetffyPoyz9UDIbsF/kYOPvFLB3DCxFm1QzQ8+V00o/u0MHUH8bZSI9B6SVWi1zy+lYKEbpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888259; c=relaxed/simple;
	bh=/AZojNtunup7U4yoraVhR0gozNSKP7V5R2u3eyYQMPA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NxkuT6eLXLKuunI3rBLquphTYhmLZJB0YugBPhYQ1yxNvcaOBy+CMgEpXBL9pxfKfKh2VLbeAVi9INzoGwlU/AYF4KEzh9qyTLqVKTncRwu6ZMz/PeP9kjzhzecXo9oO2uClFvY+cqpUUMx9prqUFLJvnG98AftBExtDywBVtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Bh7vgxyq; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Bh7vgxyq"
Received: from github.com (hubbernetes-node-bf75fb8.va3-iad.github.net [10.48.143.38])
	by smtp.github.com (Postfix) with ESMTPA id CE2FF8C12F7
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706888256;
	bh=3hAjjob2lv1wTmQ9IBJYc2Dky900+Iiqvv7Pt5dOBxQ=;
	h=Date:From:To:Subject:From;
	b=Bh7vgxyqsB525ZJvw9qfo4lgE3XwQe3yCFnoiBmbz3jqW7SGmuZOkjxnMn99YtmMo
	 SmT4xcHdWoBIytYoAmJTO8sL7qYdwsPkiqZdPpuvK6ybMr6oHMqnrNE5NQerFvWOof
	 R9Ev6Nb2Vz+UsyM5jx38fzNYR+6R4MQGlsUI+aTU=
Date: Fri, 02 Feb 2024 07:37:36 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a692cc-de8c24@github.com>
Subject: [bluez/bluez] 176230: client/mgmt: Add missing settings strings
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
  Commit: 17623000ef464aff42fda22e5fdb59f4856b3f42
      https://github.com/bluez/bluez/commit/17623000ef464aff42fda22e5fdb59f4856b3f42
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Add missing settings strings

This adds "iso-broadcaster" and "sync-receiver" which were missing.


  Commit: 17c1a9b494900e1f412032d751db2a5e623c35f5
      https://github.com/bluez/bluez/commit/17c1a9b494900e1f412032d751db2a5e623c35f5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix passing ep instead of setup to config_cb

config_cb expects setup pointer not ep.


  Commit: 59bf065b6279bd49c505cab50a1d81294a6febbe
      https://github.com/bluez/bluez/commit/59bf065b6279bd49c505cab50a1d81294a6febbe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Don't remove object if a service is connecting

If a service is connecting just restart the timer to give it more time
to complete the connection or disconnect.


  Commit: b983c31d4a76bb8b90f42099c21ffacf833ab271
      https://github.com/bluez/bluez/commit/b983c31d4a76bb8b90f42099c21ffacf833ab271
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Allow using bt_bap_attach for broadcast

This enables use of bt_bap_attach for broadcast by checking if there is
a client or ATT instance.


  Commit: 75095a9901f8494e5652222669ffb51021eb4850
      https://github.com/bluez/bluez/commit/75095a9901f8494e5652222669ffb51021eb4850
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix crash when a broadcast strean setup is pending

This fixes the following crash when a broadcast stream setup is
pending and the device is remove:

bluetoothd[37]: src/device.c:device_free() 0x89a500
bluetoothd[37]: GLib: Invalid file descriptor.
bluetoothd[37]: ++++++++ backtrace ++++++++
bluetoothd[37]: #1  g_logv+0x270 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3120]
bluetoothd[37]: #2  g_log+0x93 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3403]
bluetoothd[37]: #3  g_io_channel_error_from_errno+0x4a (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cd9da]
bluetoothd[37]: #4  g_io_unix_close+0x53 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb55839d53]
bluetoothd[37]: #5  g_io_channel_shutdown+0x10f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cdf7f]
bluetoothd[37]: #6  g_io_channel_unref+0x39 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557ce1e9]
bluetoothd[37]: #7  g_source_unref_internal+0x24f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557db79f]
bluetoothd[37]: #8  g_main_context_dispatch+0x288 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dd638]
bluetoothd[37]: #9  g_main_context_iterate.isra.0+0x318 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb5583b6b8]
bluetoothd[37]: #10 g_main_loop_run+0x7f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dcaff]
bluetoothd[37]: #11 mainloop_run+0x15 (src/shared/mainloop-glib.c:68) [0x662e65]
bluetoothd[37]: #12 mainloop_run_with_signal+0x128 (src/shared/mainloop-notify.c:190) [0x663368]
bluetoothd[37]: #13 main+0x154b (src/main.c:1454) [0x41521b]
bluetoothd[37]: #14 __libc_start_call_main+0x7a (/usr/lib64/libc.so.6) [0x7feb54e1fb8a]
bluetoothd[37]: #15 __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6) [0x7feb54e1fc4b]
bluetoothd[37]: #16 _start+0x25 (src/main.c:1197) [0x416305]
bluetoothd[37]: +++++++++++++++++++++++++++


  Commit: b4aae7f3d92b9301ccfb24350dfe9e84a8da71ab
      https://github.com/bluez/bluez/commit/b4aae7f3d92b9301ccfb24350dfe9e84a8da71ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not being able to reconfigure Broadcast Source

This fixes not being able to reconfigure broadcast source due to it
being in Releasing:

bluetoothd[37]: src/shared/bap.c:stream_set_state_broadcast() stream
0x8919e0 dir 0x00: streaming -> releasing
bluetoothd[37]: profiles/audio/bap.c:setup_new() ep 0x8802d0 setup
0x88d3e0
bluetoothd[37]: src/shared/bap.c:bt_bap_stream_new() Unable to find
unused ASE


  Commit: 8527a218d9b536c7845084d963fe83c205782af2
      https://github.com/bluez/bluez/commit/8527a218d9b536c7845084d963fe83c205782af2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix crash when disable bcast stream

bt_bap_stream_disable does cause the stream to go to releasing state
removing the owner in the process so calling bap_disable_complete
passing the existing owner would likely cause a crash.


  Commit: d14e0b5ef150e13435f8a44251dfe6fa57447dc5
      https://github.com/bluez/bluez/commit/d14e0b5ef150e13435f8a44251dfe6fa57447dc5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Make broadcast disable and release more consistent

This makes bt_bap_stream_disable and bt_bap_stream_release use disabling
and releasing states to be more consistent with their procedures.


  Commit: 29dee7b54303423d72bc737bb806886d300e9cc4
      https://github.com/bluez/bluez/commit/29dee7b54303423d72bc737bb806886d300e9cc4
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Properly cleanup bap remote endpoints

When freeing a remote bap endpoint, the endpoint reference inside the
stream should be set to NULL, to avoid later use after free errors.


  Commit: 35032a6075c5f8ba351400949d47c860e8a2edc4
      https://github.com/bluez/bluez/commit/35032a6075c5f8ba351400949d47c860e8a2edc4
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix incorrect parsing of caps and meta in parse_base

This adds a fix to properly parse the stream capabilities and
metadata in parse base.


  Commit: 05efcccdcc5e7fae85eca1a9720b38664996c930
      https://github.com/bluez/bluez/commit/05efcccdcc5e7fae85eca1a9720b38664996c930
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Remove incorrect assignment of listen io

For a broadacst sink, the io that is notified in iso_bcast_confirm_cb
is the stream io, so the listen io should not be updated.


  Commit: de8c249f785d9ca54f8fee6d1e5b0cbbfef7f0d4
      https://github.com/bluez/bluez/commit/de8c249f785d9ca54f8fee6d1e5b0cbbfef7f0d4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-02 (Fri, 02 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix crash on BIG Sync Terminate command

When receiving BIG Sync Terminate command the following crash could be
observed:

Invalid read of size 8
   at 0x15FC9F: cmd_big_term_sync (btdev.c:6417)
   by 0x15D19D: run_cmd (btdev.c:7269)
   by 0x16E7DF: process_cmd (btdev.c:7425)
   by 0x16E7DF: btdev_receive_h4 (btdev.c:7516)
   by 0x143AB9: vhci_read_callback (vhci.c:77)
   by 0x185AAE: io_callback (io-mainloop.c:110)
   by 0x187158: mainloop_run (mainloop.c:106)
   by 0x188357: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x4EA6B89: (below main) (in /usr/lib64/libc.so.6)
 Address 0x53cf678 is 8 bytes inside a block of size 16 free'd
   at 0x4845B2C: free (vg_replace_malloc.c:985)
   by 0x17E0FE: queue_remove (queue.c:256)
   by 0x1497F0: conn_remove (btdev.c:537)
   by 0x15FC8A: cmd_big_term_sync (btdev.c:6427)
   by 0x15D19D: run_cmd (btdev.c:7269)
   by 0x16E7DF: process_cmd (btdev.c:7425)
   by 0x16E7DF: btdev_receive_h4 (btdev.c:7516)
   by 0x143AB9: vhci_read_callback (vhci.c:77)
   by 0x185AAE: io_callback (io-mainloop.c:110)
   by 0x187158: mainloop_run (mainloop.c:106)
   by 0x188357: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x4EA6B89: (below main) (in /usr/lib64/libc.so.6)


Compare: https://github.com/bluez/bluez/compare/a692cc44dc87...de8c249f785d

Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAD757FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987131; cv=none; b=fI8FJuU8780eUAr/sXoyEsVwiegoZ7Co9lcGHc334R7E1n+d1je/GlsJsJf5LIuojOfarWNlnJZTHcHfPNHT2rxov9MCx/R3knGPmxm2IRYX+SS7kh0md4vn/zQO40iBUc727E1YzF6v4kL9COEuCPuU7hrRd9jpdhTDQ+Lyw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987131; c=relaxed/simple;
	bh=s+FBqvQmG1SCstuHVtCGt2gVqrH+fmuUBOD8bBd86ag=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CV9v7WS29oX4HyyE334Mb3wF+tjfuRURMKU2uXmOdSmeP/3THmyLJQuG4/z6cfIundpAMpCSJxG3h9q3Yqj2LPy32YTUacR8wcG7v+GG3c/Vo/NmVvXKyTLhdIB+bdJA8/wNGaV5/DyzMQXYJIARQh1CsYP/n47jYgismLrO64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mTJqxhg1; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mTJqxhg1"
Received: from github.com (hubbernetes-node-1abcb8a.ac4-iad.github.net [10.52.156.38])
	by smtp.github.com (Postfix) with ESMTPA id AA53070087D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713987128;
	bh=HT1yQ1VuflzzsFno+gHSugd5Mfr0qC7KMGVTTwsdB3g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mTJqxhg1cqNXpHLLcBdGUuSxwmv70ta+7oafxpCQ9GwJwurs1DGanF4MGH/kMz7jb
	 Bli+Hmdrqup66pf5GP1MKgdhQbw/tjN5Fg/GwazS+896fcwnEEKZaq7b40upOeBbCo
	 RUmhJMKlhdLgrFzvTpk4jx/45lqQyagJfwFnCAnU=
Date: Wed, 24 Apr 2024 12:32:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/30b741-c42702@github.com>
Subject: [bluez/bluez] d8f3a3: gdbus: Add testing flags
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
  Commit: d8f3a3fa497f7beac81ac5b66323c4e77eec8dc4
      https://github.com/bluez/bluez/commit/d8f3a3fa497f7beac81ac5b66323c4e77eec8dc4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-23 (Tue, 23 Apr 2024)

  Changed paths:
    M gdbus/gdbus.h
    M gdbus/object.c

  Log Message:
  -----------
  gdbus: Add testing flags

This adds testing flags which are similar to experimental but are only
available for testing.


  Commit: e7578f9ddd079042e49f6ad69e64cc73d2abb72e
      https://github.com/bluez/bluez/commit/e7578f9ddd079042e49f6ad69e64cc73d2abb72e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-23 (Tue, 23 Apr 2024)

  Changed paths:
    M src/bluetoothd.rst.in
    M src/btd.h
    M src/main.c
    M src/main.conf
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  main.conf: Add support for testing interfaces

This adds support for D-Bus testing interfaces and testing profile
drivers.


  Commit: 02ade13c439fc3add8d5ec98f50e1f52f7b9816f
      https://github.com/bluez/bluez/commit/02ade13c439fc3add8d5ec98f50e1f52f7b9816f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-23 (Tue, 23 Apr 2024)

  Changed paths:
    M profiles/audio/ccp.c

  Log Message:
  -----------
  ccp: Mark plugin for testing

This makes ccp plugin for testing only rather than experimental since
it is only meant for test validation as platforms shall integrate CCP
directly into their telephony stack.


  Commit: 638774f603c2a216b8ec4a2866e1dfa37059918a
      https://github.com/bluez/bluez/commit/638774f603c2a216b8ec4a2866e1dfa37059918a
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Initialize bap_data for scanned device in bap_bcast_probe

By moving the bap_data initialization for a scanned device to
bap_adapter_probe() the adapter field of bap_data will already be set when
short_lived_pa_sync is called. When adapter will be changed for
bap_adapter, this will help eliminate an additional queue search (in
short_lived_pa_sync).


  Commit: aa7f3574f275ea2c9964c7725c2b419c0cadce20
      https://github.com/bluez/bluez/commit/aa7f3574f275ea2c9964c7725c2b419c0cadce20
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Replace adapter in bap_data with bap_adapter

This patch introduces the bap_adapter structure. In addition to btd_adapter
it also holds the pa_timer_id and the bcast_pa_requests queue associated
with that adapter. This enables convenient access to these variables since
the functions that need them already utilize bap_data.

For each adapter a new instance of bap_adapter is created and inserted into
the global queue, bap_adapters.

For each scanned source bap_bcast_probe searches the bap_adapters queue
based on the adapter and stores the result in the bap_data associated
with the source. Operations made on the old global queue are now made
on bap_data->bap_adapter->bcast_pa_requests queue.

While this commit sought to utilize the already existing bap_data in order
to avoid searching in queues, a lookup was still necessary in
bap_bcast_probe. Here, the bap_data for the scanned devices is created and
the bap_adapter field must be set to the appropriate value. There is no way
of getting the correct bap_adapter refference without searching the
bap_adapters queue.


  Commit: 48a69222581c604916e18285298cf9b13db1c7d8
      https://github.com/bluez/bluez/commit/48a69222581c604916e18285298cf9b13db1c7d8
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Improve handling of pa_req timer

The patch handles timers on a per adapter basis.

The timer is now also started on setup_accept_io_broadcast, so
BAP_PA_BIG_SYNC_REQ can be treated if the timer is stopped in the meantime.
The timer is stopped if the bap_adapter's pa_req queue is empty.
A pa_timer_id equal to 0 means that the timer is stopped.


  Commit: c7071911d57aa684f86f9458e33dfd9abb809c50
      https://github.com/bluez/bluez/commit/c7071911d57aa684f86f9458e33dfd9abb809c50
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Remove deleted devices from pa_req queue

The bap_bcast_remove function has been updated to remove from the
pa_req queue entries of devices that were freed. pa_req that are already
in progress are treated by the bap_data_free function.

The lookup in bap_bcast_remove was necessary. The entry corresponding to
the calling service must be removed from the pa_req queue. There is no
other way to get a refference to this entry other than to search in the
queue.

This patch fixes a crash that occurs when a device is freed before the
pa_idle_timer handles it's entry in the pa_req queue. The following log
was obtained while running an Unicast setup:

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996


  Commit: f141b27bcb526d1cd95d3301775808c9b011dcfe
      https://github.com/bluez/bluez/commit/f141b27bcb526d1cd95d3301775808c9b011dcfe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Reword bap_adapter/adapter and pa_req/req

Struct name already refers to the actual operation so don't repeat it
again on the variable name which just makes the lines long for no
reason.


  Commit: c42702cfc48e74d0d19a3d2f08049d2b5d0c85f4
      https://github.com/bluez/bluez/commit/c42702cfc48e74d0d19a3d2f08049d2b5d0c85f4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-24 (Wed, 24 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use of unintialized variable

This fixes the following trace found with valgrind:

Syscall param socketcall.setsockopt(optval) points to uninitialised byte(s)
   at 0x5318B0E: setsockopt (in /usr/lib64/libc.so.6)
   by 0x39C454: iso_set_qos (btio.c:899)
   by 0x39C622: bt_io_set (btio.c:1900)
   by 0x37F3B3: iso_do_big_sync (bap.c:2874)
   by 0x3991EC: server_cb (btio.c:265)
   by 0x3991EC: server_cb (btio.c:242)
   by 0x496C4FB: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7600.6)
   by 0x49CA6B7: ??? (in /usr/lib64/libglib-2.0.so.0.7600.6)
   by 0x496BAFE: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7600.6)
   by 0x4F9694: mainloop_run (mainloop-glib.c:66)
   by 0x4F9B27: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2BE8F2: main (main.c:1464)
 Address 0x1fff0004c1 is on thread 1's stack
 in frame #2, created by bt_io_set (btio.c:1870)


Compare: https://github.com/bluez/bluez/compare/30b741baa569...c42702cfc48e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

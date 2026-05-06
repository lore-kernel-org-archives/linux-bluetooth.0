Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB03FFAD6
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075804; cv=none; b=WdEgQh5bkvDQGeJ7WBkc7sqfcW0YYRiGXBlFoI3FXIX6X918Dai+4L7HWMm5H3vfaImc7z2L6hq2Cuieq9uBLvXToKCW8cNKEcvMob9eYQ54k1rgu85YIqQkB5+MShoxjHvSRdgMNbjHeRuTgWsRRHG7Qc118W8iyh6ti/e3iEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075804; c=relaxed/simple;
	bh=GVkGG2Sj8b+sEShDvIGHGDaLVgl5HL2rwpjY4qUnXSg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cibjXNMbsTacglIsDizxF/C/BhRol+R44LcJM7jZ9+SmXCw3iz1NRC3lLno2McSTkhhVoff3z3LZ7VF+t940E+bvMdI/E25EZAzmQdYpkVJnGlmmkKiBX533zmEwlIXsxlwdSZF4Tiaxg2JSpbt5IFGT0gy27mH69agIGNe90t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RsZwU+N8; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RsZwU+N8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778075801;
	bh=VlmlsR0YsZuDKsGXYI1ba8YlkL8Ju3NEeFxnknrL4yI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RsZwU+N8+RnKpqkCFl16LvtykTg94F6qnsuFif9Im3x9rHYs9bEmFQ/C2HqkWgiHG
	 N7XG9GiPn8uJ1Y40wO86RNJPhMw3z5h5/pb1rAcq2fUWzjWTeBuMAbUBnBiKhSPywu
	 d2wt18GdzJeOzLC1RYx0FiYX0HDAXD2g+VY58VEg=
Received: from github.com (hubbernetes-node-821ef3b.va3-iad.github.net [10.48.206.71])
	by smtp.github.com (Postfix) with ESMTPA id E51CC501242
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:56:41 -0700 (PDT)
Date: Wed, 06 May 2026 06:56:41 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/31e4fb-e51115@github.com>
Subject: [bluez/bluez] ccc22a: shared/hci: Add BPF filter for registered
 events
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
  Commit: ccc22a9193884ccc3c3cb2b7a7b90100187c20b5
      https://github.com/bluez/bluez/commit/ccc22a9193884ccc3c3cb2b7a7b90100187c20b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Add BPF filter for registered events

Implement a BPF socket filter in bt_hci_register/bt_hci_unregister that
uses setsockopt(SO_ATTACH_FILTER) to only accept HCI events that have
been registered, plus BT_HCI_EVT_CMD_COMPLETE and BT_HCI_EVT_CMD_STATUS
which are always needed for command response processing.

The filter is rebuilt each time an event is registered or unregistered,
and only applies to non-stream (raw socket) connections.

Assisted-by: Claude:claude-opus-4.6


  Commit: 98f7190cf6b9e918943deeacd2f1494c9ca0710c
      https://github.com/bluez/bluez/commit/98f7190cf6b9e918943deeacd2f1494c9ca0710c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h

  Log Message:
  -----------
  shared/hci: Add bt_hci_register_subevent for LE Meta events

Add bt_hci_register_subevent/bt_hci_unregister_subevent API that allows
registering for specific LE Meta Event subevents. The BPF filter is
extended to accept BT_HCI_EVT_LE_META_EVENT packets and then check the
subevent byte (offset 4) against registered subevents.

Since bt_hci_register_subevent is only used with BT_HCI_EVT_LE_META_EVENT,
the event parameter is omitted. The subevent list reuses struct evt where
evt->event stores the subevent code.

Assisted-by: Claude:claude-opus-4.6


  Commit: 45e1e7ca2243fdea4fb0f31ac56de2e9ee9e9c5b
      https://github.com/bluez/bluez/commit/45e1e7ca2243fdea4fb0f31ac56de2e9ee9e9c5b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  ranging/rap_hci: Use bt_hci_register_subevent for LE CS events

Replace the single BT_HCI_EVT_LE_META_EVENT registration and subevent
dispatch table with individual bt_hci_register_subevent calls for each
CS subevent. This enables BPF filtering at the socket level for each
specific subevent and removes the manual subevent dispatch logic.

Event IDs are stored in a struct queue for flexible management.

Assisted-by: Claude:claude-opus-4.6


  Commit: 3502f9f51704acf8035b30e748462dd0fbf10be8
      https://github.com/bluez/bluez/commit/3502f9f51704acf8035b30e748462dd0fbf10be8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M tools/hci-tester.c

  Log Message:
  -----------
  hci-tester: Use bt_hci_register_subevent for LE Meta events

Convert all bt_hci_register(BT_HCI_EVT_LE_META_EVENT) calls to use
bt_hci_register_subevent with the specific subevent code. Update
callbacks to work with data that no longer contains the subevent byte
prefix, since bt_hci_register_subevent strips it before dispatch.

Assisted-by: Claude:claude-opus-4.6


  Commit: fda84f7004fa4f1173c6482ac19973e1e7891655
      https://github.com/bluez/bluez/commit/fda84f7004fa4f1173c6482ac19973e1e7891655
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add features bits defined in 6.2

This adds features bits defined as per core spec 6.2:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1


  Commit: 79cfd07224ff3e2dc9828bdcb795fc49120da3f3
      https://github.com/bluez/bluez/commit/79cfd07224ff3e2dc9828bdcb795fc49120da3f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Short Connection Interval feature

This adds deconding support for SCI related commands, command bits, event
event mask bit and feature bits:

Events:

HCI_LE_Connection_Rate_Change(0x37)

Commands:

HCI_LE_Connection_Rate_Request(0x20a1)
HCI_LE_Set_Default_Rate_Parameters(0x20a2)
HCI_LE_Read_Minimum_Supported_Connection_Interval(0x20a3)


  Commit: 6aa7f5b4e0224e8b6668d7b9787d11d443ec72fd
      https://github.com/bluez/bluez/commit/6aa7f5b4e0224e8b6668d7b9787d11d443ec72fd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: Fix crash if hciemu_client_new return NULL

The following crahs can be observed if hciemu_client_new fails:

 Invalid read of size 8
   at 0x12DA79: queue_get_entries (queue.c:356)
   by 0x118434: hciemu_get_client (hciemu.c:277)
   by 0x1184A3: hciemu_client_get_host (hciemu.c:301)
   by 0x11536B: setup_powered_common (l2cap-tester.c:1452)
   by 0x11568E: setup_powered_client (l2cap-tester.c:1491)
   by 0x1324C6: setup_callback (tester.c:500)
   by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x133868: mainloop_run (mainloop-glib.c:65)
   by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x13325F: tester_run (tester.c:1085)
  Address 0x4c1e388 is 8 bytes inside a block of size 32 free'd
   at 0x483CA3F: free (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x1187BF: hciemu_new_num (hciemu.c:437)


  Commit: d0d42d034f9f7be3e743f885366becb758f19bde
      https://github.com/bluez/bluez/commit/d0d42d034f9f7be3e743f885366becb758f19bde
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/vhci.c

  Log Message:
  -----------
  emulator/vhci: Add debug messages to error paths

Add debug_callback, debug_destroy and debug_data fields to struct vhci
so vhci_set_debug stores the callback locally in addition to passing it
to btdev. Introduce a variadic vhci_debug() helper using util_debug_va
and add debug messages to the following error paths:

 - vhci_write_callback: failed io_send
 - vhci_read_callback: failed read
 - vhci_debugfs_write: failed open and failed write


  Commit: d4c965eec4d391d835b8884aed6f36d343ff73af
      https://github.com/bluez/bluez/commit/d4c965eec4d391d835b8884aed6f36d343ff73af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  emulator/hciemu: Add debug messages to error paths

Introduce a variadic hciemu_debug() helper using util_debug_va and add
debug messages to the following error paths:

 - create_vhci: failed to open vhci
 - hciemu_client_new: failed to create btdev, bthost, or socketpair


  Commit: 164941a6c145b1ad9590faadc547de60bda4f020
      https://github.com/bluez/bluez/commit/164941a6c145b1ad9590faadc547de60bda4f020
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/gap-tester.c

  Log Message:
  -----------
  tools/gap-tester: Enable hciemu debug output

Add print_debug callback and call hciemu_set_debug when debug output is
enabled so that hciemu error paths are visible during test runs.


  Commit: e51115ccd4dfd8ea9dc7662240c20d7703464a45
      https://github.com/bluez/bluez/commit/e51115ccd4dfd8ea9dc7662240c20d7703464a45
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/userchan-tester: Enable hciemu debug output

Call hciemu_set_debug when debug output is enabled so that hciemu error
paths are visible during test runs.


Compare: https://github.com/bluez/bluez/compare/31e4fb1498f4...e51115ccd4df

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

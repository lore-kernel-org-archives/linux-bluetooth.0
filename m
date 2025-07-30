Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA62BD03B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883674; cv=none; b=AvCRc6yBO3Kqnp4XZ+dvMvEYoKC+hrMecrAcHsB3nlO+U0ubCJofwttSD0vq6BM1V+w3r8wyzdml9Hg8lQ6YfYbZ1fG6hW6FuIGIeP2UYIgn4a1ZHpHmgwiy8g7aVEXS1LcBtdYMEVe7yMNpB03PCnfY3oqrkDbb1YvAmH4AqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883674; c=relaxed/simple;
	bh=IuUuVG7zJQsROiiNcwkaWBDlHdmOe4cupzSE310ZzhU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gxuoh0wisGOmvfK39e7/jaM4weRw0UJVQIcSIiPb8RaI9Q+4OSNdaTbrUANpIHV3mDq9CsJ61TqE8h234IUALfc+7K/EOvN9Gfaehsy9OkB6bc4/7ZYqc0FHJH9ipRZzxioSFrzOFHoOX9+aO930/s+kpTBr0vYjO2+i1AsTQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ErAyLAN2; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ErAyLAN2"
Received: from github.com (hubbernetes-node-bebdce1.ash1-iad.github.net [10.56.159.38])
	by smtp.github.com (Postfix) with ESMTPA id D1A52921236
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753883671;
	bh=+Qpv3dlTjHrVA+wB6LUL4EkFboxZlc0PWJdI0VeAO9w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ErAyLAN21IbINZ13uthN4wiFgJkNa4Fll40luhvU4qJ/c5ZngI5jLZUSAxT1WHuHp
	 gs5mEdRuQmerb6GpUhugQAN/CV0bWG2wEntMXAsMmnqRwkXidLY4Bj/rm8lsLWMY63
	 CnrisE7nfdkozFRtfRx7wYkSnFEHMvcKFU1gjydc=
Date: Wed, 30 Jul 2025 06:54:31 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0084cf-2c0c32@github.com>
Subject: [bluez/bluez] 280c95: btdev: Fix checking for PA on
 BT_HCI_CMD_LE_TERM_BIG
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
  Commit: 280c9523a490e8ed6d609b8b0d8bfde51013e48b
      https://github.com/bluez/bluez/commit/280c9523a490e8ed6d609b8b0d8bfde51013e48b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix checking for PA on BT_HCI_CMD_LE_TERM_BIG

BT_HCI_CMD_LE_TERM_BIG does not require PA to be enabled.


  Commit: 165e57e744e6bc3d879f4b9870f58284b6d38cf6
      https://github.com/bluez/bluez/commit/165e57e744e6bc3d879f4b9870f58284b6d38cf6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix crash when Broadcast endpoint exit

The following crash can be observed when a Broadcast endpoint exit
when a bap_setup exists:

Invalid read of size 8
   at 0x4075B30: set_configuration_ready (bap.c:1120)
   by 0x40766C3: setup_ready (bap.c:748)
   by 0x407809C: setup_free (bap.c:998)
   by 0x4078301: bap_state_bcast_src (bap.c:3012)
   by 0x41319DF: bap_bcast_set_state (bap.c:2392)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x4131AA3: bap_bcast_set_state (bap.c:2404)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x412D0E6: bap_bcast_release (bap.c:2543)
   by 0x41314EF: bt_bap_stream_release (bap.c:6518)
   by 0x4131607: remove_lpac_streams (bap.c:4348)
   by 0x4108444: queue_foreach (queue.c:207)
 Address 0x56f7758 is 8 bytes inside a block of size 16 free'd
   at 0x4B85E43: free (vg_replace_malloc.c:989)
   by 0x407472D: setup_config (bap.c:1778)
   by 0x407A869: set_configuration (bap.c:1175)
   by 0x4102A8F: process_message (object.c:293)


  Commit: 13e0776cef76aaa956ec507f6f6f60928ceadda5
      https://github.com/bluez/bluez/commit/13e0776cef76aaa956ec507f6f6f60928ceadda5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add Reconnect test for Broadcaster

This adds the following test:

ISO Broadcaster Reconnect


  Commit: 077de3f8639f095ee1c2ff6aabf9e4c4e3a141c0
      https://github.com/bluez/bluez/commit/077de3f8639f095ee1c2ff6aabf9e4c4e3a141c0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix possible crash with Broadcast Sink

If the remote terminates the BIG Sync the following crash is observed:

Process terminating with default action of signal 11 (SIGSEGV)
 Access not within mapped region at address 0x8
   at 0x40781C6: setup_free (bap.c:1024)
   by 0x4078EB8: bap_state_bcast_sink (bap.c:3118)
   by 0x41319DF: bap_bcast_set_state (bap.c:2392)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x4131CBA: stream_io_disconnected (bap.c:6597)
   by 0x414A079: watch_callback (io-glib.c:173)
   by 0x4149EE9: io_err_watch_dispatch (io-glib.c:380)
   by 0x4C9587F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x4C9E7C7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x4C9EA6E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.3)
   by 0x414ABED: mainloop_run (mainloop-glib.c:65)
   by 0x414B1C4: mainloop_run_with_signal (mainloop-notify.c:196)


  Commit: f086b3d27c4141d45017342f3450a3d078cc4d27
      https://github.com/bluez/bluez/commit/f086b3d27c4141d45017342f3450a3d078cc4d27
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix sending BT_HCI_EVT_LE_BIG_SYNC_LOST with wrong BIG handle

BT_HCI_EVT_LE_BIG_SYNC_LOST must be sent with the BIG handle used by the
remote peer which may be different than the one use with
BT_HCI_CMD_LE_TERM_BIG.


  Commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
      https://github.com/bluez/bluez/commit/2c0c323d08357a4ff3065fcd49fee0c83b5835cd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-30 (Wed, 30 Jul 2025)

  Changed paths:
    M profiles/battery/battery.c

  Log Message:
  -----------
  profiles/battery: handle reversed ordering of CCC and value

Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
This causes device to appear with 0% or missing battery percentage,
because batt->percentage is set on the ignored update so the initial
update is lost.

Fix by saving new initial value, if battery is not registered.  Also
downgrade warning to debug message.

Also check data length before parsing it.

Log (Sony Linkbuds S):

src/shared/att.c:can_read_data() (chan 0x7c31eea05c50) ATT PDU received: 0x1b
profiles/battery/battery.c:parse_battery_level() Battery Level updated: 87%
profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
profiles/battery/battery.c:batt_io_ccc_written_cb() Battery Level: notification enabled


Compare: https://github.com/bluez/bluez/compare/0084cfe5634b...2c0c323d0835

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC124290D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817913; cv=none; b=qARl5TeduSdB7nkDDJazjYOIL7g0Ks3fIV2YuZGZXityEp+J8GX1RTutoIuof1qNgMQVJ9xyoyuY6hnY419ac9GPA05VuB7vnCYX/OllFZyc6VcAsWTiiGX+PCr0AN515ikoougyCKOU4EXJx6j5S/nke+WVVl4bqYvATOP5swE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817913; c=relaxed/simple;
	bh=JuwxyfSQAijv77MhFVj/Gd4AkEM3hD/sGteFJwnQIOw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dhyaJ7QL6iGklrMP/aZIXvwxPtDLswajZebOoXhKgYsNfRDLIpQPMEG7pzRawsqYce5kI30JzS1iSSXpAuaCBeEFuKokW36/CPXmI+/lYs/v8kyjH/Rxqq0gRXPGNelP4M0LwFthk2kN3ufzGRB/bKFk8Wr7jHuUMplT0Ng3oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S2GG5bL7; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S2GG5bL7"
Received: from github.com (hubbernetes-node-53d805e.va3-iad.github.net [10.48.165.11])
	by smtp.github.com (Postfix) with ESMTPA id AD2F08C02D3
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753817910;
	bh=OTb/UIP9L0DxDs0xF1ZHo3yfTRVf1m7Y02eKwqSKFb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S2GG5bL75f2aF1SbUAD8fsB/9A2glE5dYn4XuAnTTKaTP1i7vb19hSdKWIOsFamWH
	 80n2fpWOMzP9QQ4TR/oSsmCbzdf2yr7iFKCPGw95AuO/ziR6mFxOfNcPg3tZR6vvcf
	 WeVXEkQDWys11tmnBU8pEH/wBvXRZ5e2bm9Se5W4=
Date: Tue, 29 Jul 2025 12:38:30 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/986829/000000-b5136d@github.com>
Subject: [bluez/bluez] 4203b7: btdev: Fix checking for PA on
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

  Branch: refs/heads/986829
  Home:   https://github.com/bluez/bluez
  Commit: 4203b7c2d789256404a3636208a9fe0fd81ccd50
      https://github.com/bluez/bluez/commit/4203b7c2d789256404a3636208a9fe0fd81ccd50
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix checking for PA on BT_HCI_CMD_LE_TERM_BIG

BT_HCI_CMD_LE_TERM_BIG does not require PA to be enabled.


  Commit: c6774b46c28cd58c33ec21c386d21dd8a207b62f
      https://github.com/bluez/bluez/commit/c6774b46c28cd58c33ec21c386d21dd8a207b62f
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


  Commit: 829a20e97913777e18f62f72b9526a4701e5ea15
      https://github.com/bluez/bluez/commit/829a20e97913777e18f62f72b9526a4701e5ea15
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-29 (Tue, 29 Jul 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add Reconnect test for Broadcaster

This adds the following test:

ISO Broadcaster Reconnect


  Commit: d22af62eb03b20755e9a1f524f02473fe6a4484e
      https://github.com/bluez/bluez/commit/d22af62eb03b20755e9a1f524f02473fe6a4484e
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


  Commit: b5136db3162922e6f95a883ba8fe101183758890
      https://github.com/bluez/bluez/commit/b5136db3162922e6f95a883ba8fe101183758890
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


Compare: https://github.com/bluez/bluez/compare/4203b7c2d789%5E...b5136db31629

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

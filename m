Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984C21B195
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111159; cv=none; b=b0EmmCZnqedDx5JlXDrNJEqsnB5jMy/57LwmuXlq8IicDdRGfjGUrekhQF9H9FtucIbeGXwskKI7se/KLfZid5371AszrZzhcXEBv43B8/1ag3sQ1gt263T+1gI+bn5JP34ZbB8b4o266tNAd/B2hapZWxuQrchSiCoBzXplM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111159; c=relaxed/simple;
	bh=kRNgqA6SOhyDQZ0dDcF3eDIVSYAqC0jdsKm3C1c90xM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RmjrHmkhQ2pjUjL/2rU8cx7x+GSWmflG3sjE0T363Ehc83rL9wEc66SyVDnZGtjfcdOx9S3wsPXcTGv6+yFHfAxXAgF7DKgjgZA67E81bmOEiv9SSSTVG0DZeC+iFCPWsfoN0xzPF4SQ+zgRHgWj1W98WpJ6vE25c5EoZ3i32sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fVQY9JsI; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fVQY9JsI"
Received: from github.com (hubbernetes-node-e39d022.ac4-iad.github.net [10.52.146.36])
	by smtp.github.com (Postfix) with ESMTPA id E34327008F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750111156;
	bh=faA4eW4SB8Txr5adp4ZziWm+MHrbBmu925U0Ag+v6Hw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fVQY9JsIsQbaTvXHmFN7T2nKrgnEc0ymcuCgwfGEnzUrVOtCtk3uDPlnrZneHNB7l
	 X9yCrtvLpE2XX4FLHPYXqRUbR8l0LCj5ucnxmcYsYdE5kUywWcGcC51ADEJlrjshPc
	 58nemyFku3HiNsL1IbpKdN1zojMW/7ztDOZtqXSM=
Date: Mon, 16 Jun 2025 14:59:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6bc584-dc8db3@github.com>
Subject: [bluez/bluez] 3c20aa: iso-tester: Fix crashing while attemping to
 access...
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
  Commit: 3c20aa6c2ff1980f82c9546117be898515088a37
      https://github.com/bluez/bluez/commit/3c20aa6c2ff1980f82c9546117be898515088a37
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix crashing while attemping to access isodata

Some tests may not set any isodata causing the following crash:

Invalid read of size 1
   at 0x40067A8: setup_powered_callback (iso-tester.c:1691)
   by 0x40232D5: request_complete (mgmt.c:306)
   by 0x40242B3: can_read_data (mgmt.c:394)
   by 0x4028529: watch_callback (io-glib.c:173)
   by 0x493D87F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x49467A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x4946A4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x402ABFD: mainloop_run (mainloop-glib.c:65)
   by 0x402B1D4: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x402A3F5: tester_run (tester.c:1076)
   by 0x40050FE: main (iso-tester.c:4010)
 Address 0xa8 is not stack'd, malloc'd or (recently) free'd


  Commit: be36a9c9d3af691fdddd13d70db6f1e3f9663bef
      https://github.com/bluez/bluez/commit/be36a9c9d3af691fdddd13d70db6f1e3f9663bef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Make bt_gatt_client_read use bt_gatt_client_read_long

This makes bt_gatt_client_read use bt_gatt_client_read_long since the
later does use BT_ATT_OP_READ_REQ for reading the first chunk, so they
are actually equivalent in this respect, but bt_gatt_client_read_long
detects when the data returned maybe truncated due to MTU and then
proceed to use BT_ATT_OP_READ_BLOB_REQ to read the remaining chunks
which is a disarable behavior since there is no property indicating
when an attribute would require long read procedure.


  Commit: 5018c40edbb2c75c23ca54df5b7d907d80450a0a
      https://github.com/bluez/bluez/commit/5018c40edbb2c75c23ca54df5b7d907d80450a0a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Fix not using metadata set on stream->meta

bt_bap_stream_metadata maybe used before enabling state in which case it
will be store in the stream->meta so when processing
bt_bap_stream_enable if there is no metadata set use the existing one
set in stream->meta.


  Commit: dc8db3601001de9a085da063e0c5e456074b8963
      https://github.com/bluez/bluez/commit/dc8db3601001de9a085da063e0c5e456074b8963
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M client/player.c
    M client/scripts/preset-custom.bt

  Log Message:
  -----------
  client: Add prompt to enter metadata for custom presets

When adding a custom preset prompt the user to enter metadata for it
e.g.:

[bluetoothctl]> endpoint.presets 00002bcb-0000-1000-8000-00805f9b34fb 0x06 custom
[Codec] Enter frequency (Khz): **
[Codec] Enter frame duration (ms): *
[Codec] Enter channel allocation: *
[Codec] Enter frame length: **
[Metadata] Enter Metadata (value/no): <len> <type> <value...>


Compare: https://github.com/bluez/bluez/compare/6bc584b11b8b...dc8db3601001

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

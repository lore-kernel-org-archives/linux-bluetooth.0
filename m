Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620142FFF90
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973522; cv=none; b=pPeD8G1t2WARvV5hrWnqLBbPoCh8/QueJJAIZ41WKOTgwBQu4wu+o68V989XBXYU2ORKgOBUMC6ryvleZ/ABWHm2PZd5NjY9r9uyEZAWz9Z3nt/Sr7RyUKBd9QyjlTnpBVgYypCUqpHBJnW8BZ96RSzHHukdHX0QkJENNn4DDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973522; c=relaxed/simple;
	bh=wo6Iee8f0VpsaionY1bF2DBftKVaiimmAtQDgMAMlgA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wboyd5r3aE0ul/pd9yCDDtcTKhmHvG16woJY5+xSYG5Q/snQ/HATdThGRe6VTVsecXuxqV2aYOh7MtuF6L4bBAR8NxpQ8pHIACIh6J5WzAezjTwHJUmrM5jPXqqmfGi73gG98V7wI4pUmWZqr2+oYJwQb1Ey/2YCHpYB6iaZpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ldeb10oc; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ldeb10oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783973520;
	bh=wcHX+bFMb/GfL4gAx4TlVqR3U5U1Z6Kxp+Bs/Ap7W60=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ldeb10oc9UWcjbpQgk42C+O8r17M6Hv3nlrGTbkoIBvTi1scrqvMpiyZaxjWeiHOL
	 22Vb3MKmmOfTX+/19JTwb2K9przMMjIx4gSXrCAc2T9pLsL+g/Kug3qRZJB8qfthWX
	 UA3sigGu/KJJ3g3/m+sbog7vWGJqJPBLjhQWj24Q=
Received: from github.com (hubbernetes-node-b8c23bd.ash1-iad.github.net [10.56.130.83])
	by smtp.github.com (Postfix) with ESMTPA id 9BB209211BD
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:12:00 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:12:00 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b7d71e-1309d5@github.com>
Subject: [bluez/bluez] 2a3d3b: monitor: Fix printing subpages bits after all
 subp...
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
  Commit: 2a3d3b0e6f83516736c3c8191fb9440475171600
      https://github.com/bluez/bluez/commit/2a3d3b0e6f83516736c3c8191fb9440475171600
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix printing subpages bits after all subpages

This fixes printing the decoded subpage bitfields after all subpages
rather then after the subpage itself:

before:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
        Features[1/1][8]:
        00 00 00 00 00 00 00 00                          ........
        Features[1/2][8]:
        00 00 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)

after:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)


  Commit: 0f2f53fd04d4eb73801de1f8ca16a40e3b12c034
      https://github.com/bluez/bluez/commit/0f2f53fd04d4eb73801de1f8ca16a40e3b12c034
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  tools/sco-tester: fix missing clear of io_id in callbacks

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it


  Commit: 9353c0ea9f6c1bacff00d9afef0d963796d86bd3
      https://github.com/bluez/bluez/commit/9353c0ea9f6c1bacff00d9afef0d963796d86bd3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  tools/6lowpan-tester: fix race in Client Connect - Disable

It's possible client_l2cap_disconnect_cb() is called after 6lowpan
disable on connect. Prevent failing test in finish_step() in this case.


  Commit: ba08e0f6be0f2ac17de3c0609c64e1d1acaa1563
      https://github.com/bluez/bluez/commit/ba08e0f6be0f2ac17de3c0609c64e1d1acaa1563
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  tools/6lowpan-tester: add test for VHCI teardown without disable

Check 6lowpan teardown when controller disappers with active devices.
Add test

Client Connect - No Disable


  Commit: 1cfe2d8b2cbb8c645439464a217053d3cdc41e5f
      https://github.com/bluez/bluez/commit/1cfe2d8b2cbb8c645439464a217053d3cdc41e5f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: fix Set PHY test spurious failures

Setting BT_PHY does not take effect instantaneously as kernel waits for
controller, so checking getsockopt() sometimes fails here. In PHY tests,
use retry with timeout to check again later.


  Commit: 7f826d003ee7bc07698ddecf804697d55e7b9c86
      https://github.com/bluez/bluez/commit/7f826d003ee7bc07698ddecf804697d55e7b9c86
  Author: Ferose <ferose2@gmail.com>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix rejecting re-attach of the same fd

When the remote's STREAMING ASE notification arrives before
iso_connect_cb() fires, the race handler in bap_state()
(profiles/audio/bap.c) already attaches the io to the stream; the
comment there notes "Order of STREAMING and iso_connect_cb() is
nondeterministic". When iso_connect_cb() then calls
bt_bap_stream_set_io() with the same fd, the guard in
bap_ucast_set_io() sees an attached, non-connecting io and returns
false. iso_connect_cb() treats that as fatal:

  profiles/audio/bap.c:iso_connect_cb() Unable to set IO
  profiles/audio/transport.c:bap_state_changed() Unable to get stream IO

and tears down a CIS that btmon shows was established successfully
(CIS Established status 0, both ISO data paths set up). With a device
whose STREAMING notifications consistently win the race, streaming is
never possible.

Treat re-attaching the fd that is already attached as a no-op success,
without re-running the per-stream state actions (which would send a
duplicate Receiver Start Ready to a linked source ASE). Attaching a
different fd to a non-connecting io remains an error.

Fixes: https://github.com/bluez/bluez/issues/2223


  Commit: bc49d63210f23e0724e07f3e5838aff05fbaa4aa
      https://github.com/bluez/bluez/commit/bc49d63210f23e0724e07f3e5838aff05fbaa4aa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: add iso_data_* macros to hci.h

Add macros for parsing ISO Data Packet header items.


  Commit: 1309d5f9305d132bc09705ffa4afa113c6491c2b
      https://github.com/bluez/bluez/commit/1309d5f9305d132bc09705ffa4afa113c6491c2b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix parsing of ISO packet data header and slen check

Check PB flag to see whether timestamp and data headers are present.

Check bounds before accessing data. Bump handle_str length to fit
maximum.

Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
SDU length check, as we are not tracking fragmentation.

Fixes: https://github.com/bluez/bluez/issues/2292
Assisted-by: GLM-5.2


Compare: https://github.com/bluez/bluez/compare/b7d71e506785...1309d5f9305d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

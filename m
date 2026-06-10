Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DC348C64
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119305; cv=none; b=rdEch7FwRYVRGu32F123V5JeOCjPDFJiD/SjaYDcl/g2uvHA/EJ5HvmmB0ig0JeQBbBH+nCeKSGYhqHe+WGicp5V3f7szpeq+23ary4pPXBJUkow/FvIiP7ZgiKX286I2uf/hw9Zy1FanVuOdMA2VOY9i/EwFfYsu3Y+gbTf8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119305; c=relaxed/simple;
	bh=qtD7hx3ISn2yW/Tv35oxiNe9E/SR4EHTTaVUwwKZX4Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uJ9At+5XLISyYKK+muy/OZSt5u/0ElsIrEyt8U16Kovi5XeP6/nddcQMb2IcNaEhR9+5LYOZVZjYfF8yKBxz1tXeVAhBRK9GWx4b2/o8EAqFPWVap0lddI6qOFwQUyIbCeUQTTyM1ZQBIVthwLRqxzS0j3t+3feIgUQXV/dpQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A0TqXU2W; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A0TqXU2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119303;
	bh=CO9ZaNk8eWgW1E8N2NYYbNE7jr9KBBjamd1QTg+cg2Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A0TqXU2WuwIckaEDrnzD1IlYYe08AneuuZ9HIDTDKMekl3ifCTMwIn4EKQfC2A2Vl
	 ZIArLs45ZUwOS+nnuAxp6QE4J6EzINbxIMx/HQLhjB3ervx+fmPSdlsejOnaQTsZ2w
	 rL3+hs99QTsIxgvT4dAKOAf51gHo5uC/b76MJPOA=
Received: from github.com (hubbernetes-node-dac00aa.va3-iad.github.net [10.48.14.33])
	by smtp.github.com (Postfix) with ESMTPA id 981F950103A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:21:43 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:21:43 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/912d67-5d836f@github.com>
Subject: [bluez/bluez] ea4b49: btio: handle error from broadcast ISO socket
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
  Commit: ea4b494414f60beda3cf69aef9278354c07b74f1
      https://github.com/bluez/bluez/commit/ea4b494414f60beda3cf69aef9278354c07b74f1
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: handle error from broadcast ISO socket

If not handled, server_cb() will be stuck in endless loop of calling
accept() on the socket.


  Commit: 6ea27ab0dcfc1ac38467d8e88ceccb5784494cb5
      https://github.com/bluez/bluez/commit/6ea27ab0dcfc1ac38467d8e88ceccb5784494cb5
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: log errors in BIG sync


  Commit: 8c580d30d2655f75796c31ca0d496ffd1578cb46
      https://github.com/bluez/bluez/commit/8c580d30d2655f75796c31ca0d496ffd1578cb46
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Handle EOPNOTSUPP from accept() to prevent busy loop

When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
(e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
retrying will never succeed. Previously, only EBADFD was treated as
fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
remains readable, this creates an infinite busy loop that hangs
bluetoothd.

Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
GLib IO watch and stop the loop.


  Commit: abf0911e25ef414f06b895b22a6a9aa05c03360e
      https://github.com/bluez/bluez/commit/abf0911e25ef414f06b895b22a6a9aa05c03360e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Check if bearer is enabled on registration

btd_profile_register now verifies that the profile's bearer type is
compatible with btd_opts.mode before registering. If the required bearer
is not enabled (e.g. LE-only profile when mode is BR/EDR, or BR/EDR-only
profile when mode is LE), registration is rejected with -ENOTSUP.


  Commit: 7b5895d8063505798ec5988a4b3bb545834afb1a
      https://github.com/bluez/bluez/commit/7b5895d8063505798ec5988a4b3bb545834afb1a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M profiles/audio/hfp-hf.c
    M profiles/audio/micp.c
    M profiles/input/manager.c
    M profiles/network/manager.c
    M src/gatt-database.c

  Log Message:
  -----------
  plugins: Check btd_profile_register return value

Ensure all plugin init functions check the return value of
btd_profile_register. If registration fails (e.g. bearer not enabled),
the plugin init propagates the error instead of continuing with an
unregistered profile.


  Commit: 8c821a150b8f5319b8201b5e7d8fdaa6a67d3bd1
      https://github.com/bluez/bluez/commit/8c821a150b8f5319b8201b5e7d8fdaa6a67d3bd1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Check btd_opts.mode on btd_bearer_new

Only create the bearer interface if the corresponding transport is
enabled. Return NULL if BREDR bearer is requested in LE-only mode or
LE bearer in BREDR-only mode, so the D-Bus interface is never
registered for unsupported bearers.


  Commit: 39ad431de60b896a03904887a0f1d0285b719edd
      https://github.com/bluez/bluez/commit/39ad431de60b896a03904887a0f1d0285b719edd
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Return correct error when SEP is inuse

This fixes AVDTP/SNK/ACP/SIG/SMG/BI-08-C


  Commit: 249e2bedfacf51fc6c89f43a0adb9a12d761c2b7
      https://github.com/bluez/bluez/commit/249e2bedfacf51fc6c89f43a0adb9a12d761c2b7
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Abort continuing response on fragmented CT replies

Send AbortContinuingResponse when a Get Element Attributes reply
arrives fragmented, as the CT side does not reassemble fragments.

Fixes PTS test AVRCP/CT/RCR/BV-03-C


  Commit: 2e00b83c07885f960fc0d53568b4ab0091ffb09c
      https://github.com/bluez/bluez/commit/2e00b83c07885f960fc0d53568b4ab0091ffb09c
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Report invalid-length ASE CP write via notification

A zero-length write to the ASE Control Point returned an ATT error, but
ASCS requires the write to succeed at ATT level and the failure to be
carried by a CP notification. Build a response with the truncated error
code and return success instead.

Fixes PTS tests ASCS/SR/SPE/BI-01-C and BI-02-C


  Commit: 3047c2a4c5ea8313bcf5a9edbb18f9c9a187a7fd
      https://github.com/bluez/bluez/commit/3047c2a4c5ea8313bcf5a9edbb18f9c9a187a7fd
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M profiles/audio/transport.c
    M src/shared/bap.c

  Log Message:
  -----------
  transport: Complete Acquire for Sink ASE entering Enabling

On the QoS to Enabling transition the IO is not yet available because
the CIS is not established, so the handler returns early and a pending
Acquire is left unanswered once the IO later arrives.

Notify the connecting callbacks once the fd is attached so the
transport can re-run the Enabling handling and complete the Acquire.


  Commit: 5d836f1c697cde166981d31276e2dd828996f3e7
      https://github.com/bluez/bluez/commit/5d836f1c697cde166981d31276e2dd828996f3e7
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix failed bonding attempt after LE link disconnection

What happens when issue occurs:
- device is connected to both bearers BR/EDR and LE
- bonding is requested
- LE link disconnects
- pairing keys arrive

BlueZ would finish bonding request with error and mark device as
temporary. Then it would be disconnected+removed after default
temporary timeout (30 seconds).


Compare: https://github.com/bluez/bluez/compare/912d67d1d3a4...5d836f1c697c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

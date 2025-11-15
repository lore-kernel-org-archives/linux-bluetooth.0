Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14901DC1AB
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763212636; cv=none; b=jBEYD1/KEg2N52LnlCo87zq0ZoAiQXOccyn2N/K+iwwwOPtHFMGVnxUQ3VGGiOuFtT1wuMUJc16dBgO19rQDv4nnn7koEgNQ11F1vu3/t1iwxNA/oziqFLXr2qr88g/W8Gah/UUYNh1R8yd4UaiNNSX/YJl1dT7/JyFLU5xFjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763212636; c=relaxed/simple;
	bh=cmw/QMmzJRbSZMVP5AXm50UG3ykT4hQKJXAYpM7nqq4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m69lYxl/qh59bEMCbQjM+SwISid6UHLCcNWeYBJelkH87t2PSPFEftoAYCPnPFz9l26WxEOVbb18wKhVPhBt6LLIZw8F/SSEADLVanTbagL9Jfd01gB7sVxa/d0upSPIMvfnVA3f2y0CnKFCgjQ+l/+Q6Z7Ysg6wysuOKUN8P0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YcUhNbwG; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YcUhNbwG"
Received: from github.com (hubbernetes-node-b7767ca.ash1-iad.github.net [10.56.211.62])
	by smtp.github.com (Postfix) with ESMTPA id 0AD4814036E
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763212634;
	bh=dSBPTQNXflvbR31gWTKHHGg/2xV/Ln+B1PtanJNRCaI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YcUhNbwGSsEBtH74OMFDJhkl0eHd2wgD8PASjebIy0Uufb811oJ9Cmw88gl3K1EVc
	 j0f6FwRz/Xccc+kPkbsLsov5HZ2/lzeMNv7SC2bBlgE4DPWDIYrIPNvm13or19GDF0
	 lOG0sUnzPXJj2uDNiXEwtJdSnLR8X7O2JyEbk9iU=
Date: Sat, 15 Nov 2025 05:17:14 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023839/000000-64a912@github.com>
Subject: [bluez/bluez] 3d9089: shared/bap: fix channel allocation logic in
 bt_bap...
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

  Branch: refs/heads/1023839
  Home:   https://github.com/bluez/bluez
  Commit: 3d9089c41dc9b8c5cbc88f7fdd9408a6f68540f1
      https://github.com/bluez/bluez/commit/3d9089c41dc9b8c5cbc88f7fdd9408a6f68540f1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: fix channel allocation logic in bt_bap_select()

bt_bap_select() does not correctly determine the need for multi-stream
configurations 6,7,8,9,11(i), as its result depends on whether Audio
Locations is read before or after the PACs, doesn't work with general
location bits, etc.

Fix the procedure to be simpler: create streams for all locations, up to
a specific number of channels.  By default, limit to max 2 channels per
direction for compatibility (BAP doesn't have explicit AC with larger
channel counts.) Also simplify the code.

Ignore lpac Locations when selecting: the value mostly makes sense for
Unicast Server role, but Client and Server cannot use the same value as
only a few bits can be set. As Client, we should be able to configure
any Location bits.  The sound server can simply ignore our suggested
channel allocation if really needed, or use SetConfiguration() API to
build custom configurations.


  Commit: 6fed34c03367c0b190f77b2ede8abe3adc172a2e
      https://github.com/bluez/bluez/commit/6fed34c03367c0b190f77b2ede8abe3adc172a2e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()

bap_queue_req() forgot to account for ATT command headers when comparing
to MTU, and fail to send if packet too big. Fix the MTU comparison.


  Commit: 3adf59de03e2df36ef51e3554389b67bd38388c0
      https://github.com/bluez/bluez/commit/3adf59de03e2df36ef51e3554389b67bd38388c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: don't configure endpoints of all codecs at once

When device is connected we currently try create all streams for all
endpoints. If there are multiple (= vendor codecs), this likely causes
creating multiple streams for same location, which is not allowed.

Change it to create streams only for the first endpoint, for each
direction.

Sound server can later request switching to another endpoint if
necessary.


  Commit: 968570ca3ac400f933d3ac719a80dc678da15922
      https://github.com/bluez/bluez/commit/968570ca3ac400f933d3ac719a80dc678da15922
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: better debug output on io memcmp failure


  Commit: 4b1a20579d3c91d2e05cca1e4ecd6e0b4c040b70
      https://github.com/bluez/bluez/commit/4b1a20579d3c91d2e05cca1e4ecd6e0b4c040b70
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: make PDU macros parametrizable

Adjust PDU-forming macros, so that they can be used for connecting
multiple streams to parametrizable locations.


  Commit: 64a912da7f475c8594123c0d65c05f4b7beb3d6a
      https://github.com/bluez/bluez/commit/64a912da7f475c8594123c0d65c05f4b7beb3d6a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: add audio configuration selection and streaming tests

Add tests from BAP.TS 4.10.

The tests testing (ii) configurations only test configuration selection
with L/R separately. Can be filled in later to use two simultaneous BAP.

The difference between CIS Establishment at QoS vs. Enable is not
properly simulated, so only one variant is added.


Compare: https://github.com/bluez/bluez/compare/3d9089c41dc9%5E...64a912da7f47

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

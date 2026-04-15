Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6E373C04
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287591; cv=none; b=YeAIB+C/qM70lTUuGukM96GWYGMtfWz/EXHjfTg5sDx375w2wcP4q8iI7T2RgT6TvIp1TwvQMDhCmgDitz97PtsN75jYI12heNj6sYjB4cJiyFjXrh9m0nMfhHC0Ewhm2bzJzaPbiEwaIOqt4k2mwXpRXixKsylj9ahSWWN46Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287591; c=relaxed/simple;
	bh=DrDLBwKyG0Yzp59sgdGrdf7RFmLiX7fxhg5Ir+SYsOk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nJ14pzUxR1nm+t5dQSG1gdjZHWWb1C4hvPLS0rQKv98VMrDlypK3VJdDvJOzWaNQaGnh+E8sszPGh8ehL4b+KhrmJK72plDw6l4VBAkzXVLtW1y3oShpGf+s8VgJ2aUL/dac/U7ADgTDritQH2D1mOvQy304NJPg0rtOi6yZP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ikCQhE4w; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ikCQhE4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776287589;
	bh=3F4JwWIcXNB2aMpis6IogArQ5k3jIAoryReqo5JfJ9c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ikCQhE4wnFUmAvPLXlcHjOViyEBijtzKoAJoBPrSaIPf1dWTNfzaEnMT3FgR9lIug
	 ncsimYVVxJM0uBrsKOCUAs+QW00mFTkQknhU10fNhWwb6ci6a5qU5aDv/zAfwjZKw8
	 //SdiydVGJTrpFeblL/yeCJpAGKt2Y4vRDsze9Kg=
Received: from github.com (hubbernetes-node-02ef9e3.va3-iad.github.net [10.51.97.42])
	by smtp.github.com (Postfix) with ESMTPA id 076C2280FC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 14:13:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:13:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081747/000000-76d5b3@github.com>
Subject: [bluez/bluez] ae20c4: monitor: Add L2CAP channel details to analyze
 output
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

  Branch: refs/heads/1081747
  Home:   https://github.com/bluez/bluez
  Commit: ae20c44933a860640ee6fda24b47c6137a082a42
      https://github.com/bluez/bluez/commit/ae20c44933a860640ee6fda24b47c6137a082a42
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Add L2CAP channel details to analyze output

Enhance btmon analyze mode to display richer per-channel information:

- Add MTU, MPS, and mode fields to struct l2cap_chan
- Parse Configure Request/Response options for BR/EDR channels to
  extract MTU (option 0x01) and mode (option 0x04)
- Add l2cap_le_sig() to parse LE signaling (CID 5) for LE Credit
  Based Connection Request/Response and Enhanced Credit Connection
  Request, extracting PSM, MTU, MPS, and mode
- Display fixed channel names (ATT, L2CAP Signaling, SMP) for CID <= 7
- Show PSM in both decimal and hex format
- Print mode, MTU, and MPS for dynamic channels


  Commit: 846c8a570c4c0ac12377e85c4b60379778b847f0
      https://github.com/bluez/bluez/commit/846c8a570c4c0ac12377e85c4b60379778b847f0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Use wall-clock duration for throughput and add min/max speed

The previous speed calculation used the sum of per-packet latencies as
the denominator.  For TX, each latency measures the time from command
submission to completion event -- when multiple packets are in-flight
simultaneously these overlap, making the sum much larger than wall-clock
time and deflating the reported speed.  For RX the inter-arrival sum
roughly equals wall-clock time.  This asymmetry caused the same data
stream to report vastly different speeds depending on direction.

Fix by computing speed from wall-clock duration (last packet timestamp
minus first packet timestamp), which gives consistent results regardless
of direction.  Also add 1-second windowed throughput tracking to report
min and max speed alongside the average.


  Commit: 76d5b3aec064b8bba40ac04a8618f16ca5794f16
      https://github.com/bluez/bluez/commit/76d5b3aec064b8bba40ac04a8618f16ca5794f16
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

  Changed paths:
    M doc/btmon-l2cap.rst

  Log Message:
  -----------
  doc: Add throughput estimation section to btmon-l2cap.rst

Document the throughput statistics reported by btmon analyze mode,
including speed calculation methodology, channel details (PSM, mode,
MTU, MPS), and caveats about inter-packet latency vs wall-clock time.
Also document the windowed throughput approach used by btsnoop-analyzer.


Compare: https://github.com/bluez/bluez/compare/ae20c44933a8%5E...76d5b3aec064

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

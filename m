Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2434CDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348564; cv=none; b=EicdSgXh5WPrpZGA5o2rfkXLyXFXr4Lc7ROhRtlVZk0TF37McOYZhO67+06EIra9zHrNC8scYNOoukFjMKBitD9Lu25W184efpD9BMQ2FspdhwbN9plyOLOhCN5ksYJng5T2LRdVftcR2UUk/JmsiFI6Z/A8F+dpmTCWu1IB9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348564; c=relaxed/simple;
	bh=en6bMy/3liEdnR6YqQMt8MPhE23I9RPYiWx6XqGgVhY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YOU+FezFR8lu46wt7LaeNoEM/VgdYsJH32I+roXO0aGy29AMjY/z8nFUl9uEstbGL6v/N0MXC5mianVPx1gzxgaCctmtK1WV+19BuIJ0wNMI1YnTyvo6B4xRE0PpvIu+j6eTiEV/UkYW39RpOp7D40L1R+yYqZxVO9bBigumN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iX6ToLp9; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iX6ToLp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776348562;
	bh=ccFhBo3KOpXLOtzct9Q3F+gahvh0M/donRopSGCskKY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iX6ToLp9O6kWSExVGxHoI/cGKX9IoCys5YADkcBi41436cEmfg6c7q2f0QHm0Wt9I
	 6XGn2agJMYwCexOCIjktU/eJptrYz6+3YAV+TmzJzyuENemSnFIRq878w4C7kjSQAL
	 UXhUqESJ/miz3eC11wlU64ga++9pZpMl3ifsStKA=
Received: from github.com (hubbernetes-node-1eaabaf.va3-iad.github.net [10.48.222.42])
	by smtp.github.com (Postfix) with ESMTPA id 77192181136
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 07:09:22 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:09:22 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/510623-590bed@github.com>
Subject: [bluez/bluez] 6b4c21: monitor: Add L2CAP channel details to analyze
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6b4c21721c80ef09da17656920777a4f1a9bf293
      https://github.com/bluez/bluez/commit/6b4c21721c80ef09da17656920777a4f1a9bf293
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


  Commit: ebeceecd3ccb823d46427a975563987242eaa6f5
      https://github.com/bluez/bluez/commit/ebeceecd3ccb823d46427a975563987242eaa6f5
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


  Commit: f360d9e4428dde40de4ff6d33ef178752e13fc1a
      https://github.com/bluez/bluez/commit/f360d9e4428dde40de4ff6d33ef178752e13fc1a
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


  Commit: 590bed15fbaf7be93f5121fcdaf12992f234df13
      https://github.com/bluez/bluez/commit/590bed15fbaf7be93f5121fcdaf12992f234df13
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M Makefile.am
    M doc/btmon.rst

  Log Message:
  -----------
  doc: Add missing btmon-cs doc to btmon.rst


Compare: https://github.com/bluez/bluez/compare/510623fb53b5...590bed15fbaf

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

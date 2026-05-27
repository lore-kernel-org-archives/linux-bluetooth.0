Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5135F17D
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922064; cv=none; b=c2aTAMDiXkG6O+zPzq5k645Tr2KHOHSokhqtza3BxTgwSZonm09cbPfWZSZoFG41/Qne0gba4N0Cm7EY7MEld+HBOaoLH714YPv7j2bt6f16LGxAGDAzInDG5H4soYaLW/0vIGLxEWEqWiqqPUYpgtpY8CtSzqGWD/Werr8L6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922064; c=relaxed/simple;
	bh=RgtUEiqzzB8ED5FmYkSuw1sfMV9yVzziCO70rJYTlsA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MNb6jARjQ/rgMxYm86UFKsMTiSPyBjnthI0d4ObmqAMRh1b9cQYSycIYzwnBRMfhZcbJehanXRTrP60ql4Js5wOwCYRj1Fpgy3OpLEM/p9P7r4n8fzUUxglHfiju6TCEifD2vIWtM+cCCOZE4xPDaT16XkeW3M25Phnxoy7N73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fPXATu4u; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fPXATu4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779922062;
	bh=N2auGN7aKEb3u2+AIDGVp8iNQVsS6s8PXv6xZRqhRXg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fPXATu4uklbKS8Ray3/hl/fWgF4kQU9zjnGZSR11c6eaBHBYhpbLwWL0nVBWQmr0w
	 JPGdYhz9V+ds3C1vpKK/da4KEhr7/a0vzj7ivDltR/BmumYKc5PvrbxeilMAwFsfd9
	 GB8+ig3nNR2EdIcfzACStppdivyTb6RZQK8C2/bk=
Received: from github.com (hubbernetes-node-6c7363a.ac4-iad.github.net [10.52.142.32])
	by smtp.github.com (Postfix) with ESMTPA id B21E5A0AA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 15:47:42 -0700 (PDT)
Date: Wed, 27 May 2026 15:47:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b49316-68edaa@github.com>
Subject: [bluez/bluez] 0039e1: emulator/btdev: Add LE Set Host Feature V2
 command...
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
  Commit: 0039e1bec0a59ec3b3982113e06a0b16898b51b5
      https://github.com/bluez/bluez/commit/0039e1bec0a59ec3b3982113e06a0b16898b51b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-26 (Tue, 26 May 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator/btdev: Add LE Set Host Feature V2 command emulation

Add emulation for LE Set Host Feature V2 (0x2097) command which
uses a 16-bit bit_number field (vs 8-bit in v1) to allow setting
extended LE feature bits. The command bit is set at byte 47 bit 4
as defined in bt.h.

Assisted-by: OpenCode:claude-opus-4.6


  Commit: 68edaa560e92d5ee39bd97a80e20afbd2cde3c8f
      https://github.com/bluez/bluez/commit/68edaa560e92d5ee39bd97a80e20afbd2cde3c8f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-26 (Tue, 26 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for LE Set Host Feature V2

Add decoding support for LE Set Host Feature V2 (0x2097) command
which uses a 16-bit bit_number field to support extended LE feature
pages:

< HCI Command: LE Set Host F.. (0x08|0x0097) plen 3
        Bit Number: 32
        Features[0/0][8]:
        00 00 00 00 01 00 00 00                          ........
          Connected Isochronous Stream (Host Support)
        Bit Value: 1
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Host Feature V2 (0x08|0x0097) ncmd 1
        Status: Success (0x00)

Assisted-by: OpenCode:claude-opus-4.6


Compare: https://github.com/bluez/bluez/compare/b493164ffbff...68edaa560e92

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

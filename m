Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E491AF0BB
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623257; cv=none; b=qdb0t/ttSI+h9M3vBDwL/6kPLVqUR1mNzhQkYttVRE/mitddYyUERqRlXkmbWzUmIpCWJ39wVM51wLn6wSE8A57ZmHVqzBZ+KpSn6vOO/8C3b9/wXbyYtcB9rTC31v/krRtgF0hnPz5Q2JQhwedLCF4RPZHKuSO8O5m8j/6nCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623257; c=relaxed/simple;
	bh=+HzrsJm/cicDX+kW8yNsXV7xkL7ihAiokz7GgJaLxOM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H6UbFwqwUedGbw4fki6yS6xUZngb0y7feiYR0L1jqo9gespyLWBjLnMfptLC6JbjDqvxuW3hrvxXUY0Ol5YzBn9u/13opbtdgXdIq2hWED5ySeoUWRnv6NLSY/D05C8kFeFnWG2HzHxSphK7W/+eZh2L0Kdw9D2jskkHosfo8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=XTXDgaY7; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="XTXDgaY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791623254;
	bh=bjELZdIc1DDIUtaDROz9Dn+aY8vm5kDp7wG16lWksAM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XTXDgaY79s5pQDbiOKJIsCWepSgysInpckO9hvvOnk1vCkoYXciyDgmjJwnFxER3a
	 pm74enLph4ostaZnGfJfdkvZ0/8XBDIMI543QaGGzo2s81focxxlukaJuO3M/v1hz+
	 nb8JDWcp2yhZWwDhfIHlhDyRzDhKn3OwIrgEWnKJvxiANk18MCIWk8zurXjuH+tR8u
	 7BVALFNe1DqpjuP5fZj+QrV9P/Nqq/sqbrGr3KU++wF+BGMUSHo6ktsnnhmMqSaATx
	 ttXmZVV9SNaeXem2wPhNNk6KWrX0+vlvFf/nkvgleUQ5Ct4qoliwQoSG4d55NgJkhq
	 dWrce7IJANKPQ==
Received: from github.com (hubbernetes-node-674fa17.ash1-iad.github.net [10.56.201.111])
	by smtp.github.com (Postfix) with ESMTPA id ADFC384097F
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:07:34 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:07:34 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182788/000000-17c1dd@github.com>
Subject: [bluez/bluez] b6ac5e: emulator: Add btdev_send_event
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

  Branch: refs/heads/1182788
  Home:   https://github.com/bluez/bluez
  Commit: b6ac5ee71f8a29a5b93dc01215ccc0f311e38acf
      https://github.com/bluez/bluez/commit/b6ac5ee71f8a29a5b93dc01215ccc0f311e38acf
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h

  Log Message:
  -----------
  emulator: Add btdev_send_event

Allow a tester to send an arbitrary event from the emulated controller,
for instance from a command hook, so that the order of events around a
command can be chosen by the test.


  Commit: ba334e6c32d4bcc3a9dbc1b863e40985c57c345a
      https://github.com/bluez/bluez/commit/ba334e6c32d4bcc3a9dbc1b863e40985c57c345a
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M emulator/vhci.c
    M emulator/vhci.h

  Log Message:
  -----------
  emulator/vhci: Add vhci_set_quirk_simultaneous_discovery

Set or clear HCI_QUIRK_SIMULTANEOUS_DISCOVERY through the kernel's
quirk_simultaneous_discovery debugfs entry, which only accepts writes
while the controller is down.

This entry name is the longest so far: its path does not fit in the
64 byte buffer of vhci_debugfs_write() from hci1000 on, so size the
buffer with PATH_MAX and use snprintf().


  Commit: 17c1ddcf1e0b078aa8d8ee9cf892e1c4e784bd38
      https://github.com/bluez/bluez/commit/17c1ddcf1e0b078aa8d8ee9cf892e1c4e784bd38
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add simultaneous discovery stop tests

With HCI_QUIRK_SIMULTANEOUS_DISCOVERY, kernels without commit
96d006ae6445 ("Bluetooth: hci_event: fix simultaneous discovery stuck
in FINDING") stay in DISCOVERY_FINDING when the Inquiry Complete event
arrives after LE Set Scan Enable (disable) was sent but before its
Command Complete: no Discovering (disabled) event is sent and every
later Start Discovery fails with Busy.

Both tests set the quirk through debugfs and send the Inquiry Complete
themselves: one second into the discovery (Simultaneous Inquiry First,
the normal order) or from the LE Set Scan Enable (disable) command
hook, before its Command Complete (Simultaneous Inquiry Late). The LE
scan timeout itself is not shortened. One second after that command a
new Start Discovery probes the state; a test fails if no Discovering
(disabled) event came before the probe or if the probe does not
succeed. Without the kernel fix the Late test fails. If the debugfs
entry cannot be opened, the tests are reported as Not Run.


Compare: https://github.com/bluez/bluez/compare/b6ac5ee71f8a%5E...17c1ddcf1e0b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

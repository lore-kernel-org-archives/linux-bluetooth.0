Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED33288513
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541829; cv=none; b=uslo6dZuBiPz5y0bYToj6c3/CuynA7XCLauphXa94oqRsPCPTxS3WoEuHvYr7OowgGkoy9HNp22aAac2p4601MufBaIWHNqYh1JDoI80o7zTvJ64+K0GZP0VhzPxYThh3tbK+Ga01pielAayw+Q7wRUWDkpGIoWUHEsJpNzJEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541829; c=relaxed/simple;
	bh=Yr3EgDlD0ZjFvZ6IabyHImW1brXKU9cd3fmvWq8M/cI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eF9B4qiZ71+HtInSjG5TYLDEFXfRSZplWw+HGm2ECMi5UdLgNck8OBtPYudMpTioQVlQe+6jjk89+C2Onheh25kW4+DC68BSvO2QlgZkGnF5IavfKhScSq1R9m2eahZ0G0mKjMsWv49PEP5hr9T0zkJcMbmlJLIBAOVJR8De4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VmJ1gZUs; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VmJ1gZUs"
Received: from github.com (hubbernetes-node-8e41b32.ash1-iad.github.net [10.56.194.54])
	by smtp.github.com (Postfix) with ESMTPA id CE517600820
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762541826;
	bh=fDRpOrjOpL5s3apzdcSHdFZ6ENEDxBY375KjpOCcgq8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VmJ1gZUsvMUCx/T0X+2eDGenjgjymBkHZD0X6c0E9VC5rVaCdRi3GvYmw/071xxn4
	 C/E6ovXcplamLg3029MfXIIQfyv0v9T17CyRUkmAmlo4cFDmxg9kMSggrNmsAM+F20
	 gL6zEEXO5WiB4AhodWK82A9DDg6/UIcuTg2T3VTo=
Date: Fri, 07 Nov 2025 10:57:06 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021045/000000-25ede9@github.com>
Subject: [bluez/bluez] 869383: emulator: Generate PA Sync Lost
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

  Branch: refs/heads/1021045
  Home:   https://github.com/bluez/bluez
  Commit: 869383e1f2e84bda2ba86ebbed3c031509a3ee20
      https://github.com/bluez/bluez/commit/869383e1f2e84bda2ba86ebbed3c031509a3ee20
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Generate PA Sync Lost

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.


  Commit: 4f7efd3da49706a7b4a51a6db9dc290ab78efb5c
      https://github.com/bluez/bluez/commit/4f7efd3da49706a7b4a51a6db9dc290ab78efb5c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Add support for terminating a BIG

This adds support for sending BT_HCI_CMD_LE_TERM_BIG via
bthost_terminate_big.


  Commit: 06607bce043ac3c291c153eb351e6fd7bb8b6fcd
      https://github.com/bluez/bluez/commit/06607bce043ac3c291c153eb351e6fd7bb8b6fcd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for checking proper handling of Sync Lost

This introduces the following tests to check if BIG/PA Sync Lost are
handled properly:

ISO Broadcaster Receiver Sync Lost - Success
ISO Broadcaster PAST Receiver Sync Lost - Success


  Commit: a0a0b839e0c0a522e1a6594b5cdd2733cf94c51b
      https://github.com/bluez/bluez/commit/a0a0b839e0c0a522e1a6594b5cdd2733cf94c51b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not cleaning up delegator properly

When BIG sync is lost, or the assistant modify removing all streams,
delegator should be freed to so the assistant can start over and share
another stream.


  Commit: 25ede9f3504721060506c81b6f1bcb43fd7c1848
      https://github.com/bluez/bluez/commit/25ede9f3504721060506c81b6f1bcb43fd7c1848
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix endless loop if accept return -EBADFD

In certain cases, e.g. ISO Broadcast Listen, the listening socket may
get into an invalid state (CONNECTED) if the PA Sync is terminated
causing an endless loop of accept syscall.


Compare: https://github.com/bluez/bluez/compare/869383e1f2e8%5E...25ede9f35047

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

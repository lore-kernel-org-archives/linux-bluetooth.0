Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4F204F7F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924299; cv=none; b=QsWIM/BQOXPVJYkizFgJldHAKeWBxiRIIva8nvqQi7/gYvzE/pqIoBVkB20X42/4lO0ZKnh9quuBy+r/YnD/ZPS6mLCToWm1qGEQuVDW6Uvl394P4ep1QIWZ7WendZt+UIo15NQJaIxoBkaPkkiVzUhef4KhiBxMR3/h5u77zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924299; c=relaxed/simple;
	bh=r/njkd4yWFynVjZdPT/sypGuuw3ZWZZLSyGw2kwoFQM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e1/Sch2bHeR8/EuSu6MRbfITHJW5mMYST2AtxjOdk4FJiFiDHkO0n77oQF/vf5koHUBaywaS3AkcY4u8pyg208X/9k3kHQ1ell+0bWNIt07o99XKfqjORAAeQknp+l72HC9aX+ib/iOHWFAp+l9VFEGppD3HaXqWlNi8t7PDIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cDbBhvuk; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cDbBhvuk"
Received: from github.com (hubbernetes-node-5cb694b.va3-iad.github.net [10.48.222.54])
	by smtp.github.com (Postfix) with ESMTPA id EEFFD4E06E4
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730924296;
	bh=OnTDNxpfWUmnY/6aVqPylQTXgm+mk3a6kibYkrr4ZDw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cDbBhvukZFB96cFuk6F31JZ5eohU3i0cr7XP0C5ZkS4gUm0lY9eEGusjKjTpLRUV4
	 PJM4dcC6O1S2LoFiOvTrNyDIQllEYgmBtqKKml0Ho1QMAUTVy1M+xbO8tmjfxwb+CM
	 bLY6JyxgWAP+tXCXDjKMT7o8s8nE7IjlkTZRmJLM=
Date: Wed, 06 Nov 2024 12:18:16 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/002ee1-aa118e@github.com>
Subject: [bluez/bluez] 0025cd: lib: Add IPC bus type
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
  Commit: 0025cdd0c103b0c93091947cfdfeb678252a056b
      https://github.com/bluez/bluez/commit/0025cdd0c103b0c93091947cfdfeb678252a056b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-06 (Wed, 06 Nov 2024)

  Changed paths:
    M doc/mgmt-api.txt
    M lib/hci.c
    M lib/hci.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  lib: Add IPC bus type

Zephyr(1) has been using the same bus defines as Linux so tools likes of
btmon, etc, are able to decode the bus under HCI, so this attempts to
synchronize the definitions by adding the missing bus type IPC(11) and its
decoding string.

[1] https://github.com/zephyrproject-rtos/zephyr/pull/80808


  Commit: 469a75ae182a483ecbf71284205dde2508826f84
      https://github.com/bluez/bluez/commit/469a75ae182a483ecbf71284205dde2508826f84
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-06 (Wed, 06 Nov 2024)

  Changed paths:
    M profiles/audio/sink.c

  Log Message:
  -----------
  sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle

If the stream transition to AVDTP_STATE_IDLE it means the stream has
been disconnected, not the session, therefore
btd_service_disconnecting_complete shall not be called otherwise it may
trigger the policy plugin to disconnect AVRCP in cases like codec
reconfiguration.

Fixes: https://github.com/bluez/bluez/issues/1003


  Commit: 2aade568ce77a0f60715ce59fcbc223161be175f
      https://github.com/bluez/bluez/commit/2aade568ce77a0f60715ce59fcbc223161be175f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-06 (Wed, 06 Nov 2024)

  Changed paths:
    M profiles/audio/source.c

  Log Message:
  -----------
  source: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle

If the stream transition to AVDTP_STATE_IDLE it means the stream has
been disconnected, not the session, therefore
btd_service_disconnecting_complete shall not be called otherwise it may
trigger the policy plugin to disconnect AVRCP in cases like codec
reconfiguration.


  Commit: aa118e965b02a6b78039c1ed55b9947698c6de59
      https://github.com/bluez/bluez/commit/aa118e965b02a6b78039c1ed55b9947698c6de59
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-06 (Wed, 06 Nov 2024)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Don't wait to reconfigure

If the stream has been confirmed to be closed it should be safe to
attempt to send SetConfiguration without having to wait for a period
since the remote end can assume no new stream would be created it may
end up disconnecting the session.


Compare: https://github.com/bluez/bluez/compare/002ee180b1b5...aa118e965b02

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
